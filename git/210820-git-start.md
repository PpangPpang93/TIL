# 210820 TIL

## 오늘 한 일

- shell command
- vim command
- markdown syntax
- git config
- start profect with git init
- add commit push
    - add: blob을 working directory에서 stage로 이관
    - commit : stage의 blob에 대해 metadata 박성 및 snapshot
    - push : local repo에 적재된 commit들을 remote repository로 이송
- start profect with git clone


## 내일 할 일

- logical-thinkg TIL업데이트하기 


- 최우영 강사님 : me@ulgoon.com

###Shell
-  운영체제의 커널과 사용자를 이어주는 소프트웨어
-  sh, csh, bash, zsh : 유닉스 쉘 (bash를 일반적으로 사용하지만, zsh가 좀 더 완벽함

#### 기초 명령어(명령어 뒤 ‘-‘는 flag라고 부름) CLI(Command Line Interface) 사용중(GUI 기반 내용을 CLI 를 사용해서 표현)
-  GUI(Graphic User Interface) : Finder, 파일탐색기 등 
-  CLI 는 실행 후 , 상태를 꼭 확인하자
명령어	내용
ls	list segment
ls -l	line by line, 객체들을 한 줄씩 표시하면서 부가정보도 표시해라
ls -a	ls와 비교했을 때, ‘.’이 붙은 숨겨진 파일도 다 나옴
ls -al	
cd	하위 디렉토리로 이동
cd .. (점의 개수로 확인)	상위 디렉토리로 이동
cd ../..	상위로 두번 이동
mkdir	디렉토리 만들기
touch	파일 만들기(텍스트 기반만 가능), pdf/ppt/hwp 등은  생성은 되지만 작동이 안됨
mv (파일명) (폴더명)	이동
cp (파일명) (폴더명)	복사(ex: cd readme.txt .. : 상위폴더에 파일 복사) 
	내 위치 밖에 있는 파일을 끌어올때 폴더 위치 기준으로 잘 확인
rm	파일의 흔적을 지움 (delete는 정보 자체를 지워버림)
	폴더를 지울 수 없음. 내부의 파일에 접근할 방법을 지우는것이기 때문에, 내부 파일이 있으면 안됨
rm -rf 	강제로 지우기
mv 이름바꿀대상 바꿀이름	이름 바꾸기
mv writeme.md bin/test.md	writeme.md를 하위폴더 bin에 test.md로 바꿔서 이동
cp test.md ../readme.txt	test.md를 readme.txt로 이름을 바꿔서 복사기
mv bin/hello.py ./bye.py	현재폴더(상위)에 하위폴더 파일을 이름바꿔서 가져옴

###vim : CLI의 메모장
명령어	내용
어플리케이션 파일명(ex: python hello.py)	해당 어플리케이션으로 파일 실행(파일바로가기 아이콘 클릭기능)
vi 파일명 (ex : vi world.md)	‘~’ (틸드)가 나옴 : 틸드는 이 파일의 끝을 의미함
	normal 모드에서 i 를 눌러 insert 모드로 변경
	h,j,k,l 가 방향키
y	복사
y2(h j k l)	2줄 복사
p	붙여넣기
u	실행취소
control + r	앞으로
dd	줄 지우기
d2(h j k l)	2줄 지우기
o,O	각각, 아래줄, 윗줄을 한줄씩 열고 작업이 가능
a	append모드, 바로 옆에서 insert

##Markdown
- vi 파일명
- 표현을 좀 더 단순하게 할 수 있음
- 주피터를 통한 보고서 작성시 잘 활용하기
- 저장방법 :  ‘:q’ 를 누르기 / ‘:wq’ 저장 후 나가기 /. ‘w’ 중간저장 / cat 파일명 : 하면 vim창 안켜지고 바로 내용 확인가능

## Git

### 배경지식
- VCS(Version control system)
- 장점 : 예시) ppt파일 하나에 버전들이 다 남는다, 원하는 시점으로 check out이 가능함
   	       branch로 개발하면 편하게 시험이 가능, 성공적인 결과가 있을 경우 Merge해서 합친 내용을 반영하기도 가능
	       인터넷이 연결되지 않아도 개발 가능 (어떤 시간대에 한 내용이 기록됨)
- GUI Client를 사용 할 수 있음
- CLI first : 소스코드를 Cloud Platform에서 사용할때 CLI를 이용해야지만 가능하다
- git은 도구고, git을 이용해서 웹서비스를 제공하는 것이 github
 - github(Microsoft에 인수됨) / bitbucket(협업이 많은 경우) / gitlab(사설서버 이용가능, 보안)

### git object
- blob : 파일 하나의 내용에 대한 정보
- Tree : blob이나 subtree의 메타데이터(디렉토리 위치, 속성, 이름 등)
- commit : 커밋 순간의 스냅샷

    1. working directory
    2. staging area
    3. localrepo
    4. remote repo
 	  - 1->2 : git add           양말/주방용품/상의/하의 별로 따로 나눠서 담음. / blob을 add
	  - 2->3 : git commit    따로 나눠진 물품을 포장 
	  - 3->4 : git remote    포장한것을 배송시킴

- 폴더들을 생성하고 그 내용을 push하고 싶으면 각 폴더에 파일을 만들어야 논리적으로 인식이 되어 pass되지 않고 push가 됨
- git status -uall : 업로드 되는 파일의 세부 이름까지 나옴
- stage를 통해 내가 원하는 파일만 업로드 할 수 있음(부분적인 커밋)


### Conventional Commits 을 통해 자세한 commit 작성하는 습관기르기
- fix : 오류를 수정함
- refactor : refactoring, 작동은 하는데 수정함
- feat : 기능 개발 관련
- docs : 문서
- conf : 환경설정 (파이썬 뭐 쓸건지 라이브러리 뭐 쓸건지 등)

###  git clone
- TIL : today i learned
- 레포 안에서 clone을 하게되면 종속되어버림 : 새로운 레포가 의미가 없어짐 => 상위 폴더에서 clone하기

###  git repository 만들때 License 참고사항(약식)
- MIT License : 영리적 목적으로 사용해도 될 정도로 자유로움
- Apache License : 소유권을 주장할 수 있음
- GNU : 소스를 한줄이라도 여기서 소스를 가져간다면 GPL을 사용해야함(다른 라이센스를 못씀)



### 내용 정리추가로  필요함
