# world table 사용
use world;

select *
from country;

# mysql에서는 대소문자 구분 하지 않음
select code, name, population
from country;

select code as country_code, name as country_name, population
from country;

show databases;	# 서버의 데이터베이스 확인
show tables;	# database의 테이블 구조 확인alte
desc country;	# country의 schema구조를 볼 수 있음

# 산술 연산자(Select)
select code, name, gnp, gnp*1000 AS gnp_1000
from country;

# 비교 연산자(Select)
select code, name, continent, continent = "Asia"	# Asia = 1, 아니면 0 / true=1, false=0
from country;

# 논리 연산자(Select)
SELECT code, name, population, lifeexpectancy
		, (lifeexpectancy >=70) and (population > 5000*10000)
FROM country;

# WHERE절
## 인구가 1억 이상인 국가 출력
SELECT code, name, population
FROM country
WHERE population >= 1000 * 10000;		# 출력 자체를 0,1로 할꺼면 select에 비교연산자 쓰면 됨

## 인구가 7천만~1억인 국가 출력
SELECT code, name, population
FROM country
WHERE (population >= 7000 * 10000) and (population <= 10000 * 10000);
## 같은표현으로 BETWEEN 사용 가능
##WHERE population BETWEEN 7000 * 10000 and 10000 * 10000;

## 아시아와 아프리카 대륙의 국가 데이터를 출력
Select code, name, continent, population
from country
WHERE continent = "Asia" or continent = "Africa";

# IN, NOT IN
Select code, name, continent, population
from country
WHERE continent IN('Asia', "Africa")
AND population between 3000*10000 and 10000*10000;

# LIKE : 특정 문자열이 포함된 데이터 출력
## localname에 A로 시작하는 데이터 출력
SELECT code, name, localname
FROM country
WHERE localname like "A%";

# ORDER BY : 데이터의 순서를 정렬
select code, name, population
from country
order by population asc; #desc : 역순

select countrycode, name, population
from city
order by countrycode, population asc; #desc : 역순

# LIMIT : 조회되는 데이터의 수를 제한alter
## 인구 상위 5개의 국가를 내림차순으로 출력
SELECT code, name, population
from country
order by population desc
limit 5;

## 인구수 상위 6위 ~ 8위 까지의 국가를 내림차순으로 출력
SELECT code, name, population
from country
order by population desc
limit 5,3;		## 위에 5줄 스킵 후 3개까지 출력

# DISTINCT : 중복을 제거해주는 예약어
## 도시의 인구가 800만 이상의 도시를 가지고 있는 국가의 국가 코드를 출력
select distinct countrycode	#distinct가 없으면 같은 국가가 여러번 나옴
from city
where population >= 500 * 10000
order by countrycode;

# SQL Quiz 01
# Quiz 1. 한국 ( 국가코드 : KOR ) 도시중 인구가 100만이 넘는 도시를 조회하여 인구수 순으로 내림차순으로 출력
# 출력 컬럼 : 도시이름(name), 도시 인구수(population) 
SELECT name, population
FROM city
WHERE CountryCode LIKE "KOR" AND (population >= 100*10000)
ORDER BY population DESC;

# Quiz 2. 도시 인구가 800만 ~ 1000만 사이인 도시의 데이터를 국가코드 순으로 오름차순 출력
# 출력 컬럼 : 국가코드(countrycode), 도시이름(name), 도시인구수(population)
SELECT countrycode, name, population
FROM city
WHERE population BETWEEN 800*10000 AND 1000*10000
ORDER BY countrycode;

# Quiz 3. 1940 ~ 1950년도 사이에 독립한 국가들중 GNP가 10만이 넘는 국가를 GNP의 내림 차순으로 출력하세요.  
# 출력 컬럼 : 국가코드(code), 국가이름(name), 대륙(continent), GNP(gnp) 
SELECT code, name, continent, gnp
FROM country
WHERE Indepyear BETWEEN 1940 and 1950
AND gnp > 10*10000
ORDER BY gnp desc;

# Quiz 4. 스페인어(Spanish), 영어(English), 한국어(Korean) 중에 95% 이상 사용하는 국가 코드, 언어, 비율을 출력하세요.
# 출력 컬럼 : 국가코드(countrycode), 언어(language), 비율(percentage) 
SELECT countrycode, language, percentage
FROM countrylanguage
WHERE percentage >= 95
AND language IN ("Spanish", "English", "Korean")
ORDER BY percentage DESC;

# Quiz 5. 국가 코드가 "K"로 시작하는 국가 중에 기대수명(lifeexpectancy)이 70세 이상인 국 가를 기대수명의 내림차순 순으로 출력하세요.
# 출력 컬럼 : 국가코드(code), 국가이름(name), 대륙(continent), 기대수명(lifeexpectancy)
SELECT code, name, continent, lifeexpectancy
FROM country
WHERE lifeexpectancy >= 70
AND code LIKE "K%"
ORDER BY lifeexpectancy DESC;

use sakila;

# Quiz 6. film_text 테이블에서 title이 ICE가 들어가고 description에 Drama가 들어간 데이 터를 출력하세요. 
# 출력 컬럼 : 필름아이디(film_id), 제목(title), 설명(description) 
SELECT film_id, title, description
FROM film_text
WHERE title LIKE "%ICE%"
AND description LIKE "%Drama%";

# Quiz 7. actor 테이블에서 이름(first_name)의 가장 앞글자가 "A", 성(last_name)의 가장 마지막 글자가 "N"으로 끝나는 배우의 데이터를 출력하세요.  
# 출력 컬럼 : 배우아이디(actor_id), 이름(first_name), 성(last_name) 
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE "A%" AND last_name LIKE "%N";

# Quiz 8. film 테이블에서 rating이 "R" 등급인 film 데이터를 상영시간(length)이 가장 긴 상 위 10개의 film을 상영시간의 내림차순순으로 출력하세요.  
# 출력 컬럼 : 필름아이디(film_id), 필름제목(title), 필름내용(description), 대여기간(rental_duration), 렌탈비율 (rental_rate), 상영시간(length), 등급(rating)
SELECT film_id,title,description,rental_duration,rental_rate,length,rating
FROM film
WHERE rating LIKE "R"
ORDER BY length DESC
LIMIT 10;

# Quiz 9. 상영시간(length)이 60분 ~ 120분인 필름 데이터에서 영화설명(description)에 robot 들어있는 영화를 상영시간(length)이 짧은순으로 오름차순하여 정렬하고, 11위에서 13 위까지의 영화를 출력하세요.  
# 출력 컬럼 : 필름아이디(film_id), 필름제목(title), 필름내용(description), 상영시간(length) 
SELECT film_id, title, description, length
FROM film
WHERE length BETWEEN 60 and 120
AND description LIKE "%robot%"
ORDER BY length
LIMIT 10,3;

# Quiz 10. film_list view에서 카테고리(category)가 sci-fi, anmation, drama가 아니고 배 우(actors) 가 "ed chase", "kevin bloom" 이 포함된 영화리스트에서 상영시간이 긴 순서대 로 5개의 영화 리스트를 출력하세요.  
# 출력 컬럼 : 제목(title), 설명(description), 카테고리(category), 상영시간(length), 배우(actors)
SELECT title description,category,length,actors
FROM film_list view
WHERE category NOT IN("sci-fi", "animation","drama")
AND actors LIKE "%ed chase%" OR "%kevin bloom%"
ORDER BY length DESC
LIMIT 5;

