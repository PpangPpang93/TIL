# mongodb

## nosql : 테이블(컬렉션)사이의 관계가 없는 데이터 베이스
## 명칭이 sql과 다름
## 테이블 > 컬렉션 / 로우, 레코드 > 도큐먼트
## select가 느림, insert가 빠름
##빅데이터는 많은 데이터를 빠르게 저장 > nosql을 많이 사용한
## 예를 들어, 계정, 댓글, 포스팅 등의 데이터는 mysql (select가 많고 insert가 적을때)
## 텍스트에 드래그를 한다든지 하는로그 등 디테일한 부분은 nosql (insertr가 많고, select가 적을때)



### 해당 작업은 admin에서 실행
# mongodb는 자바스크립트 문법을 가져와서 쿼리로 작성한다. : 표준 sql과 다르지만 사용이 편리한 편이다.
# 실행 commnd+r, command+enter
# 데이터베이스 생성
use mongo
# 현재 선택중인 데이터 베이스 확인
db
# 데이터베이스 목록을 보여줌, 현재 mongo데이터베이스에는 데이터가 없어서 조회가 되지 않는다.
show dbs
# 도큐먼트 생성 (이제 show dbs로 mongo확인이 가능하다)
use mongo
db.user.insert({"name": "peter", "age":30})
# mongo에서 shell을 만들어서 작업을한다. 지금 이 장소에서는 admin으로 진행이 되므로, 매번 use mongo를 해줘야함
### 해당 작업은 admin에서 실행



# 해당 작업은 mongo에서 실행
# mongodb에서는 작업하는 db로 들어가서 작업을하는게 혼선이 생기지 않는다.

# create collection
# db.createCollection(name, [option])
# option : capped, autoIndex, size(byte), max(document)/ collection의 용량을 설정, sql에서 primary key와 유사함, 사이즈를 byte단위로 지정, 도큐먼트 갯수를 설정
# 예를 들어 숫자 3개만 저장이 되는 경우, 1,2,3,4,5 를 차례로 입력할때 1,2는 사라지고 3,4,5 가 됨(이런식으로 데이터를 관리함)
# 또, 1000byte, 10byte 순서로 저장이 되어 있는데 용량이 모자르면 10byte가 더 작은 크기여도 1000byte가 지워진다
use mongo

# sql과 다르게 table이 유동적으로 변한다 생각하면됨. 대신 열끼리 간섭할 수 없음 설정(이름,나이) -> 입력(이름,나이,이메일) 하면 이메일 열이 자동으로 생성됨
db.createCollection("user")

# option 사용해서 collection 생성
db.createCollection("info1",{autoIndexId: true, capped: true, size: 500, max: 5})
db.createCollection("info2",{autoIndexId: true, capped: true, size: 50, max: 5})

# 컬렉션을 생성하면서 데이터도 바로 입력
db.article.insert({"title": "ssac", "content": "mongodb"})

# 컬렉션 확인
show collections

# 컬렉션 삭제
db.article.drop()

# 도큐먼트 추가 ({"key":"value"})
db.info1.insert({"subject":"python","level":2})
db.info1.insert({"subject":"css","level":1})
db.info1.insert({"subject":"html","level":1})

# 도큐먼트 한번에 추가 : CRUD : CREATE
## 설정이 max:5개 이므로 info1 collection을 확인하면 값이 5개 들어있다. (처음 개별적으로 입력한 데이터 3개는 사라짐)
db.info1.insert([
    {"subject":"ruby","level":2},
    {"subject":"java","level":4},
    {"subject":"c++","level":5},
    {"subject":"js","level":1},
    {"subject":"go","level":1},
])
    

## 설정이 size:50byte 이므로 info2 collection을 확인하면 값이 4개 들어있다. (맨 위에 있던 ruby가 사라짐)    
db.info2.insert([
    {"subject":"ruby","level":2},
    {"subject":"java","level":4},
    {"subject":"c++","level":5},
    {"subject":"js","level":1},
    {"subject":"go","level":1},
])


## 새로운 컬렉션과 데이터 만들기
db.info.insert([
    {"subject": "python", "level": 2},
    {"subject": "css", "level": 1},
    {"subject": "html", "level": 1},
    {"subject": "ruby", "level": 2},
    {"subject": "java", "level": 4},
    {"subject": "c++", "level": 5},
    {"subject": "js", "level": 2},
    {"subject": "go", "level": 4},
])


# CRUD : READ : find
## find(query, projection)   (query : where, projection : select)
## 모든 데이터 조회
db.info.find()
    
## 조건별 조회
db.info.find({level: 2}) 
    
## 비교연산자 : $lt <, $lte <=, $gt >, $gte >=, $eq =
## 문자열에 따라 조건 설정(level이 2 이하인 document 조회)
db.info.find({level: {$lte:2}})
## level이 3이상인 경우
db.info.find({level: {$gte:3}})
## $in
db.info.find({subject: {$in: ["java", "css"]}})
    
## 논리연산자
## $or, $and, $not, $nor
db.info.find( { $and: [{subject: "python"}, {level: {$gte: 2}}]} )

## projection
## level 출력 유/무 (아이디도 안보고 싶으면  db.info.find({}, {_id: false, level: false}) / id를 제외하고 true하려면 다 true로, false하려면 다 false로
db.info.find({}, {"level": true})

## sort : 1:asc, -1:desc
db.info.find().sort({level: -1})

## limit
db.info.find().limit(3).sort({"level": 1})

## skip : sql에서는 limit 3,4 형식으로 쓰던것
db.info.find().skip(3).limit(4)

## update
## update(query, set, option)
### java를 sass로 바꿈, 이때 같은 행에 있는 level도 같이 바꿔줘야함(하나만 바꾸는 방법도 있음)
db.info.update(
    {subject: "java"},
    {subject: "sass", level: 2}
)
db.info.find()

## upset : 기존에 없는 데이터면 추가를해준다 (upsert: true 입력)
db.info.update(
    {subject: "less"},
    {subject: "less", level: 3},
    {upsert: true}
)
db.info.find()
    
## $set
## set없이 사용하면 ruby가 있던 행에 level: 2라는 데이터만 남고 ruby가 지워져버림
db.info.update(
    {subject: "ruby"},
    {level: 2}
)
db.info.find()    

## set 사용    
db.info.update(
    {subject: "python"},
    {$set: {level: 3}}
)
db.info.find()    

## level 2의 subject를 다 python으로 바꾸려했지만 한번밖에 실행되지 않음
db.info.update(
    {level: 2},
    {$set: {subject: "python"}}
)
db.info.find()    

## multi 사용    
db.info.update(
    {level: 2},
    {$set: {subject: "python"}},
    {multi: true}
)
db.info.find()        
    
# function
var pageNation = function(page, pageBlock){
    return db.info.find().skip((page-1)*pageBlock).limit(pageBlock)
    
}
pageNation(2, 3)    
    
    
    
