library(gtsummary)
library(dplyr)
library(tidyverse)
library(broom)

#checking the number of variables
names(covid_testing)

#Descriptive statistics
tbl_summary(
	covid_testing,
	include = c(gender, age, result, pan_day, drive_thru_ind, ct_result, payor_group, patient_class, orderset, col_rec_tat, rec_ver_tat))

#regression
tbl_uvregression (covid_testing,
	y = drive_thru_ind,
	include = c(age, orderset, col_rec_tat, rec_ver_tat
							),
	method = lm)

tbl_uvregression(
	covid_testing,
	y = drive_thru_ind,
	include = c(age, orderset,col_rec_tat, rec_ver_tat),
	method = glm,
	method.args = list(family = binomial()),
	exponentiate = TRUE)

specimen_collection <- tbl_uvregression (covid_testing,
																				 y = drive_thru_ind,
																				 include = c(age, orderset, col_rec_tat, rec_ver_tat
																				 ),
																				 method = lm)
specimen_collection

logistic_model <- glm(drive_thru_ind ~ age + orderset + col_rec_tat + rec_ver_tat ,
											data = covid_testing, family = binomial())

#Histogram for age variable

hist(covid_testing$age)

# Forest plot

tidy(logistic_model, conf.int = TRUE, exponentiate = TRUE) |>
	tidycat::tidy_categorical(logistic_model, exponentiate = TRUE) |>
	dplyr::slice(-1) |>
	ggplot(mapping = aes(x = level, y = estimate,
											 ymin = conf.low, ymax = conf.high)) +
	geom_point() +
	geom_errorbar() +
	facet_grid(cols = vars(variable), scales = "free", space = "free") +
	scale_y_log10()


