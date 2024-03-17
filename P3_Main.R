# This is the main program for the factor model regression project
rm(list = ls());  # Clean up memory.

# Project related tasks: 
# loc1: Load Data, run basic statistics, and draw the Terminal Wealth Chart.
# loc2: Regression analyses to get 1,3,and 4-factor alphas
# loc3: 
# Loc:    1 2 3 4 5
Tasks = c(1,1,0,0,0);
# Task 1: Load Data, and run basic statistics.
if (Tasks[1]==1) {
  source("P3_Script_1.R"); 
}

# Task 2: Regression analyses to get 1,3,and 4-factor alphas.
if (Tasks[2]==1) {
  source("P3_Script_2.R"); 
}
