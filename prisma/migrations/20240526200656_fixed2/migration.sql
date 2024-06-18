/*
  Warnings:

  - You are about to drop the column `column` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `row` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `screenId` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `showtimeId` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `ticketId` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Booking` table. All the data in the column will be lost.
  - You are about to drop the column `qrCode` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `uid` on the `Ticket` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[screenId,row,column,showtimeId]` on the table `Ticket` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `uid` to the `Booking` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bookingId` to the `Ticket` table without a default value. This is not possible if the table is not empty.
  - Added the required column `column` to the `Ticket` table without a default value. This is not possible if the table is not empty.
  - Added the required column `row` to the `Ticket` table without a default value. This is not possible if the table is not empty.
  - Added the required column `screenId` to the `Ticket` table without a default value. This is not possible if the table is not empty.
  - Added the required column `showtimeId` to the `Ticket` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Ticket` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Ticket` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_screenId_row_column_fkey";

-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_showtimeId_fkey";

-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_ticketId_fkey";

-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_userId_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_uid_fkey";

-- DropIndex
DROP INDEX "Booking_screenId_row_column_showtimeId_key";

-- DropIndex
DROP INDEX "seatIndex";

-- AlterTable
ALTER TABLE "Booking" DROP COLUMN "column",
DROP COLUMN "createdAt",
DROP COLUMN "row",
DROP COLUMN "screenId",
DROP COLUMN "showtimeId",
DROP COLUMN "ticketId",
DROP COLUMN "updatedAt",
DROP COLUMN "userId",
ADD COLUMN     "qrCode" TEXT,
ADD COLUMN     "uid" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Ticket" DROP COLUMN "qrCode",
DROP COLUMN "uid",
ADD COLUMN     "bookingId" INTEGER NOT NULL,
ADD COLUMN     "column" INTEGER NOT NULL,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "row" INTEGER NOT NULL,
ADD COLUMN     "screenId" INTEGER NOT NULL,
ADD COLUMN     "showtimeId" INTEGER NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "userId" TEXT NOT NULL;

-- CreateIndex
CREATE INDEX "seatIndex" ON "Ticket"("screenId", "row", "column");

-- CreateIndex
CREATE UNIQUE INDEX "Ticket_screenId_row_column_showtimeId_key" ON "Ticket"("screenId", "row", "column", "showtimeId");

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_showtimeId_fkey" FOREIGN KEY ("showtimeId") REFERENCES "Showtime"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_screenId_row_column_fkey" FOREIGN KEY ("screenId", "row", "column") REFERENCES "Seat"("screenId", "row", "column") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_uid_fkey" FOREIGN KEY ("uid") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
