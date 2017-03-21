parseFile <- function(input_file, output_file) {
  require(stringr)
  # Read file
  taxo <- read.csv(input_file, sep = "\t" , header = FALSE)
  length <- length(taxo[, 1])
  
  # SciName
  sciName_index <- grep("^[0-9]", taxo[, 1])
  sciName <- taxo[sciName_index,]
  sciName <- gsub("^[0-9]+. ", "", sciName)
  
  # Distribution
  Distribution <- c()
  n = 0
  cur_dis = ""
  for (i in 1:length) {
    if (str_detect(taxo[i, 1], "Distribution:") &&
        (str_detect(taxo[i, 1], "[*. ]$"))) {
      n = n + 1
      cur_dis <- str_split(taxo[i, 1], "Distribution: ")[[1]][2]
    }
    Distribution[n] <- cur_dis
    if ((str_detect(taxo[i, 1], "Distribution:")) &&
        (str_detect(taxo[i, 1], "[*. ]$") == FALSE)) {
      n = n + 1
      dstr_line <- ""
      dstr_line <- taxo[i, 1]
      if (i < length - 1) {
        j = i + 1
      }
      while (j < length - 1) {
        if (grepl("^[0-9]", taxo[j + 1, 1]) |
            grepl("^[[:alpha:]]*$", taxo[j + 1, 1])) {
          dstr_line <- paste(dstr_line, taxo[j, 1])
          break
        } else{
          dstr_line <- paste(dstr_line, taxo[j, 1])
          j = j + 1
        }
      }
      cur_dis <- str_split(dstr_line, "Distribution: ")[[1]][2]
      dstr_line <- ""
    }
    Distribution[n] <- cur_dis
  }
  
  # Family
  family_index <- grep("^[[:alpha:]]*$", taxo[, 1])
  family_name <- taxo[family_index,]
  total_num = length(sciName)
  cur_index = c()
  cur_num = c()
  for (i in 1:length(family_index)) {
    cur_index[i] <-
      (str_match(as.character(taxo[family_index[i] + 1, 1]), "^[0-9]+. "))
    cur_index[i] <- str_split(cur_index[i], "[\\.]")[[1]][1]
    cur_num[i] <- as.integer(cur_index[i])
  }
  cur_num <- c(cur_num, total_num + 1)
  Family <- rep(family_name, diff(cur_num))
  
  table <-
    cbind(as.data.frame(Family),
          as.data.frame(sciName),
          as.data.frame(Distribution))
  
  write.csv(table, file = output_file, row.names = F)
}

parseFile("taxo01.txt", "taxo_out01.csv")