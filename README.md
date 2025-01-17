# Group3 Coding-Assignment
# Project Overview
The aim of this project is to develop a comprehensive hospital database that includes information on hospitals, doctors, patients, drugs, prescriptions, diseases, appointments and laboratory results. The project is planned through Entity Relationship Diagram (ERD) and implemented on both MS Access and MySQL platforms.
The database supports complex SQL queries to facilitate information retrieval and analysis, and meets task requirements with 19 implemented queries.

# Database Structure
The data used in this project was randomly generated using ChatGPT and Excel formulas to simulate real healthcare data for testing and analysis.

1. hospital  
(hospital_id, hospital_name, hospital_address, size, hospital_type, emergency_service，accreditation_year)  
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
(prescription, doctor_id, patient_id, medication_id, create_time)  
Record prescription information and associate patients, medications, and doctors.  

6. disease  
(disease_id, disease_name)  
Store disease information.  

7. disease_to_specialist  
(ID, diease_id, doctor_id)  
Map the disease to the specialist  

8. disease_to_medication  
(ID, disease_id, medication_id)  
Associate the disease with the medication used to treat it  

9. appointment  
(appointment_id, patient_id, doctor_id scheduled_time, create_time)  
Record the patient's appointment information.  
 
10. labtest_result  
(Test_id, test_type, doctor_id, patient_id, result_detail, result_time)  
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

# SQL Query Function  
The project implements the following 19 SQL queries to meet different data retrieval requirements.

1. Print a list of all doctors based at a particular hospital  
   Purpose: retrieve the names of all doctors working in the designated hospital.    
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
   Purpose: displays all prescriptions for a particular patient in chronological order.  
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
   Purpose: displays the total number of prescriptions written by a particular doctor.  
   SELECT doctor.doctor_name, COUNT(prescription.prescription_id) AS Total_Prescriptions  
   FROM prescription  
   INNER JOIN doctor ON prescription.doctor_id = doctor.doctor_id    
   WHERE doctor.doctor_id = 7  
   GROUP BY doctor.doctor_name;  

4. Print a table showing all prescriptions ordered by the patient name alphabetically  
   Purpose: sort all prescriptions  
   SELECT  
   patient.patient_name,  
   prescription.prescription_id,  
   medication.medication_name,  
   prescription.create_time  
   FROM  
   (prescription  
   INNER JOIN  
   patient ON prescription.patient_id = patient.patient_id)  
   INNER JOIN  
   medication ON prescription.medication_id = medication.medication_id  
   ORDER BY patient.patient_name ASC;  

5. Add a new customer to the database, including being registered with one of the doctors.  
   Purpose: insert a new patient record and associate it with the doctor.  
   INSERT INTO patient (patient_name, patient_birthday, patient_address, doctor_id)  
   VALUES ('David Miller', '1997-12-25', '14 Pine Road', 1);  

6. Modify address details of an existing customer  
   Purpose: update address details for existing patients.  
   UPDATE patient  
   SET patient_address = "123 Maplewood Lane, Springfield, IL 62701"  
   WHERE patient_name = "Carla Ramos";  

7. Print a list of all patient names and addresses for patients registered to doctors based at one particular hospital -   that could be used for posting information mail to all of one hospital’s registered patients.  
   Purpose: retrieve patient names and addresses for mailing purposes.  
   SELECT  
   patient.patient_name,  
   patient.patient_address  
   FROM  
   (patient  
   INNER JOIN  
   doctor ON patient.doctor_id = doctor.doctor_id)  
   INNER JOIN  
   hospital ON doctor.hospital_id = hospital.hospital_id  
   WHERE  
   hospital.hospital_name = "Royal London Hospital";  

8. Print a list of all doctors based at Teaching hospitals which were accredited between 2015-2024.   
   Purpose: identify doctors working at teaching hospitals accredited within a specific timeframe.  
   SELECT  
   doctor.doctor_name,  
   hospital.hospital_name,  
   hospital.accreditation_year  
   FROM  
   doctor   
   INNER JOIN  
   hospital ON doctor.hospital_id = hospital.hospital_id  
   WHERE  
   hospital.hospital_type = "Teaching"   
   AND hospital.accreditation_year BETWEEN 2015 AND 2024;  

9. List all patients who may have a particular disease based on which medication they have been prescribed.  
   Purpose: follow the prescription to find patients who may be ill.  
   SELECT  
   patient.patient_name,  
   patient.patient_address,  
   medication.medication_name,  
   disease.disease_name  
   FROM  
   (((patient  
   INNER JOIN   
   prescription ON patient.patient_id = prescription.patient_id)  
   INNER JOIN  
   medication ON prescription.medication_id = medication.medication_id)  
   INNER JOIN  
   disease_to_medication ON medication.medication_id = disease_to_medication.medication_id)  
   INNER JOIN  
   disease ON disease_to_medication.disease_id = disease.disease_id  
   WHERE  
   disease.disease_name = "Asthma" ;  

10. List all doctors based at who specialize in a particular disease.  
    Purpose: display doctors who specialize in treating a specific disease.  
    SELECT  
    doctor.doctor_id,  
    doctor.doctor_name,    
    disease.disease_name  
    FROM  
    (doctor  
    INNER JOIN  
    disease_to_specialist ON doctor.doctor_id = disease_to_specialist.doctor_id)  
    INNER JOIN   
    disease ON disease_to_specialist.disease_id = disease.disease_id  
    WHERE  
    disease.disease_name = "Cancer";  

11. List all lab results for all patients over the age of 60.  
    Purpose: identify laboratory results in elderly patients.  
    SELECT  
    patient.patient_id,  
    patient.patient_name,  
    patient.patient_birthday,  
    labtest_result.test_type,  
    labtest_result.result_time,  
    labtest_result.result_detail  
    FROM  
    patient  
    INNER JOIN  
    labtest_result ON patient.patient_id = labtest_result.patient_id  
    WHERE  
    DateDiff("yyyy",patient.patient_birthday,Date()) > 60;
    
 12. Print a list of all appointments for a given patient.  
    Purpose: view appointment schedules for a specific patient.  
    SELECT  
    appointment.appointment_id,  
    appointment.scheduled_time,  
    doctor.doctor_name  
    FROM  
    appointment  
    INNER JOIN  
    doctor ON appointment.doctor_id = doctor.doctor_id  
    WHERE  
    appointment.patient_id = 60;  

13. Print a list of all appointments for a given doctor.   
    Purpose: displays all appointments for the specified doctor.  
    SELECT  
    appointment.appointment_id,  
    appointment.scheduled_time,  
    doctor.doctor_name  
    FROM  
    appointment  
    INNER JOIN   
    doctor  ON appointment.doctor_id = doctor.doctor_id  
    WHERE  
    appointment.doctor_id = 60;  

14. Print all prescriptions made from a particular hospital ordered alphabetically by the name of the medication being prescribed - The output of this SQL query should include only these 4 columns: the medication name, the name of doctor who prescribed it, the name of the patient, and the name of hospital.  
    Purpose: list hospital prescriptions alphabetically by medication.  
    SELECT  
    medication.medication_name,  
    doctor.doctor_name,  
    patient.patient_name,  
    hospital.hospital_name  
    FROM  
    (((prescription  
    INNER JOIN  
    medication ON prescription.medication_id = medication.medication_id)  
    INNER JOIN  
    doctor  ON prescription.doctor_id = doctor.doctor_id)  
    INNER JOIN  
    patient ON prescription.patient_id = patient.patient_id)  
    INNER JOIN  
    hospital ON doctor.hospital_id = hospital.hospital_id  
    WHERE  
    hospital.hospital_name = "Royal London Hospital"  
    ORDER BY  
    medication.medication_name;  

15. Print a list of all lab results from all hospitals that were accredited between 2013-2020.  
    Purpose: retrieve lab results from recently accredited hospitals.  
    SELECT  
    hospital.hospital_name,  
    labtest_result.test_type,  
    labtest_result.result_time,  
    labtest_result.result_detail  
    FROM  
    ((labtest_result  
    INNER JOIN  
    doctor ON labtest_result.doctor_id = doctor.doctor_id)  
    INNER JOIN  
    hospital ON doctor.hospital_id = hospital.hospital_id)  
    WHERE  
    hospital.accreditation_year BETWEEN 2013 AND 2020;  

16. Identify which doctor has made the most prescriptions.   
    Purpose: determine which doctor has issued the most prescriptions.  
    SELECT TOP 1  
    doctor.doctor_name,  
    COUNT (prescription_id)  
    FROM  
    Prescription  
    INNERJOIN doctor  ON  
    prescription.doctor_id = doctor.doctor_id  
    GROUP BY  
    doctor.doctor_name  
    ORDER BY  
    COUNT (prescription_id)  
    DESC;  

17. Print a list of all doctors at the hospital with biggest size (number of beds).  
    Purpose: show doctors working in the largest hospital.  
    SELECT   
    doctor_id,   
    hospital.size,   
    hospital.hospital_name   
    FROM doctor   
    INNER JOIN   
    hospital ON hospital.hospital_id = doctor.hospital_id   
    WHERE hospital.size = ( SELECT MAX(size) FROM hospital );  

18. A list of all hospital names which were accredited prior to 2015 and do have Emergency Service facilities   
    Purpose: identify hospitals that were accredited and provided emergency services prior to 2015.  
    SELECT  
    hospital_name  
    FROM  
    hospital  
    WHERE  
    accreditation_year < 2015  
    AND  
    emergency_service = True;  

19. A list of patients registered with doctors who are based at hospital with <400 beds.  
    Purpose: find patients treated in smaller hospitals.  
    SELECT  
    patient.patient_name  
    FROM  
    (hospital  
    INNER JOIN  
    doctor ON hospital.hospital_id=doctor.hospital_id)  
    INNER JOIN  
    patient ON doctor.doctor_id=patient.doctor_id  
    WHERE  
    hospital.size < 400;  

# Project Documentation  
ERD Diagram – Visual representation of the database structure.    
SQL Queries – Stored in Access and MySQL formats.    
Meeting Notes – Documented team discussions and decisions.  
Action Plan – Detailed timeline and task breakdown.    
README.md – Project overview and usage instructions.  

# GitHub Repository
https://leen2211.github.io/group3-Coding-Assignment/  




