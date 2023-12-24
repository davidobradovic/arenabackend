-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Cars" (
    "brand_id" INTEGER NOT NULL,
    "model_id" INTEGER NOT NULL,
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "price" DECIMAL NOT NULL,
    "mileage" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "engine" TEXT NOT NULL,
    "power" INTEGER NOT NULL,
    "car_status" TEXT NOT NULL,
    "advertisement_status" TEXT NOT NULL,
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
INSERT INTO "new_Cars" ("advertisement_status", "brand_id", "carColor", "car_status", "description", "doors", "drive", "engine", "fuel", "id", "mileage", "model_id", "power", "price", "title", "transmission", "type", "views", "year") SELECT "advertisement_status", "brand_id", "carColor", "car_status", "description", "doors", "drive", "engine", "fuel", "id", "mileage", "model_id", "power", "price", "title", "transmission", "type", "views", "year" FROM "Cars";
DROP TABLE "Cars";
ALTER TABLE "new_Cars" RENAME TO "Cars";
CREATE TABLE "new_Specifications" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "value" TEXT NOT NULL,
    "have" BOOLEAN NOT NULL DEFAULT true,
    "car_id" INTEGER NOT NULL,
    CONSTRAINT "Specifications_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "Cars" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Specifications" ("car_id", "have", "id", "value") SELECT "car_id", "have", "id", "value" FROM "Specifications";
DROP TABLE "Specifications";
ALTER TABLE "new_Specifications" RENAME TO "Specifications";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
