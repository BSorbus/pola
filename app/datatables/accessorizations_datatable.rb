class AccessorizationsDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :truncate, :event_path, :project_path


  def view_columns
    @view_columns ||= {
      id:                { source: "Event.id", cond: :eq, searchable: false, orderable: false },
      title:             { source: "Event.title", cond: :like, searchable: true, orderable: true },
      event_type:        { source: "EventType.name", cond: :like, searchable: true, orderable: true },
      end_date:          { source: "Event.end_date", cond: :like, searchable: true, orderable: true },
      event_status:      { source: "EventStatus.name", cond: :like, searchable: true, orderable: true },
      project:           { source: "Project.number", cond: :like, searchable: true, orderable: true },
      status:            { source: "ProjectStatus.name", cond: :like, searchable: true, orderable: true },
      event_effect:      { source: "EventEffect.name", cond: :like, searchable: true, orderable: true },
      attachments_count: { source: "Event.id", searchable: false, orderable: false },
      flat:              { source: "Event.id", cond: filter_custom_column_condition }
    }
  end

  def data
    records.map do |record|
      {
        id:                record.id,
        title:             link_to(truncate(record.title, length: 50), event_path(record.id)),
        event_type:        record.event_type.try(:name),
        end_date:          record.end_date.present? ? record.end_date.strftime("%Y-%m-%d %H:%M") : '' ,
        event_status:      record.event_status.try(:name),
        project:           link_to(record.project.number, project_path(record.project.id)),
        status:            record.project.project_status.try(:name),
        event_effect:      record.event_effect.try(:name),
        attachments_count: badge(record).html_safe,
        flat:              record.flat_assigned_users
      }
    end
  end

  private

  def get_raw_records
    if options[:only_for_current_user_id].present? 
      Event.joins(:errand, :event_type, :event_status, :accessorizations, project: [:project_status]).includes(:event_effect)
           .references(:errand, :event_type, :event_status, :event_effect, :accessorizations, :project, :project_status)
           .where(accessorizations: {user_id: options[:only_for_current_user_id]}).all
    elsif options[:only_for_current_role_id].present?
      Event.joins(:errand, :event_type, :event_status, :accessorizations, project: [:project_status]).includes(:event_effect)
           .references(:errand, :event_type, :event_status, :event_effect, :accessorizations, :project, :project_status)
           .where(accessorizations: {role_id: options[:only_for_current_role_id]}).all #distinct   # .group('events.id')
    elsif options[:only_for_current_errand_id].present?
      Event.joins(:errand, :event_type, :event_status, project: [:project_status]).includes(:event_effect)
           .references(:errand, :event_type, :event_status, :event_effect, :accessorizations, :project, :project_status)
           .where(errand_id: options[:only_for_current_errand_id]).all
    else
      Event.joins(:errand, :event_type, :event_status, :accessorizations, project: [:project_status]).includes(:event_effect)
           .references(:errand, :event_type, :event_status, :event_effect, :accessorizations, :project, :project_status).distinct
    end
  end

  def filter_custom_column_condition
    #->(column) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ column.search.value }%") }
    ->(column) {
        sanitize_search_text = Loofah.fragment(column).text;
        sql_str = "(events.id IN (" +
          "SELECT accessorizations.event_id FROM accessorizations, users WHERE " + 
          "accessorizations.user_id = users.id AND " + 
          "users.name ilike '%#{sanitize_search_text}%' " +
          "UNION " +
          "SELECT accessorizations.event_id FROM accessorizations, roles WHERE " + 
          "accessorizations.role_id = roles.id AND " + 
          "roles.name ilike '%#{sanitize_search_text}%' " +
          "))";
        ::Arel::Nodes::SqlLiteral.new("#{sql_str}") 
        }
  end


  def badge(rec)
    "<div style='text-align: center'><span class='badge alert-success'>" + "#{rec.attachments.try(:size)}" + "</span></div>"
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
