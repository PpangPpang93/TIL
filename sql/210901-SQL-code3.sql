# Quiz 1. 멕시코(Mexico)보다 인구가 많은 나라이름과 인구수를 조회하시고 인구수 순으로 내림차순하세요. 
select name, population
from country
where population > 
	(
    select population
    from country 
    where name = 'mexico'
    )
order by population desc
;

# Quiz2. 국가별 몇개의 도시가 있는지 조회하고 도시수 순으로 10위까지 내림차순하세요. 
select A.name, count(A.name) as cnt_city
from country A
left join city B
on A.code = B.countrycode
group by A.name
order by cnt_city desc
limit 10
;

# Quiz 3. 언어별 사용인구를 출력하고 언어 사용인구 순으로 10위까지 내림차순하세요. 
select A.language, round(sum(B.population * A.percentage),0) as lan_pop
from countrylanguage A
join country B
on A.countrycode = B.code
group by A.language
order by lan_pop desc
limit 10;

# Quiz 4. 나라 전체 인구의 10%이상인 도시에서 도시인구가 500만이 넘는 도시를 아래와 같이 조회 하세요. 
select A.name, A.countrycode, country.name,
	   round(A.population/country.population*100,2) as percentage
from country
join ( select name,countrycode,population
		from city
        where population >= 500*10000
	 ) A
 on A.countrycode = country.code
order by percentage desc
limit 6;

# Quiz 5. 면적이 10000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고 인구밀도(density)가 200이상인 국가들의 사용하고 있는 언어가 2가지인 나라를 조회 하세요.
# 출력 : 국가 이름, 인구밀도, 언어 수 출력 
use world;

## 한번에 출력
select B.name, B.density, D.cnt_l, group_concat(D.language) as languages
	from(	-- 면적이 10000^2 이상이고 인구밀도가 200이상인 국가들
			select A.name, A.code, round(A.population/A.surfacearea,0) as density
				from(
					select name, code, surfacearea, population
					from country
					where surfacearea >= 10000
					) A
			having density >=200
        ) B
	join (	-- 사용하는 언어가 2개인 국가들
			select T.countrycode, T.language, cnt_l
			from countrylanguage T
			join (select countrycode as tt, count(countrycode) as cnt_l
				  from countrylanguage
				  group by countrycode
				  having cnt_l = 2
				  ) C
			on T.countrycode = C.tt
		 )D
    on D.countrycode = B.code
group by B.name, B.density, D.cnt_l;

### 식 좀 더 깔끔하게
select C.name, C.density, D.cnt_l as language_count, D.language_list
    from
		(
		select code, name, round(population/surfacearea) as density
		from country
		where surfacearea >= 10000
		and population/surfacearea >=200
		) C
	join
		(
		select A.countrycode, B.cnt_l, group_concat(A.language) as language_list
			from countrylanguage A
			join (
					select countrycode, count(language) as cnt_l
					from countrylanguage
					group by countrycode
					having cnt_l=2
				  ) B
			on A.countrycode = B.countrycode
		group by countrycode
		) D
	on C.code = D.countrycode
order by C.name;
###

## view로 정리1
create view test1 as
select A.name, A.code, round(A.population/A.surfacearea,0) as density
	from(
		select name, code, surfacearea, population
		from country
		where surfacearea >= 10000
		) A
having density >=200;

## view로 정리2
create view test2 as
select T.countrycode, T.language, cnt_l
from countrylanguage T
join (select countrycode as tt, count(countrycode) as cnt_l
	  from countrylanguage
	  group by countrycode
	  having cnt_l = 2
	  ) C
on T.countrycode = C.tt;

## view를 활용한 출력
select B.name, B.density,D.cnt_l as language_count, group_concat(D.language) as languages
from test1 B
join test2 D
on D.countrycode = B.code
group by B.name,B.density,D.cnt_l
;

# Quiz 6. 사용하는 언어가 3가지 이하인 국가중 / 도시인구가 300만 이상인 도시를 아래와 같이 조회하세요. 
# GROUP_CONCAT(LANGUAGE) 을 사용하면 group by 할때 문자열을 합쳐서 볼수 있습니다. * VIEW를이용해서query를깔끔하게수정하세요.

## view로 해당 구문 만들기1
create view quiz1 as
select A.countrycode, A.name as city_name, A.population, country.name as country_name
	from(
		select countrycode, name, population
		from city
		where population >= 300*10000
		) A
	join country
    on A.countrycode = country.code;

## view로 해당 구문 만들기2
create view quiz2 as
select B.countrycode, A.cnt_l, B.language	
	from countrylanguage B
	join
		(
		select countrycode, count(language) as cnt_l
		from countrylanguage
		group by countrycode
		having cnt_l <=3
		)A
	on B.countrycode = A.countrycode;
    
## view를 사용하여 코드 간단하게 정리
select temp1.countrycode as code, temp1.city_name as city_name, temp1.population as population
	   , temp1.country_name as country_name, temp2.cnt_l as language_count, group_concat(temp2.language) as languages
from quiz1 as temp1
join quiz2 as temp2
on temp1.countrycode = temp2.countrycode
group by code, city_name, population, country_name, language_count
order by population desc;


# Quiz 7. 한국와 미국의 인구와 GNP를 세로로 아래와 같이 나타내세요. (쿼리문에 국가 코드명을 문자열로 사용 해도 됩니다.) 
create view tt as
select code, population, round(gnp,0) as gnp
					from country
					where code in ("KOR", "USA")
                    ;
                    
select category, sum(D.KOR) as KOR, sum(D.USA) as USA
	from(
		select	
			case
				when x = 1 then 'population'
				when x = 2 then 'gnp'
				end as "category" ,
			case
				when x = 1 and code like "KOR" then population
				when x = 2 and code like "KOR" then gnp
				end as "KOR" ,
			case
				when x = 1 and code like "USA" then population
				when x = 2 and code like "USA" then gnp
				end as "USA"
		from (
			  select * from tt A,
						( select 1 as x
						  union all select 2 as x
						) as B
			)C
	) D
group by category order by category desc;
                            
# Quiz 8. sakila 데이터 베이스의 payment 테이블에서 수입(amount)의 총합을 아래와 같이 출력하세요. 
use sakila;
create view quiz8 as
select date_format(payment_date, "%Y-%m") monthly, sum(amount) as amount
from payment
group by date_format(payment_date, "%Y-%m")
order by date_format(payment_date, "%Y-%m")
;

select
	 MAX(case when monthly = '2005-05' then amount end) as '2005-05'
    ,MAX(case when monthly = '2005-06' then amount end) as '2005-06'
    ,MAX(case when monthly = '2005-07' then amount end) as '2005-07'
    ,MAX(case when monthly = '2005-08' then amount end) as '2005-08'
    ,MAX(case when monthly = '2006-02' then amount end) as '2006-02'
from (
		select * from quiz8
	 ) T;

# Quiz 9. 위의 결과에서 payment 테이블에서 월별 렌트 횟수 데이터를 추가하여 아래와 같이 출력하세요. 
create view quiz9 as
select date_format(payment_date, "%Y-%m") monthly, sum(amount) as amount, count(rental_id) as rent
from payment
group by date_format(payment_date, "%Y-%m")
order by date_format(payment_date, "%Y-%m")
;
select category, sum(D.a) as '2005-05', sum(D.b) as '2005-06', sum(D.c) as '2005-07'
				,sum(D.d) as '2005-08', sum(D.e) as '2006-02'
	from
        (
		select	
				case
					when x = 1 then 'amount'
					when x = 2 then 'rent'
					end as "category" ,
				case
					when x = 1 and monthly like "2005-05" then amount
					when x = 2 and monthly like "2005-05" then rent
                    else 0
					end as "a" ,
				case
					when x = 1 and monthly like "2005-06" then amount
					when x = 2 and monthly like "2005-06" then rent
					end as "b" ,
				case
					when x = 1 and monthly like "2005-07" then amount
					when x = 2 and monthly like "2005-07" then rent
					end as "c" ,
				case
					when x = 1 and monthly like "2005-08" then amount
					when x = 2 and monthly like "2005-08" then rent
					end as "d" ,
				case
					when x = 1 and monthly like "2006-02" then amount
					when x = 2 and monthly like "2006-02" then rent
					end as "e" 
			from (
				  select * from quiz9 A,
							( select 1 as x
							  union all select 2 as x
							) as B
				)C
		) D
group by category;

