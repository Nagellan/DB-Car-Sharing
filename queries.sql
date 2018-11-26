SELECT * FROM app_vehicle;
-- SELECT * FROM 'app_vehicle' WHERE 'Color' = 'red' AND 'LicensePlate' LIKE 'AN%';
-- COUNT(SELECT * FROM 'app_charging' WHERE 'Date' > %L_DATE% AND 'Date' < %R_DATE%) // iterate over 0->23, replace %L_DATE% and %R_DATE% with date(hour) & date(hour + 1);
-- COUNT(SELECT * FROM 'app_trip' WHERE ('ArrivalTime' >= %L_DATE% AND 'DepartureTime' <= %R_DATE%) OR ('ArrivalTime' <= %L_DATE% AND 'DepartureTime' <= %R_DATE%) OR ('ArrivalTime' >= %L_DATE% AND 'ArrivalTime' <= %R_DATE% AND 'DepartureTime' >= %R_DATE%) // replace %%;
-- SELECT * FROM app_payment INNER JOIN (SELECT id as orderIDS FROM app_order WHERE OrdersCustomer_id = 1) ON app_payment.id = orderIDS.id WHERE 'DateTime' > 'Date';