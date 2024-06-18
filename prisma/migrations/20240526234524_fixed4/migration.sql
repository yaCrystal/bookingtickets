-- AlterTable
ALTER TABLE "Manager" ADD COLUMN     "cinemaId" INTEGER;

-- AddForeignKey
ALTER TABLE "Manager" ADD CONSTRAINT "Manager_cinemaId_fkey" FOREIGN KEY ("cinemaId") REFERENCES "Cinema"("id") ON DELETE SET NULL ON UPDATE CASCADE;
