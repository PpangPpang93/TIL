# Git-blog update

- 1주에 1회 git-blog 업데이트하기 
- 현재 레퍼지토리, 블로그 자체는 형성이 되어 있어서 블로그 글 작성 및 포스팅 연습

## 작업 순서
1. 블로그 폴더에 들어간다.
2. hexo new post "포스팅 제목"으로 포스팅을 만든다.
3. 블로그 폴더내, source로 들어가서 해당 포스팅 내용을 작성한다.
4. 다시 상위 폴더로 이동해서 hexo generate를 통해 html로 전환시킨다.
5. hexo -deplyer-git을 통해 deploy를 한다.
6. hexo clean && hexo deploy로 서버에 업데이트한다.
7. hexo server로 서버를 오픈해서 링크 접속을 통해 포스팅 내용을 확인한다.

## 추가 작업(21.09.05기준)
- 블로그 포스팅 틀 잡았음, 디자인 한번 신경써보기
- 포스팅 목록화 진행
