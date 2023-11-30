

***
*** Handle Pulse 1 separately from rest of files:
***

clear
use "${hhp_input}HPS_Week1_PUF_CSV/pulse2020_puf_1.dta"
rename*, lower

gen mortcur = . 
gen rentcur = . 

	foreach var in region expns_dif prescript mh_svcs mh_notget tnum_ps {
			gen `var' = .
			}
* 

forvalues v = 1/9 {
		gen pschng`v' = .
		gen pswhychg`v' = .
		}
	drop pschng8 pschng9
forvalues v = 1/9 {
			gen chldimpct`v' = .
			}
gen sexual_orientation = .

gen egenid_birth = .
gen genid_describe = .

recode tbirth_year (1996/2003 = 1)(1991/1995 = 2)(1986/1990 = 3) ///
(1981/1985 = 4)(1976/1980 = 5)(1971/1975 = 6)(1966/1970 = 7) ///
(1961/1965 = 8)(1956/1960 = 9)(1930/1955 = 10), gen (ageg5)

recode tbirth_year (1991/2003 = 1)(1981/1990 = 2) ///
(1971/1980 = 3)(1961/1970 = 4) ///
(1951/1960 = 5)(1930/1950 = 6), gen (ageg10)


destring est_st, replace
destring est_msa, replace

keep scram week est_st est_msa region pweight tbirth_year ///
		egender egenid_birth genid_describe ///
		rhispanic rrace eeduc ms thhld_numper thhld_numkid thhld_numadlt ///
		wrkloss expctloss anywork kindwork rsnnowrk ///
		anxious worry interest down tenure mortlmth mortconf income ///
		sexual_orientation expns_dif prescript mh_svcs mh_notget ///
		tnum_ps chldimpct1-chldimpct9 hlthins1-hlthins8 ///
		pschng1-pschng7 pswhychg1-pswhychg9 ageg5 ageg10 ///
		tenure mortconf

sort scram	
save "${hhp_output}01_each pulse/hhp_wrk_1.dta", replace


*** Loop for all files

forvalues i = 2/48 {

	clear

	if `i' < 22 {
	local y = 2020
	}

	if `i' >= 22 {
	local y = 2021
	}

	if `i' >= 41 {
	local y = 2022
	}

	import delimited using "${hhp_input}HPS_Week`i'_PUF_CSV/pulse`y'_puf_`i'.csv", varnames(1) case(lower)

	if `i' < 13 {
		gen mortcur = . 
		gen rentcur = . 
		gen livqtr = .
		gen evict = .
		gen forclose = .

		foreach var in region /// add childcare items here
			expns_dif prescript mh_svcs mh_notget tnum_ps {
			gen `var' = .
			}
*
		forvalues v = 1/9 {
			gen pschng`v' = .
			gen pswhychg`v' = .
			}
		drop pschng8 pschng9
*
	}
	if `i' < 22 {
		gen recvdvacc = .
		gen doses = .
		gen hadcovid = .
		
	}
	if `i' < 28 {
		
		forvalues v = 1/9 {
			gen chldimpct`v' = .
			} 
		recode livqtr (7/9=6)(10=7)
		rename livqtr livqtrrv
		}
	if `i' < 34 {
* this loop used to refer only to < 18, but sexual_orientation absent from 
*	file 18. Testing through end of Phsae 2.
		gen sexual_orientation = .
		rename doses numdoses
	}

	*
	if `i' >= 13 {
		gen mortlmth = .
		}
*
	if `i' < 34 {
		gen egenid_birth = .
		gen genid_describe = .
		}
*
	if `i' >= 34 {
		gen egender = .
		gen expctloss = .
		if `i' < 40 {
			rename dosesrv numdoses	
		}
		}
	if `i' < 40 {
		gen brand = .
	}
	if `i' < 43 {
		gen rbooster = .
		
	}
	if `i' < 46 {
		gen whencovid = .
		
	}
	if `i' >= 46 {
		gen mortconf = .
		gen prescript = .
		gen mh_svcs = .
		gen mh_notget = .
		rename boosterrv rbooster
		rename hadcovidrv hadcovid
		gen brand = .
		}
*
if `i' < 22 {
	*	these are 2020 surveys
	recode tbirth_year (1996/2003 = 1)(1991/1995 = 2)(1986/1990 = 3) ///
	(1981/1985 = 4)(1976/1980 = 5)(1971/1975 = 6)(1966/1970 = 7) ///
	(1961/1965 = 8)(1956/1960 = 9)(1930/1955 = 10), gen (ageg5)
}
if `i' >= 22 {
	*	these are 2021 surveys
	recode tbirth_year (1997/2003 = 1)(1992/1996 = 2)(1987/1991 = 3) ///
	(1982/1986 = 4)(1977/1981 = 5)(1972/1976 = 6)(1967/1971 = 7) ///
	(1962/1966 = 8)(1957/1961 = 9)(1930/1956 = 10), gen (ageg5)
}
if `i' >= 41 {
	*	these are 2022 surveys
	drop ageg5

	recode tbirth_year (1998/2004 = 1)(1993/1997 = 2)(1988/1992 = 3) ///
	(1983/1987 = 4)(1978/1982 = 5)(1973/1977 = 6)(1968/1972 = 7) ///
	(1963/1967 = 8)(1958/1962 = 9)(1930/1957 = 10), gen (ageg5)
}
*
la def ageg5 1 "18-24 years" 2 "25-29 years" 3 "30-34 years" 4 "35-39 years" ///
5 "40-44 years" 6 "45-49 years" 7 "50-54 years" 8 "55-59 years" ///
9 "60-64 years" 10 "65 and older", replace
la values ageg5 ageg5


if `i' < 22 {
	*	these are 2020 surveys
	recode tbirth_year (1991/2003 = 1)(1981/1990 = 2) ///
	(1971/1980 = 3)(1961/1970 = 4) ///
	(1951/1960 = 5)(1930/1950 = 6), gen (ageg10)

}
if `i' >= 22 {
	*	these are 2021 surveys
	recode tbirth_year (1992/2003 = 1)(1982/1991 = 2) ///
	(1972/1981 = 3)(1962/1971 = 4) ///
	(1952/1961 = 5)(1930/1951 = 6), gen (ageg10)
}
if `i' >= 41 {
	*	these are 2020 surveys
	drop ageg10
	recode tbirth_year (1993/2004 = 1)(1983/1992 = 2) ///
	(1973/1982 = 3)(1963/1972 = 4) ///
	(1953/1962 = 5)(1930/1953 = 6), gen (ageg10)
}
*

la def ageg10 1 "18-29 years" 2 "30-39 years" 3 "40-49 years" ///
4 "50-59 years" 5 "60-69 years" 6 "70 and older", replace
la values ageg10 ageg10


	keep scram week est_st est_msa region pweight tbirth_year ///
		egender egenid_birth genid_describe ///
		rhispanic rrace eeduc ms thhld_numper thhld_numkid thhld_numadlt ///
		wrkloss expctloss anywork kindwork rsnnowrk ///
		anxious worry interest down tenure mortlmth mortconf income ///
		sexual_orientation expns_dif prescript mh_svcs mh_notget ///
		tnum_ps chldimpct1-chldimpct9 hlthins1-hlthins8 ///
		pschng1-pschng7 pswhychg1-pswhychg9 ageg5 ageg10 ///
		recvdvacc numdoses brand hadcovid whencovid ///
		tenure livqtrrv rentcur mortcur mortconf evict forclose

	save "${hhp_output}01_each pulse/hhp_wrk_`i'.dta", replace
	}
*

*****************************************
*** Append all pulse surveys together ***
*****************************************

use "${hhp_output}01_each pulse/hhp_wrk_1.dta", clear

*use "${hhp_output}01_each pulse/hhp_wrk_2.dta", clear

*append using "${hhp_output}01_each pulse/hhp_wrk_1.dta"

forvalues i = 2/48 {

append using "${hhp_output}01_each pulse/hhp_wrk_`i'.dta"

}
*

***
*** THEN, manipulate variables in appended dataset
***

// (1) Demographics

gen female = 1 if egender == 2 | egenid_birth == 2
replace female = 0 if egender == 1 | egenid_birth == 1


recode ageg10 (1/2 = 1)(3/4 = 2)(5/6 = 3), gen(ageg20)
la def ageg20 1 "1: 18-39 years" 2 "2: 40-59 years" 3 "3: 60 and older"
la values ageg20 ageg20

// (2) Mental health outcomes


foreach var in anxious worry interest down {
replace `var' = . if `var' < 0
recode `var' (1=0)(2=1)(3=2)(4=3)
}
*

egen anx_sum = rowtotal(anxious worry)
egen dep_sum = rowtotal(interest down)

replace anx_sum = . if anxious == . | worry == .
replace dep_sum = . if interest == . | down == .

gen anxiety = 1 if anx_sum >= 3 & anx_sum != .
replace anxiety = 0 if anx_sum < 3

gen depression = 1 if dep_sum >= 3 & dep_sum != .
replace depression = 0 if dep_sum < 3




gen hispanic = 1 if rhispanic == 2
replace hispanic = 0 if rhispanic == 1

la def yesno 0 "0 - No" 1 "1 - Yes"
la var hispanic yesno

recode rrace (1=1)(2=2)(3=4)(4=5), gen(idrace)
replace idrace = 3 if hispanic == 1

la def idrace 1 "White, not hispanic" 2 "Black, not hispanic" ///
3 "Hispanic (may be of any race)" 4 "Asian, not Hispanic" ///
5 "Bi/multiracial or other, not Hispanic", replace
la values idrace idrace

la def msa 35620 "New York-Newark-Jersey City, NY-NJ-PA Metro Area" ///
31080 "Los Angeles-Long Beach-Anaheim, CA Metro Area" ///
16980 "Chicago-Naperville-Elgin, IL-IN-WI Metro Area" ///
19100 "Dallas-Fort Worth-Arlington, TX Metro Area" ///
26420 "Houston-The Woodlands-Sugar Land, TX Metro Area" ///
47900 "Washington-Arlington-Alexandria, DC-VA-MD-WV Metro Area" ///
33100 "Miami-Fort Lauderdale-Pompano Beach, FL Metro Area" ///
37980 "Philadelphia-Camden-Wilmington, PA-NJ-DE-MD Metro Area" ///
12060 "Atlanta-Sandy Springs-Alpharetta, GA Metro Area" ///
38060 "Phoenix-Mesa-Chandler, AZ Metro Area" ///
14460 "Boston-Cambridge-Newton, MA-NH Metro Area" ///
41860 "San Francisco-Oakland-Berkeley, CA Metro Area" ///
40140 "Riverside-San Bernardino-Ontario, CA Metro Area" ///
19820 "Detroit-Warren-Dearborn, MI Metro Area" ///
42660 "Seattle-Tacoma-Bellevue, WA Metro Area" ///

la values est_msa msa


la def educ 1 "Less than high school" 2 "Some high school" ///
3 "High school graduate or equivalent" ///
4 "Some college, but degree not received or is in progress" ///
5 "Associate’s degree" 6 "Bachelor's degree" 7 "Graduate degree" 

la values eeduc educ

recode eeduc (1/3 = 1)(4 5 = 2)(6 = 3)(7 = 4), gen(educ4)

la def educ4 1 "High school or below" 2 "Past HS, not (yet) Bachelor's" ///
3 "Bachelor's degree" 4 "Graduate degree"
la values educ4 educ4

gen ba_abv = 1 if eeduc >= 6 & eeduc != .
replace ba_abv = 0 if eeduc < 6
la var ba_abv "Bachelor's degree or above? (1=yes,0=no)"

gen poc = 1 if idrace >= 2 & idrace != .
replace poc = 0 if idrace == 1
la var poc "ER majority or minority (1=POC, 0=white)"

replace income = . if income == -99 | income == -88

la def income 1 "1: Less than $25,000" 2 "2: $25,000-34,999" ///
	3 "3: $35,000 - $49,999" 4 "4: $50,000 - $74,999" ///
	5 "5: $75,000 - $99,999" 6 "6: $100,000 - $149,999" ///
	7 "7: $150,000 - $199,999" 8 "8: $200,000 and above"
*
la values income income

la def state  1 "Alabama" 2 "Alaska" 4 "Arizona" 5 "Arkansas" ///
6 "California"  8 "Colorado" 9 "Connecticut"  10 "Delaware" ///
11 "District of Columbia"  12 "Florida" 13 "Georgia"  ///
15 "Hawaii" 16 "Idaho"  17 "Illinois" 18 "Indiana"  ///
19 "Iowa" 20 "Kansas"  21 "Kentucky" 22 "Louisiana" ///
23 "Maine" 24 "Maryland" 25 "Massachusetts" 26 "Michigan" ///
27 "Minnesota" 28 "Mississippi" 29 "Missouri" 30 "Montana" ///
31 "Nebraska" 32 "Nevada" 33 "New Hampshire" 34 "New Jersey" ///
35 "New Mexico" 36 "New York" 37 "North Carolina" 38 "North Dakota" ///
39 "Ohio" 40 "Oklahoma" 41 "Oregon" 42 "Pennsylvania" ///
44 "Rhode Island" 45 "South Carolina" 46 "South Dakota" ///
47 "Tennessee" 48 "Texas" 49 "Utah" 50 "Vermont" 51 "Virginia" ///
53 "Washington" 54 "West Virginia" 55 "Wisconsin" 56 "Wyoming" 

la values est_st state

replace sexual_orientation = . if sexual_orientation == -99
replace  genid_describ = . if  genid_describ == -99
replace  egenid_birth = . if  egenid_birth == -99

gen sexual_minority = 1 if sexual_orientation == 1 | ///
sexual_orientation == 3 | sexual_orientation == 4 | sexual_orientation == 5
replace sexual_minority = 0 if sexual_orientation == 2
replace sexual_minority = 1 if genid_describe == 3
replace sexual_minority = 1 if egenid_birth != genid_describe & egenid_birth != . & genid_describe != .

gen inc_loss = 1 if wrkloss == 1 | wrklossrv == 1
replace inc_loss = 0 if wrkloss == 2 | wrklossrv == 2

la var inc_loss "Any HH loss of emp/income in past 4 wks?"
** note this was since 3/13/20 until week 27!
la values inc_loss yesno

gen bef28 = 1 if week < 28
replace bef28 = 0 if week >= 28 & week != .

gen weekval = week

gen withkids = 1 if thhld_numkid >= 1 & thhld_numkid != .
replace withkids = 0 if thhld_numkid == 0

gen multadults = 1 if thhld_numadlt >= 2 & thhld_numadlt != .
replace multadults = 0 if thhld_numadlt == 1

la def hhstruct 1 "Single adult, no kids" 2 "Single adult, with kids" ///
3 "Multiple adults, with kids" 4 "Multiple adults, no kids"

gen hhstruct = 1 if withkids == 0 & multadults == 0
replace hhstruct = 2 if withkids == 1 & multadults == 0
replace hhstruct = 3 if withkids == 1 & multadults == 1
replace hhstruct = 4 if withkids == 0 & multadults == 1
la values hhstruct hhstruct

gen employ = 1 if anywork == 1
replace employ = 0 if anywork == 2
la var employ "YOU any work for pay past 7 days"
la values employ yesno

recode week (1 = 6) (2 = 8) (3 = 9) (4 = 10) (5 = 11) (6 = 12) (7 = 13) ///
(8 = 14) (9 = 15) (10 = 16) (11 = 17) (12 = 18) (13 = 23) (14 = 25) ///
(15 = 27) (16 = 29) (17 = 31) (18 = 33) (19 = 35) (20 = 37) ///
(21 = 39) (22 = 43) (23 = 45) (24 = 47) (25 = 49) (26 = 51) ///
(27 = 53) (28 = 57) (29 = 59) (30 = 61) (31 = 63) (32 = 65) ///
(33 = 67) (34 = 71) (35 = 73) (36 = 75) (37 = 77) (38 = 79) ///
(39 = 81) (40 = 90) (41 = 94), gen(wkssince)

gen wkssq = wkssince^2

gen st_wrk = (100+est_st)*10^2
gen statepulse = st_wrk+week
codebook statepulse
drop st_wrk

gen pre28 = 1 if week < 28
replace pre28 = 0 if week  >= 28

gen inc_lossp = 1 if inc_loss == 1 & week < 28
replace inc_lossp = 0 if inc_loss == 0
replace inc_lossp = 0 if inc_loss == 1 & week >= 28
la var inc_lossp "Any income loss since 3/13/20 (asked thru w27)"

gen inc_lossm = 1 if inc_loss == 1 & week >= 28
replace inc_lossm = 0 if inc_loss == 0
replace inc_lossm = 0 if inc_loss == 1 & week < 28
la var inc_lossm "Any income loss in past 4 weeks (asked w28 on)"

gen under40 = 1 if ageg10 < 3
replace under40 = 0 if ageg10 >= 3 & ageg10 != .

gen vaccinated = 1 if recvdvacc == 1
replace vaccinated = 0 if recvdvacc == 2
la var vaccinated "Have you received a COVID-19 vaccine?"
la values vaccinated yesno

gen doses_opt = 1 if numdoses == 1 & week < 34
replace doses_opt = 0 if numdoses == 2 & week < 34
replace doses_opt = 1 if numdoses == 1 & week >= 34 & week < 40
replace doses_opt = 1 if numdoses == 2 & week >= 34 & week < 40
replace doses_opt = 0 if numdoses == 3 & week >= 34 & week < 40
replace doses_opt = 1 if numdoses == 1 & brand == 3 & week >= 40 & week < 46
replace doses_opt = 1 if numdoses == 2 & week >= 40 & week < 46
replace doses_opt = 1 if numdoses >= 2 & numdoses < 5 & week >= 40 & week < 46 & brand >= 1 & brand < 3
replace doses_opt = 1 if numdoses >= 2 & numdoses < 5 & week >= 40 & week < 46 & brand == 4
replace doses_opt = 1 if numdoses >= 2 & numdoses < 5 & week >= 40 & week < 46
replace doses_opt = 0 if numdoses == 1 & brand != 3 & week >= 40 & week < 46
replace doses_opt = 1 if numdoses == 2 & week >= 46
replace doses_opt = 0 if numdoses == 1 & week >= 46
replace doses_opt = 0 if recvdvacc == 2
la var doses_opt "Did you recieve (or do you plan to) all req'd doses?"
la values doses_opt yesno

gen male = 1 if female == 0
replace male = 0 if female == 1

replace tnum_ps = . if tnum_ps == -88 | tnum_ps == -99

gen any_ps = 1 if tnum_ps >= 1 & tnum_ps != . // postsecondary
replace any_ps = 0 if tnum_ps == 0

replace tenure = . if tenure == -88 | tenure == -99

la def tenure 1 "1: Owned free and clear by someone in this household " ///
2 "2: Owned with a mortgage or loan by someone in this household " ///
3 "3: Rented" 4 "4: Occupied without payment of rent", replace

la values tenure tenure

gen ownedhome = 1 if tenure == 1 | tenure == 2
replace ownedhome = 0 if tenure == 3 | tenure == 4

gen hasmortgage = 1 if tenure == 2
replace hasmortgage = 0 if tenure != 2 & tenure != .

gen paysrent = 1 if tenure == 3
replace paysrent = 0 if tenure != 3 & tenure != .

gen rentormort = 1 if hasmortgage == 1 | paysrent == 1
replace rentormort = 0 if hasmortgage == 0 & paysrent == 0


replace hadcovid = . if hadcovid == -99 | hadcovid == -88 | hadcovid == 3
replace hadcovid = 0 if hadcovid == 2
la values hadcovid yesno


sort statepulse

save "${hhp_output}02_appended datasets/hhp_pulse1-48.dta", replace



