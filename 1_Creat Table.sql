CREATE TABLE regions
(
    region_id number not null,
    region_name varchar2(25) not null,
    constraint pk_regions primary key(region_id)
)

CREATE TABLE countries
(
    country_id char(2) not null,
    country_name varchar2(40) not null,
    region_id number not null,
    constraint pk_countries primary key(country_id),
    constraint fk_countries_regions foreign key(region_id) references regions(region_id)
)

CREATE TABLE locations
(
	location_id number not null,
	street_address varchar2(25) not null,
	postal_code varchar2(12) not null,
	city varchar2(30) not null,
	state_province varchar2(12) not null,
	country_id char(2),
	constraint pk_locations primary key(location_id),
	constraint fk_locations_countries foreign key(country_id) references countries(country_id)
)

CREATE TABLE departments
(
	department_id number not null,
	department_name varchar2(30) not null,
	manager_id number not null,
	location_id number not null,
	constraint pk_departments primary key(department_id),
	constraint fk_departments_locations foreign key(location_id) references locations(location_id)
)

CREATE TABLE jobs
(
	job_id varchar2(10) not null,
	job_title varchar2(35) not null,
	min_salary number not null,
	max_salary number not null,
	constraint pk_jobs primary key(job_id),
)

CREATE TABLE job_history
(
	employee_id number not null,
	start_date date not null,
	end_date date not null,
	job_id varchar2(10) not null,
	department_id number not null,
	constraint pk_job_history primary key(employee_id,start_date),
	constraint fk_job_history_departments foreign key(department_id) references departments(department_id),
	constraint fk_job_history_jobs foreign key(job_id) references jobs(job_id)
)

CREATE TABLE employees
(
	employee_id number not null,
	first_name varchar2(20) not null,
	last_name varchar2(25) not null,
	email varchar2(25) not null,
	phone_number varchar2(20) not null,
	hire_date date not null,
	job_id varchar2(10) not null,
	salary number not null,
	commission_pct number not null,
	manager_id number not null,
	department_id number not null,
	constraint pk_emlpoyees primary key(employee_id),
	constraint fk_employees_job_history foreign key(employee_id) references job_history(employee_id),
	constraint fk_employees_departments foreign key(department_id) references departments(department_id),
	constraint fk_employees_jobs foreign key(job_id) references jobs(job_id)
)

CREATE TABLE job_grades
(
	grades_level varchar2(2) not null,
	lowest_sal number not null,
	highest_sal number not null,
	constraint pk_job_grades primary key(grades_level)
)