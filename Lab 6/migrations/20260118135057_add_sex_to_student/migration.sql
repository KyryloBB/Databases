/*
  Warnings:

  - Added the required column `sex` to the `student` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "sex" AS ENUM ('man', 'woman');

-- AlterTable
ALTER TABLE "student" ADD COLUMN     "sex" "sex" NOT NULL;
