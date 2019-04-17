CREATE TABLE category (
    category_id     INTEGER NOT NULL,
    category_desc   VARCHAR2(50 CHAR)
);

ALTER TABLE category ADD CONSTRAINT category_pk PRIMARY KEY ( category_id );

CREATE TABLE customer (
    fname      VARCHAR2(30 CHAR) NOT NULL,
    minitial   VARCHAR2(1 CHAR),
    lname      VARCHAR2(30 CHAR) NOT NULL,
    cid        INTEGER NOT NULL,
    caddress   VARCHAR2(50 CHAR) NOT NULL,
    gender     CHAR(1 CHAR) NOT NULL,
    dob        DATE NOT NULL,
    user_id    VARCHAR2(30 CHAR) NOT NULL,
    password   VARCHAR2(15 CHAR) NOT NULL,
    cphone     NUMBER(10),
    email      VARCHAR2(30 CHAR)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cid );

CREATE TABLE department (
    dept_id         INTEGER NOT NULL,
    dept_name       VARCHAR2(30 CHAR) NOT NULL,
    dept_location   VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( dept_id );

CREATE TABLE dependent (
    dependent_id         INTEGER NOT NULL,
    dependent_name       VARCHAR2(30 CHAR) NOT NULL,
    dependent_sex        VARCHAR2(1 CHAR) NOT NULL,
    dependent_relation   VARCHAR2(40 CHAR) NOT NULL,
    employee_eid         INTEGER,
    employee_ssn         NUMBER(10)
);

ALTER TABLE dependent ADD CONSTRAINT dependent_pk PRIMARY KEY ( dependent_id );

CREATE TABLE employee (
    eid                  INTEGER NOT NULL,
    ename                VARCHAR2(30 CHAR) NOT NULL,
    eaddress             VARCHAR2(50 CHAR) NOT NULL,
    ephone               NUMBER(10) NOT NULL,
    email                VARCHAR2(50 CHAR),
    hire_date            DATE,
    ssn                  NUMBER(10) NOT NULL,
    dob                  DATE,
    department_dept_id   INTEGER,
    salary_salary_id     INTEGER NOT NULL
);

CREATE UNIQUE INDEX employee__idx ON
    employee ( salary_salary_id ASC );

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( eid,
ssn );

CREATE TABLE managed_by (
    category_category_id   INTEGER NOT NULL,
    employee_eid           INTEGER NOT NULL,
    employee_ssn           NUMBER(10) NOT NULL,
    category_id            NUMBER(5,5) NOT NULL,
    ssn                    NUMBER(10,10) NOT NULL,
    eid                    NUMBER(5,5) NOT NULL
);

ALTER TABLE managed_by
    ADD CONSTRAINT managed_by_pk PRIMARY KEY ( category_category_id,
    employee_eid,
    employee_ssn );

CREATE TABLE "ORDER" (
    order_id               INTEGER NOT NULL,
    order_description      VARCHAR2(50 CHAR) NOT NULL,
    order_date             DATE NOT NULL,
    product_id              NUMBER,
);

ALTER TABLE "ORDER" ADD CONSTRAINT order_pk PRIMARY KEY ( order_id );

CREATE TABLE payment (
    payment_id       INTEGER NOT NULL,
    payment_type     VARCHAR2(10 CHAR) NOT NULL,
    order_id         INTEGER NOT NULL,
    amount           INTEGER NOT NULL,
    payment_date     DATE,
    order_order_id   INTEGER NOT NULL,
    customer_cid     INTEGER NOT NULL
);

CREATE UNIQUE INDEX payment__idx ON
    payment ( order_order_id ASC );

CREATE UNIQUE INDEX payment__idxv1 ON
    payment ( customer_cid ASC );

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_id );

CREATE TABLE product (
    product_id             INTEGER NOT NULL,
    product_name           VARCHAR2(50 CHAR),
    product_price          INTEGER NOT NULL,
    category_id            INTEGER,
    supplier_supplier_id   INTEGER NOT NULL,
    order_order_id         INTEGER NOT NULL,
    category_category_id   INTEGER NOT NULL,
    customer_cid           INTEGER
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( category_category_id,
product_id );

CREATE TABLE salary (
    salary_date    DATE NOT NULL,
    salary_id      INTEGER NOT NULL,
    amount         INTEGER NOT NULL,
    employee_eid   INTEGER NOT NULL,
    employee_ssn   NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX salary__idx ON
    salary ( employee_eid ASC,
    employee_ssn ASC );

ALTER TABLE salary ADD CONSTRAINT salary_pk PRIMARY KEY ( salary_id );

CREATE TABLE shipment (
    shipment_id        INTEGER NOT NULL,
    shipping_date      DATE,
    expected_arrival   DATE,
    carrier            VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE shipment ADD CONSTRAINT shipment_pk PRIMARY KEY ( shipment_id );

CREATE TABLE supplier (
    supplier_id      INTEGER NOT NULL,
    supplier_name    VARCHAR2(30 CHAR) NOT NULL,
    supplier_phone   NUMBER(10)
);

ALTER TABLE supplier ADD CONSTRAINT supplier_pk PRIMARY KEY ( supplier_id );

ALTER TABLE dependent
    ADD CONSTRAINT dependent_employee_fk FOREIGN KEY ( employee_eid )
        REFERENCES employee ( eid );

ALTER TABLE employee
    ADD CONSTRAINT employee_department_fk FOREIGN KEY ( department_dept_id )
        REFERENCES department ( dept_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_salary_fk FOREIGN KEY ( salary_salary_id )
        REFERENCES salary ( salary_id );

ALTER TABLE orders
    ADD CONSTRAINT order_product_fk FOREIGN KEY ( product_product_id )
        REFERENCES product ( product_id );

ALTER TABLE orders
    ADD CONSTRAINT order_customer_fk FOREIGN KEY ( customer_customer_id )
        REFERENCES customer ( cid );

ALTER TABLE payment
    ADD CONSTRAINT payment_customer_fk FOREIGN KEY ( customer_cid )
        REFERENCES customer ( cid );

ALTER TABLE payment
    ADD CONSTRAINT payment_order_fk FOREIGN KEY ( order_order_id )
        REFERENCES "ORDER" ( order_id );

ALTER TABLE product
    ADD CONSTRAINT product_category_fk FOREIGN KEY ( category_category_id )
        REFERENCES category ( category_id );

ALTER TABLE product
    ADD CONSTRAINT product_customer_fk FOREIGN KEY ( customer_cid )
        REFERENCES customer ( cid );

ALTER TABLE product
    ADD CONSTRAINT product_order_fk FOREIGN KEY ( order_order_id )
        REFERENCES "ORDER" ( order_id );

ALTER TABLE product
    ADD CONSTRAINT product_supplier_fk FOREIGN KEY ( supplier_supplier_id )
        REFERENCES supplier ( supplier_id );

ALTER TABLE salary
    ADD CONSTRAINT salary_employee_fk FOREIGN KEY ( employee_eid,
    employee_ssn )
        REFERENCES employee ( eid,
        ssn );