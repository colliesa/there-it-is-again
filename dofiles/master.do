
/*

Title: Master do file for Household Pulse Survey Work
Created on: February 15, 2022

Created by: Sarah Collier Villaume (sarahcollier@northwestern.edu)

Last Modified on: November 2, 2023

*/


** Set globals ** 
global hhp_input "~[filepathhere]/household pulse/raw data/"
global hhp_output "~[filepathhere]/household pulse/working/"
global hhp_do "~[filepathhere]/household pulse/dofiles/"
global hhp_log "~[filepathhere]/household pulse/log files/"
global hhp_graphs "~[filepathhere]/household pulse/graphs/"


// Prep dataset for analysis
do "${hhp_do}looping over cohort files.do"
do "${hhp_do}add state_abrev from fips.do"
do "${hhp_do}label study weeks in created dataset.do"
do "${hhp_do}add covid cases.do"


// Analyses 
do "${hhp_do}analyses 2023-10-29.do"
do "${hhp_do}blinder oaxaca.do"


