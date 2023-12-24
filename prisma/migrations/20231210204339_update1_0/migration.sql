/*
  Warnings:

  - Added the required column `car_id` to the `Images` table without a default value. This is not possible if the table is not empty.
  - Added the required column `car_id` to the `Specifications` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Images" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "url" TEXT NOT NULL,
    "car_id" INTEGER NOT NULL,
    CONSTRAINT "Images_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "Cars" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Images" ("id", "url") SELECT "id", "url" FROM "Images";
DROP TABLE "Images";
ALTER TABLE "new_Images" RENAME TO "Images";
CREATE TABLE "new_Specifications" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "value" TEXT NOT NULL,
    "have" BOOLEAN NOT NULL DEFAULT false,
    "car_id" INTEGER NOT NULL,
    CONSTRAINT "Specifications_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "Cars" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Specifications" ("have", "id", "value") SELECT "have", "id", "value" FROM "Specifications";
DROP TABLE "Specifications";
ALTER TABLE "new_Specifications" RENAME TO "Specifications";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
