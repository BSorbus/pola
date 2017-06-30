class ProjectDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :project_path, :truncate

  def view_columns
    @view_columns ||= {
      id:        { source: "Project.id", cond: :eq, searchable: false, orderable: false },
      number:    { source: "Project.number", cond: :like, searchable: true, orderable: true },
      status:    { source: "ProjectStatus.name", cond: :like, searchable: true, orderable: true },
      customer:  { source: "Customer.name", cond: :like, searchable: true, orderable: true },
      note:      { source: "Project.note",  cond: :like, searchable: true, orderable: true },
      flat:      { source: "Project.flat_assigned_users", searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        id:       record.id,
        number:   link_to(record.number, project_path(record.id)),
        status:   record.project_status.try(:name),
      #  customer: record.customer.try(:name),
        customer: record.customer.try(:name_as_link),
        note:     truncate(record.note, length: 50),
        flat:     record.flat_assigned_users
      }
    end
  end

  private

  def get_raw_records
    #Project.joins(:project_status, :customer).all
    Project.includes(:project_status, :customer).references(:project_status, :customer).all
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
