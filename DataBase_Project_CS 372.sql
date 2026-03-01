CREATE TABLE HospitalDepartment(
DepartmentID NUMBER (5)CONSTRAINT DepartmentID_PK PRIMARY KEY,
DepartmentName VARCHAR2(20)CONSTRAINT DName_NN NOT NULL);

CREATE TABLE Doctor(
DoctorID NUMBER(5)CONSTRAINT Doctor_ID_PK PRIMARY KEY,
DoctorName VARCHAR2(15) CONSTRAINT Doctor_NAME_NN NOT NULL,
Gender VARCHAR2(6), Salary NUMBER (7,2),
DepartmentID NUMBER (5), PhoneNumber  NUMBER(10) CONSTRAINT phone_u UNIQUE,
SpecializationRank VARCHAR2 (20), 
CONSTRAINT DepartmentHID_FK FOREIGN KEY(DepartmentID) REFERENCES HospitalDepartment(DepartmentID)
);

CREATE TABLE Nurse(NurseID NUMBER(5)CONSTRAINT Nurse_ID_PK PRIMARY KEY,
NurseName VARCHAR2(20), Gender VARCHAR2(6), Salar NUMBER (9,4),
PhoneNumber Number(10)
);

CREATE TABLE Patient(PatientID NUMBER (5) CONSTRAINT Patient_ID_PK PRIMARY KEY,
PatienteName VARCHAR2(20), Gender VARCHAR2(6),PhoneNumber Number(10),
DoctorID NUMBER(5), CONSTRAINT DoctorID_FK FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE MedicalRecord( RecordID NUMBER (5) CONSTRAINT Record_ID_PK PRIMARY KEY,
PatientID_ NUMBER (5),VisitDate DATE CONSTRAINT visit_NN NOT NULL,
DoctorNoteS VARCHAR2(60), BloodType VARCHAR2(10), Allergies VARCHAR2(50),
Diagnosis VARCHAR2(50),MedicationGiven VARCHAR2(50),TreatmentPlan VARCHAR2(50),
CONSTRAINT PatientID_FK FOREIGN KEY (PatientID_) REFERENCES Patient(PatientID)
);

CREATE TABLE Medicine (MedicineID NUMBER (5) CONSTRAINT Medicine_ID_PK PRIMARY KEY,
MedicineName VARCHAR2(25),MedicineType VARCHAR2(25),UsageInstructions VARCHAR2(50),
SideEffects VARCHAR2(50),Duration VARCHAR2(25),Dosage VARCHAR2 (25),
RecordID_ NUMBER(5),
CONSTRAINT Record_IDFK FOREIGN KEY(RecordID_) REFERENCES MedicalRecord(RecordID)
);

--HospitalDepartment
INSERT INTO HospitalDepartment
 VALUES (30521, 'Cardiology');

INSERT INTO HospitalDepartment
 VALUES (10567, 'Neurology');

INSERT INTO HospitalDepartment 
VALUES (37980, 'Pediatrics');

INSERT INTO HospitalDepartment 
VALUES (67983, 'Dermatology');


-- Doctors
INSERT INTO Doctor 
VALUES (20100, 'Nuha Ahmad', 'Female', 15000.50, 30521, '0551234567', 'Consultant');

INSERT INTO Doctor
 VALUES (20200, 'Rana Alenezi', 'Female', 12000.75, 10567, '0559876543', 'Specialist');

INSERT INTO Doctor 
VALUES (20300, 'saad Alharbi', 'Male', 13000.00, 37980, '0551122334', 'Resident');

INSERT INTO Doctor
 VALUES (20400, 'Esraa AlLogmani', 'Female', 12500.00, 67983, '0554455667', 'Specialist');


-- Nurses
INSERT INTO Nurse 
VALUES (30100, 'Abrar Al Mutairi', 'Female', 8500.25, '0553344556');

INSERT INTO Nurse
 VALUES (30200, 'Rose Alharbi', 'Female', 7900.10, '0556677889');

INSERT INTO Nurse
 VALUES (30300, 'Omar Ali', 'Male', 8200.50, '0559988776');

INSERT INTO Nurse
 VALUES (30400, 'Hassan AlHarbi', 'Male', 8100.30, '0557766554');


 -- Patients
INSERT INTO Patient
 VALUES (10100, 'Ahmad Alroqi', 'Male', '1234567890', 20400);

INSERT INTO Patient
 VALUES (10200, 'Sara Alharbi', 'Female', '9876543210', 20200);

INSERT INTO Patient
 VALUES (10300, 'Ali Al-Fahad', 'Male', '4561237890', 20300);


-- Medical Records
INSERT INTO MedicalRecord 
VALUES (50116, 10100, TO_DATE('2020-04-09','YYYY-MM-DD'), 'Signs of mild fever', 'O+', 'Pollen', 'Flu', 'Paracetamol', 'Rest and hydration');
INSERT INTO MedicalRecord
 VALUES (11209, 10200, TO_DATE('2019-06-18','YYYY-MM-DD'), 'Routine check-up, no symptoms', 'AB+', 'None', 'Healthy', 'None', 'Follow-up in 4 months');
INSERT INTO MedicalRecord 
VALUES (31158, 10300, TO_DATE('2022-11-08','YYYY-MM-DD'), 'Headache and dizziness', 'B+', 'Peanuts', 'Migraine', 'Ibuprofen', 'Avoid triggers and rest');


-- Medicines
INSERT INTO Medicine 
VALUES (09919, 'Paracetamol', 'Painkiller', 'Take 1 tablet every 4-6 hours', 'Nausea, Dizziness', '3 days', '1000 mg',50116);
INSERT INTO Medicine 
VALUES (28888, 'Amoxicillin', 'Antibiotic', 'Take 1 capsule every 12 hours', 'Rash, Diarrhea', '5 days', '500 mg',11209);
INSERT INTO Medicine 
VALUES (33333, 'Ibuprofen', 'Painkiller', 'Take 1 tablet every 8 hours after meals', 'Stomach pain, Dizziness', '7 days', '200 mg',31158);

--UPDATE
UPDATE Doctor
SET Salary = 50000,
    SpecializationRank = 'Senior Consultant'
WHERE DoctorID = 20300;

UPDATE Patient
SET DoctorID = 20400
WHERE PatientID = 10200;
--DELETE
DELETE FROM Medicine 
WHERE MedicineID = 28888;


--Display doctors along with their department and salary
SELECT Doctor.DoctorName, HospitalDepartment.DepartmentName, Doctor.Salary
FROM Doctor
INNER JOIN HospitalDepartment
ON Doctor.DepartmentID = HospitalDepartment.DepartmentID;

 --Display the names of medicines and their dosages
SELECT MedicineName, MedicineType, Dosage
FROM Medicine;

-- Calculate the average salary based on gender for all doctors
SELECT Gender, AVG(Salary)
FROM Doctor
GROUP BY Gender;


-- Retrieve patient names along with their respective doctor's names
SELECT P.PatienteName, D.DoctorName
FROM Patient P
JOIN Doctor D ON P.DoctorID = D.DoctorID;

-- Retrieve patient names who are treated by Dr. Esraa AlLogmani
SELECT P.PatienteName
FROM Patient P
JOIN Doctor D ON P.DoctorID = D.DoctorID
WHERE D.DoctorName = 'Esraa AlLogmani';

-- Display medical records that occurred between January 1, 2019 and January 4, 2020
SELECT * 
FROM MedicalRecord
WHERE VisitDate BETWEEN TO_DATE('2019-01-01', 'YYYY-MM-DD') 
 AND TO_DATE('2020-01-04', 'YYYY-MM-DD');


-- Retrieve patient names with their medical records between January 1, 2020 and January 4, 2022
SELECT P.PatienteName
FROM MedicalRecord M
JOIN Patient P ON M.PatientID_= P.PatientID
WHERE M.VisitDate BETWEEN TO_DATE('2020-01-01', 'YYYY-MM-DD') 
 AND TO_DATE('2022-01-04', 'YYYY-MM-DD');


 -- Retrieve patient details with their medical records (all columns)
SELECT *
FROM Patient P
INNER JOIN MedicalRecord M ON P.PatientID = M.PatientID_;


-- Retrieve details for a specific patient (PatientID = 10100) along with their medical records
SELECT *
FROM Patient P
INNER JOIN MedicalRecord M ON P.PatientID = M.PatientID_
WHERE P.PatientID=10100;

SELECT * FROM Medicine;