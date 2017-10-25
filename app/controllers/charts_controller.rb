class ChartsController < ApplicationController

  # Events for showed user
  def by_month_all_events
    #render json: Event.group_by_month(:created_at).count #.map { |k, v| [I18n.t("date.month_names")[k], v] }
    render json: Event.group_by_month(:created_at).count
  end

  def by_month_all_errands
    result1 = Errand.group_by_month(:adoption_date).count
    result2 = Errand.group_by_month(:start_date).count
    result3 = Errand.group_by_month(:end_date).count
    render json: [{name: 'Ilość przyjęctych zleceń',  data: result1},
                  {name: 'Ilość rozpoczętych zleceń', data: result2},
                  {name: 'Ilość zakończonych zleceń', data: result3}]
  end

  def by_month_all_type_errands
    # render json: Errand.group_by_month(:adoption_date).count
    result = Errand.group_by_month(:adoption_date).count
    render json: [{name: 'Ilość przyjęctych zleceń', data: result}]
  end


end

