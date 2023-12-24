-- CreateTable
CREATE TABLE "ContacsForCars" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fullName" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "car_id" INTEGER NOT NULL,
    CONSTRAINT "ContacsForCars_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "Cars" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
