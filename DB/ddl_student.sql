
CREATE TABLE IF NOT EXISTS student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    surname VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    tg VARCHAR(50),
    email VARCHAR(100),
    phone varchar(20),
    git VARCHAR(100)
);
