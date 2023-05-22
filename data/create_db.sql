/* Database creation script */

drop table if exists news;
drop table if exists member; 

create table member(
    member_id integer primary key autoincrement,
    name text not null,
    email text  not null unique,
    age_group text not null,
    about_me text
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