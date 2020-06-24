/*array*/
data subj_bp;
input subjid $ sbp1-sbp6;
cards;
P101 230 340 210 220 210 240
P102 310 . 200 . 230 250
P103 . 210 210 220 . 210
P104 220 250 . 210 200 . 
;
/*  Replace missing values with 0  */
data mylib.subj_bp1;
set subj_bp;
array apple(6) sbp1-sbp6;
do i=1 to 6;
if apple(i)= . then apple(i)=0;
end; 

run;

proc print data=mylib.subj_bp1;
run;

/*Using _Numeric_ : 
dim function: requires array name as an argument and returns length of 
the variable */

data subj_bp2;
set subj_bp;
array apple(*) _numeric_;
do i=1 to dim(apple);
if apple(i)= . then apple(i)=0;
end;
drop i;
run;
proc print data=subj_bp2;
run;

/*replace missing values by the mean of corresponding non-missing values:*/

data subj_bp3;
set subj_bp;
Avg=mean(of sbp1-sbp6);
array apple(6) sbp1-sbp6;
do i=1 to 6;
if apple(i)= . then apple(i)=Avg;
end;
drop i Avg;
run;
proc print data=subj_bp3;
run;

/*More efficient.*/

data subj_bp4;
set subj_bp;
array apple(6) sbp1-sbp6;
do i=1 to 6;
if apple(i)= .  then apple(i)= mean(of sbp1-sbp6);
end;
drop i;
run;
proc print data=subj_bp4;
run;



/*To replace character missing:
data*/
data crosstrails;
input pid (visit1-visit4) ($);
cards;
101 Asp-05mg . Msp-10mg . 
102 . Asp-10mg . Msp-10mg
103 Asp-15mg . Msp-15mg . 
;

proc print data=crosstrails;
run;

/*  replace character missing  */
data trails;
set crosstrails;
array orange (4) $ visit1-visit4 ;
do i=1 to 4;
if orange (i)= "" then orange(i)= "placebo";
end;
drop i;
run;
proc print data=trails;
run;

/*To replace multiple columns by the multiple values or 
To replace missing values by the temporary or standard values.

Relacing values:
Hr	72
DBP	80
SBP	120
  Extract  */

data vt;
infile "\\Client\D$\sas\vitalsigns.txt";
input Pid Visit Test $ Units;
run;

/*  Transpose the data  */
proc sort data=Vt out=Vt1;
by pid Visit;
run;

proc transpose data=Vt1 out=Vt2 (drop=_Name_);
id Test;
var Units;
by Pid Visit;
run;
proc print data=Vt2;
run;

/*  Replac missing values  */
data Vt3;
set Vt2;
array apple(3) HR DBP SBP;
array temp(3) _temporary_ (72 80 120);
do i=1 to 3;
if apple(i)=. then apple(i)=temp(i);
end;
drop I;
run;
proc print data=Vt3;
run;

/*  Transpose the data into original format  */
proc sort data=Vt3;
by pid visit;
run;

proc transpose data=Vt3
out=Vt4 (rename=(_Name_=Test Col1=Unitss));
Var HR DBP SBP;
by Pid Visit;
label test=" ";
run;
proc print data=Vt4;
run;


/*data*/

data Month_sales;
infile cards dsd;
input Pcode $ Month $ Sale;
cards;
P101,M1,340
P101,M2,430
P101,M3, .
P101,M4,210
P101,M5,120
P101,M6, .
P102,M1,140
P102,M2,230
P102,M3, .
P102,M4,230
P102,M5,120
P102,M6,220
P103,M1,240
P103,M2, . 
P103,M3,220
P103,M4,240
P103,M5, .
P103,M6,210
;

/*  Transpose the data  */

proc sort data=Month_sales;
by Pcode;
run;

Proc transpose data=Month_sales
out=Sales1(drop=_Name_);
id Month;
var Sale;
by Pcode;
run;

proc print data=sales1;
run;

/*  Replacing missing values  */
Data Sales2;
set Sales1;
array apple(6) m1-m6;
do i=1 to 6;
if apple(i)=. then apple(i)=apple(i-1);
end;
drop i;
run;

/*Here apple(i-1) is used because missing values are replaced by previous
months data, if i+1 then missing values are replaced by preceeding month’s data.*/

proc print data=sales2;
run;

/*  Reformating the data into original format  */
proc sort data=sales2;
by pcode;
run;

proc transpose data=sales2
out=sales3 (rename=(_Name_=Month
col1=sale));
var M1-M6;
by pcode;
run;
proc print data=sales3;
run;
/****************When using RETAIN*****************/
DATA lab;
  INPUT usubjid $ lbtestcd $ avisitn aval;
  DATALINES;
101-1001 WBC 0 10
101-1001 WBC 1 20
101-1001 WBC 2 30
101-1001 WBC 3 . 
101-1001 WBC 4 . 
101-1001 RBC 0 100
101-1001 RBC 1 200
101-1001 RBC 2 300
101-1001 RBC 3 . 
101-1001 RBC 4 400
;
RUN;
 
PROC SORT DATA=lab;
  BY usubjid lbtestcd avisitn;
RUN;
PROC print DATA=lab;
RUN;
 
************************************************;
**** When using RETAIN be absolutely sure   ****;
****  not to drag records between patients  ****;
****  or testcds.                           ****;
****                                        ****;
**** In this example keep aval and avallocf ****;
**** separate to show what is going on.     ****;
**** Generally, aval would be overwritten   ****;
**** with the LOCFed values.                ****;
************************************************;
DATA locf;
  LENGTH dtype $15;
  RETAIN retaval;
  SET lab;
  BY usubjid lbtestcd avisitn;
 
  IF FIRST.lbtestcd THEN retaval=.;
 
  IF aval NE . THEN retaval=aval;
 
  IF aval=. THEN DO;
    avallocf=retaval;
    dtype='LOCF';
  END;
  ELSE avallocf=aval;
 
  LABEL dtype = 'Derivation Type';
RUN;
PROC print DATA=locf;
RUN;
