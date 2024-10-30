# This script adds data for the whole Netherlands available at ongelijkheidincijfers.amsterdam
# We do this for the dutch version of the data
# The data is translated to English in the R script 03_translate_data.R

bins <- c("bins5", "bins10", "bins20", "mean")
outcomes <- c("child_mortality", "classroom", "elementary_School", "high_school", "perinatal", "students", "main")


for (bin in bins) {
    for (outcome in outcomes) {
      file_path <- paste0("/Users/lilsonea/Documents/GitHub/Kansenkloof_Nederland/data/nl/", bin, "_tab_", outcome, ".csv")
      amsterdam_file_path <- paste0("/Users/lilsonea/Documents/GitHub/kenniscentrumongelijkheid/data/nl/", bin, "_tab.rds")

      if (file.exists(file_path) & file.exists(amsterdam_file_path)) {
        data <- read.csv(file_path)
        amsterdam <- readRDS(amsterdam_file_path)
        
        amsterdam_relevant <- amsterdam %>%
          filter(geografie == "Nederland", uitkomst %in% unique(data$uitkomst)) %>%
          mutate(
            N = as.integer(N),
            type = as.integer(type),
            uitkomst_NL = as.character(uitkomst_NL)
          )
        # Combine datasets
        combined_data <- bind_rows(data, amsterdam_relevant)
        write.csv(combined_data, file_path, row.names = FALSE)
      } else {
        message(paste("File not found for:", bin, outcome))
      }
    }
}



#For data by parental education
#*Only elementary school and perinatal outcomes are available

outcomes <- c("elementary_School", "perinatal")

for (outcome in outcomes) {
    file_path <- paste0("~/Documents/GitHub/Kansenkloof_Nederland/data/nl/parents_edu_tab_", outcome, ".csv")
    amsterdam_file_path <- paste0("~/Documents/GitHub/kenniscentrumongelijkheid/data/nl/parents_edu_tab.rds")

    if (file.exists(file_path) & file.exists(amsterdam_file_path)) {
      # Load existing main file if it exists
      data <- read.csv(file_path)

      # Load Amsterdam file and filter for Nederland only
      amsterdam <- readRDS(amsterdam_file_path)
      
      
      amsterdam_relevant <- amsterdam %>%
        filter(geografie == "Nederland", uitkomst %in% unique(data$uitkomst)) %>%
        mutate(
          N = as.integer(N),
          uitkomst_NL = as.character(uitkomst_NL)
          )
      # Combine datasets and write to main file path
      combined_data <- bind_rows(data, amsterdam_relevant)
      write.csv(combined_data, file_path, row.names = FALSE)
    } else {
      # If neither file exists, print a message
      message(paste("File not found for:", bin, outcome))
    }
}


#split large files in 2
bins <- c("bins10", "bins20")

for (bin in bins) {
    file_path <- paste0("/Users/lilsonea/Documents/GitHub/Kansenkloof_Nederland/data/nl/", bin, "_tab_main.csv")

    if (file.exists(file_path)) {
      data <- read.csv(file_path)

      split_index <- ceiling(nrow(data) / 2)
      data_1 <- data[1:split_index,]
      data_2 <- data[(split_index+1):nrow(data), ]
      
      file_path_1 <- gsub(".csv$", "_1.csv", file_path)
      file_path_2 <- gsub(".csv$", "_2.csv", file_path)
      
      write.csv(data_1, file_path_1, row.names = FALSE)
      write.csv(data_2, file_path_2, row.names = FALSE)
      
      file.remove(file_path)
    }
}