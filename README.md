# Objective
To understand the employee distribution of a company by conducting analysis in SQL for a dataset containing around 22K records.Cleaned and analyzed the data in SQL and built dashboards in powerbi to visualise trends thus enabling  the HR department to identify any gaps or overlaps in HR responsibilities, and ensure that all critical functions are adequately supported and resourced.

# Project Highlights/Steps Followed
1. Data Walkthrough:The data contains about 22k records from the year 2000 and 2020 and contains information regarding the employee id,name,race,department,jobtitle,hire_date,termination_date,work-location,employee hometown_location.
2. Data Preparation:Created a database and imported the csv data into MySQL workbench using the load data infile statement for improving the data import speed.
3. Data Cleaning:Corrected the data formats and cleaned the data from the records,filling in missing values and deleting or modifying the wrong data.
4. Data Extraction:The database was then queried for extracting information and specific data from the large dataset for analysis.These query results were then exported in the form of csv files
5. Data Visualisation:Imported the query results into powerbi and then created visualisations using these csv files.
6. Insights Generation:Exported the dashboard and surfaced insights from these visualisations and these were shared to the HR department for further analysis and decision making for better recuritement process,successful resource allocation and to implement HR policies for better utilisation and satisfaction of the employees.

# Live Dashboard
Explore the live dashboard [here](https://app.powerbi.com/links/03qHg8HjOv?ctid=c6e549b3-5f45-4032-aae9-d4244dc5b2c4&pbi_source=linkShare).

# Key Insights
1. The proportion of male employees is more compared to the female employees.
2. White race is the most dominant while Native Hawaiian and American Indian are the least dominant.
3. The youngest employee is 20 years old and the oldest is 57 years old.
4. 5 age groups were created (18-24, 25-34, 35-44, 45-54, 55-64). A large number of employees were between 25-34 followed by 35-44 while the least number of employees were in the 55-64 group.
5. Majority of the employees work from the headquarters while only a minor group of employees are remote workers.
6. The average length of employment for terminated employees is around 8 years.
7. The gender distribution across departments is fairly balanced but there are generally more male than female employees.
8. A large number of employees are from the state of Ohio.
9. The Marketing department has the lowest turnover rate followed by business development. The highest turn over rate are in the Training, Auditing and Legal departments.
10. The net change in employees has increased over the years suggesting that the company has seen a positive growth.
11. The average tenure for each department is about 8 years with Sales having the highest and support,product management and legal having the lowest.
12. More number of employees are present in the engineering department followed by accounting and the least number of employees are in the legal and auditing team.

# Limitations
1. Some records had negative ages and these were excluded during querying(967 records). Ages used were 18 years and above.
2. Some termdates were far into the future and were not included in the analysis(1599 records). The only term dates used were those less than or equal to the current date.

# Summary
1. Created an HR analytics dashboard in powerBi using the employee information from 2000 to 2020 thereby helping  the HR department to know the employee distribution of the company.
2. Utilised SQL to perform data cleaning and extraction and exported the data to powerbi  to create a dashboard.
3. Shared the insights with HR department and helped them to assess the effectiveness of current HR practices in meeting the needs of each department, highlighting successes and potential areas for improvement.
4. This dashboard also helped the HR department to  facilitate better decision-making and resource allocation by providing them with the data-driven insights.
