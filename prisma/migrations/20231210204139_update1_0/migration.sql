/*
  Warnings:

  - You are about to drop the column `car_id` on the `Specifications` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Specifications" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "value" TEXT NOT NULL,
    "have" BOOLEAN NOT NULL DEFAULT false
);
INSERT INTO "new_Specifications" ("have", "id", "value") SELECT "have", "id", "value" FROM "Specifications";
DROP TABLE "Specifications";
ALTER TABLE "new_Specifications" RENAME TO "Specifications";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
