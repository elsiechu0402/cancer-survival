# 03-km-survival.R
library(survival)
library(survminer)
library(readr)

df <- read_csv("output/data_cleaned.csv")

fit <- survfit(Surv(follow_up_months, event) ~ metastasis, data = df)

p <- ggsurvplot(
  fit, 
  data = df,
  risk.table = TRUE,
  ggtheme = theme_minimal(),
  pval = TRUE
)

ggsave("figures/km_plot.png", p, width = 6, height = 5)
