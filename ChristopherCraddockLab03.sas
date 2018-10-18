*Question 37;
/*A*/
/* You could view the variable attributes either by using PROC CONTENTS
or by using the SAS Exlorer window (double click on the .sas7dbat file)*/

/*B*/
PROC CONTENTS DATA='/folders/myfolders/ChapterFiles/4/crayons.sas7bdat';
RUN; 
/*CRAYONS Label:Crayon name  Length:$26 */

/*C*/
PROC FREQ data='/folders/myfolders/ChapterFiles/4/crayons.sas7bdat';
TABLES Issued / NOPERCENT;
run;
/*The year with the most colors added was 1949*/

/*D*/
PROC SORT DATA='/folders/myfolders/ChapterFiles/4/crayons.sas7bdat' out=RGBSORT;
BY RGB;
RUN;

/*E*/
PROC PRINT DATA=RGBSORT (KEEP=Color RGB);
TITLE 'Crayon Colors Sorted by RGB Triplet';
RUN;
/***********************************************************************************************/
*Question 39;
/*A*/
/*GasPrice Label:U.S. average price of unleaded regular gasoline (per gallon) 
  Varriable Type: Numeric Length 8.*/

/*B*/
PROC SORT DATA='/folders/myfolders/ChapterFiles/4/gas.sas7bdat' OUT=GASSORT;
	BY YEAR;
	FORMAT GasPrice DOLLAR5.2;
RUN;

TITLE 'Price of Gas per Gallons in USD';
PROC MEANS DATA=GASSORT MAX MIN MAXDEC=2;
BY Year;
VAR GasPrice;
RUN;

/*C*/
DATA GASQuarter;
SET GASSORT;
DATE=MDY(Month,01,Year);
QTR=QTR(DATE);
DROP DATE;
RUN;

PROC MEANS data = GASQuarter MAXDEC=2;
	BY Year Qtr;
	VAR GasPrice;
	OUTPUT OUT = GASQuarterFinal(DROP = _FREQ_ _TYPE_ )
	MEAN(GasPrice) = AveragePrice 
	STD(GasPrice) = StdDev;		
RUN;

PROC PRINT DATA=GASQuarterFinal;
TITLE 'Gas Per Quater';
RUN;
/**********************************************************************************************/
*Question 41;
/*A*/
PROC CONTENTS DATA='/folders/myfolders/ChapterFiles/4/pizzaratings.sas7bdat';
RUN;
/*Rating Label: Customer Rating (1=coustomer would never order to
5=would order often) Varriable Type: Numeric Length 8*/

/*B*/
PROC FORMAT;
VALUE ratings
    . = 'N/A'
	1 = 'Never'
	2 = 'Might'
	3 = 'At least Once'
	4 = 'Occasionally'
	5 = 'Often';
RUN;

PROC PRINT DATA='/folders/myfolders/ChapterFiles/4/pizzaratings.sas7bdat';
FORMAT Rating ratings.;
TITLE 'Pizza Ratings';
RUN;

/*C*/
PROC SORT DATA='/folders/myfolders/ChapterFiles/4/pizzaratings.sas7bdat' OUT=PizzaSort;
BY Topping;
WHERE Rating > .;
RUN;

TITLE1 'Obs by Topping using PROC MEANS';
TITLE2 '1-Never 2-Might 3-At least Once';
TITLE3 '4-Ocationally 5-Often';
PROC MEANS DATA=PizzaSort N MEAN MAXDEC=3; /*Only desplays the number of non-missing obs and the mean*/
BY Topping;
RUN;

/*D*/
TITLE1 'Obs by Topping using PROC SUMMARY';
TITLE2 '1-Never 2-Might 3-At least Once';
TITLE3 '4-Ocationally 5-Often';
PROC SUMMARY PRINT DATA=PizzaSort;
BY Topping;
RUN;

