/*
  Warnings:

  - You are about to drop the column `buttonTitle` on the `Advertisements` table. All the data in the column will be lost.
  - You are about to drop the column `buttonUrl` on the `Advertisements` table. All the data in the column will be lost.
  - Added the required column `adLink` to the `Advertisements` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `Advertisements` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `Advertisements` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Advertisements" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "backgroundImage" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "action" TEXT,
    "adLink" TEXT NOT NULL,
    "exipration" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Advertisements" ("backgroundImage", "created_at", "exipration", "id", "updated_at") SELECT "backgroundImage", "created_at", "exipration", "id", "updated_at" FROM "Advertisements";
DROP TABLE "Advertisements";
ALTER TABLE "new_Advertisements" RENAME TO "Advertisements";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
