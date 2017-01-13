
//import the data from 2007 to 2015 & Prep Data for Append
use "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\Ori_Dir_2007.dta", clear
format year %ty
g female_new = 0
replace female_new = 1 if female == "Yes"
tab female_new female, missing
format female_new %12.0g
drop female
tab classification, missing


save "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\New_Dir_2007.dta", replace

// Import data from 1996 to 2006 
use "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\Ori_Dir_1990.dta", clear
format year %ty
format female %12.0g
//*** this is the limitation of data. no missing value in the 2007 database avail
count if female == .
//*** this is the limitation of data. no missing value in the 2007 database avail 
//*** seems like the %of female increase but actually it is from automatically count missing data as male in 2007 database
//*** this explanation is weird b/c 2007 data should be more accurate than 1990 data
g female_new = female
tab female_new female, missing
format female_new %12.0g
tab classification, missing nolabel

//append two datasets
append using "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\New_Dir_2007.dta"
format female %12.0g

//generate ID for independent board .... Independent board = 1, the higher the better
g ID = 0
replace ID = 1 if classification == "I"
tab classification ID

//Compute the percentage of female board members and the percentage of independent directors for each firm
egen mean_female = mean (female_new), by(cusip)

egen mean_ID = mean (ID), by (cusip)



//collapse the data so that you retain only one observation per firm and year
collapse mean_female mean_ID, by(year)
list



//Plot both against time in the same graph using two different y-axes.
// I changed axis a bit
tw (line mean_female year, yaxis(1)) (line mean_ID year, yaxis(2)), ylabel(0 ".0" 0.2 ".2" 0.4 ".4" 0.6 ".6" 0.8 ".8" 1 "1", angle(0))

