class RoleDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :truncate

  def view_columns
    @view_columns ||= {
      id:         { source: "Role.id", cond: :eq, searchable: false, orderable: false },
      name:       { source: "Role.name", cond: :like, searchable: true, orderable: true },
      special:    { source: "Role.special", cond: :like, searchable: false, orderable: true },
      note:       { source: "Role.note", cond: :like, searchable: true, orderable: true },
      activities: { source: "Role.activities", cond: :like, searchable: true, orderable: true }
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        name:       record.try(:name_as_link),
        special:    record.is_special? ? '<div style="text-align: center"><div class="glyphicon glyphicon-ok"></div></div>'.html_safe : '',
        note:       truncate(Loofah.fragment(record.note).text, length: 50),
        activities: record.try(:activities)
      }
    end
  end

  private

  def get_raw_records
    Role.all
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
