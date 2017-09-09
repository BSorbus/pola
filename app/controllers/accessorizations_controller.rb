class AccessorizationsController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized


  # Projects for showed user
  def datatables_index_user
    respond_to do |format|
      format.json{ render json: AccessorizationsDatatable.new(view_context, { only_for_current_user_id: params[:user_id] }) }
    end
  end

  # Projects for showed role
  def datatables_index_role
    respond_to do |format|
      format.json{ render json: AccessorizationsDatatable.new(view_context, { only_for_current_role_id: params[:role_id] }) }
    end
  end


end
