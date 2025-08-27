# 📘 Student Database Project (SQL)

## 📌 Project Overview
This project builds a **Student Database** in SQL to simulate a **school information management system**.  
It demonstrates:  
- ✅ Database design (schema + constraints)  
- ✅ Data cleaning techniques (nulls, duplicates, outliers, normalization)  
- ✅ Exploratory Data Analysis (EDA)  
- ✅ CRUD operations (Create, Read, Update, Delete)  
- ✅ CTAS (Create Table As Select) operations for analytics  

This can be extended into a **School Management System** or **Data Analytics Dashboard**.  

---

## 🏗️ Database Schema
The database is called **`student_db`** and has the following schema:

```sql
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
    student_address VARCHAR(100) 
);
```

---

## 🧹 Data Cleaning Techniques
### 1. Find Null Values  
```sql
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
```

### 2. Check for Duplicates  
```sql
SELECT phone_no, COUNT(*) 
FROM student_dataset
GROUP BY phone_no
HAVING COUNT(*) > 1;
```

### 3. Standardize Subject Grades  
```sql
SELECT student_names, math,
  CASE 
    WHEN Math >= 80 THEN 'A+'
    WHEN Math >= 70 THEN 'A'
    WHEN Math >= 60 THEN 'B'
    ELSE 'F'
  END AS Math_Grade
FROM student_dataset;
```

### 4. Normalize Comments  
```sql
SELECT student_names, comments,
  CASE 
    WHEN comments LIKE '%Excellent%' THEN 'Excellent'
    WHEN comments LIKE '%Good%' THEN 'Good'
    WHEN comments LIKE '%Average%' THEN 'Average'
    ELSE 'Poor'
  END AS Performance_Category
FROM student_dataset;
```

---

## 📊 Exploratory Data Analysis (EDA)
### 1. Average & Standard Deviation  
```sql
SELECT 
  ROUND(AVG(math), 2) AS Avg_Math,
  ROUND(STDDEV(math), 2) AS Std_Math
FROM student_dataset;
```

### 2. Grade Distribution  
```sql
SELECT grade, COUNT(*) AS Student_Count
FROM student_dataset
GROUP BY grade
ORDER BY grade DESC;
```

---

## ⚡ CRUD Operations
### 1. Insert New Student  
```sql
INSERT INTO student_dataset (roll_no, student_names, phone_no, math, physics, chemistry, grade, comments, school_name, student_address)
VALUES ('600123', 'Alice Johnson', '9876543210', 85, 92, 88, 'A', 'Good', 'Martin Luther School', '123 Main St, NY');
```

### 2. Retrieve Student by Roll Number  
```sql
SELECT * FROM student_dataset WHERE roll_no = '561635';
```

### 3. Update Student Grade  
```sql
UPDATE student_dataset
SET chemistry = 75, grade = 'A', comments = 'Good'
WHERE roll_no = '560985';
```

### 4. Delete Student  
```sql
DELETE FROM student_dataset WHERE roll_no = '535126';
```

---

## 🏷️ CTAS Operations
### 1. Top Performers  
```sql
CREATE TABLE Top_Performers AS
SELECT roll_no, student_names, math, physics, chemistry, grade, school_name
FROM student_dataset
WHERE grade IN ('A+', 'A');
```

### 2. At-Risk Students  
```sql
CREATE TABLE At_Risk_Students AS
SELECT roll_no, student_names, grade, math, physics, chemistry, school_name
FROM student_dataset
WHERE grade IN ('D', 'E', 'F');
```

### 3. School-Level Average Performance  
```sql
CREATE TABLE School_Avg_Scores AS
SELECT school_name,
       ROUND(AVG(math),2) AS Avg_Math,
       ROUND(AVG(physics),2) AS Avg_Physics,
       ROUND(AVG(chemistry),2) AS Avg_Chemistry
FROM student_dataset
GROUP BY school_name;
```

---

## 📌 Key Learnings
- Designing relational databases with SQL.  
- Applying **data cleaning techniques** on raw datasets.  
- Performing **EDA** using SQL queries.  
- Using **CRUD & CTAS** to manage and analyze data.  
- Translating business questions into **SQL insights**.  

---
 
