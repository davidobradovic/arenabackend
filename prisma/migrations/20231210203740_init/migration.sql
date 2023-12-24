/*
  Warnings:

  - You are about to drop the column `logo` on the `CarModels` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CarModels" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "brand_id" INTEGER NOT NULL,
    CONSTRAINT "CarModels_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "CarBrands" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CarModels" ("brand_id", "id", "title") SELECT "brand_id", "id", "title" FROM "CarModels";
DROP TABLE "CarModels";
ALTER TABLE "new_CarModels" RENAME TO "CarModels";
CREATE TABLE "new_Cars" (
    "brand_id" INTEGER NOT NULL,
    "model_id" INTEGER NOT NULL,
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "price" DECIMAL NOT NULL,
    "mileage" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "fuel" TEXT NOT NULL,
    "transmission" TEXT NOT NULL,
    "drive" TEXT NOT NULL,
    "carColor" TEXT NOT NULL,
    "description" TEXT,
    CONSTRAINT "Cars_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "CarModels" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Cars_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "CarBrands" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Cars" ("brand_id", "carColor", "description", "drive", "fuel", "id", "mileage", "model_id", "price", "title", "transmission", "type", "year") SELECT "brand_id", "carColor", "description", "drive", "fuel", "id", "mileage", "model_id", "price", "title", "transmission", "type", "year" FROM "Cars";
DROP TABLE "Cars";
ALTER TABLE "new_Cars" RENAME TO "Cars";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
