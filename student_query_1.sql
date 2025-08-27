-- Complete database for  the dataset
--Create a database
CREATE DATABASE student_db;

DROP TABLE IF EXISTS student_dataset
-- Create the table from a given dataset
CREATE TABLE student_dataset (
    student_names VARCHAR(30),
    phone_no BIGINT,  
    math INT,
    physics INT,
    chemistry INT,
    grade VARCHAR(3),
    comments VARCHAR(25),
    roll_no VARCHAR(20) PRIMARY KEY,
    school_name VARCHAR(20),
    student_address VARCHAR(50) 
);
-- Gave me an error when i ran the database initially , so i had to update it and change the charecters of the column to 100 
ALTER TABLE student_dataset
ALTER COLUMN student_address TYPE VARCHAR(100);

-- CHECKING IF THE DATABASE IS IMPORTED CORRECTLY 
SELECT * FROM student_dataset;

--Basic data cleaning techniques
SELECT *
FROM student_dataset
WHERE student_names IS NULL
   OR phone_no IS NULL
   OR math IS NULL
   OR physics IS NULL
   OR chemistry IS NULL
   OR grade IS NULL
   OR comments IS NULL
   OR roll_no IS NULL
   OR school_name IS NULL
   OR student_address IS NULL;

-- Checking for duplicates in every column
-- Phone Number
SELECT phone_no, COUNT(*) AS count
FROM student_dataset
GROUP BY phone_no
HAVING COUNT(*) > 1;

-- Math Score
SELECT math, COUNT(*) AS count
FROM student_dataset
GROUP BY math
HAVING COUNT(*) > 1;

-- Physics Score
SELECT physics, COUNT(*) AS count
FROM student_dataset
GROUP BY physics
HAVING COUNT(*) > 1;

-- Chemistry Score
SELECT chemistry, COUNT(*) AS count
FROM student_dataset
GROUP BY chemistry
HAVING COUNT(*) > 1;

-- Grade
SELECT grade, COUNT(*) AS count
FROM student_dataset
GROUP BY grade
HAVING COUNT(*) > 1;

-- Comments
SELECT comments, COUNT(*) AS count
FROM student_dataset
GROUP BY comments
HAVING COUNT(*) > 1;

-- Roll Number
SELECT roll_no, COUNT(*) AS count
FROM student_dataset
GROUP BY roll_no
HAVING COUNT(*) > 1;

-- School Name
SELECT school_name, COUNT(*) AS count
FROM student_dataset
GROUP BY school_name
HAVING COUNT(*) > 1;

-- Student Address
SELECT student_address, COUNT(*) AS count
FROM student_dataset
GROUP BY student_address
HAVING COUNT(*) > 1;

--checking for duplicates in every row in the datasets
SELECT *, COUNT(*) AS count
FROM student_dataset
GROUP BY student_names, phone_no, math, physics, chemistry, grade, comments, roll_no, school_name, student_address
HAVING COUNT(*) > 1;

--Standardize the grades 
SELECT 
  Student_Names,
  Math,
  Physics,
  Chemistry,

  -- Math Grade
  CASE 
    WHEN Math >= 80 THEN 'A+'
    WHEN Math >= 75 THEN 'A'
    WHEN Math >= 70 THEN 'B+'
    WHEN Math >= 65 THEN 'B'
    WHEN Math >= 60 THEN 'C+'
    WHEN Math >= 55 THEN 'C'
    WHEN Math >= 50 THEN 'D'
    ELSE 'F'
  END AS Math_Grade,

  -- Physics Grade
  CASE 
    WHEN Physics >= 80 THEN 'A+'
    WHEN Physics >= 75 THEN 'A'
    WHEN Physics >= 70 THEN 'B+'
    WHEN Physics >= 65 THEN 'B'
    WHEN Physics >= 60 THEN 'C+'
    WHEN Physics >= 55 THEN 'C'
    WHEN Physics >= 50 THEN 'D'
    ELSE 'F'
  END AS Physics_Grade,

  -- Chemistry Grade
  CASE 
    WHEN Chemistry >= 80 THEN 'A+'
    WHEN Chemistry >= 75 THEN 'A'
    WHEN Chemistry >= 70 THEN 'B+'
    WHEN Chemistry >= 65 THEN 'B'
    WHEN Chemistry >= 60 THEN 'C+'
    WHEN Chemistry >= 55 THEN 'C'
    WHEN Chemistry >= 50 THEN 'D'
    ELSE 'F'
  END AS Chemistry_Grade

FROM student_dataset;
--  Normalizing the comments
SELECT 
  Student_Names,
  Comments,

  CASE 
    WHEN Comments LIKE '%Excellent%' 
         OR Comments LIKE '%Very Good%' 
         OR Comments LIKE '%Outstanding%' 
         OR Comments LIKE '%Exceptional%' THEN 'Excellent'

    WHEN Comments LIKE '%Good%' 
         OR Comments LIKE '%Pursuance%' 
         OR Comments LIKE '%Achievement%' THEN 'Good'

    WHEN Comments LIKE '%Fair%' 
         OR Comments LIKE '%Needs Improvement%' 
         OR Comments LIKE '%Average%' THEN 'Average'

    WHEN Comments LIKE '%Poor%' 
         OR Comments LIKE '%Weak%' 
         OR Comments LIKE '%Unsatisfactory%' THEN 'Poor'

    ELSE 'Uncategorized'
  END AS Performance_Category

FROM student_dataset;

-- Proving outliers according to student marks for score >100 or < 0 
SELECT 
  Student_Names, Math, Physics, Chemistry
FROM student_dataset
WHERE Math > 100 OR Math < 0
   OR Physics > 100 OR Physics < 0
   OR Chemistry > 100 OR Chemistry < 0;

-- Mean (Average)
SELECT 
  ROUND(AVG(math), 2) AS Avg_Math,
  ROUND(AVG(physics), 2) AS Avg_Physics,
  ROUND(AVG(chemistry), 2) AS Avg_Chemistry
FROM student_dataset;

-- Standard Deviation
SELECT 
  ROUND(STDDEV(math), 2) AS Std_Math,
  ROUND(STDDEV(physics), 2) AS Std_Physics,
  ROUND(STDDEV(chemistry), 2) AS Std_Chemistry
FROM student_dataset;

-- Counts how many students received each grade
SELECT grade, COUNT(*) AS Student_Count
FROM student_dataset
GROUP BY grade
ORDER BY grade DESC;


-- Applying CRUD OPERATIONS TO THE DATABASE

-- Add a new student into  the dataset
INSERT INTO student_dataset(roll_no, student_names, phone_no, math, physics, chemistry, grade, comments, school_name, student_address)
VALUES (600123, 'Alice Johnson', '9876543210', 85, 92, 88, 'A', 'Good', 'Martin Luther School', '123 Main St, NY');

-- Retrieve students details
SELECT * 
FROM student_dataset 
WHERE roll_no = '561635';

-- Update the chemistry score and grade for a student
UPDATE student_dataset
SET chemistry = 75, grade = 'A', comments = 'Good'
WHERE roll_no = '560985'; 

--Removing student students from the database
DELETE FROM student_dataset 
WHERE roll_no = '535126'; 

--Create a table of top performers 
CREATE TABLE Top_Performers AS
SELECT Roll_No, Student_Names, Math, Physics, Chemistry, Grade, School_Name
FROM student_dataset
WHERE Grade IN ('A+', 'A');
-- View the complete database
SELECT * FROM Top_Performers;

--Create a Table of Low Performers (AT Risk Students)
CREATE TABLE At_Risk_Students AS
SELECT roll_no, student_names, grade, math, physics, chemistry, school_name
FROM student_dataset
WHERE grade IN ('D', 'E', 'F');
--View the complete database
SELECT * FROM  At_Risk_Students;

--Create a summary table of average score per school
CREATE TABLE School_Avg_Scores AS
SELECT school_name,
       ROUND(AVG(math),2) AS Avg_Math,
       ROUND(AVG(physics),2) AS Avg_Physics,
       ROUND(AVG(chemistry),2) AS Avg_Chemistry,
       ROUND(AVG((math+physics+chemistry)/3),2) AS Overall_Avg
FROM student_dataset
GROUP BY school_Name;

--View the complete database
SELECT * FROM School_Avg_Scores;

--Create a table of science of science oriented students
CREATE TABLE Science_Oriented AS
SELECT roll_no, student_names, math, physics, chemistry, grade
FROM student_dataset
WHERE math>=80 AND  physics>=80;

--View the complete databse
SELECT * FROM Science_Oriented;
