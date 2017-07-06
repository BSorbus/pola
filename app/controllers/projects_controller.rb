class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]


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
    @projects = Project.order(:number).all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        flash[:success] = "Project created!"
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
    respond_to do |format|
      if @project.update(project_params)
        flash[:success] = "Project updated!"
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
    @project.destroy
    respond_to do |format|
      flash[:success] = "Project destroyed!"
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:number, :project_status_id, :customer_id, :note, accessorizations_attributes: [:id, :project_id, :user_id, :role_id, :_destroy])
    end

end
