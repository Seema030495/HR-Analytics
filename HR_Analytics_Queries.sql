Create Database HRData;

Use HRData;

# KPI-1: Query to fetch Employee count, Attrtion count, Attrtion Rate, Active Employees, Monthly Income, Average age

with result as (Select count(EmployeeNumber)  as Employees, 
	count(case when attrition = "Yes" then 1 end ) as Attrition_Count,
    round(avg(monthlyIncome)) as Monthly_Income,
    round(avg(age)) as Average_Age
    from HR1
	inner join hr2 on  EmployeeID=employeenumber)
	select Employees, Attrition_Count, 
			Concat(round((Attrition_Count/Employees)*100,2),"%") as Attrition_Rate,
            Employees-Attrition_Count as Active_Employees,
            Monthly_Income,
            Average_Age
	from Result;
    
# KPI-2: Average Attrition rate for all Departments

Select Department,
	concat(round(avg(case when attrition = "Yes" then 1 else 0 end )*100,2),"%") as Attrition_Rate
	from hr1
	group by Department;
    
# KPI-3: Average Hourly rate of Male Research Scientist

Select Department ,Round(avg(hourlyrate),2) as Average_Hourly_Rate 
	from HR1
    where Gender = 'Male' AND Jobrole = 'Research Scientist'
    group by Department
    Order by Average_Hourly_Rate;
    
# KPI-4: Attrition rate Vs Monthly income stats

SELECT
	hr1.Department,
    concat(round(AVG(CASE 
    WHEN Attrition = "Yes" THEN 1
	ELSE 0
	END) * 100,2),"%") AS Average_Attrition_Rate,
	round(AVG(hr2.MonthlyIncome)) AS Average_Monthly_Income 
FROM
	Hr1 inner join hr2 on employeenumber = hr2.employeeid
GROUP BY
	hr1.Department
Order By Average_Attrition_Rate,Average_Monthly_Income desc;

# KPI-5: Average working years for each Department

Select Department, round(avg(TotalWorkingYears),1) as Average_Working_Years
	from HR1 inner join HR2
    on HR1.EmployeeNumber = HR2.EmployeeID
    Group By Department
    order by Average_Working_Years;
    
# KPI-6: Departmentwise No of Employees

Select Department, Count(Employeecount) As Employees 
	from HR1
    group by Department
    Order By Employees;
    
# KPI-6: Count of Employees based on Educational Fields

Select Educationfield as Education, Count(Employeecount) As Employees 
	from HR1
    group by Educationfield
    Order By Employees;
    
# KPI-7: Job Role Vs Work life balance

Select  HR1.JobRole,HR2.worklifebalance , count(HR1.EmployeeCount) as Employees
	From HR1 
    inner join HR2
    on HR1.Employeenumber = HR2.EmployeeId
    group by HR1.JobRole, HR2.worklifebalance
    order by HR1.JobRole, HR2.worklifebalance;
    
# KPI-8: Attrition rate Vs Year since last promotion relation

Select 
	(case
		when HR2.YearsSinceLastPromotion >1 and HR2.YearsSinceLastPromotion < 10 then "1-10"
		when HR2.YearsSinceLastPromotion >11 and HR2.YearsSinceLastPromotion < 20 then "11-20"
		when HR2.YearsSinceLastPromotion >21 and HR2.YearsSinceLastPromotion < 30 then "21-30"
		Else "30+"
	END) as Promotion_Range, 
    concat(round(AVG(CASE WHEN HR1.Attrition = "Yes" THEN 1 ELSE 0 END) * 100,2),"%") AS Average_Attrition_Rate 
	From Hr2
	Inner Join HR1
	On HR2.EmployeeID = HR1.EmployeeNumber
	Group by Promotion_Range
	order by Promotion_Range ;
 
# KPI-9: Gender based Percentage of Employee

With Result as (
	Select Gender, count(Employeecount) Employee 
	from HR1
    Group By Gender)
Select Gender, 
		Concat(Round((Employee/Sum(Employee) over()) * 100,2),'%') as `% Employee` 
from Result;

# KPI-10: Attrition by marital status

Select MaritalStatus, 
	concat(round((avg(case when attrition = 'yes' then 1 else 0 end))*100,2),'%') as Attrition_rate
    from HR1
    group by MaritalStatus
    Order By Attrition_rate;



