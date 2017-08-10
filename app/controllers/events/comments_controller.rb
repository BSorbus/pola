class Events::CommentsController < ApplicationController
  before_action :authenticate_user!
#  after_action :verify_authorized, except: []
  before_action :set_comment, only: [:show, :edit, :update, :destroy]


  # GET /comments/1
  # GET /comments/1.json
  def show
    @event = load_event
#    authorize @comment, :download?
  end

  # GET /comments/new
  def new
    @event = load_event
    @comment = Comment.new
    @comment.event = @event
#    authorize @comment, :new?
  end

  # GET /comments/1/edit
  def edit
    @event = load_event
#    authorize @point_file, :edit?
  end

  # POST /comments
  # POST /comments.json
  def create
    @event = load_event
    @comment = Comment.new(comment_params)
    @comment.event = @event
    @comment.user = current_user
#    authorize @comment, :create?
    respond_to do |format|
      if @comment.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @comment.fullname)
        format.html { redirect_to event_path(@event) }
        format.json { render :show, status: :created, location: @comment }
#        format.js { render status: :created, layout: false, js: 'events/comments/create.js.rb' }
        format.js   { render status: :created, layout: false, file: 'comments/create_from_event.js.erb' }
      else
        flash[:error] = t('activerecord.errors.messages.created', data: @comment.fullname)
        format.html { redirect_to event_path(@event) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    # respond_to do |format|
    #   if @comment.update(comment_params)
    #     format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @comment }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    #   end
    # end
    @event = load_event
#    authorize @comment, :update?
    respond_to do |format|
      if @comment.update(comment_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @comment.fullname)
        format.html { redirect_to event_comment_path(@event, @comment) }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    # @comment.destroy
    # respond_to do |format|
    #   format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    @event = load_event
    authorize @comment, :destroy?
    if @comment.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @comment.fullname)
      redirect_to event_path(@event)
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @comment.fullname)
      render :show
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def load_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:event_id, :user_id, :body)
    end
end
