-- RedefineTables
PRAGMA foreign_keys=OFF;
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
    CONSTRAINT "Cars_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "CarModels" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Cars_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "CarBrands" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Cars" ("actionPrice", "advertisement_status", "brand_id", "carColor", "car_status", "climate", "created_at", "description", "doors", "drive", "engine", "fuel", "horsePowers", "id", "interior", "lights", "mileage", "model_id", "numberOfOwners", "parkingCamera", "parkingSenzori", "power", "price", "registeredTo", "roloZavjese", "seats", "sound", "title", "transmission", "transmissionLength", "type", "updated_at", "views", "warranty", "weight", "wheels", "year", "yearOfFirstRegistration") SELECT "actionPrice", "advertisement_status", "brand_id", "carColor", "car_status", "climate", "created_at", "description", "doors", "drive", "engine", "fuel", "horsePowers", "id", "interior", "lights", "mileage", "model_id", "numberOfOwners", "parkingCamera", "parkingSenzori", "power", "price", "registeredTo", "roloZavjese", "seats", "sound", "title", "transmission", "transmissionLength", "type", "updated_at", "views", "warranty", "weight", "wheels", "year", "yearOfFirstRegistration" FROM "Cars";
DROP TABLE "Cars";
ALTER TABLE "new_Cars" RENAME TO "Cars";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
