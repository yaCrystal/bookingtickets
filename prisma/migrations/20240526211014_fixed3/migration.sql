/*
  Warnings:

  - You are about to drop the column `qrCode` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `uid` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `bookingId` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `column` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `row` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `screenId` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `showtimeId` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Ticket` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[screenId,row,column,showtimeId]` on the table `Booking` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `column` to the `Booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `row` to the `Booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `screenId` to the `Booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `showtimeId` to the `Booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ticketId` to the `Booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `uid` to the `Ticket` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_uid_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_bookingId_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_screenId_row_column_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_showtimeId_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_userId_fkey";

-- DropIndex
DROP INDEX "Ticket_screenId_row_column_showtimeId_key";

-- DropIndex
DROP INDEX "seatIndex";

-- AlterTable
ALTER TABLE "Booking" DROP COLUMN "qrCode",
DROP COLUMN "uid",
ADD COLUMN     "column" INTEGER NOT NULL,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "row" INTEGER NOT NULL,
ADD COLUMN     "screenId" INTEGER NOT NULL,
ADD COLUMN     "showtimeId" INTEGER NOT NULL,
ADD COLUMN     "ticketId" INTEGER NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Manager" ADD COLUMN     "cinemaId" INTEGER;

-- AlterTable
ALTER TABLE "Ticket" DROP COLUMN "bookingId",
DROP COLUMN "column",
DROP COLUMN "createdAt",
DROP COLUMN "row",
DROP COLUMN "screenId",
DROP COLUMN "showtimeId",
DROP COLUMN "updatedAt",
DROP COLUMN "userId",
ADD COLUMN     "qrCode" TEXT,
ADD COLUMN     "uid" TEXT NOT NULL;

-- CreateIndex
CREATE INDEX "seatIndex" ON "Booking"("screenId", "row", "column");

-- CreateIndex
CREATE UNIQUE INDEX "Booking_screenId_row_column_showtimeId_key" ON "Booking"("screenId", "row", "column", "showtimeId");

-- AddForeignKey
ALTER TABLE "Manager" ADD CONSTRAINT "Manager_cinemaId_fkey" FOREIGN KEY ("cinemaId") REFERENCES "Cinema"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_showtimeId_fkey" FOREIGN KEY ("showtimeId") REFERENCES "Showtime"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_screenId_row_column_fkey" FOREIGN KEY ("screenId", "row", "column") REFERENCES "Seat"("screenId", "row", "column") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_ticketId_fkey" FOREIGN KEY ("ticketId") REFERENCES "Ticket"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_uid_fkey" FOREIGN KEY ("uid") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
