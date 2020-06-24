data sample_report;
  length txt $3 val 4.;
  input  txt    val   ;
datalines;
a 124
b .
a 33
b 332
b 5
a 105
a .
b 223
b 22
quit;

proc report data=sample_report;
     where val > 50;

  /* The column statement identifies all variables
     that are used in the report: */
     column txt val val_sq;

     define txt / display;
     define val / display;
     
     compute val_sq;
       val_sq = val ** 2;
     endcomp;
run;
/*define order*/
proc report data=sample_report;
     column txt val;

     define txt / order;    /* Order by txt */
     define val / display;
run;
/*group*/
data tq84_report;
  length txt1 $3
         txt2 $3
         txt3 $2
         val   4.;
  input  txt1 txt2 txt3 val;
datalines;
abc jkl uv  13
ghi mno uv 288
ghi pqr wx   7
abc mno yz  15
def pqr uv   3
abc jkl uv   .
ghi jkl wx  96
ghi mno yz  75
abc pqr yz 111
abc jkl uv  86
def pqr uv  39
ghi jkl yz  22
abc pqr wx   .
ghi mno uv  41
def pqr yz  52
quit;


proc report data=tq84_report;
     column txt1 txt2 txt3 val;

     define txt1 / group;
     define txt2 / group;
     define txt3 / group;
     define val  / analysis sum;
     
run;
/* analysis*/
proc report data=tq84_report;
     column txt1 txt2 txt3
         /* val is used for multiple statistics per
            group. Therefore, we create an alias
            for each statistics: */
            val = val_sum
            val = val_avg
            val = val_min
            val = val_max 
            val = val_cnt;

     define txt1    / group;
     define txt2    / group;
     define txt3    / group;
     define val_sum / analysis sum             'Total';
     define val_avg / analysis mean format=3.1 'Avg.' ;
     define val_min / analysis min             'Min.' ;
     define val_max / analysis max             'Max.' ;
     define val_cnt / analysis n               'Count';
     
run;
/*across*/
proc report data=tq84_report;

     column txt1 txt2 txt3 val;

     define txt1 / group        'txt one';
     define txt2 / group        'txt two';
     define txt3 / across       'txt three';
     define val  / analysis sum 'Total';
run;
/*compute*/
proc report data=tq84_report;

     column txt1 txt2 txt3 val;

     define txt1 / group        'txt one';
     define txt2 / group        'txt two';
     define txt3 / across       'twt three';
     define val  / analysis sum 'Total';

     compute before txt1;
       line  @1 "Values for " txt1 $20.;
     endcomp;

     compute after txt1;
       length group_txt $20;

       if txt1 = 'abc' then group_txt = 'Computed text foo'; else
       if txt1 = 'def' then group_txt = 'Computed text bar'; else
       if txt1 = 'ghi' then group_txt = 'Computed text baz'; else
                            group_txt = '???';

       line @1 group_txt $20.;
     endcomp;
run;
/*list*/
data tq84_dat;

 length txt_one $10
        txt_two $10
        num_one   8.
        num_two   8.;

  input txt_one
        txt_two
        num_one
        num_two;

datalines;
foo abc  2 40 
run;

proc report
     data=tq84_dat
     list;
run;

/* list */
PROC REPORT DATA=WORK.TQ84_DAT LS=132 PS=60  SPLIT="/" NOCENTER ;
COLUMN  txt_one txt_two num_one num_two;
 
DEFINE  txt_one / DISPLAY FORMAT= $10. WIDTH=10    SPACING=2   LEFT "txt_one" ;
DEFINE  txt_two / DISPLAY FORMAT= $10. WIDTH=10    SPACING=2   LEFT "txt_two" ;
DEFINE  num_one / SUM FORMAT= BEST9. WIDTH=9     SPACING=2   RIGHT "num_one" ;
DEFINE  num_two / SUM FORMAT= BEST9. WIDTH=9     SPACING=2   RIGHT "num_two" ;
RUN;
*/
