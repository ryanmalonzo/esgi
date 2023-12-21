CREATE TABLE employees (
   id serial PRIMARY KEY,
   name VARCHAR(100) NOT NULL,
   salary integer NOT NULL DEFAULT 1500,
   job VARCHAR(100) NOT NULL,
   manager_id integer,
   FOREIGN KEY (manager_id) REFERENCES employees (id) ON DELETE CASCADE
);

INSERT INTO employees (
    id,
    name,
    manager_id,
    salary,
    job
)
VALUES
    (1,  'Laura', NULL, 10000, 'CEO'),
    (2,  'Aurélien', 5, 1400, 'Junior Developer'),
    (3,  'Kévin', 5, 500, 'Intern'),
    (4,  'Irène', 5, 1800, 'Developer'),
    (5,  'Julien', 7, 3000, 'Manager'),
    (6,  'Maria', 7, 2400, 'DevOps Engineer'),
    (7,  'Maxime', 1, 4200, 'VP'),
    (8,  'Lucas', 1, 3500, 'Manager'),
    (9,  'Sophia', 8, 2000, 'Data Analyst'),
    (10, 'Philippe', 8, 2500, 'Developer');
