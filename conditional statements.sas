
/*Conditional statement*/

data medi;
input pid name$ age center$;
cards;
100 kiran 25 Appolo
101 kumar 26 nims
102 madhu 26 care
103 mohan 35 appolo
105 vishnu 25 care
;
proc print data =medi;
run;

*it is permanent to write WHERE statement in data set block*;
data mednew;
set medi(where=( CENTER = 'Appolo'));
run;
proc print data=MEDnew;
run;
proc print data =medi;
WHERE CENTER='care';
run;


proc print data=medi;
where center in ('nims','care');
run;

proc print data=medi;
where center not in ('nims','care');
run;

/* Arithmetic operators-  + - * / **   */

/*Conditional operators- symbol     memonics

                            >         gt
                            <         lt
                            >=        ge
                            <=        le
                             =        eq
                            ~=,n=     ne

*/


/*Logical operators-    symbol     nemonics

                           &         and
                           \         or
                                     in 
                                     like 
                                      is
                                     between

*/

data medidata;
input pid name$ age center$ sub;
cards;
100 kiran 25 appolo 67
101 kumar 28 nims    98
102 madhu 25 care   68
103   .    15 appolo 89
105 vishnu 60 care  90
106 vamshm  33 appolo 56
107 midhis . care  89
;

proc print data=medidata;
where age>25 and age<30;
run;

proc print data =medidata;
where center= 'care' or  age >50 ;
run;

proc print data =medidata;
where age <50 or center='care';
run;
proc print data=medidata;
where center in ('care','nims');
run;
proc print data=medidata;
where center not in ('care','nims');
run;

proc print data =medidata;
where (center='nims' or center='care') and age <= 26;
run;


proc print data =medidata;
where (center='care' and age >26 ) or (center= 'nims' and age >=25);
run;



proc print data=medidata;
where name like '%m%';
run;


proc print data=medidata;
where name like '__m%';
run;

proc print data=medidata;
where name like 'm%';
run;

proc print data=medidata;
where name like "";
run;

proc print data=medidata;
where name is null;
run;
proc print data=medidata;
where name is missing;
run;

proc print data=medidata;
where age=. ;
run;

proc print data=medidata;
where age ~=. and name ~="" ;
run;
proc print data=medidata;
where age is null  or name is null;

run;

data medi;
input pid age jdate ;
informat jdate ddmmyy10.;
cards;
100 24 21/05/1920
101 24 05-08-1991
102 25 07.09.1992
103 25 01.01.1960
100 24 21/05/1930
101 24 05-08-1981
102 25 07.09.1952
103 25 01.01.1990
;
run;

proc print data=medi;
where jdate  lt  '01jan1960'd;
format jdate ddmmyy10.;
run;

/*Double trailing method*/

data labs;
input pid week dose @@ ;
cards;
100 4 0.5 101 5 1.0 102 6 0.25 109 7 1.0
108 9 0.5
111 3 0.7 113 6 1.0 123 7 0.5 126 7 1.0
105 3 0.5
;
run;
proc print data =labs;run;
/*single trailing Method */

DATA grades;
    input ID @;
    input score @;
	output;
	input score @;
	output;
	input score @;
	output;
    DATALINES;
  111000234 79 82 100
  922232573 87 89  95
  252359873 65 72  73
  205804679 92 95  99
  ;
RUN;

PROC PRINT data = grades ;
RUN; 



                                                               
data rawdata;                                                                                                                     
infile '\\Client\D$\sas\rawdata.txt' dlm=',' firstobs=2;                                                
input CONTROL_NO $11.                                                                                                                   
DOSE $                                                                                                                                  
PATNO $13.                                                                                                                              
VISITS                                                                                                                                  
BMI                                                                                                                                     
ECG                                                                                                                                     
HR                                                                                                                                      
RESP                                                                                                                                    
S_BP                                                                                                                                    
D_BP                                                                                                                                    
K_URN                                                                                                                                   
Na_URN                                                                                                                                  
CL_URN                                                                                                                                  
Ca_URN                                                                                                                                  
SG_URN                                                                                                                                  
CPK_BL                                                                                                                                  
HCYS_BL                                                                                                                                 
pH_URN                                                                                                                                  
GL_URN                                                                                                                                  
GLUCOSE                                                                                                                                 
CALCIUM                                                                                                                                 
ALBUMIN                                                                                                                                 
TOT_PROTEIN                                                                                                                             
SODIUM_BLOOD                                                                                                                            
SERUM_POTASSIUM                                                                                                                         
BICARBONATE                                                                                                                             
SER_CHLORIDE                                                                                                                            
BUN_KDN_TEST                                                                                                                            
CREATININE                                                                                                                              
ALP_UL                                                                                                                                  
ALT                                                                                                                                     
AST                                                                                                                                     
BILIRUBIN                                                                                                                               
WBC                                                                                                                                     
RBC                                                                                                                                     
HEMOGLOBIN                                                                                                                              
HEMATOCRIT                                                                                                                              
PLATELET_COUNT                                                                                                                          
MCV                                                                                                                                     
MCH                                                                                                                                     
MCHC                                                                                                                                    
RDW                                                                                                                                     
NEUTROPHILS                                                                                                                             
LYMPHOCYTES                                                                                                                             
MONOCYTES                                                                                                                               
EOSINOPHILS                                                                                                                             
BASOPHILS                                                                                                                               
TOT_CHOLS                                                                                                                               
LDL_C                                                                                                                                   
HDL_C                                                                                                                                   
TG                                                                                                                                      
APO;                                                                                                                                    
RUN;         
                                                                                                                                   
proc print;                                                                                                                             
run;                                                                                                                                    


data variable ;                                                                                                                   
set Rawdata (keep=patno visits dose wbc neutrophils lymphocytes monocytes eosinophils basophils);                                 
run;                                                                                                                                    
proc print;                                                                                                                             
run;                                                                                                                                                                                                                                                      
data dose40_v1 dose40_v2 dose40_v3 dose40_v4 dose40_v5;                                                   
set variable;                                                                                                                     
if dose='40' and visits=1 then output dose40_v1;                                                                               
if dose='40' and visits=2 then output dose40_v2;                                                                               
if dose='40' and visits=3 then output dose40_v3;                                                                               
if dose='40' and visits=4 then output dose40_v4;                                                                               
if dose='40' and visits=5 then output dose40_v5;                                                                                  
run;                                                                                                                                    
proc print;                                                                                                                             
run;
 
 
/*If then, If then else statements*/

/*If we want to run any statement based on CONDITION ,
in these cases we should use IF statement*/

data clinical;
input pid age center$ ;
cards;
100 24 appolo  
101 25 care
102 26 nims
104 26 care
105 32 nims
106 31 care
;
run;

data clin;
length center $ 30;
set clinical;
if center='care' then dose='40mg for pain';
if center='care' then center='my care hosp';
else dose='placebo';
run;
proc print data=clin;run;

/*ELSE IF */
data clinic;
set clinical;
length dose$ 10;
if center='care' then dose='40mg';
else if center='nims' then dose='80mg';
else dose='placebo';
run;
proc print data=clinic;
run;

proc sort data=	sashelp.class out = ff;
by age;
run;

data gg;
set ff;
by age;
if 	last.age;
run;
proc print;
run;

data hh;
set ff;
by age;
if 	first.age then x=1;
if 	last.age then x=2;
run;
proc print;
run;

data gg;
set ff;
by age;
x =	first.age;
y= last.age;
z=x/y;
run;
proc print;
run;






