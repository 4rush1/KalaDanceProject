/* Database creation script */

drop table if exists news;
drop table if exists member;
drop table if exists classes;
drop table if exists registration;
drop table if exists glossary;

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
    class_title text not null unique,
    class_subtitle text not null unique,
    class_description text not null unique
);

create table registration(
    member_id integer,
    class_id integer,
    foreign key(class_id) references classes (class_id),
    foreign key(member_id) references member(member_id),
    primary key (member_id, class_id)
);

create table glossary(
    word_id integer primary key autoincrement,
    word text not null unique,
    pronunciation text not null unique,
    meaning text not null unique
);

/* CREATING MEMBERS */
/* Authorisation of 0 is for teachers who can made news, 1 is for students */
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Usha', 'Bhatnagar', 'mj@gmail.com', 'teacher', 'Head of dance group', 'temp', 0
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Abhi', 'Rathod', 'ab@gmail.com', 'teacher', 'Have learnt the Banaras Gharana', 'temp', 0
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Aditya', 'Chopra', 'ac@gmail.com', 'teacher', 'Have learnt the Jaipur Gharana in India', 'temp', 0
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Amrita', 'Rao', 'amri@gmail.com', 'junior student', 'Have learnt the Jaipur, Lucknow and Banaras gharana!', 'temp', 1
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Nandini', 'Arora', 'nandini@gmail.com', 'junior student', 'I want to learn the Banaras Gharana', 'temp', 1
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Rahul', 'Anand', 'ag@gmail.com', 'junior student', 'I just really want to learn about the culture, no experience yet!', 'temp', 1
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Akshara', 'Goenka', 'akshu@gmail.com', 'senior student', 'really want to learn the Banaras Gharana', 'temp', 1
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Anjali', 'Raichand', 'anjali@gmail.com', 'senior student', 'I would love to learn the Jaipur gharana', 'temp', 1
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Tina', 'Jones', 'tina.b@gmail.com', 'senior student', 'I would love to learn the Jaipur gharana', 'temp', 1
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Arjun', 'Srivastav', 'arjun.s@gmail.com', 'senior student', 'Have learnt a bit of the Lucknow gharana, just want to learn more!', 'temp', 1
);
insert into member( firstname, surname, email, age_group, about_me, password, authorisation)
values( 'Aakriti', 'Mathur', 'aakriti.s@gmail.com', 'senior student', 'Have learnt the banaras gharana to an intermediate level', 'temp', 1
);

/* CREATING NEWS */
insert into news( title, subtitle, content, newsdate, member_id)
values( 'Diwali Dance performance',
       'Learn dance routine before the performance!',
       'Kala dance is performing for a Diwali festival in Welly, come along and watch us! ' || char(10) ||
       'For those in the group, please learn the dance routine before then!',
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
insert into classes(class_title, class_subtitle, class_description)
values( 'Lucknow Gharana',
       'If you like acting & graceful movements, this class is for you!',
       'The Lucknow Gharana was partly developed in Indian Kingdoms as a form of entertainment. ' ||
       'Therefore it largely  focuses on storytelling, acting and emotions (known as bhaav). ' ||
       'Along with this, the hand movements are often very graceful and the footwork is complex '
       );

insert into classes(class_title, class_subtitle, class_description)
values( 'Jaipur Gharana',
       'Want to learn more powerful moves? Then learn the Jaipur Gharana!',
       'This dance form developed under the sponsorship of Rajput Warriors in ancient India,' ||
       ' therefore, it contains lots of fast spins, complex footwork and even warrior-style movements'
       );

insert into classes(class_title, class_subtitle, class_description)
values( 'Banaras Gharana',
       'This Gharana teaches many skills, from dancing on plates, to spinning on your knees.',
       'The Banaras Gharana is both graceful and powerful. If you learn this gharana, you will certainly' ||
       ' have great balance skills, due to the unique and complex moves: such as spinning in both directions,' ||
       ' balancing/dancing on metal plates, spinning on your knees and a lot more jumping! '
       );

insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Usha'),
        (select class_id from classes where class_title = 'Lucknow Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Usha'),
        (select class_id from classes where class_title = 'Jaipur Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Abhi'),
        (select class_id from classes where class_title = 'Banaras Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Aditya'),
        (select class_id from classes where class_title = 'Jaipur Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Amrita'),
        (select class_id from classes where class_title = 'Banaras Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Amrita'),
        (select class_id from classes where class_title = 'Jaipur Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Amrita'),
        (select class_id from classes where class_title = 'Lucknow Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Nandini'),
        (select class_id from classes where class_title = 'Lucknow Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Rahul'),
        (select class_id from classes where class_title = 'Banaras Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Akshara'),
        (select class_id from classes where class_title = 'Banaras Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Anjali'),
        (select class_id from classes where class_title = 'Jaipur Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Tina'),
        (select class_id from classes where class_title = 'Jaipur Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Arjun'),
        (select class_id from classes where class_title = 'Lucknow Gharana')
        );
insert into registration(member_id, class_id)
values ((select member_id from member where firstname = 'Aakriti'),
        (select class_id from classes where class_title = 'Lucknow Gharana')
        );

/* CREATING GLOSSARY */
insert into glossary(word, meaning, pronunciation)
values('Guru', 'teacher',
       'gu-roo: ''u'' = the ''u'' in ''argUe'', ''oo'' is a longer vowel, the ''r'' is rolled'
       );

insert into glossary(word, meaning, pronunciation)
values('Pandit', 'someone who is very knowledgeable in a certain area',
       'pun-di-t: u = the ''u'' in ''pUn'',' ||
       ' ''d'' = a soft ''d'' which is pronounced by tapping your tongue at the tip of your teeth,' ||
       ' t = a sharp ''t'' pronounced by tapping the tip of your tongue against the top of your mouth'
       );

insert into glossary(word, meaning, pronunciation)
values('Kala',  'means art',
       'ku-laa: u = the ''u'' in ''Under'', ' ||
       'laa = the ''laa'' in ''do re me'''
       );

insert into glossary(word, meaning, pronunciation)
values('Tatkaar',  'the basis of all footwork, you tap your feet in the pattern ' ||
        'right, left, right, left, left, right, left, right, right… and so on ',
       'tut-caar: both t''s = a hard t pronounced similar to a d, u = the ''u'' in ''Under'', ' ||
       'caar = similar to the word ''car'' with a longer vowel and rolled ''r'''
       );

insert into glossary(word, meaning, pronunciation)
values('Tukda', 'pre-set footwork and hand movements',
       'took-daa: took = the English word with a sharp ''t'', ' ||
       ' daa = the ''d'' is mixed with an ''r'' by sliding your' ||
       ' tongue from the back of your mouth and hitting it against ' ||
       'the top of your mouth (just before your teeth), not on your teeth'
       );

insert into glossary(word, meaning, pronunciation)
values('Chakkar', 'to spin',
       'chuck-kur: chuck = pronounced like the English word with a sharper ''ch'', ' ||
       'kur = the ''u'' in ''Under'' with rolled ''r'''
       );

insert into glossary(word, meaning, pronunciation)
values('Chakkardaar tukda', 'pre-set footwork and hand movements which are repeated 3 times',
       'chuck-kur-DAAR took-daa: the same as the last word ''chakkar'' except with a ''daar'' ' ||
       'at the end, and the same as the word ''tukda''. daar = a soft ''d'' with a rolled ''r'''
       );

insert into glossary(word, meaning, pronunciation)
values('Hastak', 'hand positions for dance, each hand position represents something',
       'huss-tuck: huss = say ''fuss'' with an ''h'', tuck = the english word with a hard ''t'', similar to a d'
       );

insert into glossary(word, meaning, pronunciation)
values('Gharana', 'a slight variation in dance style, originating from different regions',
       'gh-u-raa-naa: gh = say the ''g'' and ''h'' at the same time, u = the ''u'' in ''Under'', ' ||
       'raa = like the exclamation ''aah'' with a rolled ''r'' at the start, naa = like the informal slang ''nah'''
       );

insert into glossary(word, meaning, pronunciation)
values('Ghungroo', 'the bells we tied to our feet so that the footwork is heard',
       'gh-oon-groo: gh = say the ''g'' and ''h'' at the same time, oon = a very ' ||
       'nasal ''ooh'', groo = like the word ''groom'' without the ''m'' and with a rolled ''r'''
       );

insert into glossary(word, meaning, pronunciation)
values('Natya Shastra', 'an ancient book about dance written around 200 BCE to  200 CE',
       'naa-t-yuh shaa-str-uh : naa = like the informal slang ''nah'', t = a sharp ''t'', ' ||
       'yuh = like the informal slang for ''yes'' (Ariana Grande uses this word a lot during performances), ' ||
       'shaa = like the exclamation ''aah'' with a ''sh'' in front, str = like ''STRing'' with a hard ''t'' and rolled ''r'', ' ||
       'uh = the ''u'' in ''under'''
       );