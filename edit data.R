library(dplyr)
library(stringr)

# Define folder path
folder_path <- "/Users/lilsonea/Documents/GitHub/Kansenkloof_Nederland/data/nl"

# List all CSV files in the folder
csv_files <- list.files(folder_path, pattern = "\\.csv$", full.names = TRUE)

# Loop through each file
for (file in csv_files) {
  # Read CSV
  df <- read.csv(file, stringsAsFactors = FALSE)
  
  # Check if 'geografie' column exists and apply transformation
  if ("geografie" %in% colnames(df)) {
    df <- df %>%
      mutate(geografie = as.character(geografie),  # Convert to character
             geografie = if_else(str_detect(geografie, "^\\d{3}$"), 
                                 paste0(geografie, "X"), 
                                 geografie))
  }
  
  # Overwrite the original file
  write.csv(df, file, row.names = FALSE)
}


# Function to translate certain keywords from Dutch to English
translate_en <- function(i) {
  levels(i$geslacht)[match("Totaal",levels(i$geslacht))] <- "Total"
  levels(i$geslacht)[match("Mannen",levels(i$geslacht))] <- "Men"
  levels(i$geslacht)[match("Vrouwen",levels(i$geslacht))] <- "Women"
  
  levels(i$migratieachtergrond)[match("Totaal",levels(i$migratieachtergrond))] = "Total"
  levels(i$migratieachtergrond)[match("Marokko",levels(i$migratieachtergrond))] = "Morocco"
  levels(i$migratieachtergrond)[match("Turkije",levels(i$migratieachtergrond))] = "Turkey"
  levels(i$migratieachtergrond)[match("Suriname",levels(i$migratieachtergrond))] = "Suriname"
  levels(i$migratieachtergrond)[match("Nederlandse Antillen",levels(i$migratieachtergrond))] = "Dutch Caribbean"
  levels(i$migratieachtergrond)[match("Wel migratieachtergrond",levels(i$migratieachtergrond))] = "With Migration Background"
  levels(i$migratieachtergrond)[match("Zonder migratieachtergrond",levels(i$migratieachtergrond))] = "No Migration Background"
  
  
  levels(i$huishouden)[match("Totaal",levels(i$huishouden))] <- "Total"
  levels(i$huishouden)[match("Eenoudergezin",levels(i$huishouden))] <- "Single Parent"
  levels(i$huishouden)[match("Tweeoudergezin",levels(i$huishouden))] <- "Two Parents"
  
  
  if ("opleiding_ouders" %in% names(i)) {
    levels(i$opleiding_ouders)[match("Totaal",levels(i$opleiding_ouders))] <- "Total"
  }
  
  
  levels(i$bins)[match("Totaal",levels(i$bins))] <- "Total"
  
  levels(i$geografie)[match("Nederland", levels(i$geografie))] <- "The Netherlands"
  
  levels(i$opleiding_ouders)[match("geen hbo of wo", levels(i$opleiding_ouders))] <- "no hbo or wo"
  
  return(i)
}

# Loop through each file
for (file in csv_files) {
  # Read CSV
  df <- read.csv(file, stringsAsFactors = TRUE)  # Ensure factors are recognized
  
  # Apply translation function
  df <- translate_en(df)
  
  # Overwrite the original file
  write.csv(df, file, row.names = FALSE)
}

