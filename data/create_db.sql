/* Database creation script */

drop table if exists news;
drop table if exists member; 

create table member(
    member_id integer primary key autoincrement,
    firstname text not null,
    surname text not null,
    email text  not null unique,
    age_group text not null,
    about_me text,
    password text not null,
    authorisation integer not null
);

create table news(
    news_id integer primary key autoincrement,
    title text not null unique,
    subtitle text not null unique,
    content text not null unique,
    news_date date not null,
    member_id integer not null,
    foreign key(member_id) references member(member_id)
);

/* CREATING MEMBERS */
/* Authorisation of 0 is for teachers who can made news, 1 is for student who can add comments but CANT make news */
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Michael', 'Jackson', 'mj@gmail.com', 'teacher', 'I dance a lot', 'temp', 1 );
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Abby', 'Grace', 'ag@gmail.com', 'student', 'I just really want to learn about the culture, no experience yet!', 'temp', 1 );
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Nandini', 'Arora', 'nandini@gmail.com', 'teacher', 'I learn Kathak from India and came to NZ to teach', 'temp', 0 );
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Akshara', 'Goenka', 'akshu@gmail.com', 'teacher', 'Learnt the Banaras and Lucknow gharana from India', 'temp', 0 );

/* CREATING NEWS */
insert into news( title, subtitle, content, news_date, member_id)
values( 'Diwali Dance performance',
       'Learn dance routine before the performance!',
       'Kala dance is performing for a Diwali festival in Welly, come along and watch us! ' || char(10) ||
       'For those in the group, ' ||
       'please learn the dance routine before then!',
       '2023-05-12 20:30:00', /* SQLite format */
       (select member_id from member where firstname='Akshara')
       );

insert into news( title, subtitle, content, news_date, member_id)
values( 'Class cancelled',
       'enjoy your long weekend, but learn the tatkaar by next week',
       'Unfortunately class has been cancelled on the 5th of June as it is King Charle''s Birthday. ' ||
       'Please learn Tatkaar moves before our next class',
       '2023-06-01 22:45:00',
       (select member_id from member where firstname='Nandini')
       );