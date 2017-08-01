class EventsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index]
  before_action :set_event, only: [:show, :edit, :update, :destroy]


  def send_status
    event = Event.find(params[:id])
    params[:users_ids].each do |i|
      user = User.find(i)
      StatusMailer.event_status_email(user, event).deliver_now
    end
    #flash[:success] = t('activerecord.successfull.messages.created', data: @event.fullname)
    redirect_to event, notice: "Email status about \"#{event.title}\" was successfully sent."
  end

  # GET /events
  # GET /events.json
  def index
    authorize :event, :index?
    @events = Event.where(start_date: params[:start]..params[:end]).or(Event.where(end_date: params[:start]..params[:end]))
  end

  # GET /events/1
  # GET /events/1.json
  def show
    authorize @event, :show?
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.all_day = true
    @event.start_date = Time.zone.now
    @event.end_date = Time.zone.now

    authorize @event, :new?
  end

  # GET /events/1/edit
  def edit
    authorize @event, :edit?
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    authorize @event, :create?
    respond_to do |format|
      if @event.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @event.fullname)
        format.html { redirect_to @event }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    authorize @event, :update?
    respond_to do |format|
      if @event.update(event_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @event.fullname)
        format.html { redirect_to @event }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    authorize @event, :destroy?
    if @event.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @event.fullname)
      redirect_to events_url
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @event.fullname)
      #redirect_to :back
      render :show
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :all_day, :start_date, :end_date, :color, :status, :note, :project_id, :event_type_id, accessorizations_attributes: [:id, :event_id, :user_id, :role_id, :_destroy])
    end
end
