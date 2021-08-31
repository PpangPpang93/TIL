## summary
-- datatype : int, float, double, char, varchar, text, datetime, timestamp
-- constraint : not null, unique, primary key, auto_increment, foreign key
-- foreign key : 데이터 무결성을 지키이 위한 키 : on update, on delete
-- DDL : CREATE, ALTER, DROP : 데이터베이스 테이블을 생성,수정하는 것
-- DML : CRUD : CREATE(INSERT), READ(SELECT), UPDATE(UPDATE), DELETE(DELETE) : 데이터를 수정하는 것
-- Function : ceil, round, truncate, date_format, concat, count
-- if, ifnull, case when then
-- Group by, Having

# DATATYPE / 테이블 연습
use ssac;

## 정수형
create table number1(data tinyint);
show tables;	## ssac의 테이블 확인
desc number1;	## Type : tinyint
insert into number1 value(128);	-- int의 범위를 벗어남 (-128~127), Unsigned(양수)로 해줘야 출력이 가능
insert into number1 value(127);	
select * from number1;

create table number2(data tinyint unsigned);
desc number2;
insert into number2 value(128);	-- Unsinged 범위에 해당(0~255) 단, 음수는 불가능
select * from number2;

## 실수형
create table number3(data float);
create table number4(data double);
insert into number3 value(123.456789);	-- float : 정수+소수부분해서 6자리 (123.456까지만 읽음)
insert into number4 value(123.4567890123456789); -- double : 정수+소수부분해서 17자리
select * from number3;
select * from number4;
### DECIMAL (소수점 자리수 설정) / DECIMAL(5,2) 5자리수를 소수점 2자리로 설정

## 문자열
### Varchar/char : varchar은 가변길이(65525자), char은 고정길이(255자)
### TEXT : 긴 문자열을 저장할때 사용

## DATE / TIME
### DATE : 년/월/일
### DATETIME : 년/월/일/시/분/초
### TIMESTAMP : 날짜와 시간을 저장하는 데이터 타입, DATETIME과 다른점은 날짜를 입력하지 않으면 현재 날짜와 시간을 자동으로 저장할수 있는 특징이 있음
### TIME : 시/분/초
### YEAR : 연도 지정 2자리/4자리

## 제약조건(Constraint)
### NOT NULL : 비어있는 값을 저장할 수 없음 / not null 부분은 값을 필수로 입력해야함
### UNIQUE : 값은 값 지정할 수 없음
### PRIMARY KEY : not null과 unique 둘 다 만족하는 값
### FOREIGN KEY : 다른 테이블과 연결되는 값이 저장됨
### DEFAULT : 별도 저장값이 없으면 default에 지정한 값이 저장됨
### AUOT_INREMENT : PRIMARY KEY 데이터를 저장할때 자동으로 숫자를 1씩 증가시켜 주는 기능

# DDL(데이터 변경)
## DDL : CREATE(생성) / database, table
CREATE database test;	-- 데이터베이스 생성
show databases;
use ssac;
CREATE table user1(
	user_id INT,
    name VARCHAR(20),
    email VARCHAR(30),
    age INT,
    rdate date		-- 기본 구성요소 설정
);
show tables;
desc user1;	-- 테이블 타입 확인

### 제약조건 설정
CREATE table user2(
	user_id INT PRIMARY KEY AUTO_INCREMENT,	-- null이 아니면서 unique한 값으로 설정 + 자동으로 번호를 1씩 늘려주는 increment 도 같이 설정 
    name VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL UNIQUE,	-- 보통은 테이블에 primary key는 테이블에 한개만 설정
    age INT default 30,		-- 미입력시 30으로 자동으로 기입됨
    rdate timestamp		-- 기본 구성요소 설정
);
desc user2;

## DDL : ALTER(수정) incoding 수정
### 인코딩
-- 사람이 입력한 숫자를 2진수로 변환해주는 것 / 반대의 개념 : 디코딩
-- 인코딩 방식 1. ascii : ex) a -> 0001	/ 4byte 영어,숫자 (한글,중국어 등 출력X)
-- 인코딩 방식 2. utf8 : ex) a -> 1000		/ 16byte 가장 많이 사용 (모든 언어 출력 가능), 요즘 하드웨어 가성비가 좋아서 용량크더라도 utf8 많이 사용
-- 인코딩, 디코딩 방식을 일치하지 않으면 규칙이 다르므로 원하는 출력물이 나오지 않음
show variables like "character_set_database";	-- 현재 데이터베이스의 인코딩 방식(utf8)을 확인 가능
alter database ssac character set = ascii;	-- ascii 로 변환
alter database ssac character set = utf8;

### Column ADD (컬럼 추가)
ALTER table user2 add tmp text;	-- user2테이블에 tmp컬럼을 text형식으로 추가
desc user2;
### Column Modify (컬럼 변경)
ALTER table user2 modify column tmp int;	-- user2테이블 tmp컬럼을 int형식으로 변경
desc user2;
### Column Drop (컬럼 삭제)
ALTER table user2 drop tmp;	-- user2테이블 tmp컬럼을 삭제
desc user2;
### table 인코딩 확인
show full columns from user2;	-- 문자열만 인코딩 설정 되어 있음
### table 인코딩 변경
ALTER table user2 convert to character set ascii;
ALTER table user2 convert to character set utf8;
-- table의 내용을 볼때 desc가 쓰이고, 그 외의 경우는 show를 많이 씀

## DDL : DELETE(삭제)
### talbe 삭제
show tables;
drop table number1;
drop table number2;
drop table number3;
drop table number4;
### database 삭제	-- oracle은 콜백으로 취소가 가능하지만, mysql은 복구 불가
show databases;
drop database test;

## CRUD : CREATE : INSERT
use ssac;
desc user2;

insert into user2(name, email, age)	-- table명(컬럼1,컬럼2...)
value ("peter","peter@gamil.com",23) -- (값1, 값2....)
select * from user2;	-- user_id는 1씩 증가하게 설정해서 자동으로 아이디 설정됨 / timestamp로 현시간 : 세계표준시로 나와있음

insert into user2(name, email, age)	
values ("andy","andy@gamil.com",32) -- values : 여러값 추가,
	 , ("dy","dy@gamil.com",25) -- , 을 앞에 두면 편집할 때 용이함
	 , ("ay","ay@gamil.com",39); 
select * from user2;

insert into user2(name, email)	
value ("mysql", "mysql@gamil.com") -- age값 없이 기입
select * from user2;	-- default로 age가 30으로 출력

insert into user2(name, email)
value ("test", "dy@gamil.com")	-- email을 unique로 설정해서 추가가 되지 않음
select * from user2;

### 새로운 테이블에 어떤 결과를 별도로 저장하는 방법
-- 저장하려는 값
use world;
select countrycode, name, population
from city
where population >= 800*10000;

-- table 생성
create table city_800(
	countrycode char(3),
    name varchar(50),
    population int
    );
desc city_800;

-- city_800 테이블에 저장하려는 값 이동
insert into city_800	-- city_800에 해당 값 넣기
select countrycode, name, population
from city
where population >= 800*10000;

select * from city_800;

## UPDATE
use ssac;
select * from user2;
update user2	-- user2 테이블을 수정할 것이다
set email="mysql@daum.net", age=40	-- 수정내용 입력 / 단, email과 age만 입력하고 실행을 해버리면 모든 데이터가 바뀜
where name="mysql"		-- name이 mysql인 값을 바꿔라 / safe upadate기능으로 업데이트가 되지 않음
limit 5;	-- name이 mysql인 데이터 5개를 바꾸겠다.

## DELETE
use ssac;
select * from user2;
delete from user2	-- 업데이트나 딜리트 하기 전에 select문으로 적용하면 어떻게 되는지 확인 하고 작업하는게 좋음
where age <= 30	-- safe update mode로 지워지지 않음 : limit로
limit 2;
select * from user2;

## Foreign Key
-- 데이터의 무결성을 지킬 수 있는 제약 조건이다.
-- 데이터의 무결성 : user 1,2,3 table / money 1,2,3,4 table 이 있을 때, 1,2,3에 해당하는 값을 연결해주고 user에 없는 4는 연결이 되지 않게 한다.
create database test;
use test;
create table user(
	user_id int primary key auto_increment,
    name varchar(20),
    address varchar(20)    
);
create table money(
	money_id int primary key auto_increment,
    income int,
    user_id int
);

-- Foregin key 생성
desc money;		-- user_id에 키가 설정되어 있지 않음/user테이블과 연결하기위해 foregin key생성
alter table money add constraint fk_user
foreign key (user_id)	-- foreign key 설정시 참조하는 컬럼이 필요함 (reference)
references user (user_id);	-- user의 user_id 컬럼을 참조해서 money의 user_id 컬럼을 foreign key로 설정

insert into user(name, address)	-- user_id는 어차피 자동으로 설정됨 1,2,3, 순으로 자동으로
values ("peter", "seoul"), ("andy", "pusan");
select * from user;

insert into money(income, user_id)
values (5000, 1), (6000, 2);
select * from money;

insert into money(income, user_id)
value (10000, 3);	-- 3번 데이터가 들어가지 않음(오류) _ user table에 3번이라는 id가 없어서 들어가지지 않음(제약조건 발동)

-- 같은 조건으로 인해 user_id를 삭제할 수 없다 / money에 참조가 되어있지 않은 데이터는 삭제 가능함
delete from user
where user_id = 1
limit 1;
-- user table도 삭제 되지 않음 : drop table user // 연동되어 있는 money를 지우고 user을 지워야함

## On delete, On update
-- 참조되는 데이터를 수정, 삭제할 때 참조하는 데이터를 어떻게 처리할지를 설정
-- user에 1,2,3 / money에 1,2,2,3이 있을때, user의 2를 4로 바꾸면 money의 2들을 4로 바꿀지 null로 할지 설정하는 방법
### cascade : 참조되는 테이블 데이터를 삭제, 수정하면 참조하는 테이블 데이터도 삭제, 수정(user id 삭제,수정 ->  money의 user id 해당셀 삭제,수정)
### set null : 참조하는 데이터 null값으로 변경 (money의 user_id를 null로 바꾸고 데이터 남김)
### no action : 참조하는 데이터 변경하지 않음(money user id쪽 데이터변경하지 않음)
### set default : 참조하는 데이터를 컬럼의 default값으로 변경(money user_id를 디폴트값으로)
### restrict (기본적으로 이거로 설정됨) : 참조하는 데이터를 삭제하거나 수정할 수 없음 (user의 user_id를 수정 할 수 없음)

-- 테이블 세팅
use test;
drop table money;
drop table user;
create table user(
	user_id int primary key auto_increment,
    name varchar(20),
    address varchar(20)    
);
create table money(
	money_id int primary key auto_increment,
    income int,
    user_id int,
    foreign key (user_id) references user(user_id)	-- money의 user_id를 user의 user_id 참조
    on update cascade on delete set null	-- user의 아이디 변경 -> money의 아이디도 변경/user의 아이디가 삭제되면 money의 user_id를 null로 
);
-- user와 money에 값 입력
insert into user(name, address)	
values ("peter", "seoul"), ("andy", "pusan");
select * from user;
insert into money(income, user_id)
values (5000, 1), (6000, 2);
insert into money(income, user_id)
values (1000, 1), (4000, 1), (9000, 2), (3000, 2);
select * from money;

-- cascade (user의 user_id를 바꿔서 money의 user_id 바꾸기)
update user		
set user_id=3
where user_id=2
limit 1;
select * from user;	-- user id 2가 3으로 변경 
select * from money; -- 여기서도 user id 변경됨 

-- set null
delete from user
where user_id=3
limit 1;
select * from user;	-- user id 3에 해당하는 열 사라짐
select * from money; -- money의 user id가 3인 부분은 id가 null로만 바뀜

# Functions-1 : round, date_format, concat, count, distinct
-- round : 반올림, ceil : 올림, truncate : 버림
use world;
select countrycode, language, percentage,
	   ceil(percentage), round(percentage, 0), truncate(percentage, 0)	-- 반올림, 버림은 몇번째 짜리까지 계산할지 입력해야함
from countrylanguage;

-- date_format() : 날짜 데이터에 대한 포맷을 변경
use sakila;
select payment_date, date_format(payment_date, "%Y-%m")
from payment;

select distinct(date_format(payment_date, "%H")) as unique_hour	-- 매출이 발생한 시간(중복제거)
from payment
order by unique_hour;

-- concat : 컬럼끼리 결합
use world;
select code, name, concat(name, "(", code, ")")
from country;

-- count : row의 갯수를 세어줌
select count(*)	-- count(name) 도 가
from city
where population >= 100*10000;

-- ex) countrylanguage 테이블에서 전세계 언어의 갯수를 출력
use world;
select count(distinct(language))
from countrylanguage;

# Functions-2 : if, ifnull, case when then
-- if
-- ex) 도시의 인구가 100만이 넘으면 big, 아니면 small을 출력하는 scale 컬럼을 추가하세요.
select name, population, if(population >= 100*10000, "big", "small") as scale
from city
order by population desc;

-- ifnull : null이 있는 경우, null대신 다른 값 들어가게 할 때
select code, name, indepyear, ifnull(indepyear, 0)	-- indepyear의 null을 0으로
from country;

-- case when then : 조건이 여러개인 경우 사용
-- ex) 국가의 인구가 1억 이상 : big, 1천만 이상 : medium, 1천만 미만 : small
select code, name,
	case when population >= 10000*10000 then "big"
		 when population >= 1000*10000 then "medium"
		 else "small"
    end as scale
from country
order by population desc;


# GROUP BY & HAVING
## GROUP BY
-- 특정 컬럼에 있는 동일한 데이터를 합쳐주는 방법
-- 반드시 결합함수를 사용 : count, min, max, avg, sum ...
-- ex) 국가 코드별 도시의 갯수
select countrycode, count(countrycode) as city_count
from city
group by countrycode
order by city_count desc
limit 5;
-- ex) 국가 코드별 모든 도시의 인구 총합을 출력
select countrycode, sum(population) as total_population
from city
group by countrycode
order by total_population desc
;
select * from country;
-- ex) 국가 코드별 모든 도시의 인구 총합 출력
select continent, sum(population) as total_p, sum(gnp) as total_gnp
from country
group by continent
order by total_p desc
;
-- ex) 대륙별 인구의 총합 출력
select continent, sum(population) as total_p, round(sum(gnp/population), 2) as gnp_per
from country
group by continent
order by gnp_per desc
;
-- ex) 연월별 매출 출력
use sakila;
select date_format(payment_date, "%Y-%m") as yearmonth, sum(amount) as total_amount
from payment
group by date_format(payment_date, "%Y-%m")
order by yearmonth
;
-- ex) 시간대별 매출 출력
select date_format(payment_date, "%H") as hourly, sum(amount) as total_amount
from payment
group by date_format(payment_date, "%H")
order by hourly
;

## HAVING
-- group by, join과 같은 쿼리를 실행한 결과데이터를 필터링 할 때 사용
-- where은 from에서 데이터를 초반에 걸러내고, having은 작업 후 시점을 거를 때 사용
-- 대륙별 전체 인구를 출력하고 전제 인구가 5억 이상인 대륙을 출력하라
use world;
select continent, sum(population) as total_population
from country
where population >= 50000*10000		-- 국가별 5억 이상인 나라를 먼저 걸러버림 : 원하는 결과X
group by continent;

select continent, sum(population) as total_population
from country
group by continent
having total_population >= 50000*10000;

## WITH ROLLUP
-- 여러개의 컬럼을 group by하고 각 컬럼별 총합을 row로 출력
-- 대륙별, 지역별 인구수의 총합
select ifnull(continent,"total"), ifnull(region, "total"), sum(population) as population 
from country
group by continent, region
with rollup		-- continent별 총합 보여줌
;

# 변수선언
-- ranking 데이터 출력시 편함
set @data = 1;
select @data;

# city 테이블에서 도시의 인구수가 많은 5개 도시를 출력하고 내림차순으로 sorting
-- ranking 데이터를 추가하여 출력하고 싶은경우
set @RANK = 0;
select @RANK := @RANK+1 as ranking, countrycode, name, population	-- @rank := @rank+1 문법 
from city
order by population desc
limit 5;


## exercise
-- 1. countrylanguage 에서 언어별 20개 이상의 국가에서 사용하는 언어를 조회해서 언어별 사용되는 국가 수에 따라서 내림차순
select language, count(language) as cnt_language
from countrylanguage
group by language
having cnt_language >= 20
order by cnt_language desc;
 
-- 2. country 에서 대륙별 전체면적, 전체인구, 인구밀도(전체인구/전체면적), 인구밀도 높은순으로 내림차순 정렬
select continent, sum(surfacearea) as total_sur, sum(population) as total_pop
		, sum(population) / sum(surfacearea) as den
from country
group by continent
order by den desc;

