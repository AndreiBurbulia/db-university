
-- 1 -  Selezionare tutti gli studenti nati nel 1990 (160)
SELECT *
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990


-- 2- Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT *
FROM `courses`
WHERE `cfu` >10


-- 3 - Selezionare tutti gli studenti che hanno più di 30 anni
SELECT *
FROM `students`
WHERE YEAR(now()) - YEAR(`date_of_birth`) > 30

-- 4 -  Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT *
FROM `courses`
WHERE `year` = 1
AND `period` = 'I semestre'

-- 5 - Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT *
FROM `exams`
WHERE HOUR(`hour`) >= 14
AND `date` = '2020-06-20'


-- 6 - Selezionare tutti i corsi di laurea magistrale (38)
SELECT *
FROM `degrees`
WHERE `level` = 'magistrale'

-- 7 - Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(*)
AS 'How many departments'
FROM `departments`

-- 8 - Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT COUNT(*)
AS 'Teacher without phone number'
FROM `teachers`
WHERE `phone`
IS NULL



-- GROUP BY --

-- 1 -- Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*) AS 'iscrizioni', YEAR(enrolment_date) AS 'anno' 
FROM `students`
GROUP BY YEAR(`enrolment_date`)

-- 2 -- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(*) AS 'n_insegnanti', office_number 
FROM `teachers`
GROUP BY `office_number`

-- 3 -- Calcolare la media dei voti di ogni appello d'esame
SELECT AVG(`vote`) as 'voto_medio', `exam_id` as 'id_esame'
FROM `exam_student`
GROUP BY `exam_id`

-- 4 -- Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(*) AS 'n_corsi', `department_id` as 'dipartimento'
FROM `degrees`
GROUP BY `department_id`



-- JOINS

-- 1 -- Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT students.id, students.name, students.surname, students.date_of_birth, students.fiscal_code, students.enrolment_date, students.registration_number, students.email, degrees.id, degrees.name, degrees.level, degrees.address, degrees.email, degrees.website
FROM `students`
JOIN `degrees`
ON students.degree_id = degrees.id
WHERE degrees.name = "Corso di Laurea in Economia"

-- 2 -- Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT degrees.id AS 'degree_id', degrees.name, degrees.level, degrees.address, degrees.email, degrees.website, departments.id AS 'department_id', departments.name, departments.address, departments.phone, departments.email, departments.website, departments.head_of_department
FROM degrees
JOIN departments
ON degrees.department_id = departments.id
WHERE departments.name = "Dipartimento di Neuroscienze"

-- 3 -- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT teachers.id AS 'teacher_id', teachers.name, teachers.surname, teachers.phone, teachers.email, teachers.office_address, teachers.office_number, courses.id AS 'course_id', courses.name, courses.description, courses.period, courses.year, courses.cfu, courses.website
FROM course_teacher
JOIN teachers
ON course_teacher.teacher_id = teachers.id
JOIN courses
ON course_teacher.course_id = courses.id
WHERE teachers.id = 44


-- 4 -- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT students.id AS 'student_id', students.name, students.surname, students.date_of_birth, students.fiscal_code, students.enrolment_date, students.registration_number, students.email, degrees.id AS 'degree_id', degrees.name, degrees.level, degrees.address, degrees.email, degrees.website, departments.id AS 'department_id', departments.name, departments.address, departments.phone, departments.email, departments.website, departments.head_of_department
FROM students
JOIN degrees
ON students.degree_id = degrees.id
JOIN departments
ON degrees.department_id = departments.id
ORDER BY students.surname ASC

--5 -- Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT courses.id AS 'course_id', courses.name, courses.description, courses.period, courses.year, courses.cfu, courses.website, degrees.id AS 'degree_id', degrees.name, degrees.level, degrees.address, degrees.email, degrees.website, teachers.id AS 'teacher_id', teachers.name, teachers.surname, teachers.phone, teachers.email, teachers.office_address, teachers.office_number
FROM courses
JOIN degrees
ON courses.degree_id = degrees.id
JOIN course_teacher
ON courses.id = course_teacher.course_id
JOIN teachers
ON course_teacher.teacher_id = teachers.id
ORDER BY courses.year ASC

-- 6 --  Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica 
SELECT teachers.*, departments.name
FROM degrees
JOIN departments
ON degrees.department_id = departments.id
JOIN courses
ON courses.degree_id = degrees.id
JOIN course_teacher
ON courses.id = course_teacher.course_id
JOIN teachers
ON course_teacher.teacher_id = teachers.id
WHERE departments.name = "Dipartimento di Matematica"