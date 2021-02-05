
/*Run this to reset the database*/
DROP TABLE IF EXISTS  roles, users, categories, products, inventory, orders CASCADE;

/*Create the tables in the database*/
CREATE TABLE roles (
  role_id INT NOT NULL UNIQUE,
  description VARCHAR(20)  NOT NULL UNIQUE,
  PRIMARY KEY (role_id)
);

CREATE TABLE users (
  user_id INT NOT NULL UNIQUE,
  role_id INT NOT NULL,
  first_name VARCHAR(20)  NOT NULL,
  last_name VARCHAR(20)  NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  street_address VARCHAR(50),
  apt_or_unit VARCHAR(10),
  zip_code VARCHAR(20),
  country VARCHAR(20),
  state VARCHAR(20),
  city VARCHAR(20),
  password VARCHAR,
  PRIMARY KEY (user_id), 
  FOREIGN KEY (role_id) REFERENCES roles (role_id) 
);

CREATE TABLE categories (
  category_id INT NOT NULL UNIQUE,
  description VARCHAR(20)  NOT NULL UNIQUE,
  PRIMARY KEY (category_id)
);

CREATE TABLE products (
  product_id INT NOT NULL UNIQUE,
  category_id INT NOT NULL,
  product_name VARCHAR(30) NOT NULL UNIQUE,
  product_description TEXT,
  price NUMERIC(10, 2) NOT NULL, 
  weight NUMERIC(10, 2), 
  measure VARCHAR(5),
  height NUMERIC (30, 2),
  length NUMERIC (30, 2),
  image BYTEA, 
  href VARCHAR,
  PRIMARY KEY (product_id),
  FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

CREATE TABLE inventory (
  inventory_id INT NOT NULL UNIQUE,
  product_id INT NOT NULL,
  count INT NOT NULL,
  PRIMARY KEY (inventory_id),
  FOREIGN KEY (product_id) REFERENCES products (product_id) 
);

CREATE TABLE orders (
  order_id INT NOT NULL UNIQUE,
  user_id INT NOT NULL,
  order_date DATE NOT NULL DEFAULT CURRENT_DATE,
  traking_number VARCHAR,
  beforeTax NUMERIC(10, 2) NOT NULL , 
  tax NUMERIC(10, 2) NOT NULL, 
  total NUMERIC(10, 2) NOT NULL, 
  order_details JSONB,
  PRIMARY KEY (order_id), 
  FOREIGN KEY (user_id) REFERENCES users (user_id) 
);

/*run this to verify tables*/

\dt


/*Run This query to check all foreign keys of a table*/
/*
SELECT
    tc.table_schema, 
    tc.constraint_name, 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_schema AS foreign_table_schema,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name 
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_name='mytable';
*/
