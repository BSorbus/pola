class EventDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :truncate

  def view_columns
    @view_columns ||= {
      id:        { source: "Event.id", cond: :eq, searchable: false, orderable: false },
      title:     { source: "Event.title", cond: :like, searchable: true, orderable: true },
      type:      { source: "EventType.name", cond: :like, searchable: true, orderable: true },
      project:   { source: "Project.number",  cond: :like, searchable: true, orderable: true },
      end_date:  { source: "Event.end_date", cond: :like, searchable: true, orderable: true },
      status:    { source: "EventStatus.name", cond: :like, searchable: true, orderable: true },
      flat:      { source: "Event.id", cond: filter_custom_column_condition }
    }
  end

  def data
    records.map do |record|
      {
        id:       record.id,
        title:    record.try(:title_as_link),
        type:     record.event_type.try(:name),
        project:  record.project.try(:number_as_link),
        end_date: record.end_date.present? ? record.end_date.strftime("%Y-%m-%d %H:%M") : '' ,
        status:   record.event_status.try(:name),
        flat:     record.flat_assigned_users
      }
    end
  end

  private

  def get_raw_records
    Event.joins(:event_type, :project, :event_status).references(:event_type, :project, :event_status).all
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