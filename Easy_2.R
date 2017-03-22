#Task:List out all the species from the list [https://www.abdb-africa.org/genus/Papilio]

library(stringr)

url <- "https://www.abdb-africa.org/genus/Papilio"
web_line <- readLines(url, encoding = "UTF-8", warn = FALSE)

# Locate lines where species_names lie
pattern = ".*?<i>(.*?)</i>.*"
index <- grepl(pattern, web_line)

#search after the header part of html
species = list()
j = 0
headerline <- grep("</header>", web_line)
for (i in headerline:length(index)) {
  if (index[i] == TRUE) {
    j = j + 1
    species[j] = gsub(pattern, "\\1", web_line[i])
  }
}


# Check if the number of species is correct and then output the result
output <- file("SpeciesNameOut_Easy.csv")
number_line <- grep(".*?Species list: .*", web_line)
number <-
  as.integer(str_extract(web_line[number_line], "[[:blank:]]+[0-9]+"))
if (length(species) == number) {
  species<-as.character(species)
  write.csv(species,file="SpeciesNameOut_Easy.csv")
}