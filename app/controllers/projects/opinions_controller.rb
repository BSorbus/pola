class Projects::OpinionsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: []
  before_action :set_opinion, only: [:show, :edit, :update, :destroy]


  # GET /opinions/1
  # GET /opinions/1.json
  def show
    @project = load_project
    authorize @opinion, :download?
  end

  # GET /opinions/new
  def new
    @project = load_project
    @opinion = Opinion.new
    @opinion.project = @project
    authorize @opinion, :new?
  end

  # GET /opinions/1/edit
  def edit
    @project = load_project
    authorize @point_file, :edit?
  end

  # POST /opinions
  # POST /opinions.json
  def create
    # @opinion = Opinion.new(opinion_params)

    # respond_to do |format|
    #   if @opinion.save
    #     format.html { redirect_to @opinion, notice: 'Opinion was successfully created.' }
    #     format.json { render :show, status: :created, location: @opinion }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @opinion.errors, status: :unprocessable_entity }
    #   end
    # end
    @project = load_project
    @opinion = PointFile.new(opinion_params)
    @opinion.project = @project
    authorize @opinion, :create?
    respond_to do |format|
      if @opinion.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @opinion.fullname)
        @opinion.load_data_from_csv_file
        flash[:notice] = "Pomyślnie załadowano #{@opinion.zs_points.size} punktów ZS"
        format.html { redirect_to project_opinion_path(@project, @opinion) }
        format.json { render :show, status: :created, location: @opinion }
      else
        format.html { render :new }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opinions/1
  # PATCH/PUT /opinions/1.json
  def update
    # respond_to do |format|
    #   if @opinion.update(opinion_params)
    #     format.html { redirect_to @opinion, notice: 'Opinion was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @opinion }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @opinion.errors, status: :unprocessable_entity }
    #   end
    # end
    @project = load_project
    authorize @opinion, :update?
    respond_to do |format|
      if @opinion.update(opinion_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @opinion.fullname)
        format.html { redirect_to project_opinion_path(@project, @opinion) }
        format.json { render :show, status: :ok, location: @opinion }
      else
        format.html { render :edit }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opinions/1
  # DELETE /opinions/1.json
  def destroy
    # @opinion.destroy
    # respond_to do |format|
    #   format.html { redirect_to opinions_url, notice: 'Opinion was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    @project = load_project
    authorize @opinion, :destroy?
    if @opinion.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @opinion.fullname)
      redirect_to project_path(@project)
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @opinion.fullname)
      render :show
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opinion
      @opinion = Opinion.find(params[:id])
    end

    def load_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opinion_params
      params.require(:opinion).permit(:project_id, :user_id, :sec22_rate, :sec22, :sec23_rate, :sec23, :sec24_rate, :sec24, :sec25_rate, :sec25, :sec28_rate, :sec28, :sec33_rate, :sec33, :sec41, :sec42, :sec43, :sec51_rate, :sec51, :sec61)
    end
end
