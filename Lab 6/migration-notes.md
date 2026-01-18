# Коментарі до міграцій 

## Migration 1 "add_car_maintenance_table"
```
model car_maintenance {
  car_maintenance_id      Int         @id @default(autoincrement())
  car_id                  Int
  date                    DateTime    @db.Date
  number_of_problems      Int?
  description_of_problems String? 
  car                     car         @relation(fields: [car_id], references: [car_id]) 
}

model car {
  maintenances      car_maintenance[]
  ....
}
```
### Коментар
У цій міграції я додав то бази даних нову таблицю `Car_maintenance`, яка відповідає за збереження даних про технічне обслуговування автомобілів.\
`Car_maintenance` пов'язана з таблицею `Car` зв'язком 'один до багатьох' : `Car_maintenance` (1..n <--> 1) `Car`.

## Migration 2 "add_sex_to_students"
### До
```
model student {
  student_id                 Int            @id @default(autoincrement())
  driving_school_id          Int
  contact_data_id            Int            @unique
  name                       String         @db.VarChar(32)
  surname                    String         @db.VarChar(32)
  age                        Int
  is_passed_theoretical_exam Boolean?
  membership                 membership[]
  payment                    payment[]
  contact_data               contact_data   @relation(fields: [contact_data_id], references: [contact_data_id], onDelete: NoAction, onUpdate: NoAction)
  driving_school             driving_school @relation(fields: [driving_school_id], references: [driving_school_id], onDelete: NoAction, onUpdate: NoAction)
}
```

### Після
```
model student {
  student_id                 Int            @id @default(autoincrement())
  driving_school_id          Int
  contact_data_id            Int            @unique
  name                       String         @db.VarChar(32)
  surname                    String         @db.VarChar(32)
  sex                        sex
  age                        Int
  is_passed_theoretical_exam Boolean?
  membership                 membership[]
  payment                    payment[]
  contact_data               contact_data   @relation(fields: [contact_data_id], references: [contact_data_id], onDelete: NoAction, onUpdate: NoAction)
  driving_school             driving_school @relation(fields: [driving_school_id], references: [driving_school_id], onDelete: NoAction, onUpdate: NoAction)
}

...

enum sex {
  man
  woman
}
```
### Коментар
У цій міграції я додав до таблиці `Student` стовбець 'стать' `sex`, попередньо створивши enum `sex`, який складається з двох значень: `man` та `woman`.

## Migration 3 "delete_duration_in_membership"
### До
```
model membership {
  membership_id     Int                     @id @default(autoincrement())
  student_id        Int
  driving_school_id Int
  start_date        DateTime                @db.Date
  end_date          DateTime                @db.Date
  duration          Unsupported("interval")
  plan              membership_plan
  status            membership_status
  driving_school    driving_school          @relation(fields: [driving_school_id], references: [driving_school_id], onDelete: NoAction, onUpdate: NoAction)
  student           student                 @relation(fields: [student_id], references: [student_id], onDelete: NoAction, onUpdate: NoAction)
  payment           payment?
}
```
### Після
```
model membership {
  membership_id     Int                     @id @default(autoincrement())
  student_id        Int
  driving_school_id Int
  start_date        DateTime                @db.Date
  end_date          DateTime                @db.Date
  plan              membership_plan
  status            membership_status
  driving_school    driving_school          @relation(fields: [driving_school_id], references: [driving_school_id], onDelete: NoAction, onUpdate: NoAction)
  student           student                 @relation(fields: [student_id], references: [student_id], onDelete: NoAction, onUpdate: NoAction)
  payment           payment?
}
```
### Коментар
У цій міграції я прибрав стовбець `duration` з таблиці `membership`.

## Migration 4 "changed_type_of_data_in_seniority"
### До
```
model instructor {
  instructor_id     Int                     @id @default(autoincrement())
  car_id            Int                     @unique
  driving_school_id Int
  contact_data_id   Int                     @unique
  name              String                  @db.VarChar(32)
  surname           String                  @db.VarChar(32)
  seniority         Unsupported("interval")
  car               car                     @relation(fields: [car_id], references: [car_id], onDelete: NoAction, onUpdate: NoAction)
  contact_data      contact_data            @relation(fields: [contact_data_id], references: [contact_data_id], onDelete: NoAction, onUpdate: NoAction)
  driving_school    driving_school          @relation(fields: [driving_school_id], references: [driving_school_id], onDelete: NoAction, onUpdate: NoAction)
}

...

model teacher {
  teacher_id        Int                     @id @default(autoincrement())
  driving_school_id Int
  contact_data_id   Int                     @unique
  name              String                  @db.VarChar(32)
  surname           String                  @db.VarChar(32)
  seniority         Unsupported("interval")
  contact_data      contact_data            @relation(fields: [contact_data_id], references: [contact_data_id], onDelete: NoAction, onUpdate: NoAction)
  driving_school    driving_school          @relation(fields: [driving_school_id], references: [driving_school_id], onDelete: NoAction, onUpdate: NoAction)
}
```
### Після 
```
model instructor {
  instructor_id     Int                     @id @default(autoincrement())
  car_id            Int                     @unique
  driving_school_id Int
  contact_data_id   Int                     @unique
  name              String                  @db.VarChar(32)
  surname           String                  @db.VarChar(32)
  seniority         String                  @db.VarChar(16)
  car               car                     @relation(fields: [car_id], references: [car_id], onDelete: NoAction, onUpdate: NoAction)
  contact_data      contact_data            @relation(fields: [contact_data_id], references: [contact_data_id], onDelete: NoAction, onUpdate: NoAction)
  driving_school    driving_school          @relation(fields: [driving_school_id], references: [driving_school_id], onDelete: NoAction, onUpdate: NoAction)
}

...

model teacher {
  teacher_id        Int                     @id @default(autoincrement())
  driving_school_id Int
  contact_data_id   Int                     @unique
  name              String                  @db.VarChar(32)
  surname           String                  @db.VarChar(32)
  seniority         String                  @db.VarChar(16)
  contact_data      contact_data            @relation(fields: [contact_data_id], references: [contact_data_id], onDelete: NoAction, onUpdate: NoAction)
  driving_school    driving_school          @relation(fields: [driving_school_id], references: [driving_school_id], onDelete: NoAction, onUpdate: NoAction)
}
```
### Коментар
У цій міграції я змнінив тип даних стовбця `seniority` у таблицях `Instructor` та `Teacher` з `interval` на `String (varchar(16))` ,
адже Prisma ORM, на жаль, не підтримує тип даних `interval`. 
