Use Insurance
Select * From insurance

--- Calculate the insurance claims according to their age group ?
Select *, Count(*) As Insurance_claims
From(Select Case 
	 when age< 20 then '0-20'
	 when age Between 20 and 30 then '20-30'
	 when age between 30 and 40 then '30-40'
	 when age between 40 and 50 then '40-50'
	 when age between 50 and 60 then '50-60'
	 when age> 60 then 'Above>60' End as Age_Range
	 From insurance) Result 
	 Group by Age_Range
	 Order by Age_Range;

--- Calculate the customers according to the gender and education level ?
Select insured_education_level,
count(*) As Total_Claims,
Count(Case when insured_sex = 'MALE' Then 1 End) As  Male_customers,
Count(Case when insured_sex = 'FEMALE' Then 1 End) As  Female_customers
From insurance
Group By insured_education_level
Order By Total_Claims Desc;


--- Calculate the customers based on their occupations ?
Select occupation,
count(*) As Total_Customers,
Count(Case when insured_sex = 'MALE' Then 1 End) As  Male_customers,
Count(Case when insured_sex = 'FEMALE' Then 1 End) As  Female_customers
From insurance
Group By occupation
Order By Total_Customers Desc;

--- Calculate the customers based on their occupations and education level ?
Select occupation,
count(*) As Total_Customers,
Count(Case when insured_education_level = 'MD' Then 1 End) As  MD,
Count(Case when insured_education_level = 'PhD' Then 1 End) As  PhD,
Count(Case when insured_education_level = 'Associate' Then 1 End) As  Associate,
Count(Case when insured_education_level = 'Masters' Then 1 End) As  Masters,
Count(Case when insured_education_level = 'High School' Then 1 End) As  High_school,
Count(Case when insured_education_level = 'College' Then 1 End) As  College,
Count(Case when insured_education_level = 'JD' Then 1 End) As  JD
From insurance
Group By occupation
Order By Total_Customers Desc;

Select Max(months_as_customer) from [insurance_claims ] 

--- Classify the customers on their policy binding period ?
Select *, Count(*) As Total_Customers
From(Select case 
	 when months_as_customer Between 0 and 96 then '0-8years'
	 when months_as_customer Between 96 and 192  then '08-16years'
	 when months_as_customer Between 192 and 288 then '16-24years'
	 when months_as_customer Between 288 and 384 then '24-32years'
	 when months_as_customer Between 384 and 480 then '32-40years'
	 End as Total_policy_years
	 From insurance) Result 
	 Group by Total_policy_years
	 Order by Total_policy_years Asc;

--- calculate the total premium, claim amount, total claims, fraud claim percentage per year ?
Select Claim_year, Sum(policy_annual_premium) As Total_premium,
Sum(total_claim_amount) As claim_amount,
Count(*) As Total_claims,
Count(Case when fraud_reported = 'Yes' Then 1 Else Null End) As Fraud_claim,
(Count (Case when fraud_reported = 'Yes' Then 1 Else Null End))*100/(Count(fraud_reported)) As Fraud_claim_percentage
From insurance
Where Claim_year IN (2011,2012,2013,2014,2015)
Group By Claim_year
Order By Claim_year;


--- Find out the different types of claim amount According to incident severity ?
Select incident_severity, Count(fraud_reported) As Total_claims,
Sum(total_claim_amount) As Total_claim, 
Count (Case when fraud_reported = 'Yes' Then 1 Else Null End) As Fraud_claim,
Sum (Case when fraud_reported = 'Yes' Then total_claim_amount Else Null End) As Fraud_claim_amount,
Count(Case when fraud_reported = 'No' Then 1 Else Null End) As Real_claim,
Sum (Case when fraud_reported = 'No' Then total_claim_amount Else Null End) As Real_claim_amount
From insurance 
Group By incident_severity
Order By Total_claims Desc;

--- Find out the fraud claims reported per year ?
Select Claim_year, Sum(policy_annual_premium) As Total_premium,
Count (Case when fraud_reported = 'Yes' Then 1 Else Null End) As Fraud_claim,
Sum (Case when fraud_reported = 'Yes' Then total_claim_amount Else Null End) As Fraud_claim_amount
From insurance
Group By Claim_year
Order By Claim_year;


