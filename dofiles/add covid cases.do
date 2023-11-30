

*	this is just a date merging file
use "${hhp_input}covariate data/pulse weeks for covid cases.dta", clear


*	this is the CDC data
merge 1:m submission_date using "${hhp_input}covariate data/statecovidcases_thrupulse48.dta"


drop conf_cases prob_cases new_case pnew_case conf_death prob_death ///
new_death pnew_death created_at consent_cases consent_deaths

do "${hhp_do}add state fips from abrev.do" // this just adds fips codes

drop if est_st == .
gen fips3 = 100+est_st
gen statepulse = fips3*10^2+hhpweek
codebook statepulse

sort est_st submission_date
bys est_st: gen newcases_weekly = tot_cases - tot_cases[_n-1]
*codebook newcases_weekly

//tab est_st if newcases_weekly < 0 & _merge == 3
br if est_st == 56
replace newcases_weekly = 184 if statepulse == 15601 // replacing neg number

sort est_st submission_date
bys est_st: gen newdeaths_weekly = tot_death - tot_death[_n-1]
codebook newdeaths_weekly


tab est_st if newdeaths_weekly < 0 & _merge == 3
br if est_st == 5 | est_st == 6 | est_st == 19 | est_st == 32 ///
	| est_st == 34 | est_st == 40 | est_st ==53 | est_st == 54
*

replace newdeaths_weekly = 97 if statepulse == 10526
replace newdeaths_weekly = 363 if statepulse == 10636
replace newdeaths_weekly = 126 if statepulse == 11939
replace newdeaths_weekly = 37 if statepulse == 13414
replace newdeaths_weekly = 52 if statepulse == 13218
replace newdeaths_weekly = 41 if statepulse == 15332
replace newdeaths_weekly = 38 if statepulse == 15429
replace newdeaths_weekly = 2 if statepulse == 14047


// trim dataset to state-week combinations needed for HPS surveys
keep if _merge == 3
drop _merge
drop if hhpweek == .


sort est_st submission_date
save "${hhp_output}statecovidcases.dta", replace

sort statepulse
merge 1:m statepulse using "${hhp_output}02_appended datasets/hhp_pulse1-48.dta"


do "${hhp_do}statepop_from2020census.do" 

gen double cases_pcap = newcases_weekly/statepop
replace cases_pcap = cases_pcap*1000

gen double deaths_pcap = newdeaths_weekly/statepop
replace deaths_pcap = deaths_pcap*1000

la var cases_pcap "Weekly covid cases per 1000, by state"
la var deaths_pcap "Weekly covid deaths per 1000, by state"


sort statepulse
save "${hhp_output}02_appended datasets/hhp_pulse_wcoviddata.dta", replace




