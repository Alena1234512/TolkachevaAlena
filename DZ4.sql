create database DZ4_2;
create sequence provider_id;
create table provider
(
id int not null default nextval('provider_id') primary key,
provider varchar,
provider_address varchar
);

insert into provider (provider, provider_address)
values
('ООО Ромашка', 'г. Буржуев, ул. Пушкина д.8'),
('ООО Березка', 'г. Грехов, ул. Ломоносова д.190'),
('ООО Березка', 'г. Павлодар, ул. Ленина д.1');

create sequence type_payment_id;

create table type_payment
(
id int not null default nextval('type_payment_id') primary key,
type_playm varchar
);


insert into type_payment (type_playm)
values
('Наложенный платеж'),
('Безналичный платеж'),
('Наличный платеж');


create sequence customer_id;

create table customer (
id int not null default nextval('customer_id') primary key,
customer varchar,
customer_address varchar
);

insert into customer (customer, customer_address)
values
('ООО Рога и Копыта', 'г. Деревянный, ул. Смирнова, д.4');

create sequence product_id;

create table product
(
id int not null default nextval('product_id') primary key,
name varchar,
quantity_provider serial,
price real,
quantity_customer serial,
provider_id int references provider(id),
customer_id int references customer(id),
type_payment_id int references type_payment(id)
);

insert into product (name, quantity_provider, price, quantity_customer, 
provider_id, customer_id, type_payment_id)
values
('Зубная паста', 100, 25, 100, 1, 1, 1),
('Зубная нить', 34, 300, 34, 1, 1, 2),
('Ручки шариковые', 55, 12, 55, 1, 1, 3),
('Вода минеральная', 2, 150, 2, 2, 1, 3),
('Вода минеральная', 350, 500, 300, 3, 1, 2);
