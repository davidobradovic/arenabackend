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
    "active" BOOLEAN NOT NULL DEFAULT false,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Advertisements" ("action", "adLink", "backgroundImage", "created_at", "description", "exipration", "id", "title", "updated_at") SELECT "action", "adLink", "backgroundImage", "created_at", "description", "exipration", "id", "title", "updated_at" FROM "Advertisements";
DROP TABLE "Advertisements";
ALTER TABLE "new_Advertisements" RENAME TO "Advertisements";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
