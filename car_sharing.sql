PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "app_location"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "Country" varchar(100) NOT NULL,
  "ZipCode" integer NOT NULL,
  "City" varchar(100) NOT NULL,
  "Point" varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_account"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "Login" varchar(50) NOT NULL,
  "Password" varchar(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_callcentre"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "PhoneNumber" integer NOT NULL,
  "hasFreeAgent" varchar(3) NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_customer"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "Username" varchar(100) NOT NULL,
  "FirstName" varchar(100) NOT NULL,
  "LastName" varchar(100) NOT NULL,
  "EMail" varchar(100) NOT NULL,
  "PhoneNumber" varchar(100) NOT NULL,
  "CustomerLocation_id" integer NULL UNIQUE REFERENCES "app_location" ("id") DEFERRABLE INITIALLY DEFERRED,
  "CustomerAccount_id" integer NULL UNIQUE REFERENCES "app_account" ("id") DEFERRABLE INITIALLY DEFERRED,
  "CustomerCallCentre_id" integer NULL REFERENCES "app_callcentre" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_callcentreagent"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "SSN" integer NOT NULL,
  "FirstName" varchar(100) NOT NULL,
  "LastName" varchar(100) NOT NULL,
  "AgentCallCentre_id" integer NULL REFERENCES "app_callcentre" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_researchcentre"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "ResearchTopic" varchar(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_feedback"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "Author" varchar(200) NOT NULL,
  "DateTime" datetime NOT NULL,
  "Content" text NOT NULL,
  "CustomerFeedback_id" integer NULL REFERENCES "app_customer" ("id") DEFERRABLE INITIALLY DEFERRED,
  "FeedbackResearchCentre_id" integer NULL REFERENCES "app_researchcentre" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_carsoft"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "Version" varchar(100) NOT NULL,
  "Description" varchar(500) NOT NULL,
  "CarSoftResearchCentre_id" integer NULL REFERENCES "app_researchcentre" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_researcher"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "SSN" integer NOT NULL, "FirstName" varchar(100) NOT NULL,
  "LastName" varchar(100) NOT NULL,
  "Speciality" varchar(100) NOT NULL,
  "ResearcherResearchCentre_id" integer NULL REFERENCES "app_researchcentre" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_payment"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "CCN" integer NOT NULL,
  "DateTime" datetime NOT NULL,
  "Amount" integer NOT NULL,
  "Name" varchar(100) NOT NULL,
  "BillingAddress" varchar(200) NOT NULL,
  "CardExpDate" date NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_chargingstation"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "UID" integer NOT NULL,
  "CSLocation" varchar(200) NOT NULL,
  "FreeSockets" integer NOT NULL,
  "Price" integer NOT NULL,
  "ChargingTime" integer NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_plug"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "Size" integer NOT NULL,
  "Shape" varchar(50) NOT NULL,
  "PlugCS_id" integer NULL REFERENCES "app_chargingstation" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_charging"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "Date" datetime NULL REFERENCES "app_chargingstation" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_workshop"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "WorkshopLocation" varchar(200) NOT NULL,
  "HasParts" bool NOT NULL,
  "Available" bool NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_order"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "DateTime" datetime NOT NULL,
  "OrderPayment_id" integer NULL UNIQUE REFERENCES "app_payment" ("id") DEFERRABLE INITIALLY DEFERRED,
  "OrderTrip_id" integer NULL UNIQUE REFERENCES "app_trip" ("id") DEFERRABLE INITIALLY DEFERRED,
  "OrdersCustomer_id" integer NULL UNIQUE REFERENCES "app_customer" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_trip"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "A" varchar(100) NOT NULL,
  "B" varchar(100) NOT NULL,
  "Arrival" datetime NOT NULL,
  "Departure" datetime NOT NULL,
  "TripVehicle_id" integer NULL UNIQUE REFERENCES "app_vehicle" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_carpart"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "SSN" varchar(100) NOT NULL,
  "CarModel" varchar(100) NOT NULL,
  "Type" varchar(100) NOT NULL,
  "Price" integer NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_vehicle"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "PlugType" varchar(100) NOT NULL,
  "VehicleLocation" varchar(200) NOT NULL,
  "Model" varchar(100) NOT NULL,
  "SSN" integer NOT NULL,
  "Color" varchar(100) NOT NULL,
  "LicensePlate" varchar(100) NOT NULL,
  "VehicleCarSoft_id" integer NULL REFERENCES "app_carsoft" ("id") DEFERRABLE INITIALLY DEFERRED,
  "VehicleCS_id" integer NULL REFERENCES "app_chargingstation" ("id") DEFERRABLE INITIALLY DEFERRED,
  "VehicleWorkshop_id" integer NULL REFERENCES "app_workshop" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_workshop_WorkshopCarParts"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "workshop_id" integer NOT NULL REFERENCES "app_workshop" ("id") DEFERRABLE INITIALLY DEFERRED,
  "carpart_id" integer NOT NULL REFERENCES "app_carpart" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_provider"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "PhoneNumber" varchar(100) NOT NULL,
  "ProviderLocation" varchar(100) NOT NULL,
  "Speciality" varchar(100) NOT NULL,
  "Name" varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_provider_CarParts"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "provider_id" integer NOT NULL REFERENCES "app_provider" ("id") DEFERRABLE INITIALLY DEFERRED,
  "carpart_id" integer NOT NULL REFERENCES "app_carpart" ("id") DEFERRABLE INITIALLY DEFERRED
);

COMMIT;
