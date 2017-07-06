class Users::SessionsController < Devise::SessionsController

  # respond_to :json
  # dodanie powyższego umożliwia zalogowanie się z cUrla
  # curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST $ROOT_URL/users/sign_in -d '{"user":{"email":"a.wojcieszek@uke.gov.pl","password":"1qazXSW@"}}'

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
