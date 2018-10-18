** Chapter 1: Question 27;

** Compute Body Mass Index using pounds and
inches;
DATA bodymass;
	Weight = 150;
	Height = 68;
	BMI = (Weight / Height ** 2) * 703;
RUN;
PROC PRINT;
** B) 22.804930796
   C) All Types and Lengths are Numeric and 8;

** Question 28;

**PROC OPTIONS;
**RUN;
** MISSING=.         Specifies the character to print for missing numeric values
   OBS=9223372036854775807
                    Specifies the observation that is used to determine the last 
                    observation to process, or specifies the last record to process.
   PAPERSIZE=LETTER  Specifies the paper size to use for printing.
   YEARCUTOFF=1926   Specifies the first year of a 100-year span that is used by date
   					 informats and functions to read a two-digit 
                     year.;
OPTIONS NOCENTER;
RUN;
** Channged CENTER to NOCENTER;
PROC OPTIONS;
RUN;
** Change Verified;

** Question 29
OPTIONS NONUMBER;

DATA info;
	City  = 'Sao Paulo';
	Country  = 'Brazil';
	CountryCode = 55;
	CityCode = 11;
RUN;

/* ERRORS:              22
 ERROR 22-322: Syntax error, expecting one of the following:
 	!, !!, &, *, **, +, -, /, ;,
 	<, <=, <>, =, >, ><, >=, AND, EQ, GE, GT, 
    IN, LE, LT, MAX, MIN, NE, NG, NL, NOTIN, OR, ^=, |, ||, ~=.

**WARNINGS: 
	WARNING: The data set WORK.INFO may be incomplete.  
	When this step was stopped there were 0 observations and 4 variables.
*/
** The data set WORK.INFO has 1 observations and 4 variables;
*-------------------------------------------------------------------------------;
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