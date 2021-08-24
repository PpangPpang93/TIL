# Git 3회차
  - git numpy 등 pull request에 참여해보기
  - blog에 1주일에 하나씩 글 써보기

- git flow(실습)
- 상황별 되돌리기
- 코드리뷰 외에 협업 도구들
- 모든 내용을 가지고 forking workflow를 같이 실습

##  Github blog
  - 참고 사이트 : https://spoqa.github.io / https://tech.kakao.com
  - Hexo 사용(node.js기반) : md파일을 html로 변환해주는 기능

### Hexo (https://hexo.io/ko/docs/setup)_hexo 사이트 / (https://www.youtube.com/watch?v=FwRKkZXSdY8) _강사님 녹화본
  1. 세팅 
  - sudo npm install -g hexo-cli.    (npm -v, hexo를 쳐서 설치가 잘 됐나 확인)
  - brew install nodejs	(nodejs -v)
 
  2. 블로그 생성 
  - 블로그용 레퍼지토리 설정할 위치로 가서 hexo init “file name”
  - 폴더가 생겼는지 확인하고 그 폴더로 들어가기 
  - npm install로 패키지 다 깔려있는지 확인
  - hexo server 입력해서 링크 접속 확인

  3. 포스팅
  - 포스팅 만들기 : hexo new post "My first post”(hexo new post “포스팅 이름”) : 파일 위치 확인되면 vi로 편집(단, 최초 5개 메타데이터는 냅두기). 이 때, config.yml & pakage.json 이 두가지 파일이 중요함.
  - hexo generate (md파일을 html로 변환해줌)
  - vi _config.yml 에서 작업하기. (markdown에서 :set nu하면 라인넘버 확인가능)
  - title 등 수정할 내용 수정 + url 채우기(https://PpangPpang93.github.io)
  (- github에서 새 레퍼토리 만들기 (단, 아이디.github.io로 만들어야함))
  - deploy를 위해 npm install hexo-deplyer-git —save 설치
  - 다시 vi _config.yml 들어가서 https://hexo.io/docs/one-command-deployment 여기에 써있는거 참고해서 102번줄가서 입력하기
  - hexo clean && hexo deploy 로 deploy진행 후, hexo server로 들어가서 확인
  - 테마: https://github.com/next-theme/hexo-theme-next 에서 설치


## Branching models 
 - Mac에서 git flow : https://danielkummer.github.io/git-flow-cheatsheet/index.ko_KR.html 여기서 사용방법 확인
 - git flow : 버전관리라 생각하자 feature -> develop -> (release) -> main


 - develop branch를 기본으로 작업을하고, 최종본을 relese branch에서 최종 확인해서 main에 올리는 개념
 -  hotfix branch는 긴급패치 개념

 1. git flow 생성
 - git flow init -> main/branch 적힌거 잘 확인하고 다른 요소들 확인하고 다 엔터
 
 2. git feature, develop
 - git flow feature start “피쳐 이름” -> 작업하고 git add, commit
 - 해당 feature에서 작업 완료하기
 - git flow feature finish “피쳐 이름” : 호명한 feature는 삭제되고 develop에 merge가 됨 (feature branch 삭제, develop branch에 merge, develop에서 add,commit을 한번에 처리하는 효과)
 - feature를 활용해서 모든 작업이 끝난 develop branch를 만든다.
 
 3. git release
 - develop가 완료가 되면 release를 한다. git flow release start “release branch name” <- 보통 v1 이런식으로 씀. 
  * 버전 naming : v0.1.12 / 예를들면 롤에서는 1년마다 시즌변경하는데 이건 0 부분의 변경에 해당함 / 보통 0은 베타버전, 1이 되면 정식버전 으로 한다.
  * 버전 rc의 경우 이것저것 테스트해보고 정식으로 추후에 푸는 버전이라보면된다.
 - 이 과정을 이번 교육에서는 하지 않을것 같으므로, 바로 닫아준다. git flow release finish v0.1 
 - 첫번째 commit은 main에 release를 넣어주는 merge
 - 두번째 commit은 패치노트라고 보면 된다.(실질적으로 어떤 내용을 반영했는지 쓰는거라 중요한 부분)
 - 세번째 commit은 develop에 merge됨 ( 두번째 작성한 패치노트가 합쳐짐)
 - git에 push하기 develop에서 git push -u origin develop / main에서 git push origin main / 
 - 해당 작업 이후, git push —tags 입력 후, branch를 develop으로 변경 / 태크를 잘 해놓으면 해당 버전 record를 명확히 확인이 가능하다)

## 역방향 작업 / git lg로 한번 내역 잘 보면서 해보기
  - push는 항상 최종 확인 후, push를 하자. push 전까지 한 일들은 어떻게든 되돌릴 수 있다.

 1. Rename
  - mv 명령어를 쓰면, 삭제와 새로 작성된 파일 두 가지가 생김. 또한, 삭제가 되면서 히스토리가 없어져버림. / mv로 다시 원래 이름으로 변경하면 따로 변동되는 사항은 없다.
  - git mv 를 사용하면 히스토리 관리가 가능

 2. Undoing
  - 파일을 수정하고 실행취소하기
  - git checkout — “실행취소할 파일명”  /  git checkout — . : 전체 취소 /  git restore “파일명”

 3. Unstaging
  - git add 했던 내역 취소하기
  - git reset HEAD ‘파일명’ 

 4. Commit 수정하기
  - add한 파일에 대한 commit 수정
  - git commit —amend (방금 했던 commit에 대한 것 수정) / git rebase —abort (이전 comiit 수정, 구글링 해서 하는게 나음 이건)

 ☆ 주의사항!!!(Reset Commit)
  - 일정 커맨드를 통해 commit을 지울수가 있기는 함(리셋 하드 / force push)

 5. Revert는 위에보다 안전한 방법
  ○ Example
  - b1,b2,b3라는 파일을 만들고 각각 add, commit을 수행한다.
  - git revert --no-commit HEAD~3..  : ‘..’까지 입력, 지금 기준으로 3번째 전으로 돌아가라. // git revert —abort를 하면 revert를 취소함


 - 삭제 확인 후, git commit 해서 지운 내역에 대한 commit하기

## Issue & Project
 - issue 에는 문제가 생기는 사항에 대한 질문과 응답, 개선사항 글쓰기
 - project 에는 해야하는 일, 끝난일 등을 확인 (To-do board)
 - issue도 별도로 작성이 가능하고, Milestones에는 기한을 정할 수 있다.
 - issue에 대해 milestones으로 기한 설정도 가능하고 -[ ]로 체크박스 만들 수 있다. 마지막에 close issue로 끝낼 수 있다.



# 팀 프로젝트 flow
 1. 리뷰를 하는 과정 중, Collaboration에서 add, commit, push가 가능하다.
  - 할수는 있지만, 추천하지 않는 방법
 
 2. Fork and merge
  - 롤 : 팀장, 팀원 구분하기(팀장이 refo 생성)

  *팀장 : 본인 터미널에서 clone 진행
  - git flow init 해서 설정, develop에서 팀원 소개하는 파일(introduce.md), fizzbuzz.py 생성
  - git add 로 둘 다 stage에 올리고, commit 하기(동시에)
  - git push -u origin develop 으로 git에 업로드
  - 위 작업이 끝난 팀장이 url 공유

  *팀원
  - 팀원들 해당 링크로 접속
  - issue에 해야할 사항 등록하고 fork 하기 (이슈를 꼭 먼저 등록하고 fork를 누르기) => 팀장의 refo가 나의 권한이 됨
  - git clone 으로 연동하고, 팀원들도 해당 위치에서 git flow init으로 flow 생성
  - 그러면 작업중인 파일이 보임(develop에) / 이때, git remote -v로 팀장의 remote와 내 remote를 볼 수 있음
  - 팀원은 feature를 만들고 들어감
  - 대상 파일 열어서 동작 확인 및 업무 진행
  - git add, commit 후, issue에 들어가서 체크리스트 체크(완료까지 반복)
  (- 해당 issue를 마무리할때, 마지막 commit에는 끝냈다는 표현이 들어가야함)
  - git flow feature finish “feature branch 이름”
  - develop에 merge가 되었고, 이걸 git push -u origin develop으로 push한다.(팀장 refo로 바로 업로드를 할 수는 없음)
  (- pull request를 통해 팀장이 합쳐줘야함)
  - pull request 작성하기. 단, main brach에 들어가지 않게 주의. (develop으로 옮기기)
  - pull request에 대한 내용 작성 (reslove #1 <- issue 1번 해결)

  *팀장
  - 팀장은 라벨, 어사인, 기한 등등 설정
  - Scrum board로 project 만들기
  - pull requests 확인하기. 코드 리뷰
 
  *팀원
  - pull request 수정
  - 이 경우, develop에서 작업해서 수정해도 됨 (각 수정사항 별 add, commit)
  - 수정 완료후, merge하면 협업 완료
  - 다른 팀원이 변경된 사항을 pull 받을 때, develop branch에서 git fetch upstream develop -> git merge FETCH_HEAD
    - 팀장은 git pull origin develop
