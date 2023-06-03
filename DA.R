#R 활용 데이터 분석(ADP 정리)

#01 변수
# 변수값 할당

#<- #어느 곳에나 사용하는 화살표
#= # 할당 후 값 쓰이면 저장이 안됨
  
#ex
mean(x<-c(1,2,3))
x

mean(x=c(1,2,3))
x

#스칼라

a<-3
b<-4.5
c<-a+b
print(c)

#NA
is.na(x) #NA가 저장되어 있으면 TRUE, 그렇지 않으면 FALSE

#NULL
is.null(x) #NULL이 저장되어 있으면 TRUE, 그렇지 않으면 FALSE

#NA와 NULL의 차이는 NA는 숫자 입력X, NULL은 보통 미정 값으로 많이 쓰임

