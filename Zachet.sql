create database movies2;

create extension if not exists "uuid-ossp";

create table personal_account
(
id uuid not null primary key,
first_name varchar,
last_name varchar,
phone varchar,
email varchar
);

insert into personal_account
values
(uuid_generate_v4(), 'Ivan', 'Ivanov', '+79602343472', 'rus@mail.ru'),
(uuid_generate_v4(), 'Petr', 'Petrov', '+79603804829', 'aorkg@mail.ru'),
(uuid_generate_v4(), 'Ann', 'Petrova', '+79607952071', 'ewtriu@mail.ru'),
(uuid_generate_v4(), 'Elena', 'Ivanova', '+79602045083', 'rghj@mail.ru'),
(uuid_generate_v4(), 'Kate', 'Sidorova', '+79607391963', 'ujgkh@mail.ru');

create table film
(
id uuid not null primary key,
title varchar, 
length time, 
release date, 
description text,
reviews_audience text,
reviews_audience_id uuid references personal_account(id)
);

insert into film 
values
(uuid_generate_v4(), 'The Reef: Stalked', '01:32', '14.07.2022', 'Niki and her friends go to an exotic
island in the Pacific Ocean to go kayaking and diving. But the girls are being chased
by a huge sea monster, and now they will have to face their fears face to face', 'Every year, many similar stories are filmed in the world, but it is
 The Open Sea: The Monster of the Deep that is distinguished by a really intriguing plot, high-quality 
filming and absolute unpredictability', (select id from personal_account where phone = '+79602343472')),
(uuid_generate_v4(), 'Doctor Strange in the Multiverse of Madness', '02:06', '02.05.2022', 'Doctor Strange, with the help of 
Wong, saves a teenage girl named America Chavez from a giant octopus, who, with a strong fright, can open
portals to parallel universes. Trying to protect a new acquaintance from an evil force eager to get her 
ability, the Doctor, along with America, embarks on a journey through the multiverse', 'Bright, dynamic, lots of special effects', (select id from personal_account where phone = '+79603804829')),
(uuid_generate_v4(), 'One', '01:48', '9.06.2022', 'Newlyweds Larisa and Vladimir Savitsky stepped on board the plane following the 
Komsomolsk-on-Amur — Blagoveshchensk flight. The plane collided with another plane and fell to pieces. No one 
should have survived, but a miracle happened — Larisa woke up in the middle of the wreckage of the plane in 
an impassable taiga', 'The story shown in the film bears little resemblance to reality, but it seems to me that you can forgive the director for 
this little impudence, because the whole film keeps you in suspense, makes you nervous', (select id from personal_account where phone = '+79607952071')),
(uuid_generate_v4(), 'Paws of Fury: The Legend of Hank', '01:38', '21.07.2022', 'Hank is a brave dog who dreams of becoming a 
samurai, but no one takes him seriously in the city of cats. But when an army of furry ninjas threatens 
to wipe their town off the face of the Earth, Hank becomes the only hope for salvation. Now he must master 
the skills of a great warrior in a short time. This is the only way he will have a chance to win', 'A normal cartoon that children are likely to like, 
and adults will smile several times. However, it is not possible to take out something important after viewing 
the tape', (select id from personal_account where phone = '+79602045083')),
(uuid_generate_v4(), 'Bread', '01:35', '7.07.2022', 'Tanya Babanina from Protvino near Moscow masterfully bakes and dreams of her 
cafe. But to fulfill a dream, they say, you need to get out of your comfort zone. And Tanya goes out on an 
international scale, having found crazy adventures for her buns. One in Sri Lanka. Without money, documents 
and a husband who cheated on her right after the wedding. But with a hangover, in a winter coat and ... 
under the same roof with three guys who are not happy with her at all', 'A cool comedy that instantly lifts the mood', (select id from personal_account where phone = '+79607391963'));

create sequence actor_id;
create table actor
(
id int not null default nextval('actor_id') primary key,
first_name varchar, 
last_name varchar 
);

insert into actor (first_name, last_name)
values
('Teressa', 'Lien'),
('Benedict', 'Cumberbatch'),
('Nadezhda', 'Kaleganova'),
('Michael', 'Cera'),
('Kristina', 'Asmus');


create sequence directory_id;

create table directory
(
id int not null default nextval('directory_id') primary key,
title_id uuid references film(id), 
genre varchar, 
actor_id int references actor(id), 
producer varchar,
rating real,
country varchar
);


insert into directory (title_id, genre, actor_id, producer, rating, country)
values

((select id from film where title = 'The Reef: Stalked'), 'horrors', 1, 'John Christian', 4.3, 'Australia'),
((select id from film where title = 'Doctor Strange in the Multiverse of Madness'), 'fantastic', 2, 'Victoria Alonso', 6.6, 'USA'),
((select id from film where title = 'One'), 'drama', 3, 'Andrey Lyakhov', 7.0, 'Russia'),
((select id from film where title = 'Paws of Fury: The Legend of Hank'), 'cartoon', 4, 'Yair Landau', 0, 'Great Britain'),
((select id from film where title = 'Bread'), 'comedy', 5, 'Oleg Asadulin', 5.6, 'Russia');


create sequence cinema_id;

create table cinema
(
id uuid not null primary key,
title_id uuid references film(id), 
name_cinema varchar,
date_session date,
time_session time
);

insert into cinema
values
(uuid_generate_v4(), (select id from film where title = 'The Reef: Stalked'), 'А113', '21.07.2022', '12:40'),
(uuid_generate_v4(), (select id from film where title = 'Doctor Strange in the Multiverse of Madness'), 'А113', '21.07.2022', '12:20'),
(uuid_generate_v4(), (select id from film where title = 'One'), 'А113', '21.07.2022', '13:00'),
(uuid_generate_v4(), (select id from film where title = 'Paws of Fury: The Legend of Hank'), 'Europe Cinema', '21.07.2022', '13:55'),
(uuid_generate_v4(), (select id from film where title = 'Bread'), 'Lodz', '21.07.2022', '16:50');



create sequence subscription_id;

create table subscription
(
id int not null default nextval('subscription_id') primary key,
user_id uuid references personal_account(id), 
title_id uuid references film(id),
confirmed boolean,
subscription_period serial,
payment boolean
);


insert into subscription (user_id, title_id, confirmed, subscription_period, payment)
values
((select id from personal_account where phone = '+79602343472'), (select id from film where title = 'The Reef: Stalked'), 'Yes', 30, 'No'),
((select id from personal_account where phone = '+79603804829'), (select id from film where title = 'Doctor Strange in the Multiverse of Madness'), 'Yes', 365, 'Yes'),
((select id from personal_account where phone = '+79607952071'), (select id from film where title = 'One'), 'No', 30, 'No'),
((select id from personal_account where phone = '+79602045083'), (select id from film where title = 'Paws of Fury: The Legend of Hank'), 'Yes', 365, 'Yes'),
((select id from personal_account where phone = '+79607391963'), (select id from film where title = 'Bread'), 'No', 30, 'No');

select * from subscription;

create sequence news_id;

create table news
(
id int not null default nextval('news_id') primary key,
trailer_id uuid references film(id),
name_news varchar, 
description_news text,
comments_news text,
comments_news_id uuid references film(id),
comments_user_id uuid references personal_account(id)
);

insert into news (trailer_id, name_news, description_news, comments_news, comments_news_id, comments_user_id)
values
((select id from film where title = 'The Reef: Stalked'), 'A shark hunts a group of girls in the trailer for the thriller 
"Open Sea: Monster of the Deep"', 'Capella Film has unveiled the trailer for the Australian survival thriller "The High 
Seas: Monster of the Deep," which is a sequel to the 2010 film "The High Seas: New Victims."', 'It cannot be said that 
"The Open Sea: The Monster of the Deep" is a breakthrough in zoohorrors or a new word in a series of shark horror stories. 
But it is nice to look at something realistic, simple and frightening. The very thing for the viewer tired of intricate blockbusters', (select id from film where title = 'The Reef: Stalked'), (select id from personal_account where phone = '+79602343472')),
((select id from film where title = 'Doctor Strange in the Multiverse of Madness'), 'The 5 Scariest Scenes in Doctor Strange 2: How 
Marvel Got a Bloody Horror', '5th place: The murder of America Chavez is parents, 4th place: The destruction of Kamar-Taj, 
3rd place: The brutal massacre of the Illuminati, 2nd place: The Final of Wanda, 1st place: The revived corpse of Strange', 'The film 
turned out to be weak, as in the proverb - The mountain gave birth to a mouse. Compared to the same last spider, it is very sluggish
and uninteresting', (select id from film where title = 'Doctor Strange in the Multiverse of Madness'), (select id from personal_account where phone = '+79603804829')),
((select id from film where title = 'One'), 'What is happening at the box office: the records of "One" in Russia and "Top Ghana" in 
the world', 'In Russia over the past two weeks, the leader of the box office has remained unchanged - the thriller "Odin". Dmitry Suvorov is 
painting earned 174 million over three weekends. This is an unprecedented result for a Russian release at the July box office', 'This movie 
is something I want to watch more and more, I liked it very much, and it is quite interesting',(select id from film where title = 'One'), (select id from personal_account where phone = '+79607952071')),
((select id from film where title = 'Paws of Fury: The Legend of Hank'), 'Two trailers of the cartoon "Paws of Fury: The Legend of Hank" have 
been released', 'Paramount Studio and Nickelodeon TV channel presented two trailers of an animated comedy film at once, work on which has been 
carried out over the past decade. The videos make it clear that the audience is waiting for an entertaining cartoon in the Japanese entourage 
with a lot of references to famous films', 'The influence of Quentin Tarantino is "Kill Bill" is felt, and in one of the trailers there is a 
joke referring to the famous moment from "Star Wars". Comparisons with the "Kung Fu Panda" also suggest themselves', (select id from film where title = 'Paws of Fury: The Legend of Hank'), (select id from personal_account where phone = '+79602045083')),
((select id from film where title = 'Bread'), 'What is happening at the box office: the Russian audience is tired of comedies', 'In July, 
the fees of Russian cinemas continued to decline: revenue for the last two weekends did not even reach 150 million rubles. The reason is 
the lack of new products designed for the widest possible audience', 'The trouble is in the Russian producer cinema, which in fact is not a 
producer cinema, but a bureaucratic one.  Decisions are made by people far from creativity, trying to calculate success - instead of trying 
to make a movie at a decent artistic level, but for current producers these are already forgotten concepts', (select id from film where title = 'Bread'), (select id from personal_account where phone = '+79607391963'));

select directory.id, directory.title_id, directory.genre, directory.actor_id, directory.producer, 
directory.rating, directory.country,
film.id as title_id, film.title, film.length, film.release, 
film.description, film.reviews_audience, film.reviews_audience_id,
personal_account.id as reviews_audience_id, personal_account.first_name, personal_account.last_name,
personal_account.phone, personal_account.email
from directory
right join film on directory.title_id = film.id
left join personal_account on film.reviews_audience_id = personal_account.id;
