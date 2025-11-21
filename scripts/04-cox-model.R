# 04-cox-model.R
library(survival)
library(readr)
library(dplyr)
library(car)
library(broom)

df <- read_csv("output/data_cleaned.csv")

vars <- c("age", "gender", "tumor_size", "metastasis")

univ_results <- lapply(vars, function(v){
  f <- as.formula(paste0("Surv(follow_up_months, event) ~ ", v))
  model <- coxph(f, data = df)
  tidy(model)
})

univ_results <- bind_rows(univ_results, .id = "variable")
write_csv(univ_results, "output/cox_univariable.csv")

multi_model <- coxph(
  Surv(follow_up_months, event) ~ age + gender + tumor_size + metastasis,
  data = df
)

summary(multi_model)

write_csv(tidy(multi_model), "output/cox_multivariable.csv")

ph_test <- cox.zph(multi_model)
capture.output(ph_test, file = "output/cox_ph_assumption.txt")

vif_values <- vif(multi_model)
write_csv(as.data.frame(vif_values), "output/cox_vif.csv")
