SQL  자습

1. 새로운 열 만드는 방법
  - 테이블을 ALERT로 수정하거나
  - 더미 테이블을 가져와서 level로 설정한다
  - ex) 0~24 생성
    FROM(
        SELECT 
            level-1 AS "HOUR" 
            FROM DUAL
            CONNECT BY level<=24
        )B

 - ex) 새로운 시간 열을 생성해서 0시~ 23시까지 해당 조건에 맞는 수 카운트해서 넣기
  SELECT
     B.HOUR
    ,NVL(C.COUNT,0) AS COUNT
    FROM(
        SELECT 
            level-1 AS "HOUR" 
            FROM DUAL
            CONNECT BY level<=24
        )B
        
        LEFT OUTER JOIN
        
            (
            SELECT
                TO_CHAR(A.DATETIME, 'HH24') AS HOUR
               ,COUNT(*) AS COUNT
                FROM ANIMAL_OUTS A
                GROUP BY TO_CHAR(A.DATETIME, 'HH24')

            ) C
            
        ON B.HOUR = C.HOUR
                
ORDER BY B.HOUR


 2. 데이터 타입 다루기
  - DATETIME 형식의 경우, 원하는 결과를 얻기위해 TO_CHAR을 사용한다.
  - TO_CHAR(A.DATETIME, ‘YYYY-MM’) AS 날짜(“날짜”)

 3. 공백 관리하기
  - NVL함수를 사용한다.
  - NVL(A.TEST,0) AS COUNT_TEST : A로 명시한 테이블 TEST 열에서 NULL인 것을 0으로 표현하기
  
 4. JOIN 함수 활용
  - (테이블1) JOIN (OUTER/INNER) (테이블2) ON 1.키 = 2.키

 5. 데이터 읽어지는 순서 확인
  - 예를 들어, 상위 몇개만 출력하고 싶은경우, 완성된 SELECT문을 하나의 테이블로 바꿔서 
  - WHERE ROWNUM <= n 으로 표현한다.
  - ORDER, GROUP 뒤에 쓰면 코드를 읽는 순서가 달라서 에러 발생

** 이외에 GROUP 문에 대해서 더 공부해보기
** 특정 커맨드 더 연습해보기, 안써본 커맨드 연습하기(예를들어, WITH 이런것도 있더라)
** MAC M1에서 ORACLE 쓸 수 있게 환경설정 다시 해보기

