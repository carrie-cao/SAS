/*read data */
data mylib.blood;
infile"\\client\D$\sas\blood.txt" ;
input pid gender$ blood_type$ age_group$ rbc chole;
run;
proc print data=mylib.blood;
run;
proc means data=mylib.blood;
run;

/*
PROC MEANS Option            Statistic Produced
N                            Number of non-missing values
NMISS                        Number of missing values
MEAN                         Mean or Average
SUM                          Sum of the values
MIN                          Minimum (non-missing) value
MAX                          Maximum value
MEDIAN                       Median value
STD                          Standard deviation
VAR                          Variance

*/

/*Adding a VAR*/
title "Selected Statistics Using PROC MEANS";
proc means data=mylib.blood n nmiss mean median
min max maxdec=1 var;
var  RBC chole;
run;
/*Adding a BY statement to PROC MEANS*/
proc sort data=mylib.blood out=blood;
by Gender;
run;
title "Adding a BY Statement to PROC MEANS";
proc means data=mylib.blood 

KURTOSIS  LCLM  MAX  MAXDEC=1  MEAN  MEDIAN 
              MIN  MISSING     N     NMISS     NONOBS  NOPRINT    
              NOTRAP  NWAY  
              PRINTALL  PRINTALLTYPES  PRINTIDS  PRINTIDVARS  PROBT  Q1  Q3    
                QRANGE  RANGE  SKEWNESS  STDDEV  STDERR  SUM     SUMWGT 
              T    UCLM  USS  VAR   
;
by Gender;
var RBC chole;
run;
/* */
title "CLASS Statement";
proc means data=mylib.blood n nmiss mean median
min max maxdec=2;
class Gender;
var RBC chole;
run;


/*summary data*/
proc means data=mylib.blood ;
var RBC chole;
output out = my_summary 
mean = RBC chole;
run;
title "SUMMARY";
proc print data=my_summary noobs;
run;
/*Output more*/
proc means data=mylib.blood noprint;
var RBC chole;
output out = many_stats(drop=_type_ _freq_)
mean = M_RBC M_chole
n = N_RBC N_chole
nmiss = Miss_RBC Miss_chole
median = Med_RBC Med_chole;
run;
proc print data= many_stats;
run;

/*AUTONAME*/
proc means data=my.blood noprint;
var RBC chole;
output out = many_stats
mean =
n =
nmiss =
median = / autoname;
run;
proc print data= many_stats;
run;
/*two CLASS variables */
proc means data=mylib.blood ;
class Gender Age_Group;
var RBC chole;
output out = summary
mean =
n = / autoname;
run;
proc print data= summary ;
run;

/*different statistics for each variable*/
proc means data=mylib.blood  ;
class Gender Age_Group;
output out = summary2
mean(RBC chole) =
n(RBC ) =
median(Chole) = / autoname
 ;
run;
proc print data= summary2 ;
run;


