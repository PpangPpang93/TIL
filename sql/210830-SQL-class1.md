#210830(월) SQL 학습1
✻ 박두진 강사님

# 데이터 베이스의 개요, SQL에 대해

- DB : 데이터를 통합하여 관리하는 데이터의 집합
- DBMS : 데이터 베이스를 관리하는 미들웨어 시스템, 데이터 베이스 관리 시스템(데이터 베이스를 관리하는 툴이라고 생각하면 됨)
    - RDBMS(시트, 테이블 사이의 관계를 가질 수 있음, 새로운 테이블 조작이 가능함) : Oracle, Mysql, Postgresql, Sqlite _ 사용량에 대해선 Mysql을 많이 쓰고있고, 기능적으로는 Oracle이 좋음
    - NoSQL(시트, 테이블 사이의 관계를 가질 수 없음) : Mongodb, Hbase, Cassandra _ Mongodb를 가장 많이 사용함(NoSQL 중에서)
- MySQL의 특징
    - 오픈소스, 다중 사용자, 다중 스레드 지원 : 코드가 다 공개되어있다. 프로그램 외에 서칭 등을 같이 사용 할 수 있다는 의미.
    - 표준 SQL을 사용 : 기본적인 틀은 비슷하다
    - 작고 강력하고 가격이 저렴하다. / 오라클은 비쌈
        - 서버 사용 도식화 / ubuntu : 22 , Mysql : 3306서버
        - workbench, aws 설치가 필요함
        - AWS EC2에서 서버 연동되는 과정
        - 패스워드로 사용되는 파일

    - ubuntu 접속 : ssh -i ~/Downloads/ssac.pem [ubuntu@](mailto:ubuntu@ip주소)
        - public ip/private ip의 차이 : 외부에서 접속(외부망), 내부에서 접속(내부망)
    - ubuntu에 mysql 설치되었고, 비밀번호는 ssac으로 설정(pc에서 서버로 접속에서 서버에서 mysql실행시 암호 입력)
        - ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password
        BY '비밀번호';
    - mysql 접속해서 비밀번호 입력후, 설정변경
    - 외부에서 서버로 접속할때 패스워드 설정(설정후, restart해주기)
        - grant all privileges on *.* to root@'%' identified by '비밀번호';

# Workbench 활용

- 로컬 pc에서 인터넷 망을 통해 서버의 mysql을 작동시킨다.
- ubuntu의 mysql로 접속하는 것이므로, Username은 ubuntu가 아닌 root로한다.
- 데이터베이스에 모델 생성해서 업로드하기 (작업할 때, 데이터를 입력할 때 사용하는 기능)
    - File - open sql script로 파일 업로드(schemas에 refresh all)
    - File- New Model로 모델링하는법

              - users와 purchase는 1:N의 관계
              - items와 Purchase는 1:N(한 사람이 여러번 구매를 할 수 있다.)
              - 이후, database → forward engineer
              + world 같이 있던 테이블을 reverse engineer을 통해 테도식화 할 수 있음
              + 국가 언어에 여러개가 있을수 있음 : country : languge = 1:n
              + city와 같이 점선이 있는것은, 데이터가 0일 경우가 있어서다

- DML : 테이블 내의 데이터를 처리하는 쿼리문 (CRUD : READ)
    - 트랜젝션이 발생
- DDL : 데이터 정의어로 DB나 TABLE을 다루는 언어
- DCL : 데이터 제어어(현 과정에서 사용xx)
    - 트랜젝션이란?
        - 예를들어, 2명이서 한 계좌에서 동시에 출금할때 생길 수 있는 문제를 생각할 수 있다.
        - 동시에 출금을 했을 때, 출금 과정을 하나로 묶어서 진행한다.(1번 사람 출금 로직, 2번 사람 출금 로직을 하나로 합쳐서 진행)
