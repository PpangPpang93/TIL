스크립트

시작은 어느 회사에의 HR 데이터만 받은 상태로, 임의의 회사를 SSAC이라고 명명하고 분석을 시작했다.
또한, 이 회사의 HR데이터를 통해 이 회사가 어떤구조인지, 어떤 일을 하는 회사인지 알아가는 식으로 분석했습니다.

0 page : Reports
  발표에 앞서, 몇가지 정보를 말씀드리겠습니다.
  태블로 퍼블릭인 관계로 각 시트 제작 등 세세한 정보를 깃을 통해 공유하여 한명이 대표로 태블릿을 구조화 하는식으로 작업을 했다.
  HR데이터에 대한 설명이며, 아래는 어떤 질문을 시작으로 각각의 대시보드가 구성되었는지 설명되어 있으니, 관심 있으신 분들은 발표후에 확인바람

1page : Employees' information
  지금 보시는건, 이 회사 직원 분포에 대한 설명이다.
  성별을 기준으로 작업했다.

  이 데이터에는 재직자, 퇴직자가 전부 들어가 있는 상황이라, 이 회사의 현재 상황을 좀 더 명확하게 보기 위해서 재직자 데이터만 살펴보겠다.
  (참고로 재직, 퇴직 외에도 결석등의 추가 구분이 되어 있었으나, 보다 직관적인 해석을 하기 위해 실제 재직자, 퇴직자 신분으로 나누었다.)

  또한, 중간에 설명드리겠지만, 연령대 구분을 세대별로 구분해두기도 했다. 70년대 이전/ 70년대 / 80년~94년

* 현재 페이지 : active (재직상태)
* 
1. 도넛 차트 : 여성의 인구비율이 높다. 여성 비율이 높다
2. Employee by Department: 여성의 생산직 종사 비율이 높다.
3. Employee by Generation : y세대가 주류를 차지한다. 
4. Employee by Payrate : 자세히 보면, Production 구성원 비율 이 높고, 단순 생산직, 저임금임을 볼 수 있다
5. Age Group : 보통 젊은층이 분포하는 생산이 이루어지는 특성을 고려해도 20대의 직원 비율이 적다는 독특한 상황을 볼 수 있다. (3명)
6. Tenure Distribution : 평균적으로 재직 년도가 약 4년 정도 됨, 5년 이내 재직자 현황을 보니, 2015년 대대적으로 전부서에 채용이 꾸준히 이루어짐
7. Terminated Employee : 채용이 활발해진 2015년 부터 10명 이상 퇴사자 발생


2page : Department information

  부서별 현황도 재직자를 기준으로 살펴보자

1. Department Employment Status : 생산파트가 60%, IT(it& Sortware Engineering) 20%
2. Department Sex Ratio : 생산직 여성 인구비율이 높다 64%, IT 파트는 남성 비율이 높다. (23.3%)
3. Job Role By Gender : 각 직무를 남녀 비율로 관찰한것, 생산직과 IT쪽의 남/여 비율 차이 확인
4. Job Role : 생산직은 포지션이 3개인데 비해, IT쪽은 직무의 세분화가 포지션으로 배분됨
5. Generation By Department :
	각 부서별 인원 비율을 나타냄. 가장 인원이 많은 y세대를 기준으로 살펴보자
* A그룹(Admin offices, It/IS)와 B그룹 (Production, Sales, Software Engineering)에 신입(2년) 트랜드가 있음 확인
	

* A그룹의 신입 비율이 B그룹에 비해 높음 비교적 근속년수가 적고 30대~40대까지 채용한점 / 직무가 분할된 점을 감안해보면, 비교적 최근에 이 회사가 인사과 관리쪽 부분에 초점을 두고 필요한 직무에 해당하는 경력직 채용을 진행함을 유추해볼 수 있다

3page : Department information

1. Performace Rank& Sex
* 여성 노동자가 많지만, 재직자의 Performace Rank는 남/여 차이가 없고 퇴직자의 경우 남성이 평균적으로 높은 편이다
2. Pay Rate & Sex
* 평균근로자, 퇴사자 모두 여성에 비행 남성의 경우가 임금이 높은 편이다
3. Pay Rate & Performance Rank
* 퇴사자의 임금율이 재직자보다 전 성과 랭크에 걸쳐 낮다.
* 남성의 재직자의 임금률이 여성의 임금율보다 전 성과 랭크에 걸쳐 높다.
4. of Year at Comapny & Performance Rank
* 근속년수가 낮은 경우 퇴사자가 Performance Rank 랭크가 높았다
5. Race & Sex
* 재직자와 퇴직자의 남녀 모두 백인의 비율이 높았으며 여성의 경우에 재직자의 압도적으로 African American이 높다
6. Marital & Sex
* 남성 여성 모두 재직자와 퇴직자의 싱글과 기혼자의 비중이 비슷하다


4page : Department information
1. Employee Source :
* Recruit Ad, Referral (내부, 외부) 을 통해서 채용이 30% 이루어짐
* 23-> 9개로 그룹화 시켰다.
2. Generation Active & Terminated Employee
* 세대별 재직자와 퇴직자의 비율은 평균적으로 65:35 비율
3. Pay Rate_Generation Active & Terminated Employee
* 전 세대별 재직자가 퇴직자보다 임금이 높다. (세대별 재직자와 퇴직자의 임금이 차이가 있을 줄 알았음)
4. Pay Rate_Tenure Active & Terminated Employee
* 근속 년도와 임금의 상관관계는 없는 것으로 보이며 Job role이 연관 있는 것으로 판단됨

