class Projects::AccessorizationsController < ApplicationController
  before_action :set_project, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_accessorization, only: [:edit, :update, :destroy]


  def new
    @accessorization = Accessorization.new(project: @project)
  end

  def edit
  end

  def create
    @accessorization = Accessorization.new(accessorization_params)

    respond_to do |format|
      if @accessorization.save
        flash[:success] = "Accessorization created!"
        format.html { redirect_to @project }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @accessorization.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @accessorization.update(accessorization_params)
        flash[:success] = "Accessorization updated!"
        format.html { redirect_to @project }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @paccessorization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @accessorization.destroy
    respond_to do |format|
      flash[:success] = "Accessorization destroyed!"
      format.html { redirect_to @project }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_accessorization
      @accessorization = Accessorization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accessorization_params
      params.require(:accessorization).permit(:project_id, :user_id, :role_id)
    end
end
