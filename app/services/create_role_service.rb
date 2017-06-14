class CreateRoleService
  # roles
  def role_admin
    role = Role.find_or_create_by!(name: "Administrator Systemowy") do |role|
      role.special = true
      role.activities += %w(role:index role:show role:create role:update role:delete role:add_remove_user)
      role.save!
    end
  end 
  def role_manager
    role = Role.find_or_create_by!(name: "Administrator Biznesowy") do |role|
      role.special = true
      role.activities += %w(role:index role:show project:index project:show project:create project:update project:delete)
      role.save!
    end
  end
  def role_publisher
    role = Role.find_or_create_by!(name: "Użytkownik Opiniujący i Publikujący") do |role|
      role.special = false
      role.activities += %w(project:index project:show)
      role.save!
    end
  end
  def role_writer
    role = Role.find_or_create_by!(name: "Użytkownik Opiniujący") do |role| 
      role.special = false
      role.activities += %w(project:index project:show)
      role.save!
    end
  end
  def role_appeal
    role = Role.find_or_create_by!(name: "Użytkownik Weryfikujący Odwołanie") do |role| 
      role.special = false
      role.activities += %w(project:index project:show)
      role.save!
    end
  end
end
