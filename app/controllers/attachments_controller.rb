class AttachmentsController < ApplicationController

  # GET /attachments/1
  # GET /attachments/1.json
  def show
    @attachment = Attachment.find(params[:id])
  end

  # POST /attachments
  # POST /attachments.json
  def create
    #@attachment = Attachment.new(attachment_params)
    @attachment = @attachmenable.attachments.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to @attachmenable }
      else
        format.html { redirect_to @attachmenable }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to @attachment.attachmenable, notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:attachmenable_id, :attachmenable_type, :attached_file)
    end
end
