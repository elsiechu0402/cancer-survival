# 02-table1.R
library(tableone)
library(readr)
library(dplyr)

df <- read_csv("output/data_cleaned.csv")

vars <- c("age", "gender", "tumor_size", "metastasis")

tab1 <- CreateTableOne(vars = vars, strata = "survival_status", data = df)

print(tab1)

capture.output(tab1, file = "output/table1.txt")
