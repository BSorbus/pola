puts " "
puts "#####  RUN - test_XML.rb  #####"
puts " "

# doc = Nokogiri::XML(File.open("db/seeds/wniosek.xml")) do |config|
#   config.strict.nonet
# end

# # puts '------------------------------------------'
#   doc.remove_namespaces! # Remove namespaces from xml to make it clean
#   print doc
# # puts '------------------------------------------'




doc = Nokogiri::XML(File.open("db/seeds/wniosek.xml")) do |config|
  config.strict.nonet
end

#  doc.remove_namespaces! # Remove namespaces from xml to make it clean
#  print doc

doc.xpath("//*[local-name()='Dokument']").each do |dokument|
  dokument.xpath("//*[local-name()='TrescDokumentu']").each do |tresc_dokumentu|

    tresc_dokumentu.xpath("./*[local-name()='Wniosek']").each do |wniosek|
      puts wniosek.xpath("./*[local-name()='NumerWniosku']").text

      wniosek.xpath("./*[local-name()='Nabor']").each do |nabor|
        puts 'NABÓR:' +nabor.xpath("./*[local-name()='Id']").text
        puts 'NABÓR:' +nabor.xpath("./*[local-name()='Opis']").text
        puts 'NABÓR:' +nabor.xpath("./*[local-name()='Opis']").text.first(4)
      end
    end

    tresc_dokumentu.xpath("./*[local-name()='Projekt']").each do |projekt|
      projekt.xpath("./*[local-name()='ZrodlaFinansowania']").each do |zrodla_finansowania|
        zrodla_finansowania.xpath("./*[local-name()='Srodki']").each do |srodki|
          srodki.xpath("./*[local-name()='Wspolnotowe']").each do |wspolnotowe|
            puts wspolnotowe.xpath("./*[local-name()='Ogolem']").text
            puts wspolnotowe.xpath("./*[local-name()='Kwalifikowane']").text
          end

          srodki.xpath("./*[local-name()='KrajowePubliczneOgolem']").each do |krajowe_publiczne_ogolem|
            puts krajowe_publiczne_ogolem.xpath("./*[local-name()='Ogolem']").text
            puts krajowe_publiczne_ogolem.xpath("./*[local-name()='Kwalifikowane']").text
          end

          srodki.xpath("./*[local-name()='KrajoweBudzetPanstwa']").each do |krajowe_budzet_panstwa|
            puts krajowe_budzet_panstwa.xpath("./*[local-name()='Ogolem']").text
            puts krajowe_budzet_panstwa.xpath("./*[local-name()='Kwalifikowane']").text
          end

          srodki.xpath("./*[local-name()='KrajoweBudzetJednostekSamorzadu']").each do |krajowe_budzet_jednostek_samorzadu|
            puts krajowe_budzet_jednostek_samorzadu.xpath("./*[local-name()='Ogolem']").text
            puts krajowe_budzet_jednostek_samorzadu.xpath("./*[local-name()='Kwalifikowane']").text
          end

          srodki.xpath("./*[local-name()='KrajoweInne']").each do |krajowe_inne|
            puts krajowe_inne.xpath("./*[local-name()='Ogolem']").text
            puts krajowe_inne.xpath("./*[local-name()='Kwalifikowane']").text
          end

          srodki.xpath("./*[local-name()='Prywatne']").each do |prywatne|
            puts prywatne.xpath("./*[local-name()='Ogolem']").text
            puts prywatne.xpath("./*[local-name()='Kwalifikowane']").text
          end #/
        end

        zrodla_finansowania.xpath("./*[local-name()='Suma']").each do |suma|
          puts suma.xpath("./*[local-name()='Ogolem']").text
          puts suma.xpath("./*[local-name()='Kwalifikowane']").text
        end #/suma

        zrodla_finansowania.xpath("./*[local-name()='EBI']").each do |ebi|
          puts ebi.xpath("./*[local-name()='Ogolem']").text
          puts ebi.xpath("./*[local-name()='Kwalifikowane']").text
        end #/ebi
      end

      projekt.xpath("./*[local-name()='DaneOgolne']").each do |dane_ogolne|
        puts dane_ogolne.xpath("./*[local-name()='Tytul']").text
        puts dane_ogolne.xpath("./*[local-name()='KrotkiOpis']").text

        dane_ogolne.xpath("./*[local-name()='Rodzaj']").each do |rodzaj|
          puts rodzaj.xpath("./*[local-name()='Id']").text
          puts rodzaj.xpath("./*[local-name()='Opis']").text
        end

        dane_ogolne.xpath("./*[local-name()='OkresRealizacji']").each do |okres_realizacji|
          puts okres_realizacji.xpath("./*[local-name()='DataOd']").text
          puts okres_realizacji.xpath("./*[local-name()='DataDo']").text
        end

        dane_ogolne.xpath("./*[local-name()='OkresKwalifikowalnosciWydatkow']").each do |okres_kwalifikowalnosci_wydatkow|
          puts okres_kwalifikowalnosci_wydatkow.xpath("./*[local-name()='DataOd']").text
          puts okres_kwalifikowalnosci_wydatkow.xpath("./*[local-name()='DataDo']").text
        end

        dane_ogolne.xpath("./*[local-name()='DuzyProjekt']").each do |duzy_projekt|
          puts duzy_projekt.xpath("./*[local-name()='Id']").text
          puts duzy_projekt.xpath("./*[local-name()='Opis']").text
        end

        puts dane_ogolne.xpath("./*[local-name()='CzyPartnerstwoPublicznoPrywatne']").text
        puts dane_ogolne.xpath("./*[local-name()='PowiazaniaZeStrategiami']").xpath("./*[local-name()='CzyBrak']").text
        puts dane_ogolne.xpath("./*[local-name()='GrupaProjektow']").xpath("./*[local-name()='CzyNalezyDoGrupy']").text
 
        dane_ogolne.xpath("./*[local-name()='Klasyfikacja']").each do |klasyfikacja|
          klasyfikacja.xpath("./*[local-name()='DominujacyZakresInterwencji']").each do |dominujacy_zakres_interwencji|
            puts dominujacy_zakres_interwencji.xpath("./*[local-name()='Id']").text
            puts dominujacy_zakres_interwencji.xpath("./*[local-name()='Opis']").text
          end #/dominujacy_zakres_interwencji

          puts klasyfikacja.xpath("./*[local-name()='UzupelniajacyZakresInterwencji']").xpath("./*[local-name()='CzyBrak']").text

          klasyfikacja.xpath("./*[local-name()='FormaFinansowania']").each do |forma_finansowania|
            puts forma_finansowania.xpath("./*[local-name()='Id']").text
            puts forma_finansowania.xpath("./*[local-name()='Opis']").text
          end #/forma_finansowania

          puts klasyfikacja.xpath("./*[local-name()='TypObszaruRealizacji']").xpath("./*[local-name()='CzyBrak']").text

          klasyfikacja.xpath("./*[local-name()='RodzajDzialalnosciGospodarczej']").each do |rodzaj_dzialalnosci_gospodarczej|
            puts rodzaj_dzialalnosci_gospodarczej.xpath("./*[local-name()='Id']").text
            puts rodzaj_dzialalnosci_gospodarczej.xpath("./*[local-name()='Opis']").text
          end #/rodzaj_dzialalnosci_gospodarczej

          klasyfikacja.xpath("./*[local-name()='PKDProjektu']").each do |pkd_projektu|
            puts pkd_projektu.xpath("./*[local-name()='Id']").text
            puts pkd_projektu.xpath("./*[local-name()='Opis']").text
          end #/pkd_projektu

          puts klasyfikacja.xpath("./*[local-name()='TematUzupelniajacy']").xpath("./*[local-name()='CzyBrak']").text
        end #/klasyfikacja

        dane_ogolne.xpath("./*[local-name()='TechnologieRealizacjiProjektu']").each do |technologie_realizacji_projektu|
          technologie_realizacji_projektu.xpath("./*[local-name()='WybraneTechnologie']").each do |wybrane_technologie|
            wybrane_technologie.xpath("./*[local-name()='Element']").each do |element|
              puts element.xpath("./*[local-name()='Id']").text
              puts element.xpath("./*[local-name()='Opis']").text
            end #/element

          end #/wybrane_technologie
        end #/technologie_realizacji_projektu
      end #/ogolne_dane



    end      
  end
end



puts " "
puts "#####  END OF - test_XML.rb  #####"
puts " "


