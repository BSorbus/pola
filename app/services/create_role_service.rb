class CreateRoleService
  # roles
  def role_admin
    role = Role.find_or_create_by!(name: "Administrator Ról Systemowych") do |role|
      role.special = true
      role.activities += %w(role:index role:show role:create role:update role:delete role:add_remove_user role:work)
      role.save!
    end
  end 
  def role_observer
    role = Role.find_or_create_by!(name: "Obserwator Ról Systemowych") do |role|
      role.special = true
      role.activities += %w(role:index role:show)
      role.save!
    end
  end

  # users
  def user_admin
    role = Role.find_or_create_by!(name: "Administrator Użytkowników") do |role|
      role.special = true
      role.activities += %w(user:index user:show user:create user:update user:delete role:add_remove_user user:work)
      role.save!
    end
  end
  def user_observer
    role = Role.find_or_create_by!(name: "Obserwator Użytkowników") do |role|
      role.special = true
      role.activities += %w(user:index user:show)
      role.save!
    end
  end

  # customers
  def customer_admin
    role = Role.find_or_create_by!(name: "Administrator Wnioskodawców") do |role|
      role.special = true
      role.activities += %w(customer:index customer:show customer:create customer:update customer:delete)
      role.save!
    end
  end
  def customer_observer
    role = Role.find_or_create_by!(name: "Obserwator Wnioskodawców") do |role|
      role.special = true
      role.activities += %w(customer:index customer:show)
      role.save!
    end
  end

  # projects
  def project_admin
    role = Role.find_or_create_by!(name: "Administrator Projektów") do |role|
      role.special = true
      role.activities += %w(project:index project:show project:create project:update project:delete)
      role.save!
    end
  end
  def project_observer
    role = Role.find_or_create_by!(name: "Obserwator Projektów") do |role|
      role.special = true
      role.activities += %w(project:index project:show)
      role.save!
    end
  end




  def role_for_projects_manager
    role = Role.find_or_create_by!(name: "Menadżer Ról Projektowych") do |role|
      role.special = true
      role.activities += %w(role:index_only_not_special role:show_only_not_special role:add_remove_user_only_not_special)
      role.save!
    end
  end 
  def role_for_projects_observer
    role = Role.find_or_create_by!(name: "Obserwator Ról Projektowych") do |role|
      role.special = true
      role.activities += %w(role:index_only_not_special role:show_only_not_special)
      role.save!
    end
  end 


  def role_for_projects_publisher
    role = Role.find_or_create_by!(name: "Użytkownik Opiniujący i Publikujący") do |role|
      role.special = false
      role.activities += %w(customer:index customer:show project:index project:show)
      role.save!
    end
  end
  def role_for_projects_writer
    role = Role.find_or_create_by!(name: "Użytkownik Opiniujący") do |role| 
      role.special = false
      role.activities += %w(customer:index customer:show project:index project:show)
      role.save!
    end
  end

end
