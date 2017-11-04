class ChartsController < ApplicationController
  before_action :authenticate_user!

  helper :all

  def errands_by_status
    data_array = []
    ErrandStatus.all.each do |errand_status|
      data_array <<  ["#{errand_status.name}", 
                      Errand.where(errand_status: errand_status).count ]
    end
    render json: data_array 
  end

  def errands_by_month
    result1 = Errand.group_by_month(:adoption_date).count
    result2 = Errand.group_by_month(:start_date).count
    result3 = Errand.group_by_month(:end_date).count

    render json: [{name: 'Ilość (wg daty przyjęcia)',   data: result1},
                  {name: 'Ilość (wg daty rozpoczęcia)', data: result2},
                  {name: 'Ilość (wg daty zakończenia)', data: result3}]
  end

  def errands_by_month_status
    data_array = []
    ErrandStatus.all.each do |errand_status|
      data_array << { name: "#{errand_status.name}", 
                      data: Errand.where(errand_status: errand_status).group_by_month(:order_date, format: '%Y-%m-%d').count.map{|k,v| [k,v]} }
    end
    render json: data_array.to_json 
  end

  # Events
  def events_by_status
    data_array = []
    EventStatus.all.each do |event_status|
      data_array <<  ["#{event_status.name}", 
                      Event.where(event_status: event_status).count ]
    end
    render json: data_array 
  end

  def events_by_type
    data_array = []
    EventType.all.each do |event_type|
      data_array <<  ["#{event_type.name}", 
                      Event.where(event_type: event_type).count ]
    end
    render json: data_array 
  end

  def events_by_type_for_status
    data_array = []
    EventType.all.each do |event_type|
      data_array <<  ["#{event_type.name}", 
                      Event.where(event_type: event_type, event_status: params[:status_id]).count ]
    end
    render json: data_array 
  end

  def events_by_status_for_errand
    data_array = []
    EventStatus.all.each do |event_status|
      data_array <<  ["#{event_status.name}", 
                      Event.where(errand_id: params[:errand_id], event_status: event_status).count ]
    end
    render json: data_array 
  end

  def events_by_status_for_user
    data_array = []
    EventStatus.all.each do |event_status|
      data_array <<  ["#{event_status.name}", 
                      Event.joins(:accessorizations).where(event_status: event_status, accessorizations: {user_id: [params[:user_id]]}).count ]
    end
    render json: data_array 
  end

  def events_by_status_type_for_user
    data_array = [] 
    EventStatus.all.each do |event_status|
      EventType.all.each do |event_type|  
        data_array << { name: "#{event_status.name}", 
                        data: {"#{event_type.name}": Event.joins(:accessorizations).where( event_status_id: [event_status.id], event_type_id: [event_type.id], accessorizations: {user_id: [params[:user_id]]} ).size }
                      }         
      end
    end
    render json: data_array.to_json
  end

  def events_by_type_status_for_user
    data_array = [] 
    EventType.all.each do |event_type|
      EventStatus.all.each do |event_status|  
        data_array << { name: "#{event_type.name}", 
                        data: {"#{event_status.name}": Event.joins(:accessorizations).where( event_status_id: [event_status.id], event_type_id: [event_type.id], accessorizations: {user_id: [params[:user_id]]} ).size }
                      }         
      end
    end
    render json: data_array.to_json
  end


  def events_by_month
    #render json: Event.group_by_month(:created_at).count #.map { |k, v| [I18n.t("date.month_names")[k], v] }
    render json: Event.joins(:errand).group_by_month('errands.order_date').count
  end



  def events_by_month_type
    # Jest OK
    # result = Certificate.where(category: params[:category_service].upcase).group(:division_id).group_by_month(:created_at, last: 60).count.chart_json
    # render json: result

    data_array = []
    EventType.all.each do |event_type|
      data_array << { name: "#{event_type.name}", 
                      data: Event.where(event_type: event_type).group_by_month(:created_at, format: '%Y-%m-%d').count.map{|k,v| [k,v]} }
    end
    render json: data_array.to_json 
  end

  def point_files
      province_array = [['PL.DS', 'dolnośląskie'],
                        ['PL.KP', 'kujawsko-pomorskie'],
                        ['PL.LB', 'lubuskie'],
                        ['PL.LD', 'łódzkie'],
                        ['PL.LU', 'lubelskie'],
                        ['PL.MA', 'małopolskie'],
                        ['PL.MZ', 'mazowieckie'],
                        ['PL.OP', 'opolskie'],
                        ['PL.PD', 'podlaskie'],
                        ['PL.PK', 'podkarpackie'],
                        ['PL.PM', 'pomorskie'],
                        ['PL.SK', 'świętokrzyskie'],
                        ['PL.SL', 'śląskie'],
                        ['PL.WN', 'warmińsko-mazurskie'],
                        ['PL.WP', 'wielkopolskie'],
                        ['PL.ZP', 'zachodniopomorskie']]

    data_array = []
    province_array.each do |province|
      data_array << [ province[0], PointFile.where(status: 1, oi_4: province[1].mb_chars.upcase.strip).count ]
    end

    render json: data_array
  end

  private
    

end
