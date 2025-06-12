//Convert csv to dta
clear all
cd "E:\CMIE Data\Income Pyramids\Member Data"
clear
local myfilelist : dir . files"*.csv"
foreach file of local myfilelist {
drop _all
insheet using `file'
local outfile = subinstr("`file'",".csv","",.)
save "`outfile'", replace
}

//Keep relevant variables in member income data files and append with each other
cd"C:\Users\HP\Desktop\Mukta Jain\CMIE Data\Income Pyramids\Member Data\Member income 2014- 2020"

clear all

local files: dir "C:\Users\HP\Desktop\Mukta Jain\CMIE Data\Income Pyramids\Member Data\Member income 2014- 2020" files "member_income_*_MS_rev.dta" // NOTE : after C
local dir1 "C:\Users\HP\Desktop\Mukta Jain\CMIE Data\Income Pyramids\Member Data\Member income 2014- 2020" // LOCALS ARE SAFER THAN GLOBALS

tempfile building
save `building', emptyok

foreach f of local files {
     local w = substr(`"`f'"', 1, 1)
     use `"`f'"', clear
    // keep `w'hh_id `w'mem_id `w'state `w'region_type `w'month_slot `w'month `w'age_yrs `w'relation_with_hoh `w'caste_category `w'education `w'income_of_member_from_all_source
    // rename `w'* * // REQUIRES RECENT STATA; IF USING VERSION 8, -renpfix `w'-
    // gen wave = `"`w'"'
    // sort hh_id wave
     keep hh_id mem_id month state region_type age_yrs relation_with_hoh income_of_member_from_wages income_of_member_from_pension income_of_member_from_dividend income_of_member_from_interest
	 append using `building'
     save `"`building'"', replace
}


save `"`dir1'/tax_mem_income_2015_2020.dta"', replace
