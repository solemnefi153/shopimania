CREATE TABLE roles (
  role_id SERIAL NOT NULL UNIQUE,
  description VARCHAR(20)  NOT NULL UNIQUE,
  PRIMARY KEY (role_id)
);

CREATE TABLE users (
  user_id SERIAL NOT NULL UNIQUE,
  role_id INT NOT NULL,
  first_name VARCHAR(20)  NOT NULL,
  last_name VARCHAR(20)  NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR,
  PRIMARY KEY (user_id), 
  FOREIGN KEY (role_id) REFERENCES roles (role_id) 
);

CREATE TABLE products (
  product_id SERIAL NOT NULL UNIQUE,
  product_name VARCHAR(30) NOT NULL UNIQUE,
  product_description TEXT,
  weight NUMERIC(10, 2), 
  measure VARCHAR(5),
  height NUMERIC (30, 2),
  length NUMERIC (30, 2),
  image BYTEA NOT NULL, 
  PRIMARY KEY (product_id)
);

CREATE TABLE inventory (
  inventory_id SERIAL NOT NULL UNIQUE,
  product_id INT NOT NULL,
  count INT NOT NULL,
  PRIMARY KEY (inventory_id),
  FOREIGN KEY (product_id) REFERENCES products (product_id) 
);

CREATE TABLE orders (
  order_id SERIAL NOT NULL UNIQUE,
  user_id INT NOT NULL,
  order_date DATE NOT NULL DEFAULT CURRENT_DATE,
  traking_number VARCHAR,
  order_details JSONB,
  PRIMARY KEY (order_id), 
  FOREIGN KEY (user_id) REFERENCES users (user_id) 
);
