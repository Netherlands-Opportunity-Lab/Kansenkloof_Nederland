

# create workspace
rm(list=ls())
options(scipen=999)


#### PACKAGES ####
library(tidyverse)
library(readxl)

# add NL name
outcome_tab <- read_excel("~/Documents/GitHub/Kansenkloof_Nederland/data/nl/outcome_table.xlsx") 
outcome_tab <- outcome_tab %>%
  select(analyse_outcome, outcome_name)


# Define the bins and outcomes
bins <- c("bins5", "bins10", "bins20", "mean", "parents_edu")

# Loop over bins and outcomes
for (bin in bins) {
  # Check if it's the 'parents_edu' bin, which has only 2 outcomes
  if (bin == "parents_edu") {
    outcomes <- c("perinatal", "elementary_school")  # Only these two outcomes for 'parents_edu'
  } else {
    outcomes <- c("child_mortality", "classroom", "elementary_School", "high_school", "perinatal", "students", "main")  # Default outcomes
  }
  
  # Loop over the outcomes
  for (outcome in outcomes) {
    
    # Define the file path pattern for CSV files
    if (bin %in% c("bins10", "bins20") && outcome == "main") {
      # For bins10 and bins20 + main outcome, iterate over the two files
      for (i in 1:2) {
        file_path <- paste0("~/Documents/GitHub/Kansenkloof_Nederland/data/nl/", bin, "_tab_", outcome, "_", i, ".csv")
        
        # Read the CSV file
        data <- read.csv(file_path)
        data = select(data,-"uitkomst_NL")
        
        if (bin == "bins20") {
          x <- "20"
        } else if (bin == "bins10") {
          x <- "10"
        }
        
        # Update bin type and opleiding_ouders
        data <- data %>%
          mutate(
            type = x, 
            opleiding_ouders = coalesce(opleiding_ouders, "Totaal")
          ) %>%
          left_join(outcome_tab, by = c("uitkomst" = "analyse_outcome")) %>%
          rename(uitkomst_NL = outcome_name)
        
        # Write the updated CSV file
        write.csv(data, file_path, row.names = FALSE)
      }
    } else {
      # For other bins + outcomes, use a single CSV file
      file_path <- paste0("~/Documents/GitHub/Kansenkloof_Nederland/data/nl/", bin, "_tab_", outcome, ".csv")
      
      # Read the CSV file
      data <- read.csv(file_path)
      data = select(data,-"uitkomst_NL")
      
      if (bin == "bins20") {
        x <- "20"
      } else if (bin == "bins10") {
        x <- "10"
      } else if (bin == "bins5") {
        x <- "5"
      } else if (bin == "mean") {
        x <- "1"
      } else if (bin == "parents_edu") {
        x <- "parents_edu"
      } else if (bin == "median") {
        x <- "median"
      }
      
      # Update bin type and opleiding_ouders
      data <- data %>%
        mutate(
          type = x, 
          opleiding_ouders = coalesce(opleiding_ouders, "Totaal")
        ) %>%
        left_join(outcome_tab, by = c("uitkomst" = "analyse_outcome")) %>%
        rename(uitkomst_NL = outcome_name)
      
      # Write the updated CSV file
      write.csv(data, file_path, row.names = FALSE)
    }
  }
}
