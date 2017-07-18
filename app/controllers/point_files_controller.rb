class PointFilesController < ApplicationController
  before_action :set_point_file, only: [:show, :edit, :update, :destroy]

  # GET /point_files
  # GET /point_files.json
  def index
    @point_files = PointFile.all
  end

  # GET /point_files/1
  # GET /point_files/1.json
  def show
  end

  # GET /point_files/new
  def new
    @point_file = PointFile.new
  end

  # GET /point_files/1/edit
  def edit
  end

  # POST /point_files
  # POST /point_files.json
  def create
    @point_file = PointFile.new(point_file_params)

    respond_to do |format|
      if @point_file.save
        format.html { redirect_to @point_file, notice: 'Point file was successfully created.' }
        format.json { render :show, status: :created, location: @point_file }
      else
        format.html { render :new }
        format.json { render json: @point_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /point_files/1
  # PATCH/PUT /point_files/1.json
  def update
    respond_to do |format|
      if @point_file.update(point_file_params)
        format.html { redirect_to @point_file, notice: 'Point file was successfully updated.' }
        format.json { render :show, status: :ok, location: @point_file }
      else
        format.html { render :edit }
        format.json { render json: @point_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /point_files/1
  # DELETE /point_files/1.json
  def destroy
    @point_file.destroy
    respond_to do |format|
      format.html { redirect_to point_files_url, notice: 'Point file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point_file
      @point_file = PointFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def point_file_params
      params.require(:point_file).permit(:project_id, :load_date, :load_file, :status, :note)
    end
end
