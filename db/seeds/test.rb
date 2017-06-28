puts " "
puts "#####  RUN - test.rb  #####"
puts " "

#doc = Nokogiri::XML(xml_doc)
#puts '------------------------------------------'
#doc.remove_namespaces! # Remove namespaces from xml to make it clean
#print doc


def display_xml(filename)
  xsd_doc = Nokogiri::XML::Schema(File.open("db/seeds/"+filename)) do |config|
  #doc = Nokogiri::XML::Schema(File.open("db/seeds/"+filename)) do |config|
    config.strict.nonet
  end
  print xsd_doc
end




#display_xml("rodzaj_wysylki.xml")
display_xml("adres.xsd")

puts " "
puts "#####  END OF - test.rb  #####"
puts " "
