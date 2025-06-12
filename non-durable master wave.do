//USE PREVIOUS MASTER FILE
use "/Volumes/Mukta SSD/Mukta /CMIE Data/Precise RTP/master_wave.dta"

///////////////////////////////
//TAKE NONDURABLE CONSUMPTION//
///////////////////////////////

//MERGE WITH NON DURABLE DATA
merge m:m hh_id month using "/Volumes/Mukta SSD/Mukta /CMIE Data/Precise RTP/Credit constraints/As deviation from life cycle hypothesis/non-durable consumption.dta"
//merge m:m hh_id month using "E:\Mukta\CMIE Data\Precise RTP\Credit constraints\As deviation from life cycle hypothesis\non-durable consumption.dta"
drop if _merge == 2
//Non durable consumption for the previous month of the survey month.
drop _merge 

//MERGE WITH BORROWING DATA
merge m:m hh_id survey_month using "/Volumes/Mukta SSD/Mukta /CMIE Data/Precise RTP/SAMPLE DYNAMICS/borrowing.dta"
//merge m:m hh_id survey_month using "E:\Mukta\CMIE Data\Precise RTP\SAMPLE DYNAMICS\borrowing.dta"
drop if _merge == 2
drop _merge
bys hh_id: egen total_borrowing = total(borrowed)
gen borrowing_dummy = 1 if total_borrowing > 0
replace borrowing_dummy = 0 if total_borrowing == 0

//MERGE WITH INCOME DATA
//merge m:m hh_id month using "/Volumes/Mukta SSD/Mukta /CMIE Data/Precise RTP/SAMPLE DYNAMICS/hh_income/hh_income_012015_022020.dta"
//drop if _merge == 2
//drop _merge
//replace total_income = . if total_income < 0

//bys hh_id: gen n_vals = _n == 1
//count if n_vals
//drop n_vals
//1,31,529 households
//OUTLIER CORRECTION
drop if ps_fin_head_age < 18 | ps_fin_head_age > 90
drop if ps_reported_head_age < 18 | ps_reported_head_age > 90
//1,30,363 households
drop if ps_Y_fin_hoh > ps_total_hh_income
drop if ps_Y_reported_hoh > ps_total_hh_income
//1,12,982

//Credit Constrained Households - Count
//gen n_vals = .
//bys hh_id: replace n_vals = _n == 1 if borrowing_dummy == 0
//count if n_vals == 1
//drop n_vals

//FIND AVERAGE YEARLY SAVINGS & if it is greater than 10% of average income
//gen hh_savings = total_income - total_expenditure
//bys hh_id year: egen yearly_savings = mean(hh_savings)
//bys hh_id year: egen yearly_income = mean(total_income)
//gen savings_dummy = 1 if yearly_savings >= 0.1*yearly_income
//replace savings_dummy = 0 if yearly_savings < 0.1*yearly_income
//FIND HOUSEHOLDS HAVING POSITIVE SAVINGS THROUGHOUT
//bys hh_id: egen tot_savings_dummy = total(savings_dummy)
//bys hh_id: gen saver = 1 if tot_savings_dummy == _N
//bys hh_id: replace saver = 0 if tot_savings_dummy < _N
//COUNT OBSERVATIONS WITH BORROWING = 1 & SAVER = 1
//gen n_vals = .
//bys hh_id: replace n_vals = _n == 1 if borrowing_dummy == 1 & saver == 1
//count if n_vals == 1
//drop n_vals
//count if borrowing_dummy == 1 & saver == 1
//COUNT OBSERVATIONS WITH BORROWING = 1 & SAVER = 0
//gen n_vals = .
//bys hh_id: replace n_vals = _n == 1 if borrowing_dummy == 1 & saver == 0
//count if n_vals == 1
//drop n_vals
//count if borrowing_dummy == 1 & saver == 0
//COUNT OBSERVATIONS WITH BORROWING = 0 & SAVER = 1
//gen n_vals = .
//bys hh_id: replace n_vals = _n == 1 if borrowing_dummy == 0 & saver == 1
//count if n_vals == 1
//drop n_vals
//count if borrowing_dummy == 0 & saver == 1
//COUNT OBSERVATIONS WITH BORROWING = 0 & SAVER = 0
//gen n_vals = .
//bys hh_id: replace n_vals = _n == 1 if borrowing_dummy == 0 & saver == 0
//count if n_vals == 1
//drop n_vals
//count if borrowing_dummy == 0 & saver == 0
//INCLUDE NON-BORROWERS BUT SAVERS IN NON-CREDIT CONSTRAINED CATEGORY
//gen credit_constrained = 1 if saver == 0 & borrowing_dummy == 0
//replace credit_constrained = 0 if saver != 0 | borrowing_dummy != 0
//replace credit_constrained = . if saver == . | borrowing_dummy == .

//Find consumption growth rates as well
xtset hh_id wave
bys hh_id: gen wave_nd_cons_growth = D.realNondurableC/L.realNondurableC
bys hh_id: gen wave_family_size_growth = D.family_size/L.family_size
gen ln_wave_nd_cons_ratio = log(wave_nd_cons_growth + 1)
gen ln_wave_family_size_ratio = log(wave_family_size_growth + 1)
gen ratio_cons = wave_nd_cons_growth + 1
summarize ratio_cons
gen fam_size_ratio = wave_family_size_growth + 1
summarize fam_size_ratio

//GENERATE DUMMIES
//EDU_GROUP - FIN HEAD
gen edu_group_02 = 0
replace edu_group_02 = 1 if ps_fin_edu_group == 1
replace edu_group_02 = . if ps_fin_edu_group == .
gen edu_group_03 = 0
replace edu_group_03 = 1 if ps_fin_edu_group == 2
replace edu_group_03 = . if ps_fin_edu_group == .
gen edu_group_04 = 0
replace edu_group_04 = 1 if ps_fin_edu_group == 3
replace edu_group_04 = . if ps_fin_edu_group == .
//CASTE_DUMMIES
gen caste_group_02 = 0
replace caste_group_02 = 1 if ps_hh_caste == 1
gen caste_group_03 = 0
replace caste_group_03 = 1 if ps_hh_caste == 2

gen lower_caste = 0
replace lower_caste = 1 if ps_hh_caste == 1 | ps_hh_caste == 2
replace lower_caste = . if ps_hh_caste == .
	
//EDU GROUP - REP HEAD
gen edu_rep_02 = 0
replace edu_rep_02 = 1 if ps_reported_head_edu >= 5 & ps_reported_head_edu <= 10 
replace edu_rep_02 = . if ps_reported_head_edu == .
gen edu_rep_03 = 0
replace edu_rep_03 = 1 if ps_reported_head_edu > 10 & ps_reported_head_edu <= 12 
replace edu_rep_03 = . if ps_reported_head_edu == .
gen edu_rep_04 = 0
replace edu_rep_04 = 1 if ps_reported_head_edu > 12 & ps_reported_head_edu <= 16
replace edu_rep_04 = . if ps_reported_head_edu == .

gen n_vals = .
bys hh_id: replace n_vals = _n == 1 if edu_rep_04 == 1
count if n_vals == 1
drop n_vals

//ADMIN_ZONES_DUMMIES 
gen zone_dummy = .
//north-east = 1
replace zone_dummy = 1 if state == "Assam" 
//east = 2
replace zone_dummy = 2 if state == "Bihar" | state == "Jharkhand" | state == "Odisha" | state == "West Bengal"
//north = 3
replace zone_dummy = 3 if state == "Jammu & Kashmir" | state == "Delhi" | state == "Haryana" | state == "Himachal Pradesh" | state == "Punjab" | state == "Rajasthan"
//central = 4
replace zone_dummy = 4 if state == "Chhattisgarh" | state == "Madhya Pradesh" | state == "Uttar Pradesh"
//west = 5
replace zone_dummy = 5 if state == "Maharashtra" | state == "Goa" | state == "Gujarat"
//south = 6
replace zone_dummy = 6 if state == "Puducherry" | state == "Kerala" | state == "Karnataka" | state == "Andhra Pradesh" | state == "Tamil Nadu" 

//FIND PER CAPITA REAL CONSUMPTION & PERMANENT CONSUMPTION
gen percapitanondurableC = realNondurableC/wave_family_size
gen percapitapermanentC = permanentNondurableC/wave_family_size
gen lifecycleDeviation = percapitapermanentC - percapitanondurableC

//CONDITION FOR EXISTENCE OF CREDIT CONSTRAINTS
replace lifecycleDeviation = 0 if abs(lifecycleDeviation) < 0.5*percapitanondurableC
//Overfitting and underfitting problem with value < 0.4 and > 0.6
//Hence 0.5 is taken as the threshold deviation. 

//IDENTIFY NON CREDIT CONSTRAINED HOUSEHOLDS - lifecycle approach (any deviation from permanent consumption disables credit smoothening. Assuming rationality, reason to deviate from credit smothening can only be credit constraints.)
bys hh_id: egen identifier = mean(lifecycleDeviation)
gen test = 1 if identifier == 0
replace test = 0 if identifier != 0
rename test noCreditConstraint 

//save "C:\Users\vip\Desktop\Mukta Jain\CMIE Data\Precise RTP\non-durable master wave.dta",replace

// Lambda_t = welfare effects of binding credit constraints
// Can be measured by regressing LifeCycleDeviation and other controls on MDPI. The coefficient of LifeCycle Deviation represents the welfare impacts of binding credit constraints.
// lambda_t = 0 for households with nonbinding credit constraints
//1,31,529 households

//Remove poor sample
//drop if prop_poor > 0
//Without going into measurement of credit constraints, test RTP model of lawrance only for households with non binding credit.
//drop if noCreditConstraint == 0
//Count Households
bys hh_id: gen n_vals = _n == 1
count if n_vals
drop n_vals
//15,56,800 observations - 1,12,982 households without elemination of poor
//13,75,574 observations - 1,00,031 households ith elemination of the poor

//Create 10 income quantiles for further analysis
//Done only 1 time - doesn't change with sample.
xtile income_bracket_fin = ps_Y_fin_hoh, nq(10)
xtile income_bracket_rep = ps_Y_fin_hoh, nq(10)

//6,34,987 obsevations - 49,318 households
//gen n_vals = .
//bys hh_id: replace n_vals = _n == 1 if ps_hh_caste == 2 //& prop_poor == 0 & borrowed == 1
//count if n_vals == 1
//drop n_vals
//drop if hh_of_perpetual_fin_hoh == 0
//81,798 households left - didn't remove poor, didn't remove credit constaints
//////////////
//REGRESSION//
//////////////

//Create names for robustness checks - reported head
gen interest_rate = real_t365_couple
gen education1 = edu_rep_02
gen education2 = edu_rep_03
gen education3 = edu_rep_04
gen age = ps_reported_head_age
gen income = ps_Y_reported_hoh //ps_total_hh_income //weighted_assets //ps_Y_reported_hoh

//Create names for robustness checks - fin head
//gen interest_rate = real_t365_fin
//gen education1 = edu_group_02
//gen education2 = edu_group_03
//gen education3 = edu_group_04
//gen age = ps_fin_head_age //(ps_fin_head_age - 18)/(75-18)
//gen income = ps_Y_fin_hoh


sort hh_id wave

//RUN REGRESSION 
//Baseline
//reg interest_rate L.interest_rate ln_family_size_ratio education1 education2 education3 caste_group_02 caste_group_03 age income, vce(robust)
//Time dummies
//reg interest_rate L.interest_rate ln_wave_family_size_ratio education1 education2 education3 caste_group_02 caste_group_03 age income i.wave, vce(robust)
//Credit constraint dummy
//reg interest_rate L.interest_rate ln_wave_family_size_ratio education1 education2 education3 caste_group_02 caste_group_03 age income i.borrowing_dummy i.wave, vce(robust)
//Poor Removal
drop if prop_poor > 0
reg interest_rate L.interest_rate ln_wave_family_size_ratio education1 education2 education3 caste_group_02 caste_group_03 age income i.borrowing_dummy i.wave, vce(robust)

predict expected_interest
replace expected_interest = log(1+expected_interest)

//(i.ps_fin_edu_group i.ps_hh_caste c.ps_fin_head_age c.ps_Y_fin_hoh)#(i.wave)

//Baseline
//reg ln_wave_nd_cons_ratio expected_interest ln_family_size_ratio education1 education2 education3 caste_group_02 caste_group_03 age income, vce(robust)
//Time dummies
//reg ln_wave_nd_cons_ratio expected_interest ln_wave_family_size_ratio education1 education2 education3 caste_group_02 caste_group_03 age income i.wave, vce(robust)
//Credit constraint dummy
//reg ln_wave_nd_cons_ratio expected_interest ln_wave_family_size_ratio education1 education2 education3 caste_group_02 caste_group_03 age income i.borrowing_dummy i.wave, vce(robust)
//Poor Removal
reg ln_wave_nd_cons_ratio expected_interest ln_wave_family_size_ratio education1 education2 education3 caste_group_02 caste_group_03 age income i.borrowing_dummy i.wave, vce(robust)


//drop interest_rate education1 education2 education3 age income expected_interest
//Caste ID - 0 for UR and inttermediate caste, 1 for OBC and 2 for SC/ST	
//Favourable & significant sign of coefficient associated with presample income of household (+ve) and education (+ve) for vce robust and robust specification of heteroskedasticity treatment.
//Favourable sign but insignificant coefficient associated with education (+ve) for state clusters. All for for presample income, but family size importance gets inflated.
//Insignificant age, and caste in all specifications.

predict errors, residuals
matrix b = e(b) 
gen sq_errors = errors^2
sort hh_id month_slot
bys hh_id: gen lag_errors = errors[_n-1]
bys hh_id: gen  cov_errors = errors * lag_errors
summarize sq_errors, meanonly
scalar exp_sq_errors = r(mean)
summarize cov_errors, meanonly
scalar exp_cov_errors = r(mean)

//Find parameters

matrix list b

scalar _gamma = b[1,1]
scalar _theta = b[1,2]
scalar _delta2_edu = b[1,3]
scalar _delta3_edu = b[1,4]
scalar _delta4_edu = b[1,5]
scalar _delta2_caste = b[1,6]
scalar _delta3_caste = b[1,7]
scalar _delta_age = b[1,8]
scalar _delta_income = b[1,9]
//Baseline
//scalar _alpha = b[1,10]
//Time dummies
//scalar _alpha = b[1,25]
//Credit Constraint dummy
//scalar _alpha = b[1,27]
//Poor Removal
scalar _alpha = b[1,27]

scalar list

scalar sigma2_u = exp_sq_errors + 2 * exp_cov_errors
scalar sigma2_e = -1 + (1+(2*sigma2_u)/(_gamma^2))^(1/2)
scalar rho_bar = -1*(_alpha/_gamma)+ (1/2)*sigma2_e
display rho_bar
gen ln_1plusrho_i = sigma2_e/2 - ((1/_gamma)*(_alpha + education1 * _delta2_edu + education2 * _delta3_edu + education3 * _delta4_edu + caste_group_02 * _delta2_caste + caste_group_03 * _delta3_caste + age * _delta_age + income * _delta_income))  
summarize ln_1plusrho_i
gen rtp = exp(ln_1plusrho_i) - 1
//RTP generated for each household

//summarize ps_real_Y_fin_hoh
//scalar max_income =  822.3684
//gen income_bracket = .
//replace income_bracket = 1 if ps_Y_fin_hoh >= 0 & ps_Y_fin_hoh <= max_income/4
//replace income_bracket = 2 if ps_Y_fin_hoh > max_income/8 & ps_Y_fin_hoh <= 2*max_income/4
//replace income_bracket = 3 if ps_Y_fin_hoh > 2*max_income/8 & ps_Y_fin_hoh <= 3*max_income/4
//replace income_bracket = 4 if ps_Y_fin_hoh > 3*max_income/8 & ps_Y_fin_hoh <= 4*max_income/4
//replace income_bracket = 5 if ps_Y_fin_hoh > 4*max_income/8 & ps_Y_fin_hoh <= 5*max_income/8
//replace income_bracket = 6 if ps_Y_fin_hoh > 5*max_income/8 & ps_Y_fin_hoh <= 6*max_income/8
//replace income_bracket = 7 if ps_Y_fin_hoh > 6*max_income/8 & ps_Y_fin_hoh <= 7*max_income/8
//replace income_bracket = 8 if ps_Y_fin_hoh > 7*max_income/8 & ps_Y_fin_hoh <= 8*max_income/8
//misstable summarize income_bracket
//misstable summarize ps_Y_fin_hoh
//Could not use these mannual brackets, because of large skewness in data. Imcome intervals are not constant.
summarize rtp
//For fin head
//bys income_bracket_fin: summarize rtp
//For rep head
bys income_bracket_rep: summarize rtp

//bys income_bracket: egen mean_rtp = mean(rtp)
//bys income_bracket: egen stdev_rtp = sd(rtp)
//tab mean_rtp
//tab 


//scatter mean_rtp income_bracket

drop expected_interest errors sq_errors lag_errors cov_errors ln_1plusrho_i rtp 
drop age education1 education2 education3 income interest_rate
//DMI, value around 0.06 to 0.07 (t365)
//DMI, value around 0.06 (t91)
//First DMI, then IMI, value around 0.05 (t182)
//First IMI, then DMI, value around .11 to .12 (bank rate)

save "/Volumes/Mukta SSD/Mukta /CMIE Data/Precise RTP/non-durable master wave.dta", replace

