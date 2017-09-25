class Events::RatingsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: []
  before_action :set_rating, only: [:export, :show, :edit, :update, :destroy]


  # GET /ratings/1.xls
  def export
    authorize @rating, :export?
    send_data @rating.to_xls, filename: "rating_#{@rating.event.project.fullname}_#{Time.zone.today.strftime('%Y-%m-%d')}.xls"
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
    @event = load_event
    authorize @rating, :show?
  end

  # GET /ratings/new
  def new
    @event = load_event
    @rating = Rating.new
    @rating.event = @event
    @rating.user = current_user
    authorize @rating, :new?
  end

  # GET /ratings/1/edit
  def edit
    @event = load_event
    authorize @rating, :edit?
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @event = load_event
    @rating = Rating.new(rating_params)
    @rating.event = @event
    @rating.user = current_user
    authorize @rating, :create?
    respond_to do |format|
      if @rating.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @rating.fullname)
        format.html { redirect_to event_rating_path(@event, @rating) }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    @event = load_event
    authorize @rating, :update?
    respond_to do |format|
      if @rating.update(rating_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @rating.fullname)
        format.html { redirect_to event_rating_path(@event, @rating) }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @event = load_event
    authorize @rating, :destroy?
    if @rating.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @rating.fullname)
      redirect_to event_path(@event)
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @rating.fullname)
      render :show
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    def load_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:event_id, :user_id, :sec22_rate, :sec22, :sec23_rate, :sec23, :sec24_rate, :sec24, :sec25_rate, :sec25, :sec28_rate, :sec28, :sec33_rate, :sec33, :sec41, :sec42, :sec43, :sec51_rate, :sec51, :sec61_rate, :sec61, :note)
    end
end
