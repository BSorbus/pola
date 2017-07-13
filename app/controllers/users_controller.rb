class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def datatables_index_role
    respond_to do |format|
      format.json{ render json: RoleUsersDatatable.new(view_context, { only_for_current_role_id: params[:role_id] }) }
    end
  end

  def datatables_index
    respond_to do |format|
      format.json{ render json: UserDatatable.new(view_context) }
    end
  end

  def select2_index
    #params[:q] = (params[:q]).upcase
    params[:q] = params[:q]
    @users = User.order(:name).finder_user(params[:q])
    @users_on_page = @users.page(params[:page]).per(params[:page_limit])
    
    render json: { 
      users: @users_on_page.as_json(methods: :fullname, only: [:id, :fullname]),
      meta: { total_count: @users.count }  
    } 
  end

  # GET /users
  # GET /users.json
  def index
    authorize :user, :index?
    @users = User.order(:name).all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize @user, :show?
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user, :new?
  end

  # GET /users/1/edit
  def edit
    authorize @user, :edit?
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize @user, :create?
    respond_to do |format|
      if @user.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @user.fullname)
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize @user, :update?
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @user.fullname)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # @user.destroy
    # respond_to do |format|
    #   flash[:success] = "User destroyed!"
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    authorize @user, :destroy?
    if @user.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @user.fullname)
      redirect_to users_url
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @user.fullname)
      #redirect_to :back
      render :show
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :note, accessorizations_attributes: [:id, :project_id, :user_id, :role_id, :_destroy])
    end
end
