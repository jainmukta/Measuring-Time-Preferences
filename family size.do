//FAMILY SIZE VARIABLE PREPROCESSING

cd "E:\Mukta\CMIE Data\Income Pyramids\Member Data\Member income 2014- 2020"

clear all

local files: dir "E:\Mukta\CMIE Data\Income Pyramids\Member Data\Member income 2014- 2020" files "member_income_*_MS_rev.dta" // NOTE : after C
local dir1 "E:\Mukta\CMIE Data\Income Pyramids\Member Data\Member income 2014- 2020" // LOCALS ARE SAFER THAN GLOBALS

tempfile building
save `building', emptyok

foreach f of local files {
     local w = substr(`"`f'"', 1, 1)
     use `"`f'"', clear
    // keep `w'hh_id `w'mem_id `w'state `w'region_type `w'month_slot `w'month `w'age_yrs `w'relation_with_hoh `w'caste_category `w'education `w'income_of_member_from_all_source
    // rename `w'* * // REQUIRES RECENT STATA; IF USING VERSION 8, -renpfix `w'-
    // gen wave = `"`w'"'
    // sort hh_id wave
     keep hh_id month mem_id age_yrs age_mths gender month_slot
	 append using `building'
     save `"`building'"', replace
}


save `"`dir1'/family_size_mem_income_2014_2020.dta"', replace

rename month_slot survey_month

//Encode gender
gen genderDummy = .
replace genderDummy = 1 if gender =="M"
replace genderDummy = 2 if gender =="F"


//Interpolation needed for missing values of age

////Encode survey month
gen survey_slot = .
replace survey_slot = 1 if survey_month == "Jan 2014"
replace survey_slot = 2 if survey_month == "Feb 2014"
replace survey_slot = 3 if survey_month == "Mar 2014"
replace survey_slot = 4 if survey_month == "Apr 2014"
replace survey_slot = 5 if survey_month == "May 2014"
replace survey_slot = 6 if survey_month == "Jun 2014"
replace survey_slot = 7 if survey_month == "Jul 2014"
replace survey_slot = 8 if survey_month == "Aug 2014"
replace survey_slot = 9 if survey_month == "Sep 2014"
replace survey_slot = 10 if survey_month == "Oct 2014"
replace survey_slot = 11 if survey_month == "Nov 2014"
replace survey_slot = 12 if survey_month == "Dec 2014"
replace survey_slot = 13 if survey_month == "Jan 2015"
replace survey_slot = 14 if survey_month == "Feb 2015"
replace survey_slot = 15 if survey_month == "Mar 2015"
replace survey_slot = 16 if survey_month == "Apr 2015"
replace survey_slot = 17 if survey_month == "May 2015"
replace survey_slot = 18 if survey_month == "Jun 2015"
replace survey_slot = 19 if survey_month == "Jul 2015"
replace survey_slot = 20 if survey_month == "Aug 2015"
replace survey_slot = 21 if survey_month == "Sep 2015"
replace survey_slot = 22 if survey_month == "Oct 2015"
replace survey_slot = 23 if survey_month == "Nov 2015"
replace survey_slot = 24 if survey_month == "Dec 2015"
replace survey_slot = 25 if survey_month == "Jan 2016"
replace survey_slot = 26 if survey_month == "Feb 2016"
replace survey_slot = 27 if survey_month == "Mar 2016"
replace survey_slot = 28 if survey_month == "Apr 2016"
replace survey_slot = 29 if survey_month == "May 2016"
replace survey_slot = 30 if survey_month == "Jun 2016"
replace survey_slot = 31 if survey_month == "Jul 2016"
replace survey_slot = 32 if survey_month == "Aug 2016"
replace survey_slot = 33 if survey_month == "Sep 2016"
replace survey_slot = 34 if survey_month == "Oct 2016"
replace survey_slot = 35 if survey_month == "Nov 2016"
replace survey_slot = 36 if survey_month == "Dec 2016"
replace survey_slot = 37 if survey_month == "Jan 2017"
replace survey_slot = 38 if survey_month == "Feb 2017"
replace survey_slot = 39 if survey_month == "Mar 2017"
replace survey_slot = 40 if survey_month == "Apr 2017"
replace survey_slot = 41 if survey_month == "May 2017"
replace survey_slot = 42 if survey_month == "Jun 2017"
replace survey_slot = 43 if survey_month == "Jul 2017"
replace survey_slot = 44 if survey_month == "Aug 2017"
replace survey_slot = 45 if survey_month == "Sep 2017"
replace survey_slot = 46 if survey_month == "Oct 2017"
replace survey_slot = 47 if survey_month == "Nov 2017"
replace survey_slot = 48 if survey_month == "Dec 2017"
replace survey_slot = 49 if survey_month == "Jan 2018"
replace survey_slot = 50 if survey_month == "Feb 2018"
replace survey_slot = 51 if survey_month == "Mar 2018"
replace survey_slot = 52 if survey_month == "Apr 2018"
replace survey_slot = 53 if survey_month == "May 2018"
replace survey_slot = 54 if survey_month == "Jun 2018"
replace survey_slot = 55 if survey_month == "Jul 2018"
replace survey_slot = 56 if survey_month == "Aug 2018"
replace survey_slot = 57 if survey_month == "Sep 2018"
replace survey_slot = 58 if survey_month == "Oct 2018"
replace survey_slot = 59 if survey_month == "Nov 2018"
replace survey_slot = 60 if survey_month == "Dec 2018"
replace survey_slot = 61 if survey_month == "Jan 2019"
replace survey_slot = 62 if survey_month == "Feb 2019"
replace survey_slot = 63 if survey_month == "Mar 2019"
replace survey_slot = 64 if survey_month == "Apr 2019"
replace survey_slot = 65 if survey_month == "May 2019"
replace survey_slot = 66 if survey_month == "Jun 2019"
replace survey_slot = 67 if survey_month == "Jul 2019"
replace survey_slot = 68 if survey_month == "Aug 2019"
replace survey_slot = 69 if survey_month == "Sep 2019"
replace survey_slot = 70 if survey_month == "Oct 2019"
replace survey_slot = 71 if survey_month == "Nov 2019"
replace survey_slot = 72 if survey_month == "Dec 2019"
replace survey_slot = 73 if survey_month == "Jan 2020"
replace survey_slot = 74 if survey_month == "Feb 2020"
replace survey_slot = 75 if survey_month == "Mar 2020"
replace survey_slot = 76 if survey_month == "Apr 2020"
replace survey_slot = 77 if survey_month == "May 2020"
replace survey_slot = 78 if survey_month == "Jun 2020"
replace survey_slot = 79 if survey_month == "Jul 2020"
replace survey_slot = 80 if survey_month == "Aug 2020"
replace survey_slot = 81 if survey_month == "Sep 2020"
replace survey_slot = 82 if survey_month == "Oct 2020"
replace survey_slot = 83 if survey_month == "Nov 2020"
replace survey_slot = 84 if survey_month == "Dec 2020"
replace survey_slot = 85 if survey_month == "Jan 2021"
replace survey_slot = 86 if survey_month == "Feb 2021"
replace survey_slot = 87 if survey_month == "Mar 2021"
replace survey_slot = 88 if survey_month == "Apr 2021"
replace survey_slot = 89 if survey_month == "May 2021"
replace survey_slot = 90 if survey_month == "Jun 2021"
replace survey_slot = 91 if survey_month == "Jul 2021"
replace survey_slot = 92 if survey_month == "Aug 2021"
drop if survey_slot == .


//DEFINE MONTH & INCOME
gen month_slot = .
replace month_slot = 1 if month == "Jan 2014"
replace month_slot = 2 if month == "Feb 2014"
replace month_slot = 3 if month == "Mar 2014"
replace month_slot = 4 if month == "Apr 2014"
replace month_slot = 5 if month == "May 2014"
replace month_slot = 6 if month == "Jun 2014"
replace month_slot = 7 if month == "Jul 2014"
replace month_slot = 8 if month == "Aug 2014"
replace month_slot = 9 if month == "Sep 2014"
replace month_slot = 10 if month == "Oct 2014"
replace month_slot = 11 if month == "Nov 2014"
replace month_slot = 12 if month == "Dec 2014"
replace month_slot = 13 if month == "Jan 2015"
replace month_slot = 14 if month == "Feb 2015"
replace month_slot = 15 if month == "Mar 2015"
replace month_slot = 16 if month == "Apr 2015"
replace month_slot = 17 if month == "May 2015"
replace month_slot = 18 if month == "Jun 2015"
replace month_slot = 19 if month == "Jul 2015"
replace month_slot = 20 if month == "Aug 2015"
replace month_slot = 21 if month == "Sep 2015"
replace month_slot = 22 if month == "Oct 2015"
replace month_slot = 23 if month == "Nov 2015"
replace month_slot = 24 if month == "Dec 2015"
replace month_slot = 25 if month == "Jan 2016"
replace month_slot = 26 if month == "Feb 2016"
replace month_slot = 27 if month == "Mar 2016"
replace month_slot = 28 if month == "Apr 2016"
replace month_slot = 29 if month == "May 2016"
replace month_slot = 30 if month == "Jun 2016"
replace month_slot = 31 if month == "Jul 2016"
replace month_slot = 32 if month == "Aug 2016"
replace month_slot = 33 if month == "Sep 2016"
replace month_slot = 34 if month == "Oct 2016"
replace month_slot = 35 if month == "Nov 2016"
replace month_slot = 36 if month == "Dec 2016"
replace month_slot = 37 if month == "Jan 2017"
replace month_slot = 38 if month == "Feb 2017"
replace month_slot = 39 if month == "Mar 2017"
replace month_slot = 40 if month == "Apr 2017"
replace month_slot = 41 if month == "May 2017"
replace month_slot = 42 if month == "Jun 2017"
replace month_slot = 43 if month == "Jul 2017"
replace month_slot = 44 if month == "Aug 2017"
replace month_slot = 45 if month == "Sep 2017"
replace month_slot = 46 if month == "Oct 2017"
replace month_slot = 47 if month == "Nov 2017"
replace month_slot = 48 if month == "Dec 2017"
replace month_slot = 49 if month == "Jan 2018"
replace month_slot = 50 if month == "Feb 2018"
replace month_slot = 51 if month == "Mar 2018"
replace month_slot = 52 if month == "Apr 2018"
replace month_slot = 53 if month == "May 2018"
replace month_slot = 54 if month == "Jun 2018"
replace month_slot = 55 if month == "Jul 2018"
replace month_slot = 56 if month == "Aug 2018"
replace month_slot = 57 if month == "Sep 2018"
replace month_slot = 58 if month == "Oct 2018"
replace month_slot = 59 if month == "Nov 2018"
replace month_slot = 60 if month == "Dec 2018"
replace month_slot = 61 if month == "Jan 2019"
replace month_slot = 62 if month == "Feb 2019"
replace month_slot = 63 if month == "Mar 2019"
replace month_slot = 64 if month == "Apr 2019"
replace month_slot = 65 if month == "May 2019"
replace month_slot = 66 if month == "Jun 2019"
replace month_slot = 67 if month == "Jul 2019"
replace month_slot = 68 if month == "Aug 2019"
replace month_slot = 69 if month == "Sep 2019"
replace month_slot = 70 if month == "Oct 2019"
replace month_slot = 71 if month == "Nov 2019"
replace month_slot = 72 if month == "Dec 2019"
replace month_slot = 73 if month == "Jan 2020"
replace month_slot = 74 if month == "Feb 2020"
replace month_slot = 75 if month == "Mar 2020"
replace month_slot = 76 if month == "Apr 2020"
replace month_slot = 77 if month == "May 2020"
replace month_slot = 78 if month == "Jun 2020"
replace month_slot = 79 if month == "Jul 2020"
replace month_slot = 80 if month == "Aug 2020"
replace month_slot = 81 if month == "Sep 2020"
replace month_slot = 82 if month == "Oct 2020"
replace month_slot = 83 if month == "Nov 2020"
replace month_slot = 84 if month == "Dec 2020"
replace month_slot = 85 if month == "Jan 2021"
replace month_slot = 86 if month == "Feb 2021"
replace month_slot = 87 if month == "Mar 2021"
replace month_slot = 88 if month == "Apr 2021"
replace month_slot = 89 if month == "May 2021"
replace month_slot = 90 if month == "Jun 2021"
replace month_slot = 91 if month == "Jul 2021"
replace month_slot = 92 if month == "Aug 2021"
drop if month_slot == .

//Generate financial year dummies
gen year = .
replace year = 0 if month_slot >=4 & month_slot <= 15
replace year = 1 if month_slot >=16 & month_slot <= 27
replace year = 2 if month_slot >=28 & month_slot <= 39
replace year = 3 if month_slot >=40 & month_slot <= 51
replace year = 4 if month_slot >=52 & month_slot <= 63
replace year = 5 if month_slot >=64 & month_slot <= 75
replace year = 6 if month_slot >=76 & month_slot <= 87

drop if year == .

//Generate wave number

gen wave = .
replace wave = 1 if month_slot == 1 | month_slot == 2 | month_slot == 3 | month_slot == 4
replace wave = 2 if month_slot == 5 | month_slot == 6 | month_slot == 7 | month_slot == 8
replace wave = 3 if month_slot == 9 | month_slot == 10 | month_slot == 11 | month_slot == 12
replace wave = 4 if month_slot == 13 | month_slot == 14 | month_slot == 15 | month_slot == 16
replace wave = 5 if month_slot == 17 | month_slot == 18 | month_slot == 19 | month_slot == 20
replace wave = 6 if month_slot == 21 | month_slot == 22 | month_slot == 23 | month_slot == 24
replace wave = 7 if month_slot == 25 | month_slot == 26 | month_slot == 27 | month_slot == 28
replace wave = 8 if month_slot == 29 | month_slot == 30 | month_slot == 31 | month_slot == 32
replace wave = 9 if month_slot == 33 | month_slot == 34 | month_slot == 35 | month_slot == 36
replace wave = 10 if month_slot == 37 | month_slot == 38 | month_slot == 39 | month_slot == 40
replace wave = 11 if month_slot == 41 | month_slot == 42 | month_slot == 43 | month_slot == 44
replace wave = 12 if month_slot == 45 | month_slot == 46 | month_slot == 47 | month_slot == 48
replace wave = 13 if month_slot == 49 | month_slot == 50 | month_slot == 51 | month_slot == 52
replace wave = 14 if month_slot == 53 | month_slot == 54 | month_slot == 55 | month_slot == 56
replace wave = 15 if month_slot == 57 | month_slot == 58 | month_slot == 59 | month_slot == 60
replace wave = 16 if month_slot == 61 | month_slot == 62 | month_slot == 63 | month_slot == 64
replace wave = 17 if month_slot == 65 | month_slot == 66 | month_slot == 67 | month_slot == 68
replace wave = 18 if month_slot == 69 | month_slot == 70 | month_slot == 71 | month_slot == 72
replace wave = 19 if month_slot == 73 | month_slot == 74 | month_slot == 75 | month_slot == 76


// Interpolate the missing values of gender and age
sort hh_id mem_id month_slot
gen sex = genderDummy
bys hh_id mem_id: replace sex = sex[_n-1] if missing(sex)
bys hh_id mem_id: replace sex = sex[_n+1] if missing(sex)
//repeated until changes made goes to 0
replace age_yrs = . if age_yrs < 0
bys hh_id mem_id year: egen avg_age = mean(age_yrs)
gen age = age_yrs
replace age = avg_age if missing(age)

//Calculate adult equivalency weights
//Base Paper - Claro, R. M., R. B. Levy, D. H. Bandoni, and L. Mondini (2010). Per capita versus adult-equivalent estimates of calorie availability in household budget surveys. Cadernos de saude publica 26, 2188–2195.
generate w = .

replace w = 0.29 if inrange(age_yrs,0,1)
replace w = 0.51 if inrange(age_yrs,1,3)
replace w = 0.71 if inrange(age_yrs,4,6)
replace w = 0.78 if inrange(age_yrs,7,10)
replace w = 0.98 if inrange(age_yrs,11,14) & genderDummy==1
replace w = 1.18 if inrange(age_yrs,15,18) & genderDummy==1
replace w = 1.14 if inrange(age_yrs,19,24) & genderDummy==1
replace w = 1.14 if inrange(age_yrs,25,50) & genderDummy==1
replace w = 0.90 if inrange(age_yrs,51,999) & genderDummy==1
replace w = 0.86 if inrange(age_yrs,11,14) & genderDummy==2
replace w = 0.86 if inrange(age_yrs,15,18) & genderDummy==2
replace w = 0.98 if inrange(age_yrs,19,24) & genderDummy==2
replace w = 1.00 if inrange(age_yrs,25,50) & genderDummy==2
replace w = 0.75 if inrange(age_yrs,50,999) & genderDummy==2
replace w = 0.90 if inrange(age_yrs,11,14) & genderDummy==.
replace w = 1.00 if inrange(age_yrs,15,18) & genderDummy==.
replace w = 1.00 if inrange(age_yrs,19,24) & genderDummy==.
replace w = 1.00 if inrange(age_yrs,25,50) & genderDummy==.
replace w = 0.75 if inrange(age_yrs,50,999) & genderDummy==.

save "E:\Mukta\CMIE Data\Precise RTP\SAMPLE DYNAMICS\family size\adult equivalents.dta", replace

//Add adult equivalents of each member to find the adult equivalent family size of a household
bysort hh_id month_slot: egen family_size = total(w)
drop mem_id age_yrs age_mths gender genderDummy w sex avg_age age
//Remove multiple members
bysort hh_id month:  gen dup = cond(_N==1,0,_n)
drop if dup > 1
drop dup 
//bysort hh_id month: keep if mem_id == _N

label variable survey_month "survey month"

save "E:\Mukta\CMIE Data\Precise RTP\SAMPLE DYNAMICS\family size\family size.dta", replace
