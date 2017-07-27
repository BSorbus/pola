class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]


  def send_status
    project = Project.find(params[:id])
    params[:users_ids].each do |i|
      user = User.find(i)
      StatusMailer.project_status_email(user, project).deliver_now
    end
    #flash[:success] = t('activerecord.successfull.messages.created', data: @project.fullname)
    redirect_to project, notice: "Email status about \"#{project.number}\" was successfully sent."
  end

  def datatables_index
    respond_to do |format|
      format.json{ render json: ProjectDatatable.new(view_context) }
    end
  end

  def select2_index
    params[:q] = params[:q]
    @projects = Project.order(:number).finder_project(params[:q])
    @projects_on_page = @projects.page(params[:page]).per(params[:page_limit])
    
    render json: { 
      projects: @projects_on_page.as_json(methods: :fullname, only: [:id, :fullname]),
      meta: { total_count: @projects.count }  
    } 
  end

  # GET /projects
  # GET /projects.json
  def index
    authorize :project, :index?
    @projects = Project.order(:number).all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    authorize @project, :index?
  end

  # GET /projects/new
  def new
    @project = Project.new
    authorize @project, :new?
  end

  # GET /projects/1/edit
  def edit
    authorize @project, :edit?
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    authorize @project, :create?
    respond_to do |format|
      if @project.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @project.fullname)
        format.html { redirect_to @project }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    authorize @project, :update?
    respond_to do |format|
      if @project.update(project_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @project.fullname)
        format.html { redirect_to @project }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    # authorize @project, :destroy?
    # @project.destroy
    # respond_to do |format|
    #   flash[:success] = "Project destroyed!"
    #   format.html { redirect_to projects_url }
    #   format.json { head :no_content }
    # end
    authorize @project, :destroy?
    if @project.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @project.fullname)
      redirect_to projects_url
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @project.fullname)
      #redirect_to :back
      render :show
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:number, :registration, :note, :project_status_id, :customer_id)
    end

end
