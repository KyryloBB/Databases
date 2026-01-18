/*
  Warnings:

  - You are about to alter the column `seniority` on the `instructor` table. The data in that column could be lost. The data in that column will be cast from `Unsupported("interval")` to `VarChar(16)`.
  - You are about to alter the column `seniority` on the `teacher` table. The data in that column could be lost. The data in that column will be cast from `Unsupported("interval")` to `VarChar(16)`.

*/
-- AlterTable
ALTER TABLE "instructor" ALTER COLUMN "seniority" SET DATA TYPE VARCHAR(16);

-- AlterTable
ALTER TABLE "teacher" ALTER COLUMN "seniority" SET DATA TYPE VARCHAR(16);
