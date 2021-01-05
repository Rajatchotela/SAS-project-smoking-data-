data smoking;
filename refname '/folders/myfolders/smoking/smoking.csv';
run;
proc import datafile=refname dbms=csv out=smoking replace;
run;

proc print data= smoking;
run;
proc corr data=smoking;
var risk pressure;
run;

data sort_data;
set smoking;
proc sort data=smoking;
by smoker;
run;
proc print data=sort_data;
run;

data no_smokers;
set sort_data;
if smoker='Yes' then delete;
run;

data yes_smokers;
set sort_data;
if smoker='No' then delete;
run;



data new_variable;
set sort_data (rename=(Smoker=newvar));
if newvar='Yes' then Smoker=1; else Smoker=0;
drop newvar;
run;

data final_data;
set new_variable;
proc logistic data=new_variable desc;
model Smoker=risk Age Pressure;
output out=final_data p=pred_prob lower= low upper=upp;
run;



















 
 