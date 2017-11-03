puts "##### #####  RUN - project.rb  ##### #####"
puts " "

require 'csv'

File.open(File.join("db/seeds/files/log", 'project.log'), 'a+') do |f|
  f.puts "##### #####  041_project.rb  ##### #####"
  f.puts "Project.all: #{Project.all.size}"
  f.puts "... load from db/seeds/files/project.csv... start..."
end 
puts "Projects all: #{Project.all.size}"


#######################################################################
CSV.foreach("db/seeds/files/project_win1250.csv", {encoding: "WINDOWS-1250:UTF-8", 
                                            headers: true, 
                                            header_converters: :symbol, 
                                            col_sep: ';'}) do |row|

  @project = Project.new(
    number:                row[:number],  
    registration:          row[:registration],  
    project_status_id:     row[:project_status_id],  
    customer_id:           row[:customer_id],  
    note:                  row[:note].present? ? row[:note] : ""
    #user_id:               seek_user(row[:change_user]),
    )


  if @project.valid?
    # wyswietl info na ekranie
    puts "#{row[:project_id]} - #{row[:number]} ...load OK"

    #zapisz info do pliku
    File.open(File.join("db/seeds/files/log", 'project.log'), 'a+') do |f|
      f.puts "CUSTOMER_ID: #{row[:project_id]} - #{row[:number]} ...load OK"
      f.puts ""
    end 

    @project.save

  else
    # jeżeli jednak był błąd
    # wyswietl błąd na ekranie
    puts "ERROR(s)"
    puts "      CUSTOMER_ID: #{row[:project_id]}"
    @project.errors.full_messages.each do |msg|
      puts " - #{msg}"
    end     
    puts ""

    #zapisz błąd do pliku
    File.open(File.join("db/seeds/files/log", 'project.error'), 'a+') do |f|
      f.puts "ERROR(s)"
      f.puts "      CUSTOMER_ID: #{row[:project_id]}"
      @project.errors.full_messages.each do |msg|
        f.puts " - #{msg}"
      end     
      f.puts ""
    end 
  end

end
#######################################################################

puts "Projects all: #{Project.all.size}"
File.open(File.join("db/seeds/files/log", 'project.log'), 'a+') do |f|
  f.puts "Project.all: #{Project.all.size}"
  f.puts "##### #####  END ...load from 031_project.rb  ##### #####"
end 

puts " "
puts "##### #####  END - project.rb  ##### #####"
