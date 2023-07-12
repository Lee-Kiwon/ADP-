#데이터 탐색

Hmisc::describe(x, exclude.missing-TRUE)

Hmisc::describe(x, data, na.action)

Hmisc::summary.formula(formula, data, na.action=NULL, fun=NULL,method=c("response","reverse","cross")
                    )

str(mtcars)

install.packages("Hmisc")
library(Hmisc)
describe(mtcars)

summary(mtcars)
summary(mpg~cyl=hp, data=mtcars)

#데이터 시각화
caret::featurePlot(
  x,
  y,
  plot=if(is.factor(y))
)

plot(iris)
plot(iris$Species)

plot(Species~Sepal.Length,data=iris)

with(iris, {plot(Sepal.Length, Sepal.Width, pch=as.numeric(Species))
  legend("topright",legend=levels(iris$Species),pch=1:3)})

#데이터 전처리

#데이터 ㅓㅇ규화->변숫값의 분포를 표준화 함
scale(x, center=True, scale=True)

#PCA(차원 감소)
princomp(x, cor=FALSE)

x<-1:10
y<-x+runif(10,min=-.5,max=.5)
z<-x+y+runif(10,min=-10,max=.10)
(data<-data.frame(x,y,z))
pr<-princomp(data)
summary(pr)

pr$scores[,1:2]

#결측치 처리

complete.cases()
is.na(x)
DMwR::centrallmputation(data)
DMwR::knnImputation(data,k)

#변수 선택
caret::nearZeroVar(x,
                   frqeCut=95/5
                   uninqueCut=10,
                   saveMetrics=FALSE)

#상관계수
caret::findCorrelation(x, cutoff=.90)

FSelector::linear.correlation(
  formula,
  data
)

FSelector::rank.correlation(
  formula,
  data
)

FSelector::cutoff.k(
  k
)

#변수 중요도 계산
library(mlbench)
library(caret)
data(Vehicle)
findCorrelation(cor(subset(Vehicle, select=-c(Class))))
cor(subset(Vehicle,select=-c(Class)))[c(3,8,11,7,9,2),c(3,8,11,7,9,2)]

FSelector::chi.squared(formula, data)
install.packages("FSelector")
library(FSelector)
library(mlbench)
data(Vehicle)

(cs<-chi.squared(Class~., data=Vehicle))

caret::varImp(
  object
)

library(mlbench)
library(rpart)
library(caret)
datat(BreastCancer)
m<-rpart(Class~., data=BreastCancer)
VarImp(m)

#모델 평가 방법
predicted<-c(1,0,0,1,1)
actual<-c(1,0,0,1,1)

xtabs(~predicted+actual)
sum(predicted == actual) / NROW(actual)

library(caret)
confusionMatrix(data,reference)

confusionMatrix(as,factor(predicted), as.factor(actual))

ROCR::prediction(predictions,labels)

#교차검증
cvTOols:cvFolds(n,K=5,R=1,type=c("radom","consecutive","interleaved"))

install.packages("cvTools")
library(cvTools)
cvFolds(10,K=5,type="random")
cvFolds(10,K=5,type="consecutive") #연속된 데이터 차례로 ㅓㅁ증
cvFolds(10,K=5,type="interleaved") #연속된 데이터를 차례로 서로 다른 K의 검증 데이터로 할당
