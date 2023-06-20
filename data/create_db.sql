/* Database creation script */

drop table if exists news;
drop table if exists member;
drop table if exists classes;
drop table if exists registration;

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
    newsdate date not null,
    member_id integer not null,
    foreign key(member_id) references member(member_id)
);

create table classes(
    class_id integer primary key autoincrement,
    class_name text not null,
    class_subtitle text not null,
    class_description text not null
);

create table registration(
    member_id integer,
    class_id integer,
    foreign key(class_id) references classes (class_id),
    foreign key(member_id) references member(member_id),
    primary key (member_id, class_id)
);

/* CREATING MEMBERS */
/* Authorisation of 0 is for teachers who can made news, 1 is for student who can add comments but CANT make news */
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Usha', 'Bhatnagar', 'mj@gmail.com', 'teacher', 'Head of dance group', 'temp', 1 );
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Abby', 'Grace', 'ag@gmail.com', 'student', 'I just really want to learn about the culture, no experience yet!', 'temp', 1 );
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Nandini', 'Arora', 'nandini@gmail.com', 'teacher', 'I learn Kathak from India and came to NZ to teach', 'temp', 0 );
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Akshara', 'Goenka', 'akshu@gmail.com', 'student', 'really want to learn the Banaras Gharana', 'temp', 0 );

/* CREATING NEWS */
insert into news( title, subtitle, content, newsdate, member_id)
values( 'Diwali Dance performance',
       'Learn dance routine before the performance!',
       'Kala dance is performing for a Diwali festival in Welly, come along and watch us! ' || char(10) ||
       'For those in the group, ' ||
       'please learn the dance routine before then!',
       '2023-05-12 20:30:00', /* SQLite format */
       (select member_id from member where firstname='Akshara')
       );

insert into news( title, subtitle, content, newsdate, member_id)
values( 'Class cancelled',
       'enjoy your long weekend, but learn the tatkaar by next week',
       'Unfortunately class has been cancelled on the 5th of June as it is King Charle''s Birthday. ' ||
       'Please learn Tatkaar moves before our next class',
       '2023-06-01 22:45:00',
       (select member_id from member where firstname='Nandini')
       );

/* CREATING CLASSES */
insert into classes(class_name, class_subtitle, class_description)
values( 'Lucknow Gharana',
       'If you like acting & graceful movements, this class is for you!',
       'The Lucknow Gharana was partly developed in Indian Kingdoms as a form of entertainment. ' ||
       'Therefore it largely  focuses on storytelling, acting and emotions (known as bhaav). ' ||
       'Along with this, the hand movements are often very graceful and the footwork is complex '
       );

insert into classes(class_name, class_subtitle, class_description)
values( 'Jaipur Gharana',
       'Want to learn more powerful moves? Then learn the Jaipur Gharana!',
       'This dance form developed under the sponsorship of Rajput Warriors in ancient India,' ||
       ' therefore, it contains lots of fast spins, complex footwork, warrior-style movements and even devotional motifs.'
       );

insert into classes(class_name, class_subtitle, class_description)
values( 'Banaras Gharana',
       'This Gharana teaches many skills, from dancing on plates, to spinning on your knees.',
       'The Banaras Gharana is both graceful and powerful. If you learn this gharana, you will certainly' ||
       ' have great balance skills, due to the unique and complex moves: such as spinning in both directions,' ||
       ' balancing/dancing on metal plates, spinning on your knees and a lot more jumping! '
       );


insert into registration(member_id, class_id)
values ((select member_id from member where surname = 'Bhatnagar'),
        (select class_id from classes where class_name = 'Banaras Gharana'))