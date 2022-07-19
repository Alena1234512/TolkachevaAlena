create database TRY_100500;

create sequence country_id;
create table country
(
id int not null default nextval('country_id') primary key, 
name varchar, 
short_code varchar
);

insert into country (name, short_code)
values
('Russia', 'RU'),
('Abkhazia', 'AB'),
('Australia', 'AU'),
('Austria', 'AT'),
('Azerbaijan', 'AZ'),
('Albania', 'AL'),
('Algeria', 'DZ'),
('Angola', 'AO'),
('Antarctica', 'AQ'),
('Armenia', 'AM');

create extension if not exists "uuid-ossp";
create table client
(
id uuid not null primary key,
first_name varchar, 
last_name varchar, 
phone varchar, 
email varchar, 
address varchar, 
create_at date, 
confirmed  boolean,
country_id int references country(id), 
balance real
);

insert into client 
values
(uuid_generate_v4(), 'Ivan', 'Ivanov', '+79602343472', 'rus@mail.ru', 'г. Москва ул. Васильева д.5', '12.04.2018', 'Yes', 2, 34.4),
(uuid_generate_v4(), 'Petr', 'Petrov', '+79603804829', 'aorkg@mail.ru', 'г. Екатеринбург ул. НОвая д.34', '18.04.2020', 'Yes', 3, 74.3 ),
(uuid_generate_v4(), 'Ann', 'Petrova', '+79607952071', 'ewtriu@mail.ru', 'г. Ростов ул. Большая д.47', '03.03.2019', 'No', 1, 37.1),
(uuid_generate_v4(), 'Elena', 'Ivanova', '+79602045083', 'rghj@mail.ru', 'г. Тамбов ул. Демидова д.38', '29.04.2020', 'Yes', 6, 53.9),
(uuid_generate_v4(), 'Kate', 'Sidorova', '+79607391963', 'ujgkh@mail.ru', 'г. Псков ул. Минская д.73', '04.05.2021', 'No', 7, 387.9),
(uuid_generate_v4(), 'Mikle', 'Politaev', '+79603856137', 'kdhik@mail.ru', 'г. Ярославль ул. Набережная д.89', '19.06.2022', 'No', 5, 29.7),
(uuid_generate_v4(), 'Oleg', 'Pirogov', '+79607391743', 'fglkldfs@mail.ru', 'г. Тверь ул. Южная д.74', '17.09.2017', 'Yes', 4, 92.8),
(uuid_generate_v4(), 'Andrey', 'Krupov', '+79607342382', 'dfkjhdfgk@mail.ru', 'г. Кострома ул. Белая д.19', '16.05.2019', 'Yes', 8, 48.9),
(uuid_generate_v4(), 'Sonya', 'Sokolova', '+79603672843', 'dfkgjhf@mail.ru', 'г. Архангельск ул. Святая д. 85', '11.03.2017', 'No', 10, 45.9),
(uuid_generate_v4(), 'Anton', 'Maksimov', '+79605192854', 'fgljfgkdfkl@mail.ru', 'г. Нижный Новгород ул. Верхняя д.37', '04.03.2018', 'No', 9, 29.9);


create sequence provider_id;

create table provider
(
id int not null default nextval('provider_id') primary key,
provider varchar,
address_provider varchar,
country_provider int references country(id)
);

insert into provider (provider, address_provider, country_provider)
values

('ООО Березка', 'г. Санкт-Петербург ул. Тверская д.14', 1),
('ООО Золушка', 'г. Вологда ул. Северная д. 38', 1),
('ООО Звонко', 'г. Таганрог ул. Кружева д. 234', 1),
('ООО Белый', 'г. Астрахань ул. Медовая д. 83', 1),
('ООО Лен', 'г. Сочи ул. Мира д. 84', 1),
('ООО Зака', 'г. Ставрополь ул. Пшеничная д. 47', 1),
('ООО Кольцо', 'г. Курган ул. Рошина д. 76', 1),
('ООО Ракушка', 'г. Новосибирск ул. Ростова д. 54', 1),
('ООО Мальты', 'г. Челябинск ул. Пушкина д. 95', 1),
('ООО Луна', 'г. Екатеринбург ул. Ленина д. 48', 1);

create sequence product_id;

create table product
(
id int not null default nextval('product_id') primary key, 
name_product varchar, 
description_product varchar, 
amount real, 
price real, 
provider_id int references provider(id)
);

insert into product (name_product, description_product, amount, price, provider_id)
values
('Processor AMD PRO A6-8580 OEM', 'it is equipped with an AM4 socket and is designed for installation in a medium-power home station or a functional computer', 34, 145, 2),
('Motherboard Esonic G41CRL3', 'designed to create home and office systems', 545, 46.12, 3),
('Video card AFOX G 210', 'additional power for computers so that they can provide graphics, video, photo processing and high performance', 365, 40, 1),
('RAM Hynix HY5PS1G831BFP-S6C 1 ГБ', 'Unbuffered DDR2 memory module, 1024 MB in size, with a frequency of 800 MHz and a bandwidth of 6400 MB/sec', 387, 10, 4),
('Power supply unit GiNZZU SA400', 'Power 400 Vt, connectors for processor power 4 pin', 263, 12.92, 5),
('Body Winard 5813', 'The power supply is located on top, the chassis provides the possibility of installing additional 80/90 cm cooling fans on the rear panel and 80/120 cm on the side panel of the housing', 3457, 20, 7),
('CPU Cooler ID-COOLING DK-01S', 'socket LGA 1156, AM3, LGA 1155, AM3+, LGA 775, AM2+, AM2, FM1, FM2, LGA 1150, FM2+, LGA 1151, AM4, LGA 1151-v2, LGA 1200', 352, 6.15, 10),
('Cooling system ID-Cooling FROSTFLOW X 120', 'guarantees an effective outflow of hot air from the processor even when the system is overclocked', 364, 60, 8),
('Fan 5Bites', '7 blades that rotate at a maximum speed of 4200 revolutions per minute, Rated voltage 12V', 213, 1.53, 6),
('Hard drive 500 Gb', 'providing high-speed access to information stored on the computer, thanks to a 32 MB cache', 632, 60, 9);

create sequence basket_id;
create table basket
(

id int not null default nextval('basket_id') primary key,
client_id uuid references client(id), 
product_id int references product(id)
);

insert into basket (client_id, product_id)
values
((select id from client where phone = '+79602343472'), 1),
((select id from client where phone = '+79603804829'), 2),
((select id from client where phone = '+79607952071'), 3),
((select id from client where phone = '+79602045083'), 4),
((select id from client where phone = '+79607391963'), 5),
((select id from client where phone = '+79603856137'), 6),
((select id from client where phone = '+79607391743'), 7),
((select id from client where phone = '+79607342382'), 8),
((select id from client where phone = '+79603672843'), 9),
((select id from client where phone = '+79605192854'), 10);

select product.id, product.name_product, product.description_product, product.amount, 
product.price, product.provider_id, 
provider.id as provider_id, provider.provider, 
provider.address_provider, provider.country_provider,
country.name, country.short_code 
from product 
right join provider on provider.id = product.provider_id
left join country on country.id = provider.country_provider;
