create database movies;
use movies;

create table movie(movie_id varchar(20) primary key, title varchar(255), budget int, homepage text, overview text, 
					popularity varchar(255),  release_date date, revenue int, runtime varchar(40), movie_status varchar(255),
                    tagline varchar(255), votes_avg smallint, votes_count smallint);
                    
create table country(country_id varchar(20) primary key, country_iso_code varchar(10), country_name varchar(60));

create table production_country(movie_id varchar(20), country_id varchar(20),
						Foreign key (movie_id) references movie(movie_id),
								Foreign key (country_id) references country(country_id));

create table language(language_id varchar(20) primary key, language_code varchar(10), language_name varchar(60));
create table language_role(role_id varchar(20) primary key, language_role varchar(10));

create table movie_laguages(movie_id varchar(20), language_role_id varchar(20), language_id varchar(20) ,
							Foreign key (movie_id) references movie(movie_id),
							Foreign key (language_role_id) references language_role(role_id),
								Foreign key (language_id) references language(language_id));


    
        
create table genre(genre_id varchar(25) primary key, genre_name varchar(255));
create table movie_genre(movie_id varchar(20), genre_id varchar(25),
						Foreign key (movie_id) references movie(movie_id),
								Foreign key (genre_id) references genre(genre_id));
                                
create table keyword(keyword_id varchar(25) primary key, keyword_name varchar(255));
create table movie_keyword(movie_id varchar(20), keyword_id varchar(25), 
							Foreign key (movie_id) references movie(movie_id),
								Foreign key (keyword_id) references keyword(keyword_id));
                                
                                
create table production_company(company_id varchar(20) primary key, company_name varchar(255));
create table movie_company(movie_id varchar(20), company_id varchar(20),
							Foreign key (movie_id) references movie(movie_id),
								Foreign key (company_id) references production_company(company_id));

create table gender(gender_id varchar(5) primary key, gender_name varchar(10));

create table person(person_id varchar(5) primary key, person_name varchar(255));


create table movie_cast(movie_id varchar(20), person_id varchar(5), gender_id varchar(5),
						Foreign key (movie_id) references movie(movie_id),
						Foreign key (person_id) references person(person_id),
								Foreign key (gender_id) references gender(gender_id),
                                character_name varchar(255), cast_order varchar(255));

create table department(department_id varchar(10) primary key, department_name varchar(255));


create table movie_crew(movie_id varchar(20), department_id varchar(10), person_id varchar(5),  job varchar(255),
						Foreign key (movie_id) references movie(movie_id),
							Foreign key (person_id) references person(person_id),
							Foreign key (department_id) references department(department_id));                               
                                
                                
                                
                                