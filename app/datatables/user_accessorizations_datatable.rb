class UserAccessorizationsDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :truncate, :project_path, :role_user_path, :role_users_path, :policy

  def view_columns
    @view_columns ||= {
      id:         { source: "Project.id", cond: :eq, searchable: false, orderable: false },
      name:       { source: "Project.number", cond: :like, searchable: true, orderable: true },
      status:     { source: "ProjectStatus.name", cond: :like, searchable: true, orderable: true },
      customer:   { source: "Customer.name", cond: :like, searchable: true, orderable: true },
      flat:       { source: "Project.id", cond: filter_custom_column_condition }
    }
  end

  def data
    records.map do |record|
      # OK
      # user_has_role = Accessorization.joins(:user, :project).where(users: {id: options[:only_for_current_user_id]}, projects: {id: record.id}).any?
      #user_has_role = Accessorization.joins(:user, :project).where(user_id: options[:only_for_current_user_id], project_id: record.id).any?
      {
        id:         record.id,
        name:       link_to(record.number, project_path(record.id)),
        status:     record.project_status.try(:name),
        customer:   record.customer.try(:name_as_link),
        flat:       record.flat_assigned_users
      }
    end
  end

  private

  def get_raw_records
    Project.joins(:accessorizations, :customer).includes(:project_status).references(:project_status, :customer, :accessorizations).where(accessorizations: {user_id: options[:only_for_current_user_id]}).all
  end


  def link_add_remove(rec, has_role)
    if policy(rec).add_remove_role_user?
      if has_role
        "<div style='text-align: center'><button ajax-path='" + role_user_path(role_id: rec.id, id: options[:only_for_current_user_id]) + "' ajax-method='DELETE' class='btn btn-xs btn-danger glyphicon glyphicon-minus'></button></div>"
      else
        "<div style='text-align: center'><button ajax-path='" + role_users_path(role_id: rec.id, id: options[:only_for_current_user_id]) + "' ajax-method='POST' class='btn btn-xs btn-success glyphicon glyphicon-plus'></button></div>"
      end
    else
      ""
    end
  end

  def link_form_for(rec, has_role)
    '<div></div>'
  end

  def filter_custom_column_condition
    #->(column) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ column.search.value }%") }
    ->(column) {
        sanitize_search_text = Loofah.fragment(column).text;
        sql_str = "(projects.id IN (" +
          "SELECT accessorizations.project_id FROM accessorizations, users WHERE " + 
          "accessorizations.user_id = users.id AND " + 
          "users.name ilike '%#{sanitize_search_text}%' " +
          "UNION " +
          "SELECT accessorizations.project_id FROM accessorizations, roles WHERE " + 
          "accessorizations.role_id = roles.id AND " + 
          "roles.name ilike '%#{sanitize_search_text}%' " +
          "))";
        ::Arel::Nodes::SqlLiteral.new("#{sql_str}") 
        }
  end



# <td><%= link_to user.email, user %></td>
# <td>
#   <%= form_for(user) do |f| %>
#     <%= f.select(:role, User.roles.keys.map {|role| [role.titleize,role]}) %>
#     <%= f.submit 'Change Role', :class => 'btn btn-primary btn-xs' %>
#   <% end %>
# </td>
# <td><%= user.last_sign_in_at.present? ? user.last_sign_in_at.strftime("%Y-%m-%d %H:%M") : '' %></td>



  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
