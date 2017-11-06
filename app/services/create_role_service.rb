class CreateRoleService
  # roles
  def work_observer
    role = Role.find_or_create_by!(name: "Obserwator Działań") do |role|
      role.special = true
      role.activities += %w(all:work role:work user:work customer:work project:work event:work errand:work rating:work)
      role.note = "Rola służy do obserwowania historii wpisów, działań. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  def role_admin
    role = Role.find_or_create_by!(name: "Administrator Ról Systemowych") do |role|
      role.special = true
      role.activities += %w(role:index role:show role:create role:update role:delete role:work)
      role.note = "Rola służy do tworzenia, modyfikowania Ról. \r\n (Przypisz tylko zaawansowanym Administratorom systemu)"
      role.save!
    end
  end 
  def role_observer
    role = Role.find_or_create_by!(name: "Obserwator Ról Systemowych") do |role|
      role.special = true
      role.activities += %w(role:index role:show)
      role.note = "Rola służy do wyświetlania informacji o Rolach."
      role.save!
    end
  end

  # users
  def user_admin
    role = Role.find_or_create_by!(name: "Administrator Użytkowników") do |role|
      role.special = true
      role.activities += %w(user:index user:show user:create user:update user:delete role:add_remove_role_user user:work)
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

  # user_attachments
  def user_attachment_admin
    role = Role.find_or_create_by!(name: "Administrator Załączników Użytkownika") do |role|
      role.special = true
      role.activities += %w(attachment:user_index attachment:user_show attachment:user_create attachment:user_delete)
      role.note = "Rola służy do zarządzania załącznikami przypisanymi do Użytkowników. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def user_attachment_observer
    role = Role.find_or_create_by!(name: "Obserwator Załączników Użytkownika") do |role|
      role.special = true
      role.activities += %w(attachment:user_index attachment:user_show)
      role.note = "Rola służy do wyświetlania i pobierania załączników przypisanych do Użytkowników. \r\n (Przypisz Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end


  # customers
  def customer_admin
    role = Role.find_or_create_by!(name: "Administrator Wnioskodawców") do |role|
      role.special = true
      role.activities += %w(customer:index customer:show customer:create customer:update customer:delete customer:work)
      role.note = "Rola służy do zarządzania Wnioskodawcami.\r\n(Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def customer_observer
    role = Role.find_or_create_by!(name: "Obserwator Wnioskodawców") do |role|
      role.special = true
      role.activities += %w(customer:index customer:show)
      role.note = "Rola służy do wyświetlania informacji o Wnioskodawcach.\r\n(Przypisz wszystkim, którzy mogą przeglądać dane Wnioskodawców)"
      role.save!
    end
  end

  # projects
  def project_admin
    role = Role.find_or_create_by!(name: "Administrator Projektów") do |role|
      role.special = true
      role.activities += %w(project:index project:show project:create project:update project:delete project:work)
      role.note = "Rola służy do zarządzania Projektami.\r\n(Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def project_observer
    role = Role.find_or_create_by!(name: "Obserwator Projektów") do |role|
      role.special = true
      role.activities += %w(project:index project:show)
      role.note = "Rola służy do wyświetlania informacji o Projektach.\r\n(Przypisz wszystkim, którzy mogą przeglądać Projekty)"
      role.save!
    end
  end

  # project_attachments
  def project_attachment_admin
    role = Role.find_or_create_by!(name: "Administrator Załączników Projektu") do |role|
      role.special = true
      role.activities += %w(attachment:project_index attachment:project_show attachment:project_create attachment:project_delete)
      role.note = "Rola służy do zarządzania załącznikami przypisanymi do Projektów. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def project_attachment_observer
    role = Role.find_or_create_by!(name: "Obserwator Załączników Projektu") do |role|
      role.special = true
      role.activities += %w(attachment:project_index attachment:project_show)
      role.note = "Rola służy do wyświetlania i pobierania załączników przypisanych do Projektów. \r\n (Przypisz Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  # project_point_files
  def project_point_file_admin
    role = Role.find_or_create_by!(name: "Administrator Plików Punktów Adresowych") do |role|
      role.special = true
      role.activities += %w(point_file:index point_file:download point_file:show point_file:create point_file:update point_file:delete point_file:work)
      role.note = "Rola służy do zarządzania plikami punktów adresowych przypisanymi do Projektów. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def project_point_file_observer
    role = Role.find_or_create_by!(name: "Obserwator Plików Punktów Adresowych") do |role|
      role.special = true
      role.activities += %w(point_file:index point_file:download point_file:show)
      role.note = "Rola służy do wyświetlania i pobierania plików punktów adresowych przypisanych do Projektów. \r\n (Przypisz Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  # project_xml_files
  def project_proposal_file_admin
    role = Role.find_or_create_by!(name: "Administrator Plików Projektowych XML") do |role|
      role.special = true
      role.activities += %w(proposal_file:index proposal_file:download proposal_file:show proposal_file:create proposal_file:update proposal_file:delete proposal_file:work)
      role.note = "Rola służy do zarządzania plikami projektowymi xml przypisanymi do Projektów. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def project_proposal_file_observer
    role = Role.find_or_create_by!(name: "Obserwator Plików Projektowych XML") do |role|
      role.special = true
      role.activities += %w(proposal_file:index proposal_file:download proposal_file:show)
      role.note = "Rola służy do wyświetlania i pobierania plików projektowych xml przypisanych do Projektów. \r\n (Przypisz Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  # errands
  def errand_admin
    role = Role.find_or_create_by!(name: "Administrator Zleceń") do |role|
      role.special = true
      role.activities += %w(errand:index errand:show errand:create errand:update errand:delete errand:work)
      role.note = "Rola służy do zarządzania Zleceniami. \r\n(Przypisz Koordynatorom POPC)"
      role.save!
    end
  end
  def errand_observer
    role = Role.find_or_create_by!(name: "Obserwator Zleceń") do |role|
      role.special = true
      role.activities += %w(errand:index errand:show)
      role.note = "Rola służy do wyświetlania informacji o Zleceniach.\r\n(Przypisz wszystkim, którzy mogą przeglądać Zlecenia)"
      role.save!
    end
  end

  # errand_attachments
  def errand_attachment_admin
    role = Role.find_or_create_by!(name: "Administrator Załączników Zlecenia") do |role|
      role.special = true
      role.activities += %w(attachment:errand_index attachment:errand_show attachment:errand_create attachment:errand_delete)
      role.note = "Rola służy do zarządzania załącznikami przypisanymi do Zleceń. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def errand_attachment_observer
    role = Role.find_or_create_by!(name: "Obserwator Załączników Zlecenia") do |role|
      role.special = true
      role.activities += %w(attachment:errand_index attachment:errand_show)
      role.note = "Rola służy do wyświetlania i pobierania załączników przypisanych do Zleceń. \r\n (Przypisz Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  # events
  def event_admin
    role = Role.find_or_create_by!(name: "Administrator Zadań") do |role|
      role.special = true
      role.activities += %w(event:index event:show event:create event:update event:delete event:work)
      role.note = "Rola służy do zarządzania Zadaniami. \r\n(Przypisz Koordynatorom POPC)"
      role.save!
    end
  end
  def event_observer
    role = Role.find_or_create_by!(name: "Obserwator Zadań") do |role|
      role.special = true
      role.activities += %w(event:index event:show)
      role.note = "Rola służy do wyświetlania informacji o Zadaniach.\r\n(Przypisz wszystkim, którzy mogą przeglądać Zadania/Zdarzenia)"
      role.save!
    end
  end

  # event_attachments
  def event_attachment_admin
    role = Role.find_or_create_by!(name: "Administrator Załączników Zadania") do |role|
      role.special = true
      role.activities += %w(attachment:event_index attachment:event_show attachment:event_create attachment:event_delete)
      role.note = "Rola służy do zarządzania załącznikami przypisanymi do Zadań. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end
  def event_attachment_observer
    role = Role.find_or_create_by!(name: "Obserwator Załączników Zadania") do |role|
      role.special = true
      role.activities += %w(attachment:event_index attachment:event_show)
      role.note = "Rola służy do wyświetlania i pobierania załączników przypisanych do Zadań. \r\n (Przypisz Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  # comments
  def comment_admin
    role = Role.find_or_create_by!(name: "Administrator Komentarzy") do |role|
      role.special = true
      #role.activities += %w(comment:index comment:show comment:create comment:update comment:delete)
      role.activities += %w(comment:index comment:show comment:create comment:delete)
      role.note = "Rola służy do zarządzania komentarzami w Zadaniach. \r\n(Przypisz Koordynatorom POPC)"
      role.save!
    end
  end
  def comment_observer
    role = Role.find_or_create_by!(name: "Obserwator Komentarzy") do |role|
      role.special = true
      role.activities += %w(comment:index comment:show)
      role.note = "Rola służy do wyświetlania komentarzy w Zadaniach.\r\n(Przypisz wszystkim, którzy mogą przeglądać komentarze w Zadaniach)"
      role.save!
    end
  end

  # ratings
  def rating_admin
    role = Role.find_or_create_by!(name: "Administrator Ocen") do |role|
      role.special = true
      role.activities += %w(rating:index rating:show rating:create rating:update rating:delete rating:export rating:work)
      role.note = "Rola służy do zarządzania Ocenami w Zadaniach. \r\n(Przypisz Koordynatorom POPC)"
      role.save!
    end
  end
  def rating_observer
    role = Role.find_or_create_by!(name: "Obserwator Ocen") do |role|
      role.special = true
      role.activities += %w(rating:index rating:show)
      role.note = "Rola służy do wyświetlania Ocen w Zadaniach.\r\n(Przypisz wszystkim, którzy mogą przeglądać komentarze w Zadaniach)"
      role.save!
    end
  end




  def accessorization_manager
    role = Role.find_or_create_by!(name: "Administrator Ról Projektowych") do |role|
      role.special = true
      role.activities += %w(accessorization:index accessorization:create_update_delete role:index_only_not_special role:show_only_not_special)
      role.note = "Rola służy zarządzania Rolami Projektowymi.\r\n(Przypisz tylko Administratorom oraz Koordynatorom POPC)"
      role.save!
    end
  end 
  def accessorization_observer
    role = Role.find_or_create_by!(name: "Obserwator Ról Projektowych") do |role|
      role.special = true
      role.activities += %w(accessorization:index role:index_only_not_special role:show_only_not_special)
      role.note = "Rola służy do wyświetlania informacji o przypisanych Użytkownikach do projektów.\r\n(Przypisz wszystkim, którzy mogą przeglądać Projekty)"
      role.save!
    end
  end 



  def role_for_event_performer
    role = Role.find_or_create_by!(name: "Wykonawca") do |role|
      role.special = false
      role.activities += %w(*:index *:show *:create *:update *:delete comment:create attachment:event_create attachment:event_delete)
      role.note = "Rola Projektowa, która służy do realizacji zadania/zlecenia.\r\n(Przypisz tę rolę projektową tzw. 'Użytkownikowi wykonującemu' zadanie w konkretnym Projekcie)"
      role.save!
    end
  end

  def role_for_event_observer
    role = Role.find_or_create_by!(name: "Obserwator") do |role|
      role.special = false
      role.activities += %w(*:index *:show)
      role.note = "Rola Projektowa, która służy do obserwowania procesu realizacji zadań/zleceń.\r\n(Przypisz tę rolę projektową tzw. 'Użytkownikowi obserwującemu' w konkretnym Projekcie)"
      role.save!
    end
  end


end
