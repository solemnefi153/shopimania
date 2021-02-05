
-- Run this to reset the database
DROP SEQUENCE IF EXISTS roles_sequence, users_sequence, categories_sequence, products_sequence, inventory_sequence, orders_sequence;

CREATE SEQUENCE roles_sequence START 1001;
CREATE SEQUENCE users_sequence START 1001;
CREATE SEQUENCE categories_sequence START 1001;
CREATE SEQUENCE products_sequence START 1001;
CREATE SEQUENCE inventory_sequence START 1001;
CREATE SEQUENCE orders_sequence START 1001;

SELECT sequence_name, start_value FROM information_schema.sequences;




