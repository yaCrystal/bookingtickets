/*
  Warnings:

  - You are about to drop the column `cinemaId` on the `Manager` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Manager" DROP CONSTRAINT "Manager_cinemaId_fkey";

-- AlterTable
ALTER TABLE "Manager" DROP COLUMN "cinemaId";
