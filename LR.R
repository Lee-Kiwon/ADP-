#선형 회귀의 기본 가정

#1. 종속 변수와 독립 변수 간에 선형성
#2. 독립변수는 고정값
#3. 오차는 평균이 0, 분산이 시그마제곱인 정규분포, 모두에 대해 평균과 분산이 일정, 서로 독립
#4.독립 변수 간 다중 공산성 적어야 함

lm(formula, data)
data(cars)
head(cars)

(m<-lm(dist~speed, cars))

coef(m)

#적합값
fitted(m)
#잔차
residuals(m)[1:4]
#실제 데이터 값
fitted(m)[1:4] + residuals(m)[1:4]
cars$dist[1:4]
#신뢰구간
confint(m)
#잔차제곱합
deviance(m)

#예측과 신뢰구간
predict.lm(object,
           newdata,
           interval=c("none","confidence","prediction"))

predict(m, newdata=data.frame(speed=3))

coef(m)

predict(m,newdata=data.frame(speed=c(3)),interval="confidence")

summary(m)

#분산분석
anova(object,...)

anova(m)

#시각화
plot(m)

#중선형회귀, 하나 이상의 독립 변수가 사용됨
(m<-lm(Sepal.Length ~ Sepal.Width + Petal.Length+Petal.Width, data=iris))
summary(m)

#범주형 변수
(m<-lm(Sepal.Length~.,data=iris))

#상호 작용
data(Orange)
Orange
with(Orange, plot(Tree, circumference, xlab='tree', ylab='circumference'))

interaction.plot(
  x.factor,
  trace.factor, #자취를그릴 레벨을 저장한 팩터
  response
)

with(Orange, interaction.plot(age,Tree,circumference))

#이상치
rstudent(model)

car::outlierTest(model)

data(Orange)
m<-lm(circumference~age + I(age^2), data=Orange)
rstudent(m)

install.packages("car")
library(car)

outlierTest(m)
#변수 선택 방법

#전진선택, 변수 소거, 단계적 방법
step(object,
     scope,direction=c('both','forward','backwadr'))
formula(x)

install.packages("mlbench")
library(mlbench)
data(BostonHousing)
m<-lm(medv~.,data=BostonHousing)
m2<-step(m, direction="both")
formula(m2)

#모든 경우 비교
leaps::regsubsets(
  x,
  data,
  method=c("exhaustive","forward","backward","seqrep"),
  nbest=1
)

install.packages("leaps")
library(leaps)
m<-regsubsets(medv~.,data=BostonHousing)
summary(m)
plot(m,scale="adjr2")
