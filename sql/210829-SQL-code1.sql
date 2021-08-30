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

## Quiz : 한국 도시 중 인구수가 100만이 넘는 도시를 인구수 순으로 오름차순으로 정렬하여 출력
SELECT countrycode, district, population
from city
WHERE (countrycode like "KOR") AND (population >= 100*10000)
Order by population desc;