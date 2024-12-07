-- Total Sales Revenue by Country: Calculate total sales revenue for each country.

-- SELECT * FROM online_retail;

SELECT Country,
       round(SUM(Revenue),2) as Total_Revenue
from online_retail
GROUP BY Country
ORDER BY Total_Revenue Desc; 


-- Top 10 Best-Selling Products: Identify the top 10 best-selling products by quantity sold.

-- SELECT * FROM online_retail;


SELECT  TOP 10 
        StockCode, 
        Description,
        SUM(Quantity) as Total_QuantitySold
    
FROM online_retail
GROUP BY StockCode, 
         Description
ORDER BY Total_QuantitySold DESC;


-- Total Sales per Customer: Calculate total sales per customer.

-- SELECT * FROM online_retail;


SELECT  CustomerID,
        SUM(Quantity) as Total_QuantitySold
    
FROM online_retail
where CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Total_QuantitySold DESC;



-- Monthly Sales Trend: Analyze the sales trend by month.

-- SELECT * FROM online_retail;


SELECT Year,
       Month as Month_Name,
       SUM(Quantity) as Total_QuantitySold

FROM online_retail
GROUP BY Year,Month
ORDER BY Total_QuantitySold DESC;


-- Top Customers by Revenue: Identify the top 5 customers in terms of revenue.

SELECT  TOP 5
        CustomerID,
        ROUND(SUM(Revenue),2) as Total_Revenue
    
FROM online_retail
where CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Total_Revenue DESC;



-- Average Order Value: Calculate the average order value across all transactions.

-- SELECT * FROM online_retail;


SELECT round(SUM(Revenue),2) as AVG_OrderValue
FROM online_retail;


-- Find out which products are ordered the most frequently across all invoices.

-- SELECT * FROM online_retail;

SELECT TOP 10
       Description,
       COUNT(*) OrderFrequency,
       SUM(Quantity) as Total_QuantitySold
       
FROM online_retail
GROUP BY Description
order by OrderFrequency DESC;



-- identify customers who have made more than one purchase.


-- SELECT * from online_retail;


SELECT CustomerID,
       COUNT(distinct InvoiceNo) as Repeated_CustomerPurshase
FROM online_retail
where CustomerID IS NOT NULL
GROUP BY CustomerID
having COUNT(distinct InvoiceNo)>1
ORDER BY Repeated_CustomerPurshase DESC; 



-- Analyze sales based on the time of the day.

SELECT Time,
       ROUND(SUM(Revenue),2) as Total_Revenue
FROM online_retail
GROUP BY   Time
ORDER by Total_Revenue Desc; 



-- Group invoices by the total value of each transaction to analyze the distribution of small vs large orders.


SELECT InvoiceNo,
       round(SUM(Revenue),2) as Total_Value
FROM online_retail 
GROUP BY InvoiceNo
ORDER by Total_Value DESC;

-- Countries with the most customers

SELECT Country,
       COUNT(distinct CustomerID) AS no_Customers
from online_retail
where CustomerID is not null 
GROUP BY Country
ORDER BY no_Customers DESC;



-- Calculate the percentage of total orders coming from each country.

-- SELECT * from online_retail;

SELECT  Country, 
        round(cast(COUNT(distinct InvoiceNo) * 100.0 as float) / (SELECT COUNT(distinct InvoiceNo)
                                                   FROM online_retail),2) AS OrderPercentage
FROM online_retail
GROUP BY Country
ORDER BY OrderPercentage DESC;

-- or--

WITH countries_orders AS(
SELECT Country,
       count(distinct InvoiceNo) as tot_orders_per_country
FROM online_retail
GROUP BY Country
),
total_orders AS(
SELECT count(distinct InvoiceNo) as total_quan_sold
from online_retail
)

select Country,
        cast(SUM(tot_orders_per_country *100)
        / SUM(total_quan_sold)as numeric(10,2))  as order_perc
from countries_orders,total_orders
GROUP by Country
ORDER by order_perc desc


--Products Never Purchased


SELECT StockCode, Description
FROM online_retail
WHERE StockCode NOT IN (
    SELECT DISTINCT StockCode
    FROM online_retail
    WHERE Quantity > 0
);

-- or

SELECT StockCode, Description
FROM online_retail
    WHERE Quantity = 0;



-- High-Value Transactions-- Find transactions where the total value exceeds a certain threshold (e.g., $1000)



SELECT InvoiceNo,
      SUM(Revenue) as Total_Revenue
     
FROM online_retail 
GROUP BY InvoiceNo
HAVING SUM(Revenue)  > (select AVG(Revenue) from online_retail)
ORDER by Total_Revenue DESC;



-- Most Common Purchase Date

select  CAST(InvoiceDate as date),Day,Month,
        SUM(Quantity) as Total_QuantitySold 
from online_retail
GROUP BY  CAST(InvoiceDate as date),Day,Month
order by Total_QuantitySold DESC;



-- Percentage of Revenue per Month 

SELECT Year,
        Month(InvoiceDate) as Month_no,
        Month,
        round(SUM(Revenue),2) as Revenue,
       round(SUM(Revenue)*100 /(select SUM(Revenue) from online_retail),2) as Monthly_Rev_perc
from online_retail
GROUP BY Year,Month(InvoiceDate),  Month
ORDER by Month_no asc;


-- Sales Growth Rate by Month

WITH MonthlySales AS (
    SELECT  Year, Month(InvoiceDate)as Month_no,Month,
           round(SUM(Revenue),2) AS TotalRevenue
    FROM online_retail
    GROUP BY Year, Month(InvoiceDate), Month
)
 SELECT Year,  Month_no, Month, TotalRevenue,
        round((TotalRevenue- LAG(TotalRevenue) over(order by Year,Month_no,Month)) / 
        LAG(TotalRevenue) OVER(order by Year,Month_no,Month )  *100 ,2)as Monthly_GrowthRate
 from MonthlySales
 








































































































