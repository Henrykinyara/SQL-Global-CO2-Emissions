Use HenryKinyaraDatabase;

SELECT *FROM [HenryKinyaraDatabase].[dbo].[Global CO2 Emissions];

--Which industry had the highest CO2 emissions in the most recent year?
Select [Global CO2 Emissions].[Series Name],Sum(TRY_CAST([Global CO2 Emissions].[2020  YR2020 ] As float) )As Total_Emissions From [Global CO2 Emissions]
Group by [Global CO2 Emissions].[Series Name]
Order by Total_Emissions Desc;
--What has been the trend of total emissions across sectors over the last decade?
Select [Global CO2 Emissions].[Series Name],
Sum(TRY_CAST([Global CO2 Emissions].[2010  YR2010 ]  As float) )As Total_Emissions_2010 ,
Sum(TRY_CAST([Global CO2 Emissions].[2011  YR2011 ]  As float) )As Total_Emissions_2011, 
Sum(TRY_CAST([Global CO2 Emissions].[2012  YR2012 ]  As float) )As Total_Emissions_2012, 
Sum(TRY_CAST([Global CO2 Emissions].[2013  YR2013 ]  As float) )As Total_Emissions_2013, 
Sum(TRY_CAST([Global CO2 Emissions].[2014  YR2014 ]  As float) )As Total_Emissions_2014, 
Sum(TRY_CAST([Global CO2 Emissions].[2015  YR2015 ]  As float) )As Total_Emissions_2015, 
Sum(TRY_CAST([Global CO2 Emissions].[2016  YR2016 ]  As float) )As Total_Emissions_2016, 
Sum(TRY_CAST([Global CO2 Emissions].[2017  YR2017 ]  As float) )As Total_Emissions_2017, 
Sum(TRY_CAST([Global CO2 Emissions].[2018  YR2018 ]   As float) )As Total_Emissions_2018, 
Sum(TRY_CAST([Global CO2 Emissions].[2019  YR2019 ]   As float) )As Total_Emissions_2019 
From [Global CO2 Emissions]
Group by [Global CO2 Emissions].[Series Name];

-- industries showing a decline in emissions over the years
SELECT 
    [Series Name] AS Industry,
    SUM(TRY_CAST([2010  YR2010 ] AS FLOAT)) AS Emissions2010,
    SUM(TRY_CAST([2015  YR2015 ] AS FLOAT)) AS Emissions2015,
    SUM(TRY_CAST([2020  YR2020 ] AS FLOAT)) AS Emissions2020
FROM [Global CO2 Emissions]
GROUP BY [Series Name]
HAVING SUM(TRY_CAST([2020  YR2020 ] AS FLOAT)) < SUM(TRY_CAST([2010  YR2010 ] AS FLOAT))
ORDER BY Emissions2020 ASC;


--How does the emission share differ across continents or economic zones?

Select*From [countries of the world];

Select [countries of the world].Region,[Global CO2 Emissions].[Series Name], 
Sum(TRY_CAST([Global CO2 Emissions].[2010  YR2010 ]  As float) )As Total_Emissions_2010 ,
Sum(TRY_CAST([Global CO2 Emissions].[2011  YR2011 ]  As float) )As Total_Emissions_2011, 
Sum(TRY_CAST([Global CO2 Emissions].[2012  YR2012 ]  As float) )As Total_Emissions_2012, 
Sum(TRY_CAST([Global CO2 Emissions].[2013  YR2013 ]  As float) )As Total_Emissions_2013, 
Sum(TRY_CAST([Global CO2 Emissions].[2014  YR2014 ]  As float) )As Total_Emissions_2014, 
Sum(TRY_CAST([Global CO2 Emissions].[2015  YR2015 ]  As float) )As Total_Emissions_2015, 
Sum(TRY_CAST([Global CO2 Emissions].[2016  YR2016 ]  As float) )As Total_Emissions_2016, 
Sum(TRY_CAST([Global CO2 Emissions].[2017  YR2017 ]  As float) )As Total_Emissions_2017, 
Sum(TRY_CAST([Global CO2 Emissions].[2018  YR2018 ]   As float) )As Total_Emissions_2018, 
Sum(TRY_CAST([Global CO2 Emissions].[2019  YR2019 ]   As float) )As Total_Emissions_2019 
From [Global CO2 Emissions] right join [countries of the world]
on [Global CO2 Emissions].[Country Name]=[countries of the world].Country
Group by [countries of the world].Region,[Global CO2 Emissions].[Series Name];

--Identify the top three emitting industries and their year-wise emission pattern.

Select Top 3 [Global CO2 Emissions].[Series Name],
sum(TRY_CAST([Global CO2 Emissions].[2017  YR2017 ]+[Global CO2 Emissions].[2017  YR2017 ]+[Global CO2 Emissions].[2017  YR2017 ] As Float))
As Three_year_wise_Emissions From [Global CO2 Emissions]
Group By [Global CO2 Emissions].[Series Name]
Order By Three_year_wise_Emissions Desc;