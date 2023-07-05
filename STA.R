#난수 생성 및 분포 함수

rbinom #이항분포
rf #f 분포
rgeom #기하분포
rhyper #초기하 분포
rbinom #음이항 분포
rnorm #정규분포
rpois #포아송 분포
rt #t분포
runif #연속 균등 분포

rnorm(100, 0, 10)

plot(density(rnorm(1000000,0,10)))

#포아송 분포

f(3 ; 1) # 정해진 시간 안에 어떤 사건이 일어날 횟수에 대한 기댓값이 1일 때, 그 사건이 3회 일어날 확률

dpois(3,1)
(1^3 * exp(-1)) / (factorial(3)) #포아송 수식

pnorm(0)
qnorm(0)

#기초통계량

mean(x, trim=0, na.rm=FALSE) #trim : 데이터를 크기 순서대로 나ㅕㅇㄹ한 뒤, 작은값과 큰 값에서 얼마만큼 제거한 다음 평균을 계산할지(절사평균 여부)

var(x, na.rm=FALSE) #분산

sd(x, na.rm=FALSE) #표준편차
fivenum(x, na.rm = TRUE)

table(X) #분할표

which.max(x) #최대값이 ㅈ ㅓ장된 위치의 색인 반환

#표본추출

sample(x, size, replace=FALSE, prob=NULL)
#replace : 복원추출여부, prob : 데이터가 뽑힐 가중치, 각 표본이 뽑힐 확률


#가중치를 고려한 표본추출
sample(1:10, 5, replace=TRUE, prob=1:10)

#층화 임의추출
sampling::strata(data,
                 stratanames=NULL,
                 size,
                 method=c("srswor","srswr","poisson","systematic"),
                 pik,
                 description=FALSE)

#srswor : 비복원 단순 임의추출
#srswr : 복원 단순 임의추출
#systematic : 계통추출
#pik : 각 데이터를 표본에 포함할 확률

library(sampling)
(x<-strata(c("Species"),size=c(3,3,3),method="srswor",data=iris))

getdata(iris,x)

strata(c("Species"), size=c(3,1,1), method="srswr", data=iris)

#계통추출
library(doBy)
(x<-data.frame(x=1:10))
sampleBy(~1, frac=.3, data=x,systematic=TRUE)

#분할표

xtabs(formula, data)

#ex
d<-data.frame(x=c("1","2","2","1"),
              y=c("A","B","A","B"),
              num=c(3,5,8,7))
(xtabs(num~x+y,data=d))

(d2<-data.frame(x=c("A","A","A","B","B")))
(xtabs(~x,d2))

#합, 비율의 계산
margin.table(x, #배열
             margin=NULL#색인 번호, 1은 행방향, 2는열방향, NULL은 전체값
             )

prop.table(x, margin=NULL)


#독립성 검정
#독립성 검정에는 카이제곱 검정을 사용함

library(MASS)
data(survey)
str(survey)

head(survey[c("Sex","Exer")])

xtabs(~Sex+Exer,data=survey)

chisq.test(xtabs(~Sex + Exer, data=survey))

#0.05보다 크면 귀무가설 기각할 수 없음

#피셔의 정확성 검정(표본수가 너무 적거나, 표본이 분할표의 셀에 너무 치우쳐져 있을 수 있음, 이 경우에는 피셔 사용)

fisher.test(x, y=NULL, alternative="two.sided")

#ex.
xtabs(~ W.Hnd + Clap, data=survey)
chisq.test(xtabs(~W.Hnd + Clap, data=survey))
fisher.test(xtabs(~W.Hnd+Clap,data=survey))

#성향이 사건 전후에 어떻게 달라졌는지 알아보는 경우 맥니마 검정을 수행함

mcnemar.test(x,
             y=NULL,
             correct=TRUE) #correct : 연속성 수정 적용 여부

binom.test(x,n,p=0.5,alternative=c("two.sided","less","greater")) #p : 성공 확률에 대한 가설

#적합도 검정
#실제로 가정한 분포를 따르는지 확인해보기

#카이제곱 ex. 30, 70의 분포를 따르는지 확인해 보기
table(survey$W.Hnd)
chisq.test(table(survey$W.Hnd), p=c(.3,.7))

#귀무가설 기각하니까 0.3, 0.7 이 아님

#샤피로 윌크, 표본이 정규분포로부터 온 것인지?
shapiro.test(x)

shapiro.test(rnorm(1000))

#콜모고로프 스미르노프 검정
ks.test(x, y, ..., alternative=c("two.sided","less","greater"))

#상관분석 : 두 변수 사이의 관련성 파익

#피어슨
#-1, 1 사이의 값, 선형적 상관관계 측정
cor(x, y=NULL, method=c("pearson","kendall","spearman"))
corrgram(x,type=NULL,panel=panel.shade,lower.panel=panel,upper.panel=panel,diag.panel=NULL,text.panel.textPanel)

#스피어만, 순위(rank)를 이용해 상관계수 계산

#상관계수 검정

cor.test(x, y, alternative=c("two.sided","less","greater"),
         method=c("pearson","kendall","spearman"))

