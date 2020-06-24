/*loop  */

data subject1;
subjid=100;
do while (subjid<130);  /*can use do until (subjid>130);*/
subjid2=subjid;  output;
subjid=subjid+1;   
end; 
run;
proc print data=subject1 ;
run;

/*Using two variables*/

data subjects ;
i= 1;
do while (i <= 20);
subjid = i;    output;
i = i+1; 
end;
run;
proc print data=subjects noobs;
run;

/* generate custno */

data subject2;
subjid=100;
do while (subjid>50);
subjid1=subjid;output;
subjid = subjid-2;
end;
run;
proc print data=subject2 noobs;
run;

/*do */

data subject2;
do subjid = 2 to 130 by 2;
subjid = subjid; output;
end;
run;
proc print data = subject2 noobs;
run;



/*Nested
Sno	Pid
1	1
1	2
1	3
1	4
1	5
2	1
2	2
2	3
2	4
2	5
3	1
3	2
3	3
3	4
3	5 */

data dm;
sno=1;
do while (sno<=3);
 pid = 1;
  do while (pid<=10);
   sno = sno;
   pid = pid; output;
   pid = pid+1;
  end;
sno = sno+1;
end;
run;

proc print data=dm noobs;
run;
/*do loop */

data cust_house;
do custno = 100 to 130 by 1;
custno = custno; output;
end;
run;

proc print data = cust_house noobs;
run;

/*GRADES data*/

data grades;
length Gender $ 1. Quiz $ 2. AgeGrp $ 13.;
infile '\\Client\D$\sas\grades.txt' ;
input Age Gender Midterm Quiz FinalExam;
if missing(Age) then delete;
if Age le 39 then do;
Agegrp = 'Younger group';
naidu="SAS Trainer";
palce="HYD";

end;
else if Age gt 39 then do;
Agegrp = 'Older group';
naidu="SAS programmer";
palce="USA";
end;
run;
title "Listing of GRADES";
proc print data=grades noobs;
run;


data table;
do n = 1 to 10;
Square = n*n;
output;
end;
run;
title "Table of Squares and Square Roots";
proc print data=table ;
run;

/*DO process*/
data medi;
input pid age ;
cards;
100 23 
102 34
103 45
104 35
105 25  
106 45
107 50
;
run;

data med;
set medi;
length range$ 6.;
if age <=25 then do;
dose='col5mg';
range='low';
end;
else if age >25 and age <=40 then do;
dose='col10mg';
range='medium';
end;
else do;
dose='col15mg';
range='high';
end;
run;
proc print data=med;
run;
/*DO UNTIL */

data info(drop=i);
i=200;
do until(i<300);
pid=i;output;
i=i+2;
end;
run;
proc print data=info;
run;
