-- CreateEnum
CREATE TYPE "gearbox" AS ENUM ('manual', 'automatic');

-- CreateEnum
CREATE TYPE "membership_plan" AS ENUM ('theory', 'practice');

-- CreateEnum
CREATE TYPE "membership_status" AS ENUM ('active', 'terminated', 'payment failed');

-- CreateEnum
CREATE TYPE "payment_method" AS ENUM ('cash', 'credit_card', 'GooglePay');

-- CreateEnum
CREATE TYPE "payment_status" AS ENUM ('successful', 'failed');

-- CreateTable
CREATE TABLE "car" (
    "car_id" SERIAL NOT NULL,
    "driving_school_id" INTEGER NOT NULL,
    "model" VARCHAR(60) NOT NULL,
    "gearbox" "gearbox" NOT NULL,
    "year_of_production" INTEGER NOT NULL,
    "mileage" VARCHAR(10) NOT NULL,
    "license_plate" CHAR(8) NOT NULL,

    CONSTRAINT "car_pkey" PRIMARY KEY ("car_id")
);

-- CreateTable
CREATE TABLE "car_maintenance" (
    "car_maintenance_id" SERIAL NOT NULL,
    "car_id" INTEGER NOT NULL,
    "date" DATE NOT NULL,
    "number_of_problems" INTEGER,
    "description_of_problems" TEXT,

    CONSTRAINT "car_maintenance_pkey" PRIMARY KEY ("car_maintenance_id")
);

-- CreateTable
CREATE TABLE "contact_data" (
    "contact_data_id" SERIAL NOT NULL,
    "phone" VARCHAR(13) NOT NULL,
    "email" VARCHAR(32),

    CONSTRAINT "contactdata_pkey" PRIMARY KEY ("contact_data_id")
);

-- CreateTable
CREATE TABLE "driving_school" (
    "driving_school_id" SERIAL NOT NULL,
    "contact_data_id" INTEGER NOT NULL,
    "address" VARCHAR(60) NOT NULL,
    "full_name_of_director" VARCHAR(60) NOT NULL,

    CONSTRAINT "drivingschool_pkey" PRIMARY KEY ("driving_school_id")
);

-- CreateTable
CREATE TABLE "instructor" (
    "instructor_id" SERIAL NOT NULL,
    "car_id" INTEGER NOT NULL,
    "driving_school_id" INTEGER NOT NULL,
    "contact_data_id" INTEGER NOT NULL,
    "name" VARCHAR(32) NOT NULL,
    "surname" VARCHAR(32) NOT NULL,
    "seniority" interval NOT NULL,

    CONSTRAINT "instructor_pkey" PRIMARY KEY ("instructor_id")
);

-- CreateTable
CREATE TABLE "membership" (
    "membership_id" SERIAL NOT NULL,
    "student_id" INTEGER NOT NULL,
    "driving_school_id" INTEGER NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "duration" interval NOT NULL,
    "plan" "membership_plan" NOT NULL,
    "status" "membership_status" NOT NULL,

    CONSTRAINT "membership_pkey" PRIMARY KEY ("membership_id")
);

-- CreateTable
CREATE TABLE "payment" (
    "payment_id" SERIAL NOT NULL,
    "membership_id" INTEGER NOT NULL,
    "student_id" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "method" "payment_method" NOT NULL,
    "status" "payment_status" NOT NULL,
    "date" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "payment_pkey" PRIMARY KEY ("payment_id")
);

-- CreateTable
CREATE TABLE "student" (
    "student_id" SERIAL NOT NULL,
    "driving_school_id" INTEGER NOT NULL,
    "contact_data_id" INTEGER NOT NULL,
    "name" VARCHAR(32) NOT NULL,
    "surname" VARCHAR(32) NOT NULL,
    "age" INTEGER NOT NULL,
    "is_passed_theoretical_exam" BOOLEAN,

    CONSTRAINT "student_pkey" PRIMARY KEY ("student_id")
);

-- CreateTable
CREATE TABLE "teacher" (
    "teacher_id" SERIAL NOT NULL,
    "driving_school_id" INTEGER NOT NULL,
    "contact_data_id" INTEGER NOT NULL,
    "name" VARCHAR(32) NOT NULL,
    "surname" VARCHAR(32) NOT NULL,
    "seniority" interval NOT NULL,

    CONSTRAINT "teacher_pkey" PRIMARY KEY ("teacher_id")
);

-- CreateTable
CREATE TABLE "training_ground" (
    "training_ground_id" SERIAL NOT NULL,
    "driving_school_id" INTEGER NOT NULL,
    "address" VARCHAR(60) NOT NULL,

    CONSTRAINT "trainingground_pkey" PRIMARY KEY ("training_ground_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "car_license_plate_key" ON "car"("license_plate");

-- CreateIndex
CREATE UNIQUE INDEX "contactdata_phone_key" ON "contact_data"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "contactdata_email_key" ON "contact_data"("email");

-- CreateIndex
CREATE UNIQUE INDEX "drivingschool_contact_data_id_key" ON "driving_school"("contact_data_id");

-- CreateIndex
CREATE UNIQUE INDEX "drivingschool_address_key" ON "driving_school"("address");

-- CreateIndex
CREATE UNIQUE INDEX "drivingschool_director_key" ON "driving_school"("full_name_of_director");

-- CreateIndex
CREATE UNIQUE INDEX "instructor_car_id_key" ON "instructor"("car_id");

-- CreateIndex
CREATE UNIQUE INDEX "instructor_contact_data_id_key" ON "instructor"("contact_data_id");

-- CreateIndex
CREATE UNIQUE INDEX "payment_membership_id_key" ON "payment"("membership_id");

-- CreateIndex
CREATE UNIQUE INDEX "student_contact_data_id_key" ON "student"("contact_data_id");

-- CreateIndex
CREATE UNIQUE INDEX "teacher_contact_data_id_key" ON "teacher"("contact_data_id");

-- CreateIndex
CREATE UNIQUE INDEX "trainingground_driving_school_id_key" ON "training_ground"("driving_school_id");

-- CreateIndex
CREATE UNIQUE INDEX "trainingground_address_key" ON "training_ground"("address");

-- AddForeignKey
ALTER TABLE "car" ADD CONSTRAINT "car_driving_school_id_fkey" FOREIGN KEY ("driving_school_id") REFERENCES "driving_school"("driving_school_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "car_maintenance" ADD CONSTRAINT "car_maintenance_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "car"("car_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driving_school" ADD CONSTRAINT "drivingschool_contact_data_id_fkey" FOREIGN KEY ("contact_data_id") REFERENCES "contact_data"("contact_data_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "instructor" ADD CONSTRAINT "instructor_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "car"("car_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "instructor" ADD CONSTRAINT "instructor_contact_data_id_fkey" FOREIGN KEY ("contact_data_id") REFERENCES "contact_data"("contact_data_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "instructor" ADD CONSTRAINT "instructor_driving_school_id_fkey" FOREIGN KEY ("driving_school_id") REFERENCES "driving_school"("driving_school_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "membership" ADD CONSTRAINT "membership_driving_school_id_fkey" FOREIGN KEY ("driving_school_id") REFERENCES "driving_school"("driving_school_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "membership" ADD CONSTRAINT "membership_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student"("student_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "payment" ADD CONSTRAINT "payment_membership_id_fkey" FOREIGN KEY ("membership_id") REFERENCES "membership"("membership_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "payment" ADD CONSTRAINT "payment_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "student"("student_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "student" ADD CONSTRAINT "student_contact_data_id_fkey" FOREIGN KEY ("contact_data_id") REFERENCES "contact_data"("contact_data_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "student" ADD CONSTRAINT "student_driving_school_id_fkey" FOREIGN KEY ("driving_school_id") REFERENCES "driving_school"("driving_school_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "teacher" ADD CONSTRAINT "teacher_contact_data_id_fkey" FOREIGN KEY ("contact_data_id") REFERENCES "contact_data"("contact_data_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "teacher" ADD CONSTRAINT "teacher_driving_school_id_fkey" FOREIGN KEY ("driving_school_id") REFERENCES "driving_school"("driving_school_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "training_ground" ADD CONSTRAINT "trainingground_driving_school_id_fkey" FOREIGN KEY ("driving_school_id") REFERENCES "driving_school"("driving_school_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
