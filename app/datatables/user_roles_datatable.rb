class UserRolesDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :truncate, :role_user_path, :role_users_path

  def view_columns
    @view_columns ||= {
      id:     { source: "Role.id", cond: :eq, searchable: false, orderable: false },
      name:   { source: "Role.name", cond: :like, searchable: true, orderable: true },
      status: { source: "Role.id",  searchable: false, orderable: false },
      action: { source: "Role.id", searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      href_remove = "<button ajax-path='" + role_user_path(role_id: record.id, id: options[:only_for_current_user_id]) + "' ajax-method='DELETE' class='btn btn-xs btn-danger glyphicon glyphicon-minus'></button>"
      href_add    = "<button ajax-path='" + role_users_path(role_id: record.id, id: options[:only_for_current_user_id]) + "' ajax-method='POST' class='btn btn-xs btn-success glyphicon glyphicon-plus'></button>"
      user_has_role = User.joins(:roles).where(roles: {id: record.id, special: true}, users: {id: options[:only_for_current_user_id]}).any?
      {
        id:     record.id,
        name:   record.try(:name_as_link),
        status: user_has_role ? '<div style="text-align: center"><div class="glyphicon glyphicon-ok"></div></div>'.html_safe : '',
        action: user_has_role ? href_remove.html_safe : href_add.html_safe
      }
    end
  end

  private

  def get_raw_records
    Role.where(special: true).all
  end


        # action: user_has_role ? "<button ajax-path='" + @view.role_user_path(role_id: record.id, id: options[:only_for_current_user_id]) + "' ajax-method='DELETE' class='button-xs-danger glyphicon glyphicon-minus' ></button>".html_safe
        #                       : "<button ajax-path='" + @view.role_users_path(role_id: record.id, id: options[:only_for_current_user_id]) + "' ajax-method='POST' class='button-xs-success glyphicon glyphicon-plus' ></button>".html_safe



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
