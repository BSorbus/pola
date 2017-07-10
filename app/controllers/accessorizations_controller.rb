class AccessorizationsController < ApplicationController
  before_action :authenticate_user!


  def datatables_index_user
    respond_to do |format|
      format.json{ render json: UserAccessorizationsDatatable.new(view_context, { only_for_current_user_id: params[:user_id] }) }
    end
  end



end
