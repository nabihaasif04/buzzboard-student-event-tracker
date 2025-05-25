CREATE DATABASE buzz;
USE buzz;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    major VARCHAR(100)
);

CREATE TABLE Organizers (
    organizer_id INT PRIMARY KEY,
    name VARCHAR(100),
    contact_email VARCHAR(100)
);

CREATE TABLE Events (
    event_id INT PRIMARY KEY,
    title VARCHAR(100),
    category VARCHAR(50),
    date DATE,
    location VARCHAR(100),
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
);

CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY,
    student_id INT,
    event_id INT,
    registration_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

INSERT INTO Students VALUES
(1, 'Ahmed Khan', 'ahmed@uni.edu', 'Computer Science'),
(2, 'Bilal Ahmed', 'bilal@uni.edu', 'Physics'),
(3, 'maira Riaz', 'maira@uni.edu', 'Economics'),
(4, 'Maryam Fatima', 'maryam@uni.edu', 'AI'),
(5, 'Emaan Sheikh', 'emaan@uni.edu', 'Media Studies');

INSERT INTO Organizers VALUES
(101, 'Tech Club', 'tech@uni.edu'),
(102, 'Music Society', 'music@uni.edu'),
(103, 'Sports Council', 'sports@uni.edu');

INSERT INTO Events VALUES
(201, 'Python Workshop', 'Tech', '2025-06-05', 'NC Lab 4', 101),
(202, 'Battle of Bands', 'Music', '2025-06-10', 'Auditorium', 102),
(203, 'Football Cup', 'Sports', '2025-06-15', 'Gymnasium', 103),
(204, 'AI Innofest', 'Tech', '2025-06-20', 'LT 2', 101),
(205, 'Photography Walk', 'Art', '2025-06-25', 'Auditorium', 102);

INSERT INTO Registrations VALUES
(301, 1, 201, '2025-05-20'),
(302, 2, 202, '2025-05-22'),
(303, 1, 204, '2025-05-25'),
(304, 3, 201, '2025-05-21'),
(305, 4, 203, '2025-05-27');

SELECT * FROM Events WHERE category = 'Tech';

SELECT s.name, e.title
FROM Students s
JOIN Registrations r ON s.student_id = r.student_id
JOIN Events e ON r.event_id = e.event_id
WHERE e.category = 'Tech';

SELECT event_id, COUNT(*) AS total_registrations
FROM Registrations
GROUP BY event_id;

SELECT event_id, COUNT(*) AS reg_count
FROM Registrations
GROUP BY event_id
HAVING COUNT(*) > 1;

SELECT s.name AS Student, e.title AS Event, o.name AS Organizer
FROM Students s
JOIN Registrations r ON s.student_id = r.student_id
JOIN Events e ON r.event_id = e.event_id
JOIN Organizers o ON e.organizer_id = o.organizer_id;

SELECT MAX(date) AS Latest_Event FROM Events;

SELECT student_id FROM Registrations WHERE event_id = 201
UNION
SELECT student_id FROM Registrations WHERE event_id = 204;


SELECT student_id 
FROM Registrations 
WHERE event_id = 201
AND student_id IN (
    SELECT student_id 
    FROM Registrations 
    WHERE event_id = 204
);

SELECT r1.student_id
FROM Registrations r1
LEFT JOIN Registrations r2
  ON r1.student_id = r2.student_id AND r2.event_id = 204
WHERE r1.event_id = 201 AND r2.student_id IS NULL;

SELECT e.title, COUNT(*) AS total
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
GROUP BY e.title
ORDER BY total DESC
LIMIT 3;









