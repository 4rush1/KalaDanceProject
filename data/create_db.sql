/* Database creation script */

drop table if exists news;
drop table if exists member;

create table member(
    member_id integer primary key autoincrement not null
    name text not null,
    email text not null unique,
    age_group text not null,
    about_me text null
)