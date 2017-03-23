# Task: Read the html from URL and get the all the species names
library(rvest)
library(stringr)

url = 'http://ftp.funet.fi/pub/sci/bio/life/insecta/lepidoptera/ditrysia/papilionoidea/papilionidae/papilioninae/lamproptera/'

#html_nodes selection please refer to selectorgadget.com
species_line = url %>% 
  read_html() %>% 
  html_nodes(".SP .SN > li") %>% html_text()

sciname <- gsub("\\;.*","",species_line)
author_year <- gsub(".*  ","",sciname)
Author<-gsub(",.*","",author_year)
year<-str_trim(gsub(".*,","",author_year))
for(i in 1:length(year)){
  if(str_detect(year[i],"\\[.*\\]")){
  Year<-str_replace(year,"\\[.*\\]",str_sub(year,2,5))
  }
}

Genus<-c()
Species<-c()
Subspecies<-c()
sci<-gsub("  .*","",sciname)
sci_split<-str_split(sci," ")
for(i in 1:length(sci_split)){
  if(length(sci_split[[i]])==2){
    Genus[i]<-sci_split[[i]][1]
    Species[i]<-sci_split[[i]][2]
    Subspecies[i]<-"NA"
  }
  if(length(sci_split[[i]])==3){
    Genus[i]<-sci_split[[i]][1]
    Species[i]<-sci_split[[i]][2]
    Subspecies[i]<-sci_split[[i]][3]
  }
}

table<-cbind(as.data.frame(Genus),
             as.data.frame(Species),
             as.data.frame(Subspecies),
             as.data.frame(Author),
             as.data.frame(Year))

write.csv(table, file = "Medium_extension.csv", row.names = T)
