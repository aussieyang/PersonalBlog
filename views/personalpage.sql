CREATE DATABASE personalpage;

CREATE TABLE posts (
  id SERIAL4 PRIMARY KEY,
  heading VARCHAR(300) NOT NULL,
  post VARCHAR NOT NULL,
  image VARCHAR(500),
  topic VARCHAR(200),
  author VARCHAR(200),
  postdate DATE DEFAULT CURRENT_DATE,
  user_id INTEGER
);


CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(200) NOT NULL,
  password_digest VARCHAR(400) NOT NULL,
  name VARCHAR(200) NOT NULL,
  portrait VARCHAR(500) NOT NULL,
  about VARCHAR NOT NULL,
  git VARCHAR(400)
);

-- Not yet executed

ALTER TABLE posts ADD featured BOOLEAN;

ALTER TABLE posts ADD summary VARCHAR(500);
