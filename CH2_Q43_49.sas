*Chapter 2: Question 43;
* A) In CancerRates.dat there are 2 variables and 10 observations;
* B);
DATA CancerRates;
INFILE '/folders/myfolders/ChapterFiles/2/CancerRates.dat';
INPUT Type $ 5-13 Rate;
RUN;
*C);
PROC PRINT DATA=CancerRates;
RUN;

** Question 49;
DATA CompUsers;
INFILE '/folders/myfolders/ChapterFiles/2/CompUsers.dat';
	INPUT userid group $ first $ last $ @"email:" email :$35. @"phone:" phone $ major $ @@ ;
RUN;
PROC PRINT DATA= Compusers;
	TITLE 'Computer Users';
RUN;
DATA CompUsers;
INFILE '/folders/myfolders/ChapterFiles/2/CompUsers.dat';
	INPUT userid group $ first $ last $ @"email:" email :$35. @"phone:" phone $ major $ @@;
	IF group = 'Student' THEN DELETE;
RUN;

PROC PRINT DATA= Compusers;
	TITLE 'Non-Student Computer Users';
RUN;
