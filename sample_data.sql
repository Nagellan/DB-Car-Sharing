insert into app_location(Country, ZipCode, City, Point) values('Russia', 111111, 'Innopolis', '11,11');
insert into app_location(Country, ZipCode, City, Point) values('Russia', 111111, 'Kazan', '110,911');
insert into app_location(Country, ZipCode, City, Point) values('Russia', 111111, 'Moscow', '13,81');
insert into app_location(Country, ZipCode, City, Point) values('Russia', 111111, 'Saratov', '31,144');
insert into app_location(Country, ZipCode, City, Point) values('Russia', 111111, 'Nizhnekamk', '1,121');

insert into app_account(Login, Password) values('ireknazm', '1288irek');
insert into app_account(Login, Password) values('kamkr', 'eshkere112');
insert into app_account(Login, Password) values('keklol', 'lolkek594');

insert into app_callcentre(PhoneNumber, hasFreeAgent) values(88008991245, 'Yes');
insert into app_callcentre(PhoneNumber, hasFreeAgent) values(88008924521, 'No');

insert into app_customer(Username, FirstName, LastName, EMail, PhoneNumber) values('ireknazm', 'Irek', 'Nazmiev', 'inazm@m.ru', 11242341);
insert into app_customer(Username, FirstName, LastName, EMail, PhoneNumber) values('kamkr', 'Kam', 'Kr', 'kamkr@m.ru', 141455225);
insert into app_customer(Username, FirstName, LastName, EMail, PhoneNumber) values('keklol', 'kek', 'lol', 'keklol@m.ru', 29458);

insert into app_callcentreagent(SSN, FirstName, LastName) values(124, 'KAtya', 'Cavan');
insert into app_callcentreagent(SSN, FirstName, LastName) values(12, 'Dmitry', 'Beevan');

insert into app_researchcentre(ResearchTopic) values('To be or not to be?');

insert into app_feedback(Author, DateTime, Content) values('Irek', '2012-06-18 10:34:09', 'OK');
insert into app_feedback(Author, DateTime, Content) values('Kam', '2015-06-18 10:44:09', 'BAD!');

insert into app_carsoft(Version, Description) values('0.0.1', 'Very fresh, such new');
insert into app_carsoft(Version, Description) values('0.0.0.1', 'Old, slow, bad');

insert into app_researcher(SSN, FirstName, LastName, Speciality) values(113, 'Ivan', 'Kon', 'Cleaner');
insert into app_researcher(SSN, FirstName, LastName, Speciality) values(113, 'Ivan', 'Kon', 'Researcher');
insert into app_researcher(SSN, FirstName, LastName, Speciality) values(113, 'Ivan', 'Kon', 'Scientist');

insert into app_payment(CCN, DateTime, Amount, Name, BillingAddress, CardExpDate) values(1145, '2015-06-18 10:44:09', 112, 'Alphi', 'Kiev', '2015-06-18');
insert into app_payment(CCN, DateTime, Amount, Name, BillingAddress, CardExpDate) values(2452, '2015-06-18 10:44:09', 112, 'Irek', 'Moscow', '2016-07-28');
insert into app_payment(CCN, DateTime, Amount, Name, BillingAddress, CardExpDate) values(546, '2015-06-18 10:44:09', 112, 'Kamil', 'Piter', '2015-01-8');
insert into app_payment(CCN, DateTime, Amount, Name, BillingAddress, CardExpDate) values(11465, '2015-06-18 10:44:09', 112, 'Ilnur', 'Samara', '2016-02-1');

insert into app_chargingstation(UID, CSLocation, FreeSockets, Price, ChargingTime) values(14, 'Innopolis', 3, 133, 5);
insert into app_chargingstation(UID, CSLocation, FreeSockets, Price, ChargingTime) values(1, 'Kazan', 2, 13, 1);

insert into app_plug(Size, Shape) values(12, 'circle');
insert into app_plug(Size, Shape) values(15, 'square');

insert into app_workshop(WorkshopLocation, HasParts, Available) values('Innopolis', 'True', 'True');
insert into app_workshop(WorkshopLocation, HasParts, Available) values('Moscow', 'True', 'False');
insert into app_workshop(WorkshopLocation, HasParts, Available) values('Kazan', 'False', 'True');

insert into app_order(DateTime) values('2015-06-18 10:44:09');
insert into app_order(DateTime) values('2015-06-18 10:44:09');
insert into app_order(DateTime) values('2015-06-18 10:44:09');

insert into app_trip(A, B, Arrival, Departure) values('12,22', '3434, 23', '2015-06-18 10:44:09', '2015-06-18 10:54:09');
insert into app_trip(A, B, Arrival, Departure) values('72,2', '34, 2', '2016-06-18 10:44:09', '2016-06-18 10:54:09');

insert into app_carpart(SSN, CarModel, Type, Price) values(12314, 'Lada Kalina', 'Sedan', 123414134);
insert into app_carpart(SSN, CarModel, Type, Price) values(12314, 'Lada Vesta', 'Sedan', 12341);
insert into app_carpart(SSN, CarModel, Type, Price) values(12314, 'Lada Granta', 'Sedan', 12344134);

insert into app_vehicle(PlugType, VehicleLocation, Model, SSN, Color, LicensePlate) values('Circle', 'Innopolis', 'Sedan', 1214, 'red', 'AN23525');
insert into app_vehicle(PlugType, VehicleLocation, Model, SSN, Color, LicensePlate) values('Circle', 'Innopolis', 'notSedan', 12, 'red', 'KD23525');
insert into app_vehicle(PlugType, VehicleLocation, Model, SSN, Color, LicensePlate) values('Square', 'Innopolis', 'notSedan', 14, 'red', 'LSM3525');
insert into app_vehicle(PlugType, VehicleLocation, Model, SSN, Color, LicensePlate) values('Circle', 'Innopolis', 'Sedan', 21, 'red', 'D32S525');

insert into app_provider(PhoneNumber, ProviderLocation, Speciality, Name) values(235252, 'Innopolis', 'Mechanic', 'Kiril');
insert into app_provider(PhoneNumber, ProviderLocation, Speciality, Name) values(235252, 'Innopolis', 'Cleaner', 'Evgraf');