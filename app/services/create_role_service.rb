class CreateRoleService
  # roles
  def role_admin
    role = Role.find_or_create_by!(name: "Administrator Systemowy") do |role|
      role.activities += %w(role:index role:show role:create role:update role:delete role:add_remove_user)
      role.save!
    end
  end 
  def role_manager
    role = Role.find_or_create_by!(name: "Administrator Biznesowy") do |role|
      role.activities += %w(role:index role:show)
      role.save!
    end
  end
end
