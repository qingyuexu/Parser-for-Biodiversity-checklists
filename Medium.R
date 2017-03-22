# Task: Read the html from URL and get the all the species names
library(rvest)

getSpecies<-function(input_url,output_file){
  url = input_url
  
  #html_nodes selection please refer to selectorgadget.com
  species_name = url %>% 
    read_html() %>% 
    html_nodes(".SN li:nth-child(1) > i:nth-child(1)") %>% 
    html_text()
  write.csv(species_name,file=output_file)
  print(species_name)

}

getSpecies('http://ftp.funet.fi/pub/sci/bio/life/insecta/lepidoptera/ditrysia/papilionoidea/papilionidae/papilioninae/lamproptera/',
           "SpeciesNameOut_Medium.csv")