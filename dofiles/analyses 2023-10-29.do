

					*****************************************
					*** Descriptive statistics (eTable 2) ***
					*****************************************

do "${hhp_do}new variables in fully merged dataset.do"

log using "${hhp_log}hhp_01 Descriptive statistics_2023-06-16.log", name(logdesc) replace

svyset [pweight=pweight], singleunit(scaled)

*****************************
*** I. For sample overall ***
*****************************

// Means go into descriptives table, column 1
svy: mean female i.idrace i.ba_abv
svy: mean i.inc_4cat // 4-category is used in table, other for ref
svy: mean i.ageg10 
svy: mean i.hhstruct
svy: mean i.tenure
svy: mean inc_loss if week < 28
svy: mean inc_loss if week >= 28
svy: mean employ
svy: mean i.risksc


*******************************
*** II. For 18-39 and 40-59 ***
*******************************

// descriptives columns 2 and 3
forvalues i = 0/1 {
	
	svy: mean female i.idrace i.ba_abv if under40 == `i' & ageg10 < 5
	svy: mean i.inc_4cat if under40 == `i' & ageg10 < 5
	svy: mean i.hhstruct if under40 == `i' & ageg10 < 5
	svy: mean hadcovid if under40 == `i' & ageg10 < 5
	svy: mean vaccinated if under40 == `i' & ageg10 < 5
	svy: mean i.tenure if under40 == `i' & ageg10 < 5
	svy: mean inc_loss if week < 28 & under40 == `i' & ageg10 < 5
	svy: mean inc_loss if week >= 28 & under40 == `i' & ageg10 < 5
	svy: mean employ if under40 == `i' & ageg10 < 5
	svy: mean i.risksc if under40 == `i' & ageg10 < 5
}
*


******************************
*** III. For 60+ age group ***
******************************

// descriptives table column 4

	svy: mean female i.idrace i.ba_abv if ageg10 == 5 | ageg10 == 6
	svy: mean i.inc_4cat if ageg10 == 5 | ageg10 == 6
	svy: mean i.hhstruct if ageg10 == 5 | ageg10 == 6
	svy: mean hadcovid if ageg10 == 5 | ageg10 == 6
	svy: mean vaccinated if ageg10 == 5 | ageg10 == 6
	svy: mean i.tenure if ageg10 == 5 | ageg10 == 6
	svy: mean inc_loss if week < 28 & ageg10 >= 5 & ageg10 != .
	svy: mean inc_loss if week >= 28 & ageg10 >= 5 & ageg10 != .
	svy: mean employ if ageg10 == 5 | ageg10 == 6
	svy: mean i.risksc if ageg10 == 5 | ageg10 == 6

***********************
*** IV. Odds Ratios ***
***********************

// for weighted descriptive statistics (columns 5 and 6)


// First, all that are already indicator vars
foreach var in female ba_abv ownedhome hadcovid vaccinated employ {
	svy: logistic `var'  ib2.ageg20 // age 40-59 ref group
}
*

// Then, items that changed over survey period
svy: logistic inc_loss ib2.ageg20 if week < 28 
svy: logistic inc_loss ib2.ageg20 if week >= 28


// Next, create indicator variables as needed 
foreach var in idrace educ4 inc_4cat hhstruct tenure risksc {
	tab `var', gen(`var'_)
	}
*

// Generate descriptives for these
foreach var in idrace_1 idrace_2 idrace_3 idrace_4 idrace_5 ///
inc_4cat_1 inc_4cat_2 inc_4cat_3 inc_4cat_4 ///
hhstruct_1 hhstruct_2 hhstruct_3 hhstruct_4 ///
risksc_1 risksc_2 risksc_3 risksc_4 risksc_5 {
	svy: reg `var' ib2.ageg20
	svy: logistic `var' ib2.ageg20
	}
*

save "${hhp_output}analytic_dataset2023-10-31.dta", replace


							****************
							*** Analyses ***
							****************

							
log using "${hhp_log}hhp_01 Regression models.log", name(logreg) replace				
				
************************************************
*** I. Demographic differences in prevalence ***
************************************************

svy: mean anxiety if ageg20 == 1
svy: mean depression if ageg20 == 1

// In-text reference to age disparity by 20-year category (18-39 vs 40-59 vs 60+)
areg anxiety i.ageg20 [pw=pweight], a(est_st)
areg depression i.ageg20 [pw=pweight], a(est_st)

areg anxiety ib2.ageg20 [pw=pweight], a(est_st)
areg depression ib2.ageg20 [pw=pweight], a(est_st)

areg anxiety ib3.ageg20 [pw=pweight], a(est_st)
areg depression ib3.ageg20 [pw=pweight], a(est_st)


areg anxiety [pw=pweight] if ageg20 == 1, a(est_st)


// In-text reference to widening age gap 
*	(for the period from April 2020 to Jan 2021 vs Jan 2021 to August 2022)

gen wk22orlater = 1 if week >= 22 & week != .
replace wk22orlater = 0 if week < 22

areg anx100 under40##wk22orlater if ageg10 < 5 [pw=pweight], a(est_st)
areg dep100 under40##wk22orlater if ageg10 < 5 [pw=pweight], a(est_st)

// for second set of confidence intervals:
areg anx100 under40##ib1.wk22orlater if ageg10 < 5 [pw=pweight], a(est_st)
areg dep100 under40##ib1.wk22orlater if ageg10 < 5 [pw=pweight], a(est_st)


***
*** eTable 4 (analysis of demographic differences in prevalence)
***

* First set of regression results reported: columns 1 and 2 

// standard covariates: sex, race, age, education level
areg anx100 female i.ageg10 i.idrace ba_abv i.week [pw=pweight], a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week [pw=pweight], a(est_st)

*	models that include income // columns 3 and 4 
areg anx100 female i.idrace ba_abv i.inc_4cat i.ageg10 i.week [pw=pweight], a(est_st)
areg dep100 female i.idrace ba_abv i.inc_4cat i.ageg10 i.week [pw=pweight], a(est_st)



**********************************************
*** II. Is it driven by pandemic severity? ***
**********************************************

***
*** eTable 5 (COVID cases and deaths, by state-week)
***

// (1) Cases

areg anx100 female i.ageg10 i.idrace ba_abv i.week c.cases_pcap10 c.cases_pcap10sq [pw=pweight] if ageg10 < 5, a(est_st) // column 1
areg anx100 female i.ageg10 i.idrace ba_abv i.week c.cases_pcap10##under40 c.cases_pcap10sq##under40 [pw=pweight] if ageg10 < 5, a(est_st) // column 2
areg anx100 female i.ageg10 i.idrace ba_abv i.week c.cases_pcap10##under40 c.cases_pcap10sq##under40 [pw=pweight] if ageg10 < 5 & week < 22, a(est_st) // column 3
areg anx100 female i.ageg10 i.idrace ba_abv i.week c.cases_pcap10##under40 c.cases_pcap10sq##under40 [pw=pweight] if ageg10 < 5 & week >= 22, a(est_st) // column 4

areg dep100 female i.ageg10 i.idrace ba_abv i.week c.cases_pcap10 c.cases_pcap10sq [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week c.cases_pcap10##under40 c.cases_pcap10sq##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week c.cases_pcap10##under40 c.cases_pcap10sq##under40 [pw=pweight] if ageg10 < 5 & week < 22, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week c.cases_pcap10##under40 c.cases_pcap10sq##under40 [pw=pweight] if ageg10 < 5 & week >= 22, a(est_st)


// (2) Deaths

areg anx100 female i.ageg10 i.idrace ba_abv i.week deaths_pcap deaths_sq [pw=pweight] if ageg10 < 5, a(est_st)
areg anx100 female i.ageg10 i.idrace ba_abv i.week c.deaths_pcap##under40 c.deaths_sq##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg anx100 female i.ageg10 i.idrace ba_abv i.week c.deaths_pcap##under40 c.deaths_sq##under40 [pw=pweight] if ageg10 < 5 & week < 22, a(est_st)
areg anx100 female i.ageg10 i.idrace ba_abv i.week c.deaths_pcap##under40 c.deaths_sq##under40 [pw=pweight] if ageg10 < 5 & week >= 22, a(est_st)

areg dep100 female i.ageg10 i.idrace ba_abv i.week deaths_pcap deaths_sq [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week c.deaths_pcap##under40 c.deaths_sq##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week c.deaths_pcap##under40 c.deaths_sq##under40 [pw=pweight] if ageg10 < 5 & week < 22, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week c.deaths_pcap##under40 c.deaths_sq##under40 [pw=pweight] if ageg10 < 5 & week >= 22, a(est_st)


***
*** eTable 6 
***

// the results below correspond to Table S5 (organized here in the order presented in text)

*****************
*** Had COVID ***
*****************

areg anx100 female i.ageg10 i.idrace ba_abv i.week hadcovid [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week hadcovid [pw=pweight] if ageg10 < 5, a(est_st)

areg anx100 female i.ageg10 i.idrace ba_abv i.week hadcovid##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week hadcovid##under40 [pw=pweight] if ageg10 < 5, a(est_st)

*************************
*** Prior vaccination ***
*************************

areg anx100 female i.ageg10 i.idrace ba_abv i.week vaccinated [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week vaccinated [pw=pweight] if ageg10 < 5, a(est_st)

areg anx100 female i.ageg10 i.idrace ba_abv i.week vaccinated##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv i.week vaccinated##under40 [pw=pweight] if ageg10 < 5, a(est_st)




************************************************
*** III. Is it driven by economic precarity? ***
************************************************

***
*** eTable 7
***

// Home owned vs rented
areg anx100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week homeowned [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week homeowned [pw=pweight] if ageg10 < 5, a(est_st)

areg anx100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week homeowned##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week homeowned##under40 [pw=pweight] if ageg10 < 5, a(est_st)


// Employed prior week
areg anx100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week employ [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week employ [pw=pweight] if ageg10 < 5, a(est_st)

areg anx100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week employ##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week employ##under40 [pw=pweight] if ageg10 < 5, a(est_st)


// Lost income due to pandemic
areg anx100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week inc_lossp inc_lossm [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week inc_lossp inc_lossm [pw=pweight] if ageg10 < 5, a(est_st)

areg anx100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week inc_lossp##under40 inc_lossm##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week inc_lossp##under40 inc_lossm##under40 [pw=pweight] if ageg10 < 5, a(est_st)

// Economic precarity - risk score
areg anx100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week i.risksc [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week i.risksc  [pw=pweight] if ageg10 < 5, a(est_st)

areg anx100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week i.risksc##under40 [pw=pweight] if ageg10 < 5, a(est_st)
areg dep100 female i.ageg10 i.idrace ba_abv ib2.inc_4cat i.week i.risksc##under40  [pw=pweight] if ageg10 < 5, a(est_st)








