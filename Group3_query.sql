# Print a list of all doctors based at a particular hospital.
SELECT *FROM doctor
WHERE hospital_id= 22;

# Print a list of all prescriptions for a particular patient, ordered by the prescription date
SELECT prescription.*, patient.patient_name 
FROM prescription
INNER JOIN patient on prescription.patient_id = patient.patient_id
WHERE prescription.patient_id= 40
ORDER BY create_time DESC;

# Print a list of all prescriptions that a particular doctor has prescribed
SELECT prescription.*, doctor_name
FROM prescription
INNER JOIN doctor on prescription.doctor_id = doctor.doctor_id
WHERE doctor.doctor_id = 3;

#Print a table showing all prescriptions ordered by the patient name alphabetically
SELECT prescription.* , patient.patient_name
FROM prescription 
INNER JOIN patient ON patient.patient_id = prescription.patient_id
ORDER BY patient.patient_name;

#Add a new customer to the database, including being registered with one of the doctors.
INSERT INTO patient(patient_name, patient_address, patient_birthday, doctor_id)
VALUES('Jason Green','42 Elm Street, Bristol,BS1 4DJ','1970-09-05',20);

#Check the inserted data 
SELECT *FROM patient
WHERE patient_name='Jason Green';

# Modify address details of an existing customer
UPDATE  patient
SET patient_address='53 Maple Avenue, Manchester, M13 9PL'
WHERE patient_name ='Jason Green';

#Print a list of all patient names and addresses for patients registered to doctors based at one particular hospital 
SELECT patient.patient_name,patient.patient_address
FROM patient 
INNER JOIN doctor on doctor.doctor_id= patient.doctor_id
WHERE doctor.hospital_id= 5;

#Print a list of all doctors based at Teaching hospitals which were accredited between 2015-2024.
SELECT doctor.* ,hospital.accreditation_year
FROM doctor 
INNER JOIN hospital on doctor.hospital_id = hospital.hospital_id
WHERE hospital.accreditation_year BETWEEN 2015 AND 2024;

#List all patients who may have a particular disease based on which medication they have been prescribed
SELECT patient.*, disease.disease_name
FROM prescription
INNER JOIN disease_to_medication on prescription.medication_id = disease_to_medication.medication_id
INNER JOIN patient on prescription.patient_id =patient.patient_id 
INNER JOIN disease on disease.disease_id = disease_to_medication.disease_id
WHERE disease_to_medication.disease_id=4;

# List all doctors based at who specialize in a particular disease
SELECT doctor.*, disease.disease_name
FROM doctor
INNER JOIN disease_to_specialist on disease_to_specialist.doctor_id = doctor.doctor_id
INNER JOIN disease on disease.disease_id= disease_to_specialist. disease_id
WHERE disease_to_specialist.disease_id=4;



# List all lab results for all patients over the age of 60
SELECT labtest_result.*, patient.patient_birthday, patient.patient_name
FROM labtest_result
INNER JOIN patient ON patient.patient_id= labtest_result.patient_id
WHERE (YEAR(CURDATE()) - YEAR(patient.patient_birthday)) - 
      (DATE_FORMAT(CURDATE(), '%m-%d') < DATE_FORMAT(patient.patient_birthday, '%m-%d')) > 60;
      


# Print a list of all appointments for a given patient.
SELECT *FROM appointment
WHERE patient_id= 3;


# Print a list of all appointments for a given doctor
SELECT *FROM appointment
WHERE doctor_id=3;

# Print all prescriptions made from a particular hospital ordered alphabetically by the name of the medication being prescribed
SELECT 
 medication.medication_name,
 doctor.doctor_name,
 patient.patient_name,
 hospital.hospital_name
FROM prescription
JOIN medication ON medication.medication_id=prescription.medication_id
JOIN doctor ON doctor.doctor_id = prescription.doctor_id
JOIN  patient ON patient.patient_id = prescription.patient_id
JOIN hospital ON hospital.hospital_id=doctor.hospital_id
WHERE doctor.hospital_id=5
ORDER BY medication.medication_name;

#Print a list of all lab results from all hospitals that were accredited between 2013-2020

SELECT labtest_result.*,hospital_name,accreditation_year
FROM labtest_result
JOIN hospital ON hospital.hospital_id =labtest_result.hospital_id
WHERE accreditation_year BETWEEN 2013 AND 2020;


# Identify which doctor has made the most prescriptions
SELECT 
 prescription.doctor_id, 
 doctor_name,
 COUNT(prescription_id) as prescription_count
FROM prescription
JOIN doctor ON doctor.doctor_id= prescription.doctor_id
GROUP BY prescription.doctor_id
ORDER BY prescription_count DESC
LIMIT 1;

# Print a list of all doctors at the hospital with biggest size (number of beds)  
SELECT 
 doctor_name,
 hospital.size,
 hospital.hospital_name,
 hospital.hospital_id
FROM  doctor
INNER JOIN  hospital ON hospital.hospital_id =doctor.hospital_id
WHERE hospital.size=(
SELECT MAX(size) FROM hospital
);


# A list of all hospital names which were accredited prior to 2015 and do have Emergency Service facilities
SELECT *FROM hospital
WHERE accreditation_year < 2015 AND emergency_service='Yes';

# A list of patients registered with doctors who are based at hospital with <400 beds.
SELECT patient.*,doctor.doctor_name,hospital.size,hospital.hospital_name
FROM patient
INNER JOIN  doctor on doctor.doctor_id = patient.doctor_id
INNER JOIN hospital on hospital.hospital_id =doctor.hospital_id
WHERE hospital.size < 400;

