/*Appending concept*/

data labs1;
input pid age  ;
cards;
101 34 
102 24 
;
proc print ;
run;

data labs2;
input pid age   visit;
cards;
101 25   1
103 26   2
102 28  1
;
proc print ;
run;

data lab;
set labs1 labs2 ;
run;
proc print ;
run;


proc append base=labs1 data=labs2;
run;
proc print ;run;


proc append base=labs2 data=labs1;
run;
proc print ;run;


/*IF, FORCE option*/
data med1;
input pid age ;
cards;
101 34 
102 24 
;
proc print ;
run;

data med2;
input pid age test$;
cards;
104 25 dbp
103 26 sbp
105 28 dbp
;
proc print ;
run;

proc append base=med1 data=med2 ;
run;
proc print ;
run;
proc append base=med1 data=med2 force;
run;
proc print ;
run;
proc append base=med2 data=med1 (where=(age>25)) ;
run;
proc print;
run;

/*Alternative method*/

data visit1;
input pid  dose$;
cards;
100 5mg
101 10mg
104 5mg
;
run;

 
data visit2;
input pid dose$ area$;
cards;
100 15mg hyd
103 10mg hyd
102 20mg hyd
101 15mg hyd
;
run;
 proc sort data =visit1;
 by pid;
 run;
 proc sort data=visit2;
 by pid;
 run;


 
 data visits;
 update visit1 visit2 ;
 by pid;
 run;
 proc print data=visits;
 run;

/* missing values */
data clinic1;
input pid dose;
cards;
100 0.5
101 0.5
;
run;

data clinic2;
input pid dose;
cards;
100  .
102 1.5
101 0.8
;
run;
 proc sort data =clinic1;
 by pid;
 run;
 proc sort data=clinic2;
 by pid;
 run;

 data clinic;
 update clinic1 clinic2	updatemode=nomissingcheck
 ;
 by pid;
 run;
 proc print data=clinic;
 run;

/* update dataset*/

 data clinical;
 input pid dose range$;
 cards;
 200 0.5 low
 201 0.7 medium
 205 1.0 high
 202 0.5 low
 ;

/*Using set statement*/
 data clinicaldata;
 set clinical;
 newdose=dose+0.5;
 run;
 proc print data=clinicaldata;
 run;
/*modify statement cannot save in new dataset,
 only in existing variables in existing dataset only
 */
 data clinical;
 modify clinical;
 dose=dose+1.0;
 run;
 proc print data=clinical;
 run;

data lab1;
 input pid dose range$;
 cards;
 200 0.5 low
 201 0.7 medium
 205 1.0 high
 202 0.5 low
 ;

 data lab2;
 input pid ldose;
 cards; 
 200 1.5
 202 .
 ;
 proc sort data=lab1;
 by pid;
 run;
 proc sort data=lab2;
 by pid;
 run;

 data lab1;
 modify lab1 lab2;
 by pid;
 dose=sum(dose,ldose);
 run;
 proc print data=lab1;
 run;

/*Additional variables  */

 
/* dataset*/

DATA dads; 
  INPUT famid name $ inc ; 
CARDS; 
2 Art  22000 
1 Bill 30000 
3 Paul 25000 
5 Paul 25000 

; 
RUN; 
DATA faminc; 
  INPut famid faminc96 faminc97 faminc98 ; 
CARDS; 
3 75000 76000 77000 
1 40000 40500 41000 
2 45000 45400 45800 
4 45000 45400 45800
;
run;

proc sort data=dads out=dad;
by famid;
run;

proc sort data=faminc out=fam;
by famid;
run;

DATA dadfam ; 
  MERGE dad fam; 
  BY famid; 
RUN;
PROC PRINT DATA=dadfam; 
RUN; 

/*ONE to MANY Merge*/

DATA dady; 
  INPUT famid name $ inc ; 
CARDS; 
2 Art  22000 
1 Bill 30000 
3 Paul 25000 
4 jack 25000 
; 
RUN; 

DATA kids; 
  INPUT famid kidname $ birth age wt sex $ ; 
CARDS; 
1 Beth 1 9 60 f 
1 Bob  2 6 40 m 
1 Barb 3 3 20 f 
2 Andy 1 8 80 m 
2 Al   2 6 50 m 
2 Ann  3 2 20 f 
3 Pete 1 6 60 m 
3 Pam  2 4 40 f 
3 Phil 3 2 20 m 
5 pet  5 3 20 M
; 
RUN; 


proc sort data=dady out=dady1;
by famid;
run;

proc sort data=kids out=kids1;
by famid;
run;
Proc print data=kids1;
run;

data dadkid;
merge dady1 kids1;
by famid;
run;
proc print data=dadkid;
run;

/*Many to Many Merge*/

data ae; 
input ptnum $ 1-3 @5 date date9. event $ 15-35;
format date date9.;
cards;
001 16NOV2009 Nausea
002 16NOV2009 Heartburn
002 16NOV2009 Acid Indigestion
002 18NOV2009 Nausea
003 17NOV2009 Fever
003 18NOV2009 Fever
005 17NOV2009 Fever
;
run;

data cm; ** Concomitant Medication Data;
infile cards;
input ptnum $ 1-3 @5 date date9. medication $ 15-35;
format date date9.;
cards;
001 16NOV2009 Dopamine
002 16NOV2009 Antacid
002 16NOV2009 Sodium bicarbonate
002 18NOV2009 Dopamine
003 18NOV2009 Asprin
004 19NOV2009 Asprin
005 17NOV2009 Asprin
;
run;
proc print data=ae;
run;

data all0;
merge ae cm;
by ptnum;
run;
title1 "Merge using the MERGE statement ";
proc print data=all0;
run;

data a;
input pid	age	gender$	dose$	vist;
cards;
100	28	.	   2MG	1
100	28	.      3mg	2
100	28	.	   2MG	3
100	28	.	   3mg	4
200	32	.	   2MG	1
200	32	Female 3mg	2
200	32	.	   2MG	3
200	32	.	   3mg	4
;
run;

data b;
input pid	age	gender$	vist	sideeffect$	drug$ ;
cards;
100	28	.	    1	pain	srd
100	.	Male	2	vomting	XXYY
100	.	.	    3	motin	yyy	
200	.	.	    1	pain	srd
200	32	Female	2	vomting	 XXX
200	.	.	    3	motin	yyy
200	32	.	    4	head	pctml
;
run;


proc sort data =a;
by pid vist ;
run;

proc sort data =b;
by pid vist;
run;
data c ;
merge a g;
by pid  vist;
run;




