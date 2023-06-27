install.packages("plyr")
library(plyr)

adply() #a(배열)을 받아 d(데이터 프레임)을 반환하는 함수 a + d + ply

plyr::adply(.data, #행렬, 배열 또는 데이터 프레임
            # 함수를 적용할 방향 1(행 방향), 2(컬럼 방향), c(1,2) 행과 컬럼 모두 지정
            .margins,
            .fun=NULL)

iris

apply(iris[, 1:4], 1, function(row) { print(row) } )

apply(iris, 1, function(row) {print(row)})

#apply는 각 칼럼에 서로 다른 데이터 타입이 섞여있다면 예상치 못한 타입 변환이 일어날 수 있음

adply(iris, 1, function(row) {row$Sepal.Length >= 5.0 & row$Species == "setosa"})

# 위와 같은 경우 최종 반환 값이 데이터 프레임으로 의도, 하지만 그런 경우 함수부터 데이터 프레임으로 반환하는 것이 안전함

adply(iris, 1, function(row) {data.frame(sepal_ge_5_setosa=c(row$Sepal.Length >= 5.0 & row$Species == "setosa"))})


ddply() #데이터 프레임(d)를 입력으로 받아 데이터 프레임을 보내는 함수

plyr::ddply(
  .data,
  .variables, # 데이터를 그룹 지을 변수명
  .fun=NULL
)

#그룹마다 연산 쉽게 수행하기

#객체 변환
base::transform(_data #변환할 객체)

plyr::mutate(.data, #변환할 데이터 프레임
             ) #해당 연산은 연산이 여러개 있을 때 앞의 연산 결과를 뒤에서 참조 가능

plyr::summarise() #요약

subset(x, #일부를 취할 데이터
       subset, #데이터를 선택할지 여부 고룸
       select #선택할 칼럼의 벡터, 제외할 칼럼은 -를 붙여 표시
       )


#ex.
head(ddply(baseball, .(id), transform, cyear=year-min(year) + 1))

head(ddply(baseball, .(id), summarise, minyear=min(year),mxyear=max(year)))

head(ddply(baseball, .(id), subset, g==max(g)))     

#데이터 구조 변형 & 요약
melt() #여러 칼럼으로 구성된 데ㅣㅇ터를 식별자, 변수, 값으로 변환
cast() #melt된 데이터를 다시 여러 칼럼으로 변환

library(reshape2)
head(french_fries)

reshape2::melt.data.frame(
  data, #melt할 데이터
  id.vars, #식별자 칼럼들
  measure.vars, #측정치 칼럼들
  na.rm = FALSe
)

m<- melt(french_fries, id.vars = 1:4)
head(m)

library(plyr)
ddply(m, .(variable), summarise, mean = mean(value, na.rm=TRUE))
french_fries[!complete.cases(french_fries),]
m<-melt(id=1:4, french_fries, na.rm=TRUE)
head(m)

reshape2::dcast(
  data,
  #변환 포뮬러 규칙
  # id~variablee변수 형태로 적음
  # 아무 변수도 지정하지 않으려면 .사용
    #모든 변수 표현하려면 ,,, 사용
  formula,
  fun.aggregate=NULL
)

m<-melt(french_fries, id.vars=1:4)
r<-dcast(m,time+treatment+subject+rep~...)
rownames(r)<-NULL
rownames(french_fries)<-NULL
identical(r,french_fries)

#데이터 테이블
library(data.table)

data.table(..., stringsAsFactors=default.stringsAsFactors()#문자열 팩터로 저장할지 여부
           )

data.table(df)

#반복문

library(foreach)
foreach(...,#표현식에 넘겨줄 인자
        #combine은 ex에서의 반환값을 어떻게 합칠지 지정, cbind, rbind, c
        .combine) %do% ex

foreach(i=1:5) %do%{
  return(i)
}

#병렬처리

#멀티코어 사용해 적용, 여러 프로세스에서 병렬적으로 돌아갈 수 있음

library(doParallel)

doParallel::registerDoParallel(
  cl, #makeCluster 클러스터에 만들 노드 수
  cores=NULL)

  

