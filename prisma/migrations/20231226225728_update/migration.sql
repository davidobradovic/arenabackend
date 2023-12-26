/*
  Warnings:

  - Added the required column `creator_id` to the `Cars` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Administrators" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "security_code" INTEGER NOT NULL,
    "role" INTEGER NOT NULL DEFAULT 1,
    "worktime" INTEGER NOT NULL DEFAULT 0,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Administrators" ("created_at", "id", "password", "role", "security_code", "updated_at", "username") SELECT "created_at", "id", "password", "role", "security_code", "updated_at", "username" FROM "Administrators";
DROP TABLE "Administrators";
ALTER TABLE "new_Administrators" RENAME TO "Administrators";
CREATE TABLE "new_Cars" (
    "brand_id" INTEGER NOT NULL,
    "model_id" INTEGER NOT NULL,
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "actionPrice" INTEGER NOT NULL DEFAULT 0,
    "mileage" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "engine" TEXT NOT NULL,
    "power" INTEGER NOT NULL,
    "horsePowers" INTEGER NOT NULL,
    "weight" INTEGER,
    "climate" TEXT,
    "sound" TEXT,
    "parkingSenzori" TEXT,
    "parkingCamera" TEXT,
    "interior" TEXT,
    "roloZavjese" TEXT,
    "lights" TEXT,
    "seats" INTEGER,
    "transmissionLength" TEXT,
    "wheels" TEXT,
    "numberOfOwners" INTEGER,
    "emmisionStandad" TEXT,
    "yearOfFirstRegistration" INTEGER,
    "registeredTo" INTEGER,
    "warranty" INTEGER,
    "car_status" TEXT NOT NULL DEFAULT 'Koristeno',
    "advertisement_status" TEXT NOT NULL DEFAULT 'Na lageru',
    "doors" TEXT NOT NULL DEFAULT '4/5',
    "type" TEXT NOT NULL,
    "fuel" TEXT NOT NULL,
    "transmission" TEXT NOT NULL,
    "drive" TEXT NOT NULL,
    "carColor" TEXT NOT NULL,
    "description" TEXT,
    "views" INTEGER NOT NULL DEFAULT 0,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "creator_id" INTEGER NOT NULL,
    CONSTRAINT "Cars_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "CarModels" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Cars_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "CarBrands" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Cars_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "Administrators" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Cars" ("actionPrice", "advertisement_status", "brand_id", "carColor", "car_status", "climate", "created_at", "description", "doors", "drive", "emmisionStandad", "engine", "fuel", "horsePowers", "id", "interior", "lights", "mileage", "model_id", "numberOfOwners", "parkingCamera", "parkingSenzori", "power", "price", "registeredTo", "roloZavjese", "seats", "sound", "title", "transmission", "transmissionLength", "type", "updated_at", "views", "warranty", "weight", "wheels", "year", "yearOfFirstRegistration") SELECT "actionPrice", "advertisement_status", "brand_id", "carColor", "car_status", "climate", "created_at", "description", "doors", "drive", "emmisionStandad", "engine", "fuel", "horsePowers", "id", "interior", "lights", "mileage", "model_id", "numberOfOwners", "parkingCamera", "parkingSenzori", "power", "price", "registeredTo", "roloZavjese", "seats", "sound", "title", "transmission", "transmissionLength", "type", "updated_at", "views", "warranty", "weight", "wheels", "year", "yearOfFirstRegistration" FROM "Cars";
DROP TABLE "Cars";
ALTER TABLE "new_Cars" RENAME TO "Cars";
CREATE TABLE "new_Specifications" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "value" TEXT NOT NULL,
    "have" BOOLEAN NOT NULL DEFAULT true,
    "car_id" INTEGER NOT NULL DEFAULT 1,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Specifications_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "Cars" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Specifications" ("car_id", "created_at", "have", "id", "updated_at", "value") SELECT "car_id", "created_at", "have", "id", "updated_at", "value" FROM "Specifications";
DROP TABLE "Specifications";
ALTER TABLE "new_Specifications" RENAME TO "Specifications";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
