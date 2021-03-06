# Database backup
-- 보통 목요일 밤 12 ~ 6시, 수요일 밤 12 ~ 4시
## hot backup / cold backup : 데이터 베이스 백업시 환경에 따라서 사용
### hot backup : 데이터베이스가 동작중인 상태에서 백업
### cold backup : 데이터베이스 동작이 중단된 상태에서 백업

## logical backup / physical backup : 데이터 베이스 백업하는 방법에 따라서 사용
### logical backup : (바이너리로 된)데이터를 sql 쿼리문으로 변환해서 저장
-- 단점1 : sql 쿼리로 변환하는 시간이 소요 : 느린 백업과 복권
-- 단점2 : 시스템 자원을 많이 사용
-- 장점1 : 파일용량을 적게 사용(예를들어, index를 자체로 보관하면 내용 자체를 저장하기에 용량이 크지만 sql로하면 간단해짐)
-- 장점2 : 데이터 복원시 문제발생 확인 쉬움 : 에러 출력
-- 장점3 : OS 호환이 잘된다
    
### pyhsical backup : 데이터를 바이너리 파일 그대로 복사해서 붙여넣기로 저장
-- 단점1 : 파일용량 많이 사용
-- 단점2 : 문제 발생에 대한 확인이 거의 불가
-- 단점3 : OS 호환이 잘 안된다
-- 장점1 : 백업과 복원의 속도가 빠름
-- 장점2 : 시스템 자원을 적게 사용

-- => 데이터의 양이 적을때 > 논리적 백업
-- => 데이터의 양이 많고 빠른 시간안에 백업해야하는 경우 > 물리적 백업

## workbench를 이용한 백업
-- 회사에 관련된 자료를 개발팀에 요청 > .csv
-- csv형태로 전환 : query에서 export result로 저장 : 회사내 다른팀에서 요청하는 경우
-- 단, excel, 한글 등에서 깨지는 경우 인코딩 방법을 알아내야
-- sql형태로 전환 : server에서 data export로 저장

# 해당 실습 링크 : https://heliotrope-composer-6a6.notion.site/SQL-TIP-a49d81a5c7f846b1b1ca13fa6952f123
## hot logical backup 실습 : backup의 스케줄을 설정해서 백업(crontab)
## cold physical backup 실습
