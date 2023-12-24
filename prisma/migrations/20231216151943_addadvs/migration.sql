-- CreateTable
CREATE TABLE "Advertisements" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "backgroundImage" TEXT NOT NULL,
    "buttonTitle" TEXT NOT NULL,
    "buttonUrl" TEXT NOT NULL,
    "exipration" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Cars" (
    "brand_id" INTEGER NOT NULL,
    "model_id" INTEGER NOT NULL,
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "mileage" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "engine" TEXT NOT NULL,
    "power" INTEGER NOT NULL,
    "car_status" TEXT NOT NULL DEFAULT 'Koristeno',
    "advertisement_status" TEXT NOT NULL DEFAULT 'Na lageru',
    "doors" TEXT NOT NULL DEFAULT '4/5',
    "seats" TEXT NOT NULL DEFAULT '5',
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
INSERT INTO "new_Cars" ("advertisement_status", "brand_id", "carColor", "car_status", "description", "doors", "drive", "engine", "fuel", "id", "mileage", "model_id", "power", "price", "seats", "title", "transmission", "type", "views", "year") SELECT "advertisement_status", "brand_id", "carColor", "car_status", "description", "doors", "drive", "engine", "fuel", "id", "mileage", "model_id", "power", "price", "seats", "title", "transmission", "type", "views", "year" FROM "Cars";
DROP TABLE "Cars";
ALTER TABLE "new_Cars" RENAME TO "Cars";
CREATE TABLE "new_CarModels" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "brand_id" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "CarModels_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "CarBrands" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CarModels" ("brand_id", "id", "title") SELECT "brand_id", "id", "title" FROM "CarModels";
DROP TABLE "CarModels";
ALTER TABLE "new_CarModels" RENAME TO "CarModels";
CREATE TABLE "new_ContacsForCars" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fullName" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "car_id" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "ContacsForCars_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "Cars" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ContacsForCars" ("car_id", "email", "fullName", "id", "message", "phone") SELECT "car_id", "email", "fullName", "id", "message", "phone" FROM "ContacsForCars";
DROP TABLE "ContacsForCars";
ALTER TABLE "new_ContacsForCars" RENAME TO "ContacsForCars";
CREATE TABLE "new_KomisijaImages" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "url" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "kom_id" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "KomisijaImages_kom_id_fkey" FOREIGN KEY ("kom_id") REFERENCES "KomisionaProdaja" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_KomisijaImages" ("id", "kom_id", "name", "url") SELECT "id", "kom_id", "name", "url" FROM "KomisijaImages";
DROP TABLE "KomisijaImages";
ALTER TABLE "new_KomisijaImages" RENAME TO "KomisijaImages";
CREATE TABLE "new_KomisionaProdaja" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "customer_name" TEXT NOT NULL,
    "customer_phone" TEXT NOT NULL,
    "customer_email" TEXT NOT NULL,
    "car_name" TEXT NOT NULL,
    "car_price" INTEGER NOT NULL,
    "car_desc" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_KomisionaProdaja" ("car_desc", "car_name", "car_price", "customer_email", "customer_name", "customer_phone", "id") SELECT "car_desc", "car_name", "car_price", "customer_email", "customer_name", "customer_phone", "id" FROM "KomisionaProdaja";
DROP TABLE "KomisionaProdaja";
ALTER TABLE "new_KomisionaProdaja" RENAME TO "KomisionaProdaja";
CREATE TABLE "new_Specifications" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "value" TEXT NOT NULL,
    "have" BOOLEAN NOT NULL DEFAULT true,
    "car_id" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Specifications_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "Cars" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Specifications" ("car_id", "have", "id", "value") SELECT "car_id", "have", "id", "value" FROM "Specifications";
DROP TABLE "Specifications";
ALTER TABLE "new_Specifications" RENAME TO "Specifications";
CREATE TABLE "new_WebViews" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "view" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_WebViews" ("id", "view") SELECT "id", "view" FROM "WebViews";
DROP TABLE "WebViews";
ALTER TABLE "new_WebViews" RENAME TO "WebViews";
CREATE TABLE "new_CarBrands" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "logo" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_CarBrands" ("id", "logo", "title") SELECT "id", "logo", "title" FROM "CarBrands";
DROP TABLE "CarBrands";
ALTER TABLE "new_CarBrands" RENAME TO "CarBrands";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
