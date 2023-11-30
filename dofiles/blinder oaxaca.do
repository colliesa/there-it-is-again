


ssc install oaxaca

tab ageg10, gen(ageg10_)
tab est_st, gen(statefips_)
tab week, gen(week_)


log using "${hhp_log}hhp_03 Blinder Oaxaca_2023-02-07.log", name(logBO) replace


****************************
*** Results for eTable 8 ***
****************************

// column 1

foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_2 week_3 week_4 week_5 week_6 week_7 week_8 week_9 week_10 ///
week_11 week_12 week_13 week_14 week_15 week_16 week_17 week_18 ///
week_19 week_20 week_21 week_22 week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*


// column 2
* Repeat with income omitted. 

foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_2 week_3 week_4 week_5 week_6 week_7 week_8 week_9 week_10 ///
week_11 week_12 week_13 week_14 week_15 week_16 week_17 week_18 ///
week_19 week_20 week_21 week_22 week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*


***
*** With income, plus each source of econ instability 
***

// column 3
foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
ownedhome ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*

// column 4
foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
employ ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*

// column 5
foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
inc_lossp inc_lossm ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*

// column 6 
foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
risksc_2 risksc_3 risksc_4 risksc_5 ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*



***********************
*** COVID Variables ***
***********************

// column 7 (just adds COVID cases, otherwise comparable to model 1)
foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
cases_pcap10 cases_pcap10sq ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_2 week_3 week_4 week_5 week_6 week_7 week_8 week_9 week_10 ///
week_11 week_12 week_13 week_14 week_15 week_16 week_17 week_18 ///
week_19 week_20 week_21 week_22 week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*

// column 8
* Demogs only but with timeframe narrowed to weeks 22-on

foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*

// column 9
* adds COVID cases
foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
cases_pcap10 cases_pcap10sq ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*

// columns 10 and 11 (had COVID, vaxxed each in separate models)

foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
cases_pcap10 cases_pcap10sq ///
hadcovid ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
cases_pcap10 cases_pcap10sq ///
vaccinated ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*

// column 12 (had COVID, vaxxed in same model)
foreach var in anxiety depression {

oaxaca `var' female educ4_1 educ4_3 educ4_4 ///
idrace_2 idrace_3 idrace_4 idrace_5 ///
inc4_1 inc4_2 inc4_3 ///
cases_pcap10 cases_pcap10sq ///
hadcovid vaccinated ///
statefips_2 statefips_3 statefips_4 statefips_5 ///
statefips_6 statefips_7 statefips_8 statefips_9 statefips_10 ///
statefips_11 statefips_12 statefips_13 statefips_14 statefips_15 ///
statefips_16 statefips_17 statefips_18 statefips_19 statefips_20 ///
statefips_21 statefips_22 statefips_23 statefips_24 statefips_25 ///
statefips_26 statefips_27 statefips_28 statefips_29 statefips_30 ///
statefips_31 statefips_32 statefips_33 statefips_34 statefips_35 ///
statefips_36 statefips_37 statefips_38 statefips_39 statefips_40 ///
statefips_41 statefips_42 statefips_43 statefips_44 statefips_45 ///
statefips_46 statefips_47 statefips_48 statefips_49 statefips_50 ///
statefips_51 ///
week_23 week_24 week_25 week_26 ///
week_27 week_28 week_29 week_30 week_31 week_32 week_33 week_34 ///
week_35 week_36 week_37 week_38 week_39 week_40 week_41 week_42 ///
week_43 week_44 week_45 week_46 week_47 week_48 if ageg10 < 5, by(under40) svy 
	
}
*



