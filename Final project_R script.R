library(gtsummary)
library(dplyr)
library(tidyverse)

names(covid_testing)

tbl_summary(
	covid_testing,
	include = c(gender, age, result, pan_day, drive_thru_ind, ct_result, payor_group, patient_class, orderset, col_rec_tat, rec_ver_tat))

tbl_uvregression (covid_testing,
	y = drive_thru_ind,
	include = c(age, orderset
							),
	method = lm)

tbl_uvregression(
	covid_testing,
	y = drive_thru_ind,
	include = c(age, orderset),
	method = glm,
	method.args = list(family = binomial()),
	exponentiate = TRUE)

