
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

