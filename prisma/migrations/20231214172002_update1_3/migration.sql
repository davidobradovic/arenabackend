/*
  Warnings:

  - Added the required column `name` to the `Images` table without a default value. This is not possible if the table is not empty.

*/
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
    CONSTRAINT "Cars_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "CarModels" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Cars_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "CarBrands" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Cars" ("advertisement_status", "brand_id", "carColor", "car_status", "description", "doors", "drive", "engine", "fuel", "id", "mileage", "model_id", "power", "price", "seats", "title", "transmission", "type", "views", "year") SELECT "advertisement_status", "brand_id", "carColor", "car_status", "description", "doors", "drive", "engine", "fuel", "id", "mileage", "model_id", "power", "price", "seats", "title", "transmission", "type", "views", "year" FROM "Cars";
DROP TABLE "Cars";
ALTER TABLE "new_Cars" RENAME TO "Cars";
CREATE TABLE "new_Images" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "url" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "car_id" INTEGER NOT NULL,
    CONSTRAINT "Images_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "Cars" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Images" ("car_id", "id", "url") SELECT "car_id", "id", "url" FROM "Images";
DROP TABLE "Images";
ALTER TABLE "new_Images" RENAME TO "Images";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
