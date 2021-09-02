# git-base-overview

1. git, git-hub의 초기 세팅 복습
- 최초 git 실행 및 연동시, git config global user.name "name"/user.email "mail address"/core.editor "vim"/core.pager "cat"으로 설정하기
- 레퍼토리 만들고 주소 복사
- git init, git remote add origin 레퍼토리주소 입력
- 추후, README.md 등 설명 및 추가 기능 세팅 후, git add filename, git commit(or git commit -m "commit"),git branch -M main, git push -u origin main(최초, 이후 git push or git push origin main)
- commit 작성시 내용 타이틀 잘 적어두기(feat, docs, conf, fix, test, conf, build, ci ----)

2. branch와 git clone 활용
- git branch "Branch name" 으로 분기점 생성.
- git checkout branch로 해당 분기점으로 이동하여 작업 수행 및 git add, git commit으로 분기점 상태 업데이트
- main branch로 복귀하여 merge하여 branch들을 관리하고, merge시 문법상 오류나 중복되는 내용 등을 vi 와 commit 등을 통해 최신화
- git-hub network 또는 commit/history에서 분기점에 대한 히스토리가 남음

- 새로운 레퍼토리를 생성하고 연동하고 싶은경우, 일단 git-hub에서 레퍼토리 생성(이때, 라이센스 등 설정 유의하기)
- 새로운 레퍼토리와 연결하고 싶은 위치에서 git clone "새 레퍼토리 주소"를 입력
- readme.md 업데이트하고 git init, git add, git commit, git branch -M main, git push -u origin main 등 과정을 통해 연동하기 


- gitignore, gitattributes 등의 기능 더 공부하기
- 업데이트 대상이 아닌 파일들은 어떻게 해야하는지.(swp활용)
