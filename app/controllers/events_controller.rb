class EventsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :datatables_index, :show_charts]
  before_action :set_event, only: [:show, :edit, :update, :destroy]


  def show_charts
    respond_to do |format|
      format.html{ render 'charts/show_charts' }
    end
  end

  def datatables_index
    respond_to do |format|
      format.json{ render json: EventDatatable.new(view_context) }
    end
  end

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
    @comment = @event.comments.new
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.all_day = true

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
    @event.user = current_user
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
    @event.user = current_user
    authorize @event, :update?
    respond_to do |format|
      if @event.update(event_params)
        if event_or_any_accessorization_changed? 
          flash[:success] = t('activerecord.successfull.messages.updated', data: @event.fullname)
          @event.log_work_without_check_changed('update')
        end
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
      @comment = @event.comments.new
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
      # params.require(:event).permit(:title, :all_day, :start_date, :end_date, :note, :project_id, :event_status_id, :event_type_id, accessorizations_attributes: [:id, :event_id, :user_id, :role_id, :_destroy])
      params.require(:event).permit(policy(:event).permitted_attributes)
    end

    def accessorization_changed_any?
      @event.accessorizations.map {|a| a.saved_changes?}.flatten.include?(true)
    end

    def accessorization_marked_destroy_any?
      event_params.to_h[:accessorizations_attributes].map {|a| a[1][:_destroy] }.include?("1")
    end

    def event_or_any_accessorization_changed?
      @event.saved_changes? || accessorization_changed_any? || accessorization_marked_destroy_any?
    end

end
