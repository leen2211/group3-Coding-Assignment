# Group3 Coding-Assignment
# Project Overview
The aim of this project is to develop a comprehensive hospital database that includes information on hospitals, doctors, patients, drugs, prescriptions, diseases, appointments and laboratory results. The project is planned through Entity Relationship Diagram (ERD) and implemented on both MS Access and MySQL platforms.
The database supports complex SQL queries to facilitate information retrieval and analysis, and meets task requirements with 19 implemented queries.

# Database Structure
1. hospital
(hospital_id, hospital_name, hospital_address, size, hospital_type, emergency_service)
Stores basic hospital information such as name, address, size, etc.

2. doctor
(doctor_id, doctor_name, doctor_birthday, doctor_address, hospital_id)
Stores information about doctors and their associated hospitals

3. patient
(patient_id, patient_name, patient_birthday, patient_address, doctor_id)
Record the patient's personal information, such as name, birthday, address, and their designated doctor.

4. medication
(medication_id, medication_name)
List medications and their names.

5. prescription
(prescription, doctor_id, patient_id, medication_id, create_time,)
Record prescription information and associate patients, medications, and doctors.

6. disease
(disease_id, disease_name)
Store disease information.

7. disease_to_specialist
(ID, diease_id, doctor_id,)
Map the disease to the specialist

8. disease_to_medication
(ID, disease_id, medication_id)
Associate the disease with the medication used to treat it

9. appointment
(appointment_id, patient_id, doctor_id scheduled_time, create_time,)
Record the patient's appointment information.

10. labtest_result
Test_id, test_type, doctor_id, patient_id, result_detail, result_time)
Record patient laboratory test results

# Guide to using SQL queries
1. For MS Access：
   Open the hospital_database.accdb file directly.
   Navigate to the Queries section.
   Double-click on any saved query to run it.

2. For MySQL：
   Use My SQL Workbench's import csv command to import hospital_database.
   Open the SOL_queries.sql file in the appropriate database management tool, select the query you want to execute and run it.
   
   Note: Since the database is created using MySQL Workbench, you can simply run the SQL query in the Workbench environment.

# Examples of SQL Queries
Here are a few examples of the implemented SQL queries to demonstrate the database functionality:

1. Print a list of all doctors based at a particular hospital
SELECT
hospital.hospital_name, 
doctor.doctor_name
FROM
doctor
INNER JOIN
hospital ON doctor.hospital_id = hospital.hospital_id
WHERE
hospital.hospital_id = 15;

2. Print a list of all prescriptions for a particular patient, ordered by the prescription date.
SELECT
prescription_id,
medication_name,
create_time
FROM
prescription
INNER JOIN
medication ON prescription.medication_id = medication.medication_id
WHERE
patient_id = 56
ORDER BY 
prescription.create_time ASC;

3. Print a list of all prescriptions that a particular doctor has prescribed.
SELECT doctor.doctor_name, COUNT(prescription.prescription_id) AS Total_Prescriptions
FROM prescription
INNER JOIN doctor ON prescription.doctor_id = doctor.doctor_id
WHERE doctor.doctor_id = 7
GROUP BY doctor.doctor_name;  

# Project Contributors
Shelly - The entity relationship diagram is created, and the structure and fields of the database are planned.
Eva and Leena - The database is created and populated in MS Access and all SQL queries are implemented.
Alaa - Documentation.
Shelly, Eva, Leena - Testing，Redame file and Readme page.

# Project Documentation
ERD Diagram – Visual representation of the database structure.  
SQL Queries – Stored in Access and MySQL formats.  
Meeting Notes – Documented team discussions and decisions.  
Action Plan – Detailed timeline and task breakdown.  
README.md – Project overview and usage instructions.

# GitHub Repository
Project LInk？




