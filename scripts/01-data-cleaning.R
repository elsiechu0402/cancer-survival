# 01-data-cleaning.R
# -------------------------------------------------------
# Purpose: Load raw data, clean variables, export cleaned data
# -------------------------------------------------------

library(dplyr)
library(janitor)
library(readr)

# 1. Load raw data (replace with your file name)
df_raw <- read_csv("data/your_raw_data.csv") %>% 
  clean_names()

# 2. Basic cleaning (example operations)
df <- df_raw %>%
  mutate(
    # ensure numeric types
    age = as.numeric(age),
    tumor_size = as.numeric(tumor_size),
    # create or convert binary variables
    metastasis = ifelse(metastasis == "Yes", 1, 0),
    event = ifelse(survival_status == "Deceased", 1, 0)
  )

# 3. Remove impossible values / cap outliers
df <- df %>%
  filter(age >= 0 & age <= 120)

# 4. Export cleaned data
write_csv(df, "output/data_cleaned.csv")
