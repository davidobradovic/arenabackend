/*
  Warnings:

  - Added the required column `name` to the `KomisijaImages` table without a default value. This is not possible if the table is not empty.
  - Added the required column `customer_email` to the `KomisionaProdaja` table without a default value. This is not possible if the table is not empty.
  - Added the required column `customer_name` to the `KomisionaProdaja` table without a default value. This is not possible if the table is not empty.
  - Added the required column `customer_phone` to the `KomisionaProdaja` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_KomisijaImages" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "url" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "kom_id" INTEGER NOT NULL,
    CONSTRAINT "KomisijaImages_kom_id_fkey" FOREIGN KEY ("kom_id") REFERENCES "KomisionaProdaja" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_KomisijaImages" ("id", "kom_id", "url") SELECT "id", "kom_id", "url" FROM "KomisijaImages";
DROP TABLE "KomisijaImages";
ALTER TABLE "new_KomisijaImages" RENAME TO "KomisijaImages";
CREATE TABLE "new_KomisionaProdaja" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "customer_name" TEXT NOT NULL,
    "customer_phone" TEXT NOT NULL,
    "customer_email" TEXT NOT NULL,
    "car_name" TEXT NOT NULL,
    "car_price" INTEGER NOT NULL,
    "car_desc" TEXT NOT NULL
);
INSERT INTO "new_KomisionaProdaja" ("car_desc", "car_name", "car_price", "id") SELECT "car_desc", "car_name", "car_price", "id" FROM "KomisionaProdaja";
DROP TABLE "KomisionaProdaja";
ALTER TABLE "new_KomisionaProdaja" RENAME TO "KomisionaProdaja";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
