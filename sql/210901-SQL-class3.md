# SQL day3

# JOIN
-- user/addr 테이블 작성 후 join 연습
use ssac;

create table user(
	user_id int primary key auto_increment,
    name varchar(30) not null
);

create table addr(
		addr_id int primary key auto_increment,
        addr_name varchar(30) not null,
        user_id int not null
);

insert into user(name)
values ("jin"), ("po"), ("alice");
select * from user;

insert into addr(addr_name, user_id)
values ("seoul", 1), ("pusan", 2), ("daegu", 4), ("seoul", 5);
select * from addr;

## inner join
select *
from user
join addr;	-- join만 하면, user기준으로 모든 행에 각각 addr 요소가 붙음

-- 교집합의 데이터만 출력
select user.user_id, user.name, addr.addr_name
from user
join addr	-- inner join과 같은뜻
on user.user_id = addr.user_id;

## left join
select user.user_id, user.name, addr.addr_name
from user
left join addr	
on user.user_id = addr.user_id; -- user기준 addr테이블 붙이기

## right join
select addr.user_id, user.name, addr.addr_name
from user
right join addr	-- inner join과 같은뜻
on user.user_id = addr.user_id;

-- 국가코드, 국가이름, 국가인구, 도시이름, 도시인구 출력
-- 도시인구가 500만 이상인 도시만 출력, 도시인구순으로 내림차순
-- 도시의 국가인구에 대한 비율 출력하는 컬럼 추가
use world;
select country.code, country.name, country.population
	   , city.name, city.population
       , round(city.population/country.population * 100, 2) as rate
from country
join city
on country.code = city.countrycode
having city.population >= 500*10000
order by rate desc
limit 10
;

-- (staff id기준) 스태프 아이디, 스태프 풀네임, 매출액
use sakila;
select payment.staff_id, concat(staff.first_name, " ", staff.last_name), payment.amount
from payment
join staff
on payment.staff_id = staff.staff_id

-- 스태프별 발생한 총 매출을 출력
use sakila;

select payment.staff_id, concat(staff.first_name, " ", staff.last_name) as full_name, 
		sum(payment.amount) as total
from payment
join staff
on payment.staff_id = staff.staff_id
group by payment.staff_id;

-- 위의 문제를 서브쿼리로
use sakila;
select *
from(
		select payment.staff_id, concat(staff.first_name, " ", staff.last_name) as full_name, 
				amount
		from payment
		join staff
		on payment.staff_id = staff.staff_id
)A

-- 테이블 3개 조인
-- 국가이름, 도시이름, 사용언어, 사용언어 비율
use world;
select country.name as country_name, city.name as city_name
	   ,countrylanguage.language, countrylanguage.percentage
from country
join city
on country.code = city.countrycode
join countrylanguage
on country.code=countrylanguage.countrycode
;

-- 좀 더 간편하게
select country.name as country_name, city.name as city_name
	   ,countrylanguage.language, countrylanguage.percentage	-- 중복되지 않은 컬럼인 language, percentage는 독립적으로 써도 되긴함
from country, city, countrylanguage
where country.code = city.countrycode
	  and country.code = countrylanguage.countrycode;


-- 도시에서 언어를 사용하는 인구수(국가의 언어사용비율이 도시의 언어사용비율과 같다 가정)
select country.name as country_name, city.name as city_name
	   , countrylanguage.language, countrylanguage.percentage
       , round(city.population*countrylanguage.percentage/100,0) as rate
from country, city, countrylanguage
where country.code = city.countrycode
	  and country.code = countrylanguage.countrycode;

## UNION (outer join) : 쿼리를 실행한 결과를 row 데이터 기준으로 합쳐서 출력
use ssac;
select name
from user
union		-- 중복 데이터를 제거하고 싶지 않은 경우, union all
select addr_name
from addr;	-- addr의 서울이 2개 있었는데, union으로 하면 사라짐 : 중복 데이터를 제거하는 기능도 포함 

-- outer join
select user.user_id, user.name, addr.addr_name
from user
left join addr
on user.user_id=addr.user_id
union
select addr.user_id, user.name, addr.addr_name
from user
right join addr
on user.user_id=addr.user_id;

# Sub Query
-- select, from, where에서 사용 가능

## sub query : select
-- 전체 나라수, 전체 도시수, 전체 언어수를 하나의 row, 세개의 column으로 출력
use world;
select 
		(select count(*) from country) as country_count
		, (select count(*) from city ) as city_count
		, (select count(distinct(language)) from countrylanguage) as language_count
from dual;	-- 빈 테이블

-- 800만 이상이 되는 도시의 국가코드, 국가이름, 도시이름, 도시인구수 출력
-- join으로 표현
select country.code, country.name, city.name, city.population
from country	-- 239개
join city		-- 4079개 > 975000 rows 생성
on country.code=city.countrycode	-- 4079개
having city.population >= 800*10000;	-- 10개

-- sub query로 표현(계산 효율이 좋음)
select country.code, country.name, city.name, city.population
from ( select *
		from city
        where population >= 800*10000
 	) as city	-- 10개
join country	-- 239개 > 2390 rows 생성
on country.code=city.countrycode;	-- 10개 

## sub query : where
-- 800만 이상 도시의 국가코드, 국가이름, 대통령이름 출력
select countrycode
from city
where population >= 800*10000;

select code, name, headofstate
from country
where code in (select countrycode
				from city
			  where population >= 800*10000
              );
              
-- any, all
select code, name, headofstate, population
from country
where population >= (
					select population from country where code in ("KOR", "BRA")
                    );	-- 오류 발생
                    
-- any : or : 둘중에 하나만 만족해도 TRUE 
select code, name, headofstate, population
from country
where population >= any (
					select population from country where code in ("KOR", "BRA")
                    );	
-- all : and : 둘다 만족해야 TRUE    
select code, name, headofstate, population
from country
where population >= all (
					select population from country where code in ("KOR", "BRA")
                    );	

-- 대륙과 지역별 사용하는 언어의 수
select country.continent, country.region, countrylanguage.language
from country
join countrylanguage
on country.code = countrylanguage.countrycode;

-- continent, region별 language의 수를 출력
select A.continent, A.region, count(A.language) as language
	from
    (
		select country.continent, country.region, countrylanguage.language
		from country
		join countrylanguage
		on country.code = countrylanguage.countrycode
	) A
group by A.continent, A.region

# View
-- 가상의 테이블로 특정 쿼리를 실행한 결과 데이터를 출력하는 용도
-- 실제 데이터를 저장하지 않음 => "수정 및 인덱스 설정이 불가능"
-- 쿼리를 조금 더 단순하게 작성하게 해주는 기능
-- table에 저장된 데이터의 주소를 불러와서 사용하는 개념

## 800만 이상의 도시인구가 있는 국가의 국가콛, 국가이름, 도시이름
use world;
select country.code, country.name, city_800.name
from (
	  select countrycode, name
      from city 
      where population >= 800*10000
	 ) as city_800
join country
on country.code = city_800.countrycode;

-- 위의 sub query를 view를 사용해서 단순하게
create view city2 as	-- view이름을 city2로 설정
select countrycode, name
from city 
where population >= 800*10000;

-- city2 활용
select country.code, country.name, city2.name
from city2
join country
on country.code = city2.countrycode;

-- 테이블의 데이터를 직접 다루는(수정하는) 경우, 그만큼 공간을 많이 차지함
-- 뷰는 같은 저장공간을 같이 사용하므로 공간의 제약이 없음(직접 저장하지 않기도하고)

# INDEX : 테이블에서 데이터를 빠르게 검색할 수 있도록 해주는 기능
-- employs 데이터로 실습
-- employs 데이터를 pc에 저장 -> 인터넷을 통해 aws ec2로 전송 (scp 방법)
-- (scp방법을 사용하기 위해 ip, pem값이 있어야 전송이 가능)
-- scp로 전송한 파일을 ec2에서 mysql을 실행해서 넣어주기
use employees;
show index from salaries;	-- 인덱스 확인
desc salaries;
select count(*) from salaries;
select * from salaries where to_date < "1986-01-01"; -- 763ms

create index tdate on salaries (to_date);	-- 인덱스 생성
select * from salaries where to_date < "1986-01-01"; -- 37ms

drop index tdate on salaries;
select * from salaries where to_date < "1986-01-01"; -- 1s, 인덱스가 없어서 매우느림 

# 실행계획
explain
select * from salaries where to_date < "1986-01-01";
-- 인덱스 생성 후, 실행
create index tdate on salaries (to_date);	
explain
select * from salaries where to_date < "1986-01-01";
drop index tdate on salaries;

# Trigger : 특정 테이블을 감시하고 있다가, 설정한 조건이 감지되면 지정해놓은 쿼리가 자동으로 실행
use test;
show tables;
drop table money;
drop table user;

-- ex)chat, backup이라는 테이블이 있다. chat의 데이터를 delete를 했을 때, backup으로 chat으로 옮겨지게 할 수 있다.
create table chat(
	chat_id int primary key auto_increment,
    msg varchar(200) not null
);
create table backup(
	backup_id int primary key auto_increment,
    backup_msg varchar(200),
    backup_date timestamp default current_timestamp	-- 현재시간 자동저장되는 열
);

insert into chat(msg) values ("hello"), ("hi"), ("my name is peter!");
select * from chat;

-- trigger 생성
delimiter |
	create trigger backup_tr
	before delete on chat	-- backup_tr이라는 이름의 트리거생성 / chat테이블에 delete가 실행되기 전에
	for each row begin		-- for each row : 한줄 한줄 실행될때 begin : 실행해라(delete는 한줄씩 삭제된다)
		insert into backup(backup_msg)
		value (old.msg);	-- backup 테이블의 backup_msg열에 값을 넣는다
							-- create에도, value에도 ';'가 들어가야해서 오류가 난다 -> delimiter 설정
end |	-- '|'로 사용됨을 알 수 있다.
show triggers;	-- trigger에 대한 정보 알 수 있음

select * from chat;
select * from backup;	-- 현재 비어있음

-- 삭제 쿼리 작동시키기
delete from chat
where msg like "h%"	-- chat테이블에서 h로 시작하는 msg 삭제
limit 10;

select * from chat;	-- 데이터가 삭제됨
select * from backup;	-- 삭제된 데이터가 백업되어 있음

-- 데이터 복원
insert into chat(msg)
select backup_msg
from backup;

select * from chat;		-- 현재 메세지만 복원했는데, 보통 id랑 같이 해주는게 좋다

-- triger 삭제
use test;
drop trigger backup_tr;

-- join 예제 : 국가별로 국가코드, 국가이름, 국가인구, 도시인구, 도시갯수 를 출력
use world;

select A.code, A.name, A.population
	 , sum(B.population) as city_p, count(B.name) as city_c
from country A
join city B
on A.code = B.countrycode
group by A.code, A.name, A.population;

