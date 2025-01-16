SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE hospital_db;


USE hospital_db;
#create hospital table
CREATE TABLE hospital(
hospital_id INT AUTO_INCREMENT NOT NULL,
hospital_name VARCHAR(100) NOT NULL,
hospital_address VARCHAR(300) NOT NULL,
size  INT NOT NULL,
hospital_type ENUM('General','Teaching','Specialist','Children\'s') NOT NULL,
emergency_service ENUM('YES','NO') NOT NULL,
accreditation_year INT NOT NULL,
PRIMARY KEY (`hospital_id`)
);

# create doctor table
CREATE TABLE  doctor(
doctor_id INT AUTO_INCREMENT NOT NULL,
doctor_name VARCHAR(100) NOT NULL,
doctor_address VARCHAR(300) NOT NULL,
doctor_birthday DATE NOT NULL,
hospital_id INT NOT NULL,
PRIMARY KEY (`doctor_id`),
FOREIGN KEY(`hospital_id`)  REFERENCES hospital(`hospital_id`)
);


# create patient table
CREATE TABLE patient(
patient_id INT AUTO_INCREMENT NOT NULL,
patient_name VARCHAR(100) NOT NULL,
patient_brithday DATE NOT NULL,
patient_address VARCHAR(300) NOT NULL,
doctor_id INT NOT NULL,
PRIMARY KEY (`patient_id`),
FOREIGN KEY(`doctor_id`) REFERENCES doctor(`doctor_id`)
);

#create medication table
CREATE TABLE medication(
medication_id INT AUTO_INCREMENT NOT NULL,
medication_name VARCHAR(100) NOT NULL,
PRIMARY KEY (`medication_id`)
);

#create diesese table
CREATE TABLE disease(
disease_id INT AUTO_INCREMENT NOT NULL,
disease_name VARCHAR(100) NOT NULL,
PRIMARY KEY (`disease_id`)
);
# create relationship for mapping disease to speicalist
CREATE TABLE disease_to_specialist (
id INT AUTO_INCREMENT NOT NULL,
disease_id INT NOT NULL,
doctor_id INT NOT NULL,
PRIMARY KEY (`id`),
FOREIGN KEY(`disease_id`) REFERENCES disease(`disease_id`), 
FOREIGN KEY(`doctor_id`) REFERENCES doctor(`doctor_id`),
INDEX idx_disease_doctor(disease_id, doctor_id)
);

# create the relationship for mapping disease to medication
CREATE TABLE disease_to_medciation (
id INT AUTO_INCREMENT NOT NULL,
disease_id INT NOT NULL,
medication_id INT NOT NULL,
PRIMARY KEY (`id`),
FOREIGN KEY(`disease_id`) REFERENCES disease(`disease_id`), 
FOREIGN KEY(`medication_id`) REFERENCES medication(`medication_id`),
INDEX idx_disease_medication(disease_id, medication_id)
);

# create appintment table
CREATE TABLE appointment(
appointment_id INT AUTO_INCREMENT NOT NULL,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
scheduled_time DATETIME NOT NULL,
create_time DATETIME NOT NULL,
PRIMARY KEY(`appointment_id`),
FOREIGN KEY(`patient_id`) REFERENCES patient(`patient_id`),
FOREIGN KEY(`doctor_id`) REFERENCES doctor(`doctor_id`)
);

#create prescripiton table
CREATE TABLE prescription(
prescription_id INT AUTO_INCREMENT NOT NULL,
medication_id INT NOT NULL,
doctor_id INT NOT NULL,
patient_id INT NOT NULL,
create_time DATE NOT NULL,
PRIMARY KEY(`prescription_id`),
FOREIGN KEY(`medication_id`) REFERENCES medication(`medication_id`),
FOREIGN KEY(`doctor_id`) REFERENCES doctor(`doctor_id`),
FOREIGN KEY(`patient_id`) REFERENCES patient(`patient_id`)
);

# create labtest_result table 
CREATE TABLE labtest_result(
test_id INT AUTO_INCREMENT NOT NULL,
test_type VARCHAR(100) NOT NULL,
doctor_id INT NOT NULL,
patient_id INT NOT NULL,
result_detail VARCHAR(50) NOT NULL,
reslut_time DATETIME NOT NULL,
PRIMARY KEY (`test_id`),
FOREIGN KEY(`doctor_id`) REFERENCES doctor(`doctor_id`),
FOREIGN KEY(`patient_id`) REFERENCES patient(`patient_id`)
);