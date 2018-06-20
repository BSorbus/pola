class ProjectDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :project_path, :truncate

  def view_columns
    @view_columns ||= {
      id:         { source: "Project.id", cond: :eq, searchable: false, orderable: false },
      number:     { source: "Project.number", cond: :like, searchable: true, orderable: true },
      enrollment: { source: "Enrollment.name", cond: :like, searchable: true, orderable: true },
      status:     { source: "ProjectStatus.name", cond: :like, searchable: true, orderable: true },
      note:       { source: "Project.note",  cond: :like, searchable: true, orderable: true },
      customer:   { source: "Customer.name", cond: :like, searchable: true, orderable: true },
      flat:       { source: "Project.id", cond: filter_custom_column_condition }
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        number:     link_to(record.number, project_path(record.id)),
        enrollment: record.enrollment.try(:name_as_link),
        status:     record.project_status.try(:name),
        note:       truncate(record.note, length: 50),
        customer:   record.customer.try(:name_as_link_truncate),
        flat:       record.flat_assigned_events_with_status
      }
    end
  end

  private

  def get_raw_records
    if options[:only_for_current_customer_id].present?
      data = Project.joins(:enrollment, :project_status, :customer)
        .includes(:events).references(:enrollment, :project_status, :customer, :events)
        .where(customer_id: options[:only_for_current_customer_id])
    else 
      data = Project.joins(:enrollment, :project_status, :customer)
        .includes(:events).references(:enrollment, :project_status, :customer, :events)
    end
    options[:eager_filter].present? ? data.for_user_in_accessorizations(options[:eager_filter]).all : data.all
  end


  def filter_custom_column_condition
    #->(column) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ column.search.value }%") }
    ->(column) {
        sanitize_search_text = Loofah.fragment(column).text;
        sql_str = "(projects.id IN (" +
          "SELECT events.project_id FROM events WHERE " + 
          "events.title ilike '%#{sanitize_search_text}%' " +
          "UNION " +
          "SELECT events.project_id FROM events, event_statuses WHERE " + 
          "events.event_status_id = event_statuses.id AND " + 
          "event_statuses.name ilike '%#{sanitize_search_text}%' " +
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
