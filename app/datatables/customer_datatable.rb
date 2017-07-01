class CustomerDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :truncate

  def view_columns
    @view_columns ||= {
      id:        { source: "Customer.id", cond: :eq, searchable: false, orderable: false },
      name:      { source: "Customer.name", cond: :like, searchable: true, orderable: true },
      note:      { source: "Customer.note",  cond: :like, searchable: true, orderable: true },
      flat:      { source: "Customer.id", cond: filter_custom_column_condition }
    }
  end

  def data
    records.map do |record|
      {
        id:       record.id,
        name:     record.try(:name_as_link),
        note:     truncate(record.note, length: 50),
        flat:     record.try(:flat_assigned_projects)
      }
    end
  end

  private

  def get_raw_records
    Customer.all
  end


  def filter_custom_column_condition
    #->(column) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ column.search.value }%") }
    ->(column) {
        sanitize_search_text = Loofah.fragment(column).text;
        sql_str = "(customers.id IN (SELECT projects.customer_id FROM projects WHERE projects.number ilike '%#{sanitize_search_text}%'))";
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
