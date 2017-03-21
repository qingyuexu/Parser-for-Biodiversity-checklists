# Task: Read the html from URL and get the genus name

# According to the structure of this website
# the genus names will appear in the top table of this page.
library(XML)

url <- "http://ftp.funet.fi/pub/sci/bio/life/insecta/lepidoptera/ditrysia/papilionoidea/papilionidae/papilioninae/lamproptera/"
web_parsed <- htmlParse(url, encoding = "UTF-8")

# read data from HTML tables
tables <- readHTMLTable(web_parsed, stringsAsFactors = FALSE)

genus_list <- tables[1]$'NULL'
# get the scientific names of this genus
genus_name<-genus_list$`Scientific names`[1]
genus_name

# if you want to get other genus names which appear on this page, 
# please comment out the following lines

# # prev
# print(genus_list$prev)
# # next
# next_genus<-genus_list$`next`
# next_genus<-next_genus[!is.na(next_genus)]
# print(next_genus[!next_genus==""])
# # Finnish Names
# finnish<-levels(as.factor(gsub("[(.*)]", "", genus_list$`Finnish names`)))
# print(finnish[!finnish==""])
# # English Names
# english<-genus_list$`English names`[!genus_list$`English names`==""]
# print(levels(factor(english)))