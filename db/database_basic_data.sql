
--Create the basic roles 
INSERT INTO roles VALUES (
  nextval('roles_sequence'),
  'admin'
);
INSERT INTO roles VALUES (
  nextval('roles_sequence'),
  'client'
);

select * from roles;

--Create the basic users 
INSERT INTO users (
  user_id,
  role_id,
  first_name,
  last_name,
  email,
  password
) 
VALUES (
  nextval('users_sequence'),
  (SELECT role_id from roles where description='admin'),
  'Nefi',
  'Aguilar',
  'admin@shopimania.com',
  'password1'
);

INSERT INTO users (
  user_id,
  role_id,
  first_name,
  last_name,
  email,
  street_address,
  apt_or_unit,
  zip_code,
  country,
  state,
  city,
  password
) 
VALUES (
  nextval('users_sequence'),
  (SELECT role_id from roles where description='client'),
  'Robert',
  'Smith',
  'smithr@gmail.com',
  '50 N 700 W',
  '#56',
  '84116',
  'USA', 
  'UT',
  'Salt Lake City',
  'password2'
);

select * from users;

--Create the basic categories
INSERT INTO  categories VALUES(
  nextval('categories_sequence'),
  'men_clothing'
);

INSERT INTO  categories VALUES(
  nextval('categories_sequence'),
  'women_clothing'
);

INSERT INTO  categories VALUES(
  nextval('categories_sequence'),
  'boy_clothing'
);

INSERT INTO  categories VALUES(
  nextval('categories_sequence'),
  'girl_clothing'
);

INSERT INTO  categories VALUES(
  nextval('categories_sequence'),
  'baby_boy_clothing'
);

INSERT INTO  categories VALUES(
  nextval('categories_sequence'),
  'baby_girl_clothing'
);

select * from categories; 


--Create  basic products
INSERT INTO  products (
  product_id,
  category_id,
  product_name,
  price, 
  product_description,
  href
)
VALUES(
  nextval('products_sequence'),
  (select category_id from categories where description='men_clothing'),
  'Black V-Neck T-Shirt',
  15.99, 
  'Best quality an looks. Soft and light fabric.',
  'https://m.media-amazon.com/images/I/61L9FFm56WL._AC_UL320_.jpg'
);

INSERT INTO  inventory (
  inventory_id ,
  product_id ,
  count
)
VALUES(
  nextval('inventory_sequence'),
  currval('products_sequence'),
  5
);


INSERT INTO  products (
  product_id,
  category_id,
  product_name,
  price, 
  product_description,
  href
)
VALUES(
  nextval('products_sequence'),
  (select category_id from categories where description='men_clothing'),
  'Black V-Neck Blouse',
  15.99,
  'Best quality an looks. Soft and light fabric.', 
  'https://m.media-amazon.com/images/I/81OJAe9HhEL._AC_UL320_.jpg'
);

INSERT INTO  inventory (
  inventory_id ,
  product_id ,
  count
)
VALUES(
  nextval('inventory_sequence'),
  currval('products_sequence'),
  10
);

select  product_id, product_name, price from products;
select * from inventory;

--Create  sample orders 
INSERT INTO  orders (
  order_id,
  user_id,
  traking_number,
  beforeTax, 
  tax, 
  total, 
  order_details
)
VALUES(
  nextval('orders_sequence'),
  1002, 
  '1283yf63b4ffqwejf',
  31.98, 
  1.91, 
  33.89,
  '{
    "products":[
      {
          "product_id": 1001, 
          "product_name": "Black V-Neck T-Shirt",
          "price": 15.99,
          "quantity": 2
      }
    ], 
    "shipping_address":{
        "street": "50 N 700 W",
        "unit": "#56",
        "zipcode": "84116",
        "country": "USA", 
        "state": "UT",
        "city" : "Salt Lake City"
    }
  }'
);

select order_id, order_details from orders;
