-------------------------------------------------------------------------
-- Micro Exam 4.2 (Zoraida White)
-- Instructions: Using the armc database, answer the questions in each
-- part below. Submit this SQL file as your response to Micro Exam 4.2.
-- Total points: 35 + 10 bonus
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- PART 1: Female patients born after 2000-12-01.
-------------------------------------------------------------------------
-- (1) List all patients. HINT: 100,000 rows. (5 points)
SELECT *
FROM patients;


-- (2) List all female (F) patients. Hint: Begin with (1) and add a 
--     WHERE clause. (2 points)
SELECT *
FROM patients
WHERE gender = 'F';

-- (3) List all female (F) patients born after '2000-12-01'. 
--     Hint: Begin with (2) and add an AND clause - 3,482 rows. (2 points)
SELECT *
FROM patients
WHERE gender = 'F'
AND birth_date >= '2000-12-01';


-------------------------------------------------------------------------
-- PART 2: Patients and encounters between 18 and 25 with a recorded BP.
-------------------------------------------------------------------------
-- (1) List all patients and encounters. HINT: Join patients and 
--     encounters - 1,718,315 rows. (5 points)
SELECT *
FROM patients p JOIN encounters e 
	ON p.patient_id = e.patient_id;

-- (2) Constrain (1) to those with non-null bp_systolic and bp_diastolic 
--     values. HINT: 135,191 rows. (3 points)
SELECT *
FROM patients p 
	JOIN encounters e ON p.patient_id = e.patient_id
WHERE bp_systolic IS NOT NULL
AND bp_diastolic IS NOT NULL;

-- (3) Constrain encounter age in (2) to between 18 and 25. 
--     HINT: 18,721 rows. (3 points)

SELECT *
FROM patients p 
	JOIN encounters e ON p.patient_id = e.patient_id
WHERE age BETWEEN 18 AND 25
AND bp_systolic IS NOT NULL
AND bp_diastolic IS NOT NULL;

-------------------------------------------------------------------------
-- PART 3: Count the number of encounters by department.
-------------------------------------------------------------------------
-- (1) List all encounter and department details. HINT: Join encounters 
--     to departments. (5 points)
SELECT *
FROM encounters e JOIN departments d ON e.department_id = d.department_id;

-- (2) From (1), return the department_name. HINT: You only need to 
--     change the SELECT statement. (2 points)
SELECT department_name
FROM encounters e JOIN departments d ON e.department_id = d.department_id;

-- (3) To (2), return the count by department_name. HINT: Add count to 
--     SELECT and add a GROUP BY clause - 74 rows. (5 points)
SELECT department_name, COUNT (*) 
FROM encounters e JOIN departments d ON e.department_id = d.department_id
GROUP BY department_name;

-- (4) Sort (3) by count descending. HINT: Top result is 
--     INTERNAL MEDICINE with count 1,215,253. (3 points)
SELECT department_name, COUNT (*) 
FROM encounters e JOIN departments d ON e.department_id = d.department_id
GROUP BY department_name
ORDER BY COUNT DESC;


-------------------------------------------------------------------------
-- BONUS: Count the number of encounters with a diabetes diagnosis.
-------------------------------------------------------------------------
-- (1) List all encounter, diseases, and disease type details. HINT: Join 
--     encounters to diseases to disease_types - 1,927,535 rows. (6 points)
SELECT *
FROM encounters e JOIN diseases d ON e.encounter_id = d.encounter_id
	JOIN disease_types t ON d.disease_id = t.disease_id;

-- (2) Constrain (1) to those with a disease name beginning with DIABETES. 
--     HINT: You will use a single % - 41,589 rows. (2 points)
SELECT *
FROM encounters e JOIN diseases d ON e.encounter_id = d.encounter_id
	JOIN disease_types t ON d.disease_id = t.disease_id
WHERE t.name LIKE 'DIABETES%';
	

-- (3) Count the number of encounters with a diabetes diagnosis. HINT: 
--     You will NOT need a GROUP BY - 41589 is the answer (only 1 row). 
--     (2 points)
SELECT COUNT (*)
FROM encounters e JOIN diseases d ON e.encounter_id = d.encounter_id
	JOIN disease_types t ON d.disease_id = t.disease_id
WHERE t.name LIKE 'DIABETES%';


