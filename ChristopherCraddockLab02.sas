*Question 30
*A);
DATA HotelData;
INFILE '/folders/myfolders/ChapterFiles/3/Hotel.dat';
INPUT RmNum $
	 NofGsts 
	 CkInMnth 
	 InDay 
	 InYear 
	 CkOutMnth
	 OutDay
	 OutYear
	 WiFi $
	 WiFiDays 49-52
	 RmType $ 53-68
	 RmRate ;
	 IF WiFiDays < 1 THEN WiFiDays = 0;
	 	
RUN;
*B);
/* Take HotelData and apply changes*/
DATA Hotels;
SET HotelData;
InDate=INPUT(CATX('-',InYear,CkInMnth,InDay),yymmdd10.);
OutDate=INPUT(CATX('-',OutYear,CkOutMnth,OutDay),yymmdd10.);
DaysStayed=OutDate - InDate;
AddGstChrg=SUM((NofGsts * 10) - 10);
WiFi_Use= (9.95 + (WifiDays * 4.95));
IF WiFi_Use < 10 THEN WiFi_Use = 0;
SubTotal=SUM((DaysStayed*RmRate) + AddGstChrg + Wifi_Use);
RmTax=SubTotal * .0775;
RoomTotal=SUM(SubTotal + (SubTotal * .0775));
FORMAT 
	InDate yymmdd10.
	OutDate yymmdd10.
	RmRate dollar10.2
	WiFi_Use dollar10.2
	SubTotal dollar10.2
	RmTax dollar10.2
	RoomTotal dollar10.2;
RUN;

PROC PRINT DATA = Hotels;
	TITLE 'Hotel Data';
RUN;
/*ROOM 211 CHARGE WAS $1293*/

******************************************

/* Question 32 */
*READ IN DATA;
DATA SASConference;
INFILE '/folders/myfolders/ChapterFiles/3/Conference.dat' TRUNCOVER;
INPUT FName $
LName $
ID 
Work $ 47-59
Home $ 61-73
Cell $ 75-87 
ContactWork $
ContactHome $
ContactCell $
RegRate $
AttndMixer $
Lunch $
Volunteer $
FoodRestriction $ 117-150;

*REGISTRATION LABELS;
IF RegRate = 350 THEN RegRate = "Academic Regular";
ELSE IF RegRate = 200 THEN RegRate = "Student Regular";
ELSE IF RegRate = 450 THEN RegRate = "Regular";
ELSE IF RegRate = 295 THEN RegRate = "Academic Early";
ELSE IF RegRate = 150 THEN RegRate = "Student Early";
ELSE IF RegRate = 395 THEN RegRate = "Early";
ELSE IF RegRate = 550 THEN RegRate = "On-Site";
ELSE RegRate = "Unavailable";

*AREA CODE VARIABLE;
IF LENGTH(Work)=13 THEN Area_Code=SUBSTR(Work,2,3);
ELSE IF LENGTH(Home)=13 THEN Area_Code=SUBSTR(Home,2,3);
ELSE IF LENGTH(Cell)=13 THEN Area_Code=SUBSTR(Cell,2,3);
ELSE Area_Code = "Unknown";

*VEGAN FLAGS;
IF findw(upcase(FoodRestriction),"VEGAN")  THEN Vegan = 1;
ELSE IF findw(upcase(FoodRestriction),"VEGETARIAN") THEN Vegan = 1;
ELSE Vegan = 0;
RUN;
/*
GONZALES(ID 1082) INFO=RegGroup:On-Site AreaCode:650 FoodRestrictions:Vegan
PATRICK(ID 1083) INFO=RegGroup:Early AreaCode:408 FoodRestrictions:None  */
PROC PRINT DATA = SASConference;
TITLE 'SAS CONFERENCE';
RUN;

*********************************************************************
*Question 30
*A);
DATA IceCream;
INFILE '/folders/myfolders/ChapterFiles/3/BenAndJerrys.dat' DLM=',' DSD ENCODING='wlatin1' TRUNCOVER;
	INPUT	Flavor :$35.
	PortionSize_g 
	Calories
	FatCal
	Fat_g
	SatFat_g
	TransFat_g
	Cholesterol_mg
	Sodium_mg
	TotalCarb_g
	DietaryFiber_g $ 
	Sugars_g
	Protein_g
	Introduced 
	Retired 
	Contents :$200.
	Notes :$200.;
RUN;

PROC PRINT DATA = IceCream;
TITLE Ben & Jerry;
RUN;

/*List ONLY Flavors NOT Exlusive or Retired*/
DATA CurrentIceCream;
SET IceCream;
IF (Notes > .) THEN DELETE;
IF (INDEX(Notes,'Scoop Shop')>0) THEN DELETE;
RUN;

PROC PRINT DATA = CurrentIceCream;
TITLE Ben & Jerry;
RUN;

/* Calculate Grams per 1 Tablespoon AND
 Calorie Running Total per Tablespoon AND
 Running count of Max Calories so far*/
DATA Tablespoon;
SET IceCream;
Cal_Per_TB = (Calories/15);
IF (Cal_Per_TB = .) THEN DELETE;
CalTB_RunningTotal + Cal_Per_TB;
RETAIN MaxCalories;
MaxCalories = MAX(MaxCalories, Calories);
FORMAT
Cal_Per_TB 4.2;
RUN;

PROC PRINT DATA = Tablespoon;
TITLE Ben & Jerry;
RUN;
/* Total Calories: 1146.67
	Highest Number of Calories: 340*/