# Quiz 1. 국가 코드별 도시의 갯수를 출력하세요. (상위 5개를 출력) 
SELECT Countrycode, count(countrycode) as count
FROM city
GROUP BY countrycode
ORDER BY count desc
limit 5;

# Quiz 2. 대륙별 몇개의 국가가 있는지 대륙별 국가의 갯수로 내림차순하여 출력하세요. 
SELECT continent, count(*) as num
FROM country
GROUP BY continent
ORDER BY num DESC;

# Quiz 3. 대륙별 인구가 1000만명 이상인 국가의 수와 GNP의 평균을 소수 둘째 자리에서 반올 림하여 첫째자리까지 출력하세요.
SELECT continent, count(continent) as num, ROUND(AVG(gnp),1) as avg_gnp
FROM country
WHERE population >= 1000*10000
GROUP BY continent
order by avg_gnp desc;

# Quiz 4. city 테이블에서 국가코드(CountryCode) 별로 총인구가 몇명인지 조회하고 총인구 순으로 내림차순하세요. (총인구가 5천만 이상인 도시만 출력) 
SELECT countrycode, sum(population) as total_p
FROM city
GROUP BY countrycode
HAVING total_p >= 5000*10000
ORDER BY total_p DESC

# Quiz 5. countrylanguage 테이블에서 언어별 사용하는 국가수를 조회하고 많이 사용하는 언어를 6위에서 10위까지 조회하세요. 
SELECT language, count(language) as total_l
FROM countrylanguage
GROUP BY language
ORDER BY total_l DESC, language DESC
limit 5,5;

# Quiz 6. countrylanguage 테이블에서 언어별 20개 국가 이상에서 사용되는 언어를 조회하고 언어별 사용되는 국가수에 따라 내림차순하세요.
SELECT language, count(language) as total_l
FROM countrylanguage
GROUP BY language
HAVING total_l >= 20
ORDER BY total_l DESC;

# Quiz 7. country 테이블에서 대륙별 전체 표면적크기를 구하고 표면적 크기 순으로 내림차순하세요. 
SELECT continent, round(sum(surfacearea),0) as con_area
FROM country
GROUP BY continent
ORDER BY con_area DESC;

# Quiz 8. World 데이터 베이스의 countrylanguage에서 언어의 사용 비율이 90%대(90 ~  99.9)의 사용율을 갖는 언어의 갯수를 출력하세요.
SELECT count(distinct(language)) as count_language
FROM countrylanguage
WHERE percentage BETWEEN 90 and 99.9;

# Quiz 9. 1800년대에 독립한 국가의 수와 1900년대에 독립한 국가의수를 출력하세요. 
SELECT 
	CASE WHEN IndepYear BETWEEN 1800 AND 1899 THEN '1800' 
		 WHEN IndepYear BETWEEN 1900 AND 1999 THEN '1900' 
         END AS IndepYear_ages,
		count(IndepYear)
FROM country
WHERE IndepYear BETWEEN 1800 AND 1999
GROUP BY 
	CASE WHEN IndepYear BETWEEN 1800 AND 1899 THEN '1800' 
		 WHEN IndepYear BETWEEN 1900 AND 1999 THEN '1900' 
    END
ORDER BY IndepYear_ages DESC
;

# Quiz 10. sakila의 payment 테이블에서 월별 총 수입을 출력하세요.
use sakila;
select date_format(payment_date, "%Y-%m") monthly, sum(amount) as amount
from payment
group by date_format(payment_date, "%Y-%m")
order by date_format(payment_date, "%Y-%m")
;

# Quiz 11. actor 테이블에서 가장 많이 사용된 first_name을 아래와 같이 출력하세요. 
# 가장 많이 사용된 first_name의 횟수를 먼저 구하고, 횟수를 Query에 넣어서 결과를 출력하세요. 
select first_name, count(first_name) as cnt_name
from actor
group by first_name
order by cnt_name desc
limit 3;

# Quiz 12. film_list 뷰에서 카테고리별 가장 많은 매출을 올린 카테고리 3개를 매출순으로 정렬 하여 아래와 같이 출력하세요.
select category
from film_list
group by category
order by sum(price) desc
limit 3;
