clear 
set more off
//Import data of 2007 to 2015
use "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\Ori_Gov_2007.dta" 


//optional, to see the data we are working on
describe
summarize
list, nolabel



//change variable from "YES" to 1 and "No" to 0

generate BCP = 0
replace BCP = 1 if blankcheck == "YES"

generate CB = 0
replace CB = 1 if cboard == "YES"

generate PP = 0
replace PP = 1 if ppill == "YES"

//save data for appending
keep cusip BCP CB PP year
save "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\New_Gov_2007.dta", replace


//Import data of 1990 to 2006
use "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\Ori_Gov_1990.dta", clear

//optional, to see the data we are working on
describe
summarize
list, nolabel


//Prep data for append

generate BCP = 0
replace BCP = 1 if blankcheck == 1

generate CB = 0
replace CB = 1 if cboard == 1

generate PP = 0
replace PP = 1 if ppill == 1

g cusip = cn6

// appending two dataset
keep cusip BCP CB PP year
append using "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\New_Gov_2007.dta" 


//get the average values of variables, by year
sort year

egen mean_BCP=mean(BCP), by(year)

egen mean_CB=mean(CB), by(year)

egen mean_PP=mean(PP), by(year)



//generate and save the data
line mean_BCP mean_CB mean_PP year


graph export "C:\Users\sirianong\Desktop\Empirical Method in Finance\Assignment 1\Graph1_Lynn.png", as(png)



