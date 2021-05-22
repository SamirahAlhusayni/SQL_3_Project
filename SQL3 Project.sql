-- SQL3

/* 
create a relationship between the table of teachers and students 
(the teacher teaches more than one student, 
and the student is taught by more than one teacher) */
CREATE TABLE stuRelTech (
student_id int not null,
teacher_id int not null,
 FOREIGN KEY (student_id) REFERENCES Students (Student_id),
 FOREIGN KEY (teacher_id) REFERENCES Teachers (Teacher_id),
 PRIMARY KEY (student_id,teacher_id)
  );

  /* create a relationship between the table of subjects and teachers 
 (so that the teacher teaches only one subject, 
 and the subject is taught by more than one teacher) */
 
 ALTER TABLE Teachers
 ADD COLUMN subject_id int,
 ADD FOREIGN KEY (subject_id) REFERENCES Courses(Subject_id);


 /*
create a relationship between the table of subjects and students 
(So that the student studies more than one subject,
 and the subject is studied by more than one student).
*/
CREATE TABLE subjRelSTU (
sub_id INT NOT NULL,
stu_id INT NOT NULL,
 FOREIGN KEY (sub_id) REFERENCES Courses (Subject_id),
 FOREIGN KEY (stu_id) REFERENCES Students (Student_id),
 PRIMARY KEY (sub_id,stu_id)
  );

/* Create the procedure called student_info that displays the names 
of the students and the subjects contain all the data shared between 
the subjects and students table */
delimiter //
CREATE PROCEDURE student_info()
BEGIN
SELECT Student_name, Subject_name 
FROM subjRelSTU
JOIN Students ON Student_id = stu_id
JOIN Courses ON Subject_id = sub_id;
END



-- call this procedure
CALL student_info();

/* Create a view with the name teacher_info that contains the teacher's name,
 the office number, and the name of the subject being taught. */
 CREATE VIEW teacher_info AS 
 SELECT Teacher_name, OfficeNum, Subject_name
 FROM Teachers 
 join Courses on Courses.Subject_id= Teachers.subject_id
 
 -- show the view 
 SELECT * FROM teacher_info;
 -- drop view 
 DROP VIEW teacher_info;
 -- Create an index to search using student names alphabetically
 CREATE INDEX StudentIndex 
 ON Students (Student_name)
 -- show index 
 SHOW INDEX FROM Students
 -- drop index
 DROP INDEX StudentIndex  on Students