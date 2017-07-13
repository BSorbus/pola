class CreateRoleService
  # roles
  def role_admin
    role = Role.find_or_create_by!(name: "Administrator Ról Systemowych") do |role|
      role.special = true
      role.activities += %w(role:index role:show role:create role:update role:delete)
      role.note = "Rola służy do tworzenia, modyfikowania Ról. \r\n (Przypisz tylko zaawansowanym Administratorom systemu)"
      role.save!
    end
  end 
  def role_observer
    role = Role.find_or_create_by!(name: "Obserwator Ról Systemowych") do |role|
      role.special = true
      role.activities += %w(role:index role:show)
      role.note = "Rola służy do wyświetlania informacji o Rólach."
      role.save!
    end
  end

  # users
  def user_admin
    role = Role.find_or_create_by!(name: "Administrator Użytkowników") do |role|
      role.special = true
      role.activities += %w(user:index user:show user:create user:update user:delete role:add_remove_role_user)
      role.note = "Rola służy do zarządzania Użytkownikami i przypisywania im Ról Systemowych. \r\n (Przypisz tylko zaawansowanym Administratorom systemu)"
      role.save!
    end
  end
  def user_observer
    role = Role.find_or_create_by!(name: "Obserwator Użytkowników") do |role|
      role.special = true
      role.activities += %w(user:index user:show)
      role.note = "Rola służy do wyświetlania informacji o Użytkownikach. \r\n (Przypisz Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  # customers
  def customer_admin
    role = Role.find_or_create_by!(name: "Administrator Wnioskodawców") do |role|
      role.special = true
      role.activities += %w(customer:index customer:show customer:create customer:update customer:delete)
      role.note = "Rola służy do zarządzania Wnioskodawcami. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def customer_observer
    role = Role.find_or_create_by!(name: "Obserwator Wnioskodawców") do |role|
      role.special = true
      role.activities += %w(customer:index customer:show)
      role.note = "Rola służy do wyświetlania informacji o Wnioskodawcach. (Przypisz wszystkim, którzy mogą przeglądać dane Wnioskodawców)"
      role.save!
    end
  end

  # projects
  def project_admin
    role = Role.find_or_create_by!(name: "Administrator Projektów") do |role|
      role.special = true
      role.activities += %w(project:index project:show project:create project:update project:delete)
      role.note = "Rola służy do zarządzania Projektami. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def project_observer
    role = Role.find_or_create_by!(name: "Obserwator Projektów") do |role|
      role.special = true
      role.activities += %w(project:index project:show)
      role.note = "Rola służy do wyświetlania informacji o Projektach. (Przypisz wszystkim, którzy mogą przeglądać Projekty)"
      role.save!
    end
  end




  def accessorization_manager
    role = Role.find_or_create_by!(name: "Menadżer Ról Projektowych") do |role|
      role.special = true
      role.activities += %w(accessorization:index accessorization:show accessorization:create accessorization:update accessorization:delete role:index_only_not_special role:show_only_not_special role:add_remove_role_user_only_not_special)
      role.note = "Rola służy zarządzania Rolami Projektowymi. \r\n (Przypisz tylko Administratorom oraz Koordynatorom POPC)"
      role.save!
    end
  end 
  def accessorization_observer
    role = Role.find_or_create_by!(name: "Obserwator Ról Projektowych") do |role|
      role.special = true
      role.activities += %w(accessorization:index accessorization:show role:index_only_not_special role:show_only_not_special)
      role.note = "Rola służy do wyświetlania informacji o przypisanych Użytkownikach do projektów. (Przypisz wszystkim, którzy mogą przeglądać Projekty)"
      role.save!
    end
  end 



  def role_for_projects_publisher
    role = Role.find_or_create_by!(name: "Użytkownik Opiniujący i Publikujący") do |role|
      role.special = false
      role.activities += %w(customer:index customer:show project:index project:show)
      role.note = "Rola Projektowa, która służy do publikowania treści opinii. \r\n (Przypisz tę rolę projektową tzw. 'Użytkownikowi podpisującemu' w konkretnym Projekcie)"
      role.save!
    end
  end
  def role_for_projects_writer
    role = Role.find_or_create_by!(name: "Użytkownik Opiniujący") do |role| 
      role.special = false
      role.activities += %w(customer:index customer:show project:index project:show)
      role.note = "Rola Projektowa, która służy do opiniowania Projektu. \r\n (Przypisz tę rolę projektową tzw. 'Użytkownikowi opiniującemu' w konkretnym Projekcie)"
      role.save!
    end
  end

end
