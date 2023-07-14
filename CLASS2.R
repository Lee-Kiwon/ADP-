#로지스틱 회귀 모델

glm(formula, data, family)
predict.glm(object, newdata, type=c("link","response","terms"))

#ex.
d<-subset(iris,Species=="virginica"|Species=="versicolor")
str(d)

d$Species<-factor(d$Species)
str(d)
(m<-glm(Species~.,data=d,family="binomial"))

fitted(m)[c(1:5, 51:55)]

f<-fitted(m)
as.numeric(d$Species)

ifelse(f>.5, 1,0) == as.numeric(d$Species)-1

is_correct <-(ifelse(f> .5, 1, 0))
sum(is_correct)
sum(is_correct) / NROW(is_correct)

predict(m, newdata=d[c(1, 10, 55),], type="response")

#다항 로지스틱 분석
nnet::multinom(
  formula,
  data
)

fitted(object)

predcit.multinom(object,
                 newdata,
                 type=c("class","probs"))

library(nnet)
(m<-multinom(Species~.,data=iris))

head(fitted(m))
predict(m, newdata=iris[c(1,51,101),], type="class")

predict(m, newdata=iris, type="probs")
predicted <-predict(m, newdata=iris)
sum(predicted == iris$Species)/NROW(predicted)

xtabs(~predicted+iris$Species)

#의사 결정 나무
library(rpart)
rpart(formula, data)
predict.rpart(object,newdata,type=c("vector","prob","class","matrix"))
plot.rpart(x,uniform=FALSE,branch=1,compress=FALSE,nspace,margin=1)
rpart.plot::prp(x,type=0,extra=0,digits=2)

(m<-rpart(Species~.,data=iris))
plot(m, compress=TRUE, margin=.2)
text(m, cex=1.5)
library(rpart.plot)
prp(m, type=4, extra=2, digits=3)
head(predict(m,newdata=iris, type="class"))

party::ctree(formula, data)
party::predict.BinaryTree(obj, newdata, type=c("response","node","prob"))

install.packages("party")
library(party)
(m<-ctree(Species~.,data=iris))
plot(m)

#랜덤포레스트(앙상블 기법 사용)
randomForest::randomForest(
  formula,
  data,
  ntree=500,
  mtry,
  importance=FALSE
)

randomForest::predict.randomForest(
  object,
  newdata,
  type=c("response","prob","vote")
)

randomForest::importance(
  x,
  type=NULL
)

randomForest::varImpPlot(x,
                         type=NULL)

#ex
library(randomForest)
m<-randomForest(Species~., data=iris)
m
head(predict(m,newdata=iris))

#x,y를 직접 지정하는 방법
m<-randomForest(iris[,1:4],iris[,5])

#변수 중요도 평가

m<-randomForest(Species~., data=iris,importance=TRUE)
importance(m)
varImpPlot(m,main="varImpPlot of iris")

#파라미터 튜닝
expand.grid()
(grid<-expand.grid(ntree=c(10,100,200),mtry=c(3,4)))

library(cvTools)
library(foreach)
library(randomForest)
set.seed(719)
K=10
R=3
cv<-cvFolds(NROW(iris),K=K,R=R)
grid<-expand.grid(ntree=c(10,100,200),mtry=c(3,4))

result<-foreach(g=1:NROW(grid), .combine=rbind)%do%{
foreach(r=1:R, .combine=rbind) %do%{
  foreach(k=1:K, .combine=rbind)  %do%{
    validation_idx<-cv$subsets[which(cv$which==k),r]
    train<-iris[-validation_idx,]
    validation<-iris[validation_idx,]
    m<-randomForest(Species~.,
                    data=train,
                    ntree=grid[g, "ntree"],mtry=grid[g,"mtry"])
    #예측
    predicted<-predict(m,newdata=validation)
    #성능평가
    precision<-sum(predicted==validation$Species)/NROW(predicted)
    return(data.frame(g=g,precision=precision))
    }
  }
}

result
library(plyr)
ddply(result, .(g), summarize, mean_precision=mean(precision))

#신경망
nnet::nnet(formula, data, weights)

nnet(x,y,
     weights,
     size,
     Wts,
     mask,
     linout=FALSE,
     entropy=FALSE,
     softmax=FALSE,
     MaxNWts=1000)

predict.nnet(object,
             newdata,
             type=c("raw","class"))

#신경망 할 때는 지역해 문제 때문에 정규화 적용하는게 낫다

library(nnet)
m<-nnet(Species~., data=iris, size=3)
predict(m, newdata=iris)
predict(m, newdata=iris, type="class")

#X,Y 직접 지정, Y를 지시행렬로 변환

class.ind(cl)

#SVM
#다른 분류에 속한 데이터 간에 서로 간격이 최대가 되는 선을 찾아서 이를 기준으로 데이터를 분류하는 문제
#최대 여백 초평면 찾기, 커널 트릭

kernlab::ksvm(
  x,
  data=NULL
)

kernlab::ksvm(
  x, y=NULL,
  scaled=TRUE,
  kernel="rbfdot",
  kpar="automatic"
)

kernlab::predict.ksvm(
  object,
  newdata,
  type="response"
)

e1071::svm(formula, data=NULL)

e1071::svm(x,y=NULL,
           scale=TRUE,
           type=NULL,
           kernel="radial",
           gamma=if(is.vector(x)) 1 else 1/ncol(x),
           cost=1)

e1071::tune(
  method,
  train.x,
  train.y,
  data,)

library(kernlab)
(m<-ksvm(Species~., data=iris))
head(predict(m,newdata=iris))

ksvm(Species~., data=iris, kernel="vanilladot")
(m<-ksvm(Species~.,data=iris, kernel="polydot", kpar=list(degree=3)))

library(e1071)
tune(svm, Species~., data=iris, gamma=2^(-1:1),cost=2^(2:4))

attributes(result)
result$best.parameters

#클래스 불균형

library(mlbench)
data(BreastCancer)
table(BreastCancer$Class)

#업샘플링(데이터가 적은 쪽을 표본으로 더 많이 추출하는 방법, 다운샘플링은 데이터가 많은 쪽을 적게 추출하는 방법)

library(caret)
library(rpart)
caret::upSample(
  x,y #데이터
)

caret::downSample(
  x,y
)

x<-upSample(subset(BreastCancer, select=-Class),BreastCancer$Class)
table(BreastCancer$Class)
table(x$Class)
NROW(x)
NROW(unique(x))

#ex. 성능비교, 업샘플링 X와 업샘플O

#기본
data<-subset(BreastCancer, select=-Id)
parts<-createDataPartition(data$Class,p=.8)
data.train<-data[parts$Resample,]
data.test<-data[-parts$Resample,]
m<-rpart(Class~.,data=data.train)
confusionMatrix(data.test$Class, predict(m,newdata=data.test,type="class"))

#업샘플
data.up.train<-upSample(subset(data.train, select=-Class), data.train$Class)
m<-rpart(Class~., data=data.up.train)
confusionMatrix(data.test$Class, predict(m, newdata=data.test, type="class"))


#SMOTE, 비율이 낮은 분류의 데이터를 만들어 내는 방법(knn), 기존 샘플을 주변 이웃들을 고려해 약간씩 이동 시킨 점들을 추가함
DMwR::SMOTE(
  form,
  data,
  perc.over=200,
  k=5,
  perc.under=200
)

#문서분류

tm::summary(
  corpus
)

tm::inspect(
  x
)

library(tm)
data(crude)
summary(crude)
inspect(crude[1])
inspect(crude)

#문서변환
tm::tm_map(x, FUN)

removePunctuation #문장 부호를 없앰
stripWhitespace #불필요한 공백을 지움

inspect(tm_map(tm_map(crude,tolower),removePunctuation)[1]) #글자를 모두 소문자로 바꾸고, 문장 부호를 없앰

#문서의 행렬 표현
tm::TermDocumentMatrix(x,
                         control=list(),)
tm::DocumentTermMatrix(x,control=list())

#빈번한 단어
tm::findFreqTerms(
  x,
  lowfreq=0,
  highfreq=Inf,
)


#단어 간 상관관계
tm::findAssocs(
  x,
  terms,
  corlimit
)

#문서 분류

data(crude)
data(acq)
to_dtm<-function(corpus, label){
  x<-tm_map(corpus, tolower)
  x<-tm_map(corpus, removePunctuation)
  return(DocumentTermMatrix(x))
}
crude_acq<-c(to_dtm(crude),to_dtm(acq))
crude_acq_df<-cbind(
  as.data.frame(as.matrix(crude_acq)),
  LABEL=c(rep("crude",20), rep("acq",50))
)
str(crude_acq_df)
str(crude_acq_df$LABEL)