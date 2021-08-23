#Git 2회차

## 과제 리뷰
### 강사님 코드
- Spiderman.md 를 만들rl -> branch 생성 (빈 spiderman)
- git checkout toey -> vi Spiderman.md -> 내용 입력 -> git add Spiderman.md -> git commit 
- git checkout main -> git merge tobey -> git branch -D tobey(작업완료된 브랜치 지움)  / main에 합쳐짐
- git branch andrew -> git add Spiderman.md -> vi Spiderman.md (이 때, 파일은 비어있음) -> 내용입력 -> git add Spiderman.md -> git commit
- git checkout main -> git merge Andrew (Conflict 발생)-> vi Spiderman.md -> 내용 수정 -> git add Spiderman.md -> git commit -> git branch -D Andrew // 해당과정 tom에서 반복
- git push


  - 파일이 잘못돼서 지우고 다시진행할 경우, swp 파일(종료가 정상적으로 되지 않아 생긴경우) 생길경우 -> touch Spiderman.md.swp 로 잡고 -> rm Spiderman.md.swp로 지우면 해결 됨
  - merge 할때 main으로 가도 commit을 작성해서 사용에 문제는 없음. 단순 시각화의 문제
  - git branch에 여러개를 동시에 작업하는 경우 git flow?를 활용하면 됨
  - git commit을 삭제하는건 올바른 방법이 아니다
  - commit을 안햇으면 branch에서 옮겨다닐 수 있다


## 주피터 노트북
  - git에서 관리할 경우, 코드에 대한 output도 확인이 가능함
  - 다만, blob으로 저장을 할 때, 코드에 대한 history를 관리가 어려움 / 길이가 길면 업로드 오류가 될 때도 있음
### 단점을 보완하는 방법
 1. Cell 탭에서 output 관리 기능으로 output을 지우고 업데이트 : 실행결과를 알 수 없음 
 2. python으로 Convert하기 : $jupyter nbconvert {파일이름} —to=“python” —output-dir=“./dest” —output=“파일이름.py” -> 터미널에서 작업가능 : 해당 명령어가 기억하기 쉽지 않음
 3. ReviewNB 사용 app.reviewnb.com 에서 연결해서 업로드하면 2번 과정 쉽게 처리됨

  - git에 업로드를 할 수 있는 정도만 알아두고, 추후 SQL, Python 강의 때 재설정
  - 주피터 노트북 파일 만드는것 한 번 다시 해보기(2번 방법 다시해보기)

## Code review
 - 코드리뷰어/ 코드 생성자 지정 (영상에서는 강사님 : 코드리뷰어 <- 키왕짱 계정 : 코드를 생성)
 1. 코드생성자 : 레퍼토리 생성 -> git clone으로 레퍼토리 연결
 2. 코드 리뷰를 받기 위해서는 branch를 생성 : git branch 0823-fb -> checkout 
 3. touch fizzbuzz.py 만들고 vi로 작업하기 -> 간단한 코드써서 작동하는지 확인 후, git add, git commit : 여기까지가 환경설정
 4. 코드 다시 열기 : 코드 작성하고 python 돌려보고 다시 add commit / 히스토리 관리를 위해 fizz -> buzz -> fizzbuzz 각각 작업후 add, commit
 5. 킹왕짱에서 새로운 레프, 브랜치에서 git push -u origin 0823-fb
 6. 코드리뷰 받을 사람 지정 : Settings -> manage access -> invite a collaborator : 아이디 -> 받은사람은 메일 확인
 7. 내가 할 땐, main 가서 merge 하는데, 여기서는 리뷰어의 승인을 받고 merge 가능/ 브랜치로 다시 가서 com 뭐시기 눌러서 승인해주기 / 공동으로 merge하는거라 승인한다 생각하자
 8. Assigness에는 코드를 만든사람 추가
 9. 코드 리뷰어로 들어가기 -> pull request -> add your review -> 코드 피드백하기 -> finish your review 누르기
 10. 코드 작성자로 들어가서 리뷰에 대한 피드백 -> 이때는, 수정 후 add, commit, push 하기
 11. 코드 리뷰어가 재확인 -> reslove 눌러주고 -> viewed를 체크하고 -> review changesdptj approve하기
 12. 코드 작성자가 merge pull request 누르면 main에서 확인 가능


**로컬에 연동하는게 어떻게 될지 다시 확인해보기

