class BusinessTripsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :datatables_index, :datatables_index_user]
  before_action :set_business_trip, only: [:show, :edit, :costs_edit, :update, :costs_update, :status_update, :payment_approved, :destroy]


  def datatables_index
    user_filter = (params[:eager_filter_for_current_user].blank? || params[:eager_filter_for_current_user] == 'false' ) ? nil : current_user.id
    respond_to do |format|
      format.json{ render json: BusinessTripDatatable.new(view_context, eager_filter: user_filter ) }
    end
  end

  def datatables_index_user
    respond_to do |format|
      format.json{ render json: UserBusinessTripsDatatable.new(view_context, { only_for_current_user_id: params[:user_id] }) }
    end
  end

  # GET /business_trips
  # GET /business_trips.json
  def index
    authorize :business_trip, :index?
  end

  # GET /business_trips/1
  # GET /business_trips/1.json
  def show
    authorize @business_trip, :show?
  end

  # GET /business_trips/new
  def new
    @business_trip = BusinessTrip.new
    authorize @business_trip, :new?
  end

  # GET /business_trips/1/edit
  def edit
    authorize @business_trip, :edit?
  end

  # GET /business_trips/1/edit
  def costs_edit
    authorize @business_trip, :edit?
  end

  # POST /business_trips
  # POST /business_trips.json
  def create
    @business_trip = BusinessTrip.new(business_trip_create_params)
    @business_trip.user = current_user
    @business_trip.business_trip_status = BusinessTripStatus.first
    @business_trip.business_trip_status_updated_at = Time.zone.now
    @business_trip.business_trip_status_updated_user = current_user

    authorize @business_trip, :create?
    respond_to do |format|
      if @business_trip.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @business_trip.fullname)
        format.html { redirect_to @business_trip }
        format.json { render :show, status: :created, location: @business_trip }
      else
        format.html { render :new }
        format.json { render json: @business_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_trips/1
  # PATCH/PUT /business_trips/1.json
  def update
    @business_trip.user = current_user
    authorize @business_trip, :update?
    respond_to do |format|
      if @business_trip.update(business_trip_update_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @business_trip.fullname)
        format.html { redirect_to @business_trip }
        format.json { render :show, status: :ok, location: @business_trip }
      else
        format.html { render :edit }
        format.json { render json: @business_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def costs_update
    @business_trip.user = current_user
    authorize @business_trip, :update?
    respond_to do |format|
      if @business_trip.update(business_trip_costs_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @business_trip.fullname)
        format.html { redirect_to @business_trip }
        format.json { render :show, status: :ok, location: @business_trip }
      else
        format.html { render :costs_edit }
        format.json { render json: @business_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def payment_approved
    authorize @business_trip, :payment_approved?
    @business_trip.user = current_user
    @business_trip.payment_on_account_approved = current_user
    @business_trip.payment_on_account_approved_date_time = Time.zone.now
    respond_to do |format|
      if @business_trip.save
        flash[:success] = 'payment_approved'
        format.html { redirect_to @business_trip }
        format.json { render :show, status: :ok, location: @business_trip }
      else
        format.html { render :edit_additional }
        format.json { render json: @business_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def status_update
    authorize @business_trip, :approved?
    @business_trip.user = current_user
    @business_trip.business_trip_status_updated_user = current_user
    @business_trip.business_trip_status_updated_at = Time.zone.now
    respond_to do |format|
      if @business_trip.update(business_trip_status_update_params)
        flash[:success] = 'Status updated'
        format.html { redirect_to @business_trip }
        format.json { render :show, status: :ok, location: @business_trip }
      else
        format.html { render :edit_additional }
        format.json { render json: @business_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_trips/1
  # DELETE /business_trips/1.json
  def destroy
    authorize @business_trip, :destroy?
    if @business_trip.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @business_trip.fullname)
      @business_trip.log_work('destroy', current_user.id)
      redirect_to business_trips_url
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @business_trip.fullname)
      #redirect_to :back
      render :show
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_trip
      @business_trip = BusinessTrip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_trip_create_params
      params.require(:business_trip).permit(:number, :employee_id, :start_date, :end_date, :destination, :purpose, :trip_confirmation, :payment_on_account, :note, :business_trip_status_id, :business_trip_status_updated_user_id, :business_trip_status_updated_at, :user_id, 
        transports_attributes:[:id, :transport_type_id, :_destroy])
    end

    def business_trip_update_params
      params.require(:business_trip).permit(:number, :employee_id, :start_date, :end_date, :destination, :purpose, :trip_confirmation, :payment_on_account, :note, :user_id, 
        transports_attributes:[:id, :transport_type_id, :_destroy],
        roads_attributes: [:id, :from, :start_date_time, :to, :end_date_time, :transport_type_id, :cost, :_destroy])
    end

    def business_trip_status_update_params
      params.require(:business_trip).permit(:business_trip_status_id, :business_trip_status_updated_at, :user_id)
    end

    def business_trip_costs_params
      params.require(:business_trip).permit(:hotel, roads_attributes: [:id, :from, :start_date_time, :to, :end_date_time, :transport_type_id, :cost, :_destroy])
    end
end
