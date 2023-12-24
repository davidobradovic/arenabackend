-- CreateTable
CREATE TABLE "KomisionaProdaja" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "car_name" TEXT NOT NULL,
    "car_price" INTEGER NOT NULL,
    "car_desc" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "KomisijaImages" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "url" TEXT NOT NULL,
    "kom_id" INTEGER NOT NULL,
    CONSTRAINT "KomisijaImages_kom_id_fkey" FOREIGN KEY ("kom_id") REFERENCES "KomisionaProdaja" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
