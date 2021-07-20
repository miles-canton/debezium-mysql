-- Create and populate our products using a single insert with many rows
CREATE TABLE "products" (
  "id" NUMBER(4) GENERATED BY DEFAULT ON NULL AS IDENTITY (START WITH 101) NOT NULL PRIMARY KEY,
  "name" VARCHAR2(255) NOT NULL,
  "description" VARCHAR2(512),
  "weight" FLOAT
);
GRANT SELECT ON "products" to dbzuser;
ALTER TABLE "products" ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO "products"
  VALUES (NULL,'scooter','Small 2-wheel scooter',3.14);
INSERT INTO "products"
  VALUES (NULL,'car battery','12V car battery',8.1);
INSERT INTO "products"
  VALUES (NULL,'12-pack drill bits','12-pack of drill bits with sizes ranging from #40 to #3',0.8);
INSERT INTO "products"
  VALUES (NULL,'hammer','12oz carpenter''s hammer',0.75);
INSERT INTO "products"
  VALUES (NULL,'hammer','14oz carpenter''s hammer',0.875);
INSERT INTO "products"
  VALUES (NULL,'hammer','16oz carpenter''s hammer',1.0);
INSERT INTO "products"
  VALUES (NULL,'rocks','box of assorted rocks',5.3);
INSERT INTO "products"
  VALUES (NULL,'jacket','water resistent black wind breaker',0.1);
INSERT INTO "products"
  VALUES (NULL,'spare tire','24 inch spare tire',22.2);

-- Create and populate the products on hand using multiple inserts
CREATE TABLE "products_on_hand" (
  "product_id" NUMBER(4) NOT NULL PRIMARY KEY,
  "quantity" NUMBER(4) NOT NULL,
  FOREIGN KEY ("product_id") REFERENCES "products"("id")
);
GRANT SELECT ON "products_on_hand" to dbzuser;
ALTER TABLE "products_on_hand" ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO "products_on_hand" VALUES (101,3);
INSERT INTO "products_on_hand" VALUES (102,8);
INSERT INTO "products_on_hand" VALUES (103,18);
INSERT INTO "products_on_hand" VALUES (104,4);
INSERT INTO "products_on_hand" VALUES (105,5);
INSERT INTO "products_on_hand" VALUES (106,0);
INSERT INTO "products_on_hand" VALUES (107,44);
INSERT INTO "products_on_hand" VALUES (108,2);
INSERT INTO "products_on_hand" VALUES (109,5);

-- Create some customers ...
CREATE TABLE "customers" (
  "id" NUMBER(4) GENERATED BY DEFAULT ON NULL AS IDENTITY (START WITH 1001) NOT NULL PRIMARY KEY,
  "first_name" VARCHAR2(255) NOT NULL,
  "last_name" VARCHAR2(255) NOT NULL,
  "email" VARCHAR2(255) NOT NULL UNIQUE
);
GRANT SELECT ON "customers" to dbzuser;
ALTER TABLE "customers" ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO "customers"
  VALUES (NULL,'Sally','Thomas','sally.thomas@acme.com');
INSERT INTO "customers"
  VALUES (NULL,'George','Bailey','gbailey@foobar.com');
INSERT INTO "customers"
  VALUES (NULL,'Edward','Walker','ed@walker.com');
INSERT INTO "customers"
  VALUES (NULL,'Anne','Kretchmar','annek@noanswer.org');

-- Create some very simple orders
CREATE TABLE debezium."orders" (
  "id" NUMBER(6) GENERATED BY DEFAULT ON NULL AS IDENTITY (START WITH 10001) NOT NULL PRIMARY KEY,
  "order_date" DATE NOT NULL,
  "purchaser" NUMBER(4) NOT NULL,
  "quantity" NUMBER(4) NOT NULL,
  "product_id" NUMBER(4) NOT NULL,
  FOREIGN KEY ("purchaser") REFERENCES "customers"("id"),
  FOREIGN KEY ("product_id") REFERENCES "products"("id")
);
GRANT SELECT ON "orders" to dbzuser;
ALTER TABLE "orders" ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO "orders"
  VALUES (NULL, '16-JAN-2016', 1001, 1, 102);
INSERT INTO orders
  VALUES (NULL, '17-JAN-2016', 1002, 2, 105);
INSERT INTO orders
  VALUES (NULL, '19-FEB-2016', 1002, 2, 106);
INSERT INTO orders
  VALUES (NULL, '21-FEB-2016', 1003, 1, 107);
