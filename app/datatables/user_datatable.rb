class UserDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :user_path, :strftime

  def view_columns
    @view_columns ||= {
      id:                 { source: "User.id", cond: :eq, searchable: false, orderable: false },
      name:               { source: "User.name", cond: :like, searchable: true, orderable: true },
      email:              { source: "User.email",  cond: :like, searchable: true, orderable: true },
      last_sign_in_ip:    { source: "User.last_sign_in_ip",  cond: :like, searchable: true, orderable: true },
      last_sign_in_at:    { source: "User.last_sign_in_at",  cond: :like, searchable: true, orderable: true },
      current_sign_in_ip: { source: "User.current_sign_in_ip",  cond: :like, searchable: true, orderable: true },
      current_sign_in_at: { source: "User.current_sign_in_at",  cond: :like, searchable: true, orderable: true },
      flat:               { source: "User.id", cond: filter_custom_column_condition }
    }
  end

  def data
    records.map do |record|
      {
        id:                 record.id,
        name:               link_to(record.name, user_path(record.id)),
        email:              record.email,
        last_sign_in_ip:    record.last_sign_in_ip,
        last_sign_in_at:    record.last_sign_in_at.present? ? record.last_sign_in_at.strftime("%Y-%m-%d %H:%M:%S") : '' ,
        current_sign_in_ip: record.current_sign_in_ip,
        current_sign_in_at: record.current_sign_in_at.present? ? record.current_sign_in_at.strftime("%Y-%m-%d %H:%M:%S") : '' ,
        flat:               record.try(:flat_assigned_projects)
      }
    end
  end

  private

  def get_raw_records
    User.all
  end

  def filter_custom_column_condition
    #->(column) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ column.search.value }%") }
    ->(column) {
        sanitize_search_text = Loofah.fragment(column).text;
        sql_str = "(users.id IN (" +
          "SELECT accessorizations.user_id FROM accessorizations, projects WHERE " + 
          "accessorizations.project_id = projects.id AND " + 
          "projects.number ilike '%#{sanitize_search_text}%' " +
          "UNION " +
          "SELECT accessorizations.user_id FROM accessorizations, roles WHERE " + 
          "accessorizations.role_id = roles.id AND " + 
          "roles.name ilike '%#{sanitize_search_text}%' " +
          "))";
        ::Arel::Nodes::SqlLiteral.new("#{sql_str}") 
        }
  end


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
