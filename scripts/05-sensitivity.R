# 05-sensitivity.R
library(readr)
library(dplyr)
library(survival)
library(mice)

df <- read_csv("output/data_cleaned.csv")

df_cc <- df %>% filter(complete.cases(.))

model_cc <- coxph(
  Surv(follow_up_months, event) ~ age + gender + tumor_size + metastasis,
  data = df_cc
)

capture.output(summary(model_cc), file = "output/cox_complete_case.txt")

imp <- mice(df, m = 5, seed = 123)
df_imp <- complete(imp)

model_mice <- coxph(
  Surv(follow_up_months, event) ~ age + gender + tumor_size + metastasis,
  data = df_imp
)

capture.output(summary(model_mice), file = "output/cox_mice.txt")

df_no_outliers <- df %>% filter(tumor_size < quantile(tumor_size, 0.99))

model_no_outliers <- coxph(
  Surv(follow_up_months, event) ~ age + gender + tumor_size + metastasis,
  data = df_no_outliers
)

capture.output(summary(model_no_outliers), file = "output/cox_no_outliers.txt")
