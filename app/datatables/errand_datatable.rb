class ErrandDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :errand_path, :truncate

  def view_columns
    @view_columns ||= {
      id:                { source: "Errand.id", cond: :eq, searchable: false, orderable: false },
      number:            { source: "Errand.number", cond: :like, searchable: true, orderable: true },
      order_date:        { source: "Errand.order_date", cond: :like, searchable: true, orderable: true },
      principal:         { source: "Errand.principal",  cond: :like, searchable: true, orderable: true },
      adoption_date:     { source: "Errand.adoption_date", cond: :like, searchable: true, orderable: true },
      start_date:        { source: "Errand.start_date", cond: :like, searchable: true, orderable: true },
      end_date:          { source: "Errand.end_date", cond: :like, searchable: true, orderable: true },
      status:            { source: "ErrandStatus.name", cond: :like, searchable: true, orderable: true },
      attachments_count: { source: "Errand.attachments_count", cond: :like, searchable: true, orderable: true }
    }
  end

  def data
    records.map do |record|
      {
        id:             record.id,
        number:         link_to(record.number, errand_path(record.id)),
        order_date:     record.order_date.present? ? record.order_date.strftime("%Y-%m-%d") : '' ,
        principal:      record.principal,
        adoption_date:  record.adoption_date.present? ? record.adoption_date.strftime("%Y-%m-%d") : '' ,
        start_date:     record.start_date.present? ? record.start_date.strftime("%Y-%m-%d") : '' ,
        end_date:       record.end_date.present? ? record.end_date.strftime("%Y-%m-%d") : '' ,
        status:         record.errand_status.try(:name),
        attachments_count: badge(record).html_safe
      }
    end
  end

  private

  def get_raw_records
    Errand.joins(:errand_status).references(:errand_status).all
  end

  def badge(rec)
    count = rec.try(:attachments_count)
    if count > 0
      "<div style='text-align: center'><span class='badge alert-info'>" + "#{count}" + "</span></div>"
    else
      "<div style='text-align: center'><span class='badge'>" + "#{count}" + "</span></div>"
    end
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

