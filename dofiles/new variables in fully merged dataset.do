
/*

Title: Prepare appended dataset for analyses


*/


use "${hhp_output}02_appended datasets/hhp_pulse_wcoviddata.dta", clear

drop if anxiety == . & depression == .
*	474,826/3,720,633 = 12.76%

gen anx100 = anxiety*100
gen dep100 = depression*100

sort scram week

drop n 
bys scram: gen n = _n
bys scram: gen N = _N

codebook scram
*codebook scram if N != 1
* 158,644/3,028,923 = 5.24%

keep if n==1

drop n N
bys week: gen n = _n
bys week: gen N = _N

sum N if n == 1
*	48 surveys with Mean # respondents = 63,102.56 and SD = 13550.98

codebook income

recode income (3=2)(4 5=3)(6/8 = 4), gen(inc_4cat)

la def inc_4cat 1 "1: below 25k" 2 "2: $25k - below 50k" ///
3 "3: $50- below 100k" 4 "4: $100k and above"
la values inc_4cat inc_4cat


// working vars to create risk score

gen rw_hous = 1 if tenure == 3 | tenure == 4
replace rw_hous = 0 if tenure == 1 | tenure == 2

gen rw_inc = 1 if income < 3
replace rw_inc = 0 if income >= 3 & income != .

gen rw_educ = 1 if educ4 < 3
replace rw_educ = 0 if educ4 == 3 | educ4 == 4

gen rw_incloss = 1 if inc_loss == 1
replace rw_incloss = 0 if inc_loss == 0

gen risksc = rw_hous + rw_inc + rw_educ + rw_incloss

egen riskmiss = rowmiss(rw_hous rw_inc rw_educ rw_incloss)

codebook riskmiss if riskmiss != 0


gen cases_sq = cases_pcap^2
gen deaths_sq = deaths_pcap^2

gen cases_pcap10 = cases_pcap/10
gen cases_pcap10sq = cases_pcap10^2


**************
*** Tenure ***
**************

codebook tenure

recode tenure (1 2 = 0)(3 = 1)(4 = .), gen(homerented)
tab homerented
la def homerented 0 "Home owned (outright or mortgaged)" 1 "Home rented"
la values homerented homerented

recode tenure (1 2 = 1)(3 4 = 0), gen(homeowned)
codebook homeowned


