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

#문자열

a<-"hello"
print(a)

#진릿값

TRUE&TRUE #TRUE

TRUE&FALSE #FALSE

TRUE | TRUE #TRUE

TRUE | FALSE #TRUE

!TRUE #FALSE

!FALSE #TRUE

c(TRUE, TRUE) & c(TRUE, FALSE) #TRUE FALSE

c(TRUE, TRUE) && c(TRUE, FALSE) #TRUE

#팩터 - 범주형 데이터를 표현하기 위한 자료
#-팩터 관련 함수

factor(x, #팩터로 표현하고자 하는 값
       levels, #값의 레벨
       ordered #TRUE 순서형, FALSE 명목형(기본값 FALse
       )

nlevels(x) #팩터에서 레벨 개수 반환

levels(x) #팩터에서 레벨 목록 반환

is.factor(x) # 팩터인지 아닌지 반환

ordered(x) #순서형 팩터를 생성

#벡터

names(x #이름 저장할 R 객체)
) <- value #저장할 이름

#ex
x<-c(1,3,4)
names(x) <-c("kim","seo","park")
x

x[n] #x의 n번째 요소
x[-n] #x에서 n번째 요소를 제외한 나머지
x[idx_vecotr] #x로부터 지정된 요소 얻어옴(idx_vector는 셀 이름 표현하는 문자열 벡터)
x[start:end]#start 부터 end 까지 반영

length(X) #객체 길이 반환
NROW(x) # 배열 행 수 반환

#ex
x<-c("a","b","c")
x[1]
x[3]    

x[-1]

#행렬
seq(from,# 시작값
    to, #끝값
    by #증가치
    )

#반복
rep(x, times = value, each = value)

#리스트 - 리스트는 벡터와 달리 서로 다른 데이터 타입을 담을 수 있음

#리스트 기본 함수
list(key1=value1, key1=value2, ...)

#ex
(x<-list(name="foo",height=70))

#리스트 데이터 접근
x$key
x[n] #데이터 서브리스트
x[[n]] #요소 단위

#행렬

matrix(data, nrow, ncol, byrow=FALSE, dinmaes=NULL)

dimnames(x) #  차원별 이름
dimnames(x) < -value #이름 부여

#ex
matrix(1:9, nrow=3, dimnames=list(c("r1","r2","r3"),c("c1","c2","c3")))

#행렬 데이터 접군
A[ridx,cidx] #ridx 행 숫자, cidx 열 숫자

#행렬 연산
A + x
A + B #행렬 덧셈
A %*% B #행렬 곱

t(x) # 전치행렬
solve(a,b) #행렬의해구하기

#배열 다차원이며 2 X 3 X 4 이런 식으로

array( data = value, dim = length(data), dimnames =NULL)
#data : 데이터 저장, dim = 배열의 차원, dimnames = 차원의 이름

#ex
(x<-array(1:12, dim=c(2,2,3)))

x[1,1,1]

#데이터 프레임 - 표 같은 형태로 저장

(d<-data.frame(X=c(1,2,3,4,5),y=c(2,4,6,8,10),z=c("M","F","M","F","M")))
#stringAsFactor를 지정하지 않으면 문자열이 팩터로 저장됨

d$X

d[m,n,drop=TRUE] #drop = FALSE하면 데이터 프레임 형태 유지하면서 가져오기 가능

#데이터 타입 판별ㄹ
class(x)
str(x)
is.factor(x)
is.numeric(x)
is.character(x)
is.matrix(x)
is.array(x)
is.data.frame(X)

#타입을 변환시키고 싶으면 is를 as로 바꾸기
