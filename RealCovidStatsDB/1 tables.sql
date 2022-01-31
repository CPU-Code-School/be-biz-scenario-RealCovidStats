use RealCovidStatsDB
go 

drop table if exists users

create table dbo.Users(
   UsersId int not null primary key identity,
   UserFirstName varchar(25) not null constraint ck_users_User_First_Name_cannot_not_blank check(UserFirstName <> ''),
   UserLastName varchar(25) not null constraint ck_users_User_Last_Name_cannot_not_blank check(UserLastName <> ''),
   UserDOB date not null,
   UserSSN char(4) not null constraint ck_users_User_SSN_cannot_be_blank check(UserSSN <> ''),
   HealthStatus varchar(20) not null constraint ck_users_Health_Status_cannot_be_blank check(HealthStatus <> ''),
   FirstOrSecondWave bit not null,
   DeltaWave bit not null,
   OmicronWave bit not null,
   DateReceivedDisease date,
   DegreeOfSymptom varchar(15) constraint ck_users_Degree_of_symptom_are_in_mild_moderate_harsh_extreme_died check(DegreeOfSymptom in ('mild', 'moderate', 'harsh', 'extreme', 'died')),
   LossOfTasteAndSmell bit not null,
   ListOfSymptoms varchar(25) not null constraint ck_users_List_Of_Symptoms_cannot_be_blank check(ListOfSymptoms <> ''),
   VaccinationStatus bit,
   VaccineCompany varchar(25) null,
   DateOfVaccine date null,
   BoosterStatus int constraint ck_users_Booster_Status_must_be_between_zero_and_four check(BoosterStatus between 0 and 4),
   BoosterCompany varchar(25) constraint ck_users_Booster_Company_cannot_be_blank check(BoosterCompany <> ''),
   constraint ck_users_Vaccination_Status_and_Vaccine_Company_and_Date_Of_Vaccine_are_either_all_null_or_all_not_null 
       check(VaccinationStatus = 1 and VaccineCompany is not null and DateOfVaccine is not null or
           VaccinationStatus = 0 and VaccineCompany is null and DateOfVaccine is null),
   constraint ck_users_Booster_Status_and_Booster_Company_are_both_null_or_both_not_null 
       check(BoosterStatus is null and BoosterCompany is null or BoosterStatus is not null and BoosterCompany is not null)
)
go 

