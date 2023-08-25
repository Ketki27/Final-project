library(gtsummary)
names(covid_testing)

tbl_summary(
	covid_testing,
	include = c(gender, age, result, pan_day, drive_thru_ind, ct_result, payor_group, patient_class, orderset, col_rec_tat, rec_ver_tat))

