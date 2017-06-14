class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.name = Rails.application.secrets.admin_name
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        #user.admin!
      end
  end

  def call_simple(email, name, pass)
    user = User.find_or_create_by!(email: "#{email}") do |user|
        user.name = "#{name}"
        user.password = "#{pass}"
        user.password_confirmation = "#{pass}"
        #user.admin!
      end
  end

end
