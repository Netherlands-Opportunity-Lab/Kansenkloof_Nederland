library(tidyverse)

# Function to translate certain keywords from Dutch to English
translate_en <- function(i) {
  levels(i$geslacht)[match("Totaal",levels(i$geslacht))] <- "Total"
  levels(i$geslacht)[match("Mannen",levels(i$geslacht))] <- "Men"
  levels(i$geslacht)[match("Vrouwen",levels(i$geslacht))] <- "Women"
  
  levels(i$migratieachtergrond)[match("Totaal",levels(i$migratieachtergrond))] = "Total"
  levels(i$migratieachtergrond)[match("Marokko",levels(i$migratieachtergrond))] = "Morocco"
  levels(i$migratieachtergrond)[match("Turkije",levels(i$migratieachtergrond))] = "Turkey"
  levels(i$migratieachtergrond)[match("Suriname",levels(i$migratieachtergrond))] = "Suriname"
  levels(i$migratieachtergrond)[match("Nederlandse Cariben",levels(i$migratieachtergrond))] = "Dutch Caribbean"
  levels(i$migratieachtergrond)[match("Wel migratieachtergrond",levels(i$migratieachtergrond))] = "With Migration Background"
  levels(i$migratieachtergrond)[match("Zonder migratieachtergrond",levels(i$migratieachtergrond))] = "No Migration Background"
  
  
  levels(i$huishouden)[match("Totaal",levels(i$huishouden))] <- "Total"
  levels(i$huishouden)[match("Eenoudergezin",levels(i$huishouden))] <- "Single Parent"
  levels(i$huishouden)[match("Tweeoudergezin",levels(i$huishouden))] <- "Two Parents"
  
  
  if ("opleiding_ouders" %in% names(i)) {
    levels(i$opleiding_ouders)[match("Totaal",levels(i$opleiding_ouders))] <- "Total"
  }
  
  
  levels(i$parent_income_wealth_bins)[match("Totaal",levels(i$bins))] <- "Total"
  
  levels(i$geografie)[match("Nederland", levels(i$geografie))] <- "The Netherlands"
  
  levels(i$opleiding_ouders)[match("Geen hbo of wo", levels(i$opleiding_ouders))] <- "No hbo or wo"
  
  return(i)
}

# Retrieve the data from the Dutch data folder
rds_files <- list.files(path = "./data/nl", pattern = "*.rds", full.names = TRUE)
data_list <- rds_files %>% map(read_rds)
names(data_list) <- gsub("\\.rds$", "", basename(rds_files))

# The variable types need to be converted to factors for the translation to work!!
cols <- c("geografie", "geslacht", "migratieachtergrond", "huishouden", "parent_income_wealth_bins", "uitkomst", "type", "opleiding_ouders")

translate_mutate_cols <- function(df) {
  df <- df %>%  mutate_at(cols, factor)
  df <- translate_en(df)
}

data_list <- data_list %>% map(translate_mutate_cols)

write_to_rds <- function(data) {
  for (name in names(data_list)) {
    saveRDS(data_list[[name]], file.path("./data/en/", paste0(name, ".rds")))
  }
}

write_to_rds(data_list)
