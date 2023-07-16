titanic = read.csv("titanic3.csv")
titanic<-titanic[, !names(titanic) %in% c("home.dest", "boat", "body")]
str(titanic)

#범주형 변수로 변환시키기
titanic$name<-as.factor(titanic$name)
titanic$ticket<-as.factor(titanic$ticket)
titanic$cabin<-as.factor(titanic$cabin)
titanic$pclass<-as.factor(titanic$pclass)
titanic$survived<-factor(titanic$survived, levels=c(0,1),labels=c("dead","survived"))
str(titanic)


#빈값 처리
levels(titanic$embarked)[1] <-NA
titanic$cabin<-ifelse(titanic$cabin=="",NA,titanic$cabin)

#테스트 데이터 분리

library(caret)
set.seed(137)
test_idx<-createDataPartition(titanic$survived, p=0.1)$Resample1
titanic.test<-titanic[test_idx,]
titanic.train<-titanic[-test_idx,]
NROW(titanic.test)
prop.table(table(titanic.test$survived))

save(titanic, titanic.test, titanic.train, file="titanic.RData")

#교차검증 준비
createFolds(titanic.train$survived, k=10)

create_ten_fold_cv<-function() {
  set.seed(137)
  lapply(createFolds(titanic.train$survived, k=10), function(idx){
    return(list(train=titanic.train[-idx,],
                validation=titanic.train[idx,]))
  })
}

x<-create_ten_fold_cv()
str(x)

#데이터 탐색
library(Hmisc)
data<-create_ten_fold_cv()[[1]]$train
summary(survived~pclass+sex+age+sibsp+parch+fare+embarked, data=data, method="reverse")

data<-create_ten_fold_cv()[[1]]$train
data.complete<-data[complete.cases(data),]
featurePlot(
  data.complete[,
                sapply(names(data.complete),
                       function(n) { is.numeric(data.complete [, n])})],
  data.complete [, c("survived")],
  "ellipse")

mosaicplot(survived~pclass+sex, data=data, color=TRUE, main="palcss and sex")
xtabs(~sex+pclass, data=data)
xtabs(survived=="survived"~sex+pclass, data=data)
xtabs(survived=="survived"~sex+pclass, data=data) / xtabs(~sex+pclass, data=data)

#의사결정나무 모형
library(rpart)
m<-rpart(survived~pclass+sex+age+sibsp+parch+fare+embarked,data=titanic.train)
p<-predict(m,newdata=titanic.train,type="class")
head(p)


#교차검증
library(foreach)
folds<-create_ten_fold_cv()
rpart_result<-foreach(f=folds) %do% {
  model_rpart <-rpart(
    survived~pclass+sex+age+sibsp+parch+fare+embarked, data=f$train
  )
  predicted<-predict(model_rpart,newdata=f$validation,type="class")
  return(list(actual=f$validation$survived, predicted=predicted))
}
head(rpart_result)

#정확도 평가
evaluation<-function(lst) {
  accuracy<-sapply(lst, function(one_result){
    return(sum(one_result$predicted ==one_result$actual) / NROW(one_result$actual))
  })
  print(sprintf("MEAN+/-SD: %.3f+/-%.3f",
                mean(accuracy),sd(accuracy)))
  return(accuracy)
}
(rpart_accuracy<-evaluation(rpart_result))

#조건부 추론 나무
library(party)
ctree_result<-foreach(f=folds) %do% {
  model_ctree<-ctree(
    survived~pclass+sex+age+sibsp+parch+fare+embarked,
    data=f$train)
  predicted<-predict(model_ctree, newdata=f$validation,
                     type="response")
  return(list(actual=f$validation$survived, predicted=predicted))
}
(ctree_accuracy<-evaluation(ctree_result))
