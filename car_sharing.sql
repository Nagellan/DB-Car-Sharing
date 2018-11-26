PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "auth_user"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "password" varchar(128) NOT NULL,
  "last_login" datetime NULL,
  "is_superuser" bool NOT NULL,
  "username" varchar(150) NOT NULL UNIQUE,
  "first_name" varchar(30) NOT NULL,
  "email" varchar(254) NOT NULL,
  "is_staff" bool NOT NULL,
  "is_active" bool NOT NULL,
  "date_joined" datetime NOT NULL,
  "last_name" varchar(150) NOT NULL
);

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
  "Password" varchar(200) NOT NULL,
  "AID" integer NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_callcentre"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "CCID" integer NOT NULL,
  "PhoneNumber" integer NOT NULL
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
  "SSN" integer NOT NULL, "FirstName" varchar(100) NOT NULL,
  "LastName" varchar(100) NOT NULL,
  "AgentCallCentre_id" integer NULL REFERENCES "app_callcentre" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_researchcentre"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "RCID" integer NOT NULL,
  "ResearchTopic" varchar(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_feedback"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "FID" integer NOT NULL,
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
  "PID" integer NOT NULL,
  "CCN" integer NOT NULL,
  "DateTime" datetime NOT NULL,
  "Amount" integer NOT NULL,
  "Name" varchar(100) NOT NULL,
  "BillingAdress" varchar(200) NOT NULL,
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
  "PID" integer NOT NULL,
  "Size" integer NOT NULL,
  "Shape" varchar(50) NOT NULL,
  "PlugCS_id" integer NULL REFERENCES "app_chargingstation" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_workshop"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "WID" integer NOT NULL,
  "WorkshopLocation" varchar(200) NOT NULL,
  "HasParts" bool NOT NULL,
  "Available" bool NOT NULL
);

CREATE TABLE IF NOT EXISTS "app_order"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "OID" integer NOT NULL,
  "DateTime" datetime NOT NULL,
  "OrderPayment_id" integer NULL UNIQUE REFERENCES "app_payment" ("id") DEFERRABLE INITIALLY DEFERRED,
  "OrderTrip_id" integer NULL UNIQUE REFERENCES "app_trip" ("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS "app_trip"
(
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "A" varchar(100) NOT NULL,
  "B" varchar(100) NOT NULL,
  "Arrival" datetime NOT NULL,
  "Derparture" datetime NOT NULL,
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
  "SSN" varchar(100) NOT NULL,
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
  "CID" integer NOT NULL,
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

CREATE INDEX IF NOT EXISTS "app_customer_CustomerCallCentre_id_842d20b9"
ON "app_customer" ("CustomerCallCentre_id");

CREATE INDEX IF NOT EXISTS "app_callcentreagent_AgentCallCentre_id_756771ad"
ON "app_callcentreagent" ("AgentCallCentre_id");

CREATE INDEX IF NOT EXISTS "app_feedback_CustomerFeedback_id_2ac8aae4"
ON "app_feedback" ("CustomerFeedback_id");

CREATE INDEX IF NOT EXISTS "app_feedback_FeedbackResearchCentre_id_25aa23e7"
ON "app_feedback" ("FeedbackResearchCentre_id");

CREATE INDEX IF NOT EXISTS "app_carsoft_CarSoftResearchCentre_id_9a5b1d82"
ON "app_carsoft" ("CarSoftResearchCentre_id");

CREATE INDEX IF NOT EXISTS "app_researcher_ResearcherResearchCentre_id_40945016"
ON "app_researcher" ("ResearcherResearchCentre_id");

CREATE INDEX IF NOT EXISTS "app_plug_PlugCS_id_a5abc1a1"
ON "app_plug" ("PlugCS_id");

CREATE INDEX IF NOT EXISTS "app_vehicle_VehicleCarSoft_id_16b21a2c"
ON "app_vehicle" ("VehicleCarSoft_id");

CREATE INDEX IF NOT EXISTS "app_vehicle_VehicleCS_id_45cb576a"
ON "app_vehicle" ("VehicleCS_id");

CREATE INDEX IF NOT EXISTS "app_vehicle_VehicleWorkshop_id_32c65edf"
ON "app_vehicle" ("VehicleWorkshop_id");

CREATE UNIQUE INDEX IF NOT EXISTS "app_workshop_WorkshopCarParts_workshop_id_carpart_id_1810fd13_uniq"
ON "app_workshop_WorkshopCarParts" ("workshop_id", "carpart_id");

CREATE INDEX IF NOT EXISTS "app_workshop_WorkshopCarParts_workshop_id_2c92bcba"
ON "app_workshop_WorkshopCarParts" ("workshop_id");

CREATE INDEX IF NOT EXISTS "app_workshop_WorkshopCarParts_carpart_id_8326c940"
ON "app_workshop_WorkshopCarParts" ("carpart_id");

CREATE UNIQUE INDEX IF NOT EXISTS "app_provider_CarParts_provider_id_carpart_id_d4de3c1e_uniq"
ON "app_provider_CarParts" ("provider_id", "carpart_id");

CREATE INDEX IF NOT EXISTS "app_provider_CarParts_provider_id_a18a1cf7"
ON "app_provider_CarParts" ("provider_id");

CREATE INDEX IF NOT EXISTS "app_provider_CarParts_carpart_id_90bdd7ee"
ON "app_provider_CarParts" ("carpart_id");

COMMIT;
