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
 - git flow init -> main/branch 적힌거 잘 확인하고 다른 요소들 확인하고 다 엔터
 - git flow feature start “피쳐 이름” -> 작업하고 git add, commit
 - 해당 feature에서 작업 완료하기
 - git flow feature finish “피쳐 이름” : 호명한 feature는 삭제되고 develop에 merge가 됨 (feature branch 삭제, develop branch에 merge, develop에서 add,commit을 한번에 처리하는 효과)
 - feature를 활용해서 모든 작업이 끝난 develop branch를 만든다.
 - develop가 완료가 되면 release를 한다,

