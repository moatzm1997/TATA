-- data cleaning and transformation

select * from online_retail;


select * 
from online_retail
where UnitPrice <=0 ;


DELETE from online_retail
where UnitPrice =0;

UPDATE online_retail
set UnitPrice= REPLACE(UnitPrice,'-','');


SELECT * 
FROM online_retail
WHERE Quantity <0;



DELETE from online_retail
WHERE Quantity <=0;


SELECT COUNT(*)
from online_retail;



SELECT * from online_retail;



alter TABLE online_retail
add Revenue float;


UPDATE online_retail
set Revenue= round(Quantity * UnitPrice , 2);


SELECT distinct Country 
from online_retail;


ALTER TABLE online_retail

 add        Year int ,
            Month VARCHAR(20),
            Day   VARCHAR(20)
;



SELECT * from online_retail;



UPDATE online_retail
SET Year = DATEPART(year,InvoiceDate);


UPDATE online_retail
SET Month = FORMAT(InvoiceDate,'MMM');

UPDATE online_retail
SET Day = FORMAT(InvoiceDate,'ddd');



ALTER TABLE online_retail
add Time TIME;


UPDATE online_retail
set Time = concat(DATEPART(HOUR,InvoiceDate),':', DATEPART(MINUTE,InvoiceDate),':',DATEPART(SECOND,InvoiceDate));





