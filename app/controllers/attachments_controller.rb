class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  # GET /attachments/1
  # GET /attachments/1.json
  def show
    # @attachment = Attachment.find(params[:id])
    # saved_file = @attachment.attached_file.file
    # data = open(saved_file.file)

    # send_data data, 
    #   filename: @attachment.attached_file_identifier,
    #   type: @attachment.file_content_type, 
    #   disposition: "attachment"              

    @attachment = Attachment.find(params[:id])
    attachment_authorize(:attachment, "show", @attachment.attachmenable_type.singularize.downcase)    
    # is OK
    # send_file "#{@attachment.attached_file.file.file}"
    send_file "#{@attachment.attached_file.path}"
  end

  # POST /attachments
  # POST /attachments.json
  def create
    attachment_authorize(:attachment, "create", params[:controller].classify.deconstantize.singularize.downcase)    
    @attachment = @attachmenable.attachments.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @attachment.fullname)
        format.html { redirect_to @attachmenable }
      else
        flash[:error] = t('activerecord.errors.messages.created', data: @attachment.fullname)
        format.html { redirect_to @attachmenable }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    attachment_authorize(:attachment, "destroy", @attachment.attachmenable_type.singularize.downcase)    
    if @attachment.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @attachment.fullname)
      redirect_to @attachment.attachmenable
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @attachment.fullname)
      render :show
    end      
  end

  private
    def attachment_authorize(model_class, action, sub_controller)
      unless ['index', 'show', 'create', 'destroy'].include?(action)
         raise "Ruby injection"
      end
      puts '================================================'
      puts sub_controller
      puts "================================================"
      authorize model_class,"#{sub_controller}_#{action}?"      
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:attachmenable_id, :attachmenable_type, :attached_file)
    end
end
