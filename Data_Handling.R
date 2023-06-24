#파일 입출력

#csv 파일을 읽어들이기
read.csv(file, #파일명
         header = FALSE, # 파일의 첫 행을 헤더로 처리할지)
         # 데이터에 결측치가 포함되어 있을 경우 R의 NA에 대응시킬 값을 지정한다.
         # 기본값은 NA, NA로 저장된 문자열들은 R의 NA로 저장된다.
         na.strings="NA",
         #문자열을 팩터로 저장할지 문자열로 저장할지
         stringsAsFactors=default.stringsAsFactors()
)

write.csv(
  x,
  file="", #파일명
  row.names=TRUE
)

save(
  ..., #저장할 객체의 이름
  list=character(), #저장할 객체의 이름을 벡터로 지정할 경우 ...대신 사용
  file #파일명
)

load(
  file #파일명
)

#데이터 프레임의 행과 컬럼 합치기
rbind(...) #지정된 데이터들을 행으로 취급
cbind(...) #지정된 데이터들을 칼럼으로 취급

#ex.
rbind(c(1,2,3),c(4,5,6))

x<-data.frame(id=c(1,2),name=c("a","b"),stringAsFactors=FALSE)
x
y<-rbind(x,c(3,"c",F))
y

cbind(c(1,2,3),c(4,5,6))
y<-cbind(x,greek=c("alpha","beta"))
y

#apply 계열 함수
apply() #배열 또는 행렬에 주어진 함수를 적용한 뒤 그 결과를 벡터, 배열 또는 리스트로 반환
lapply() #벡터, 리스트 표현식에 함수를 적용해 그 결과를 리스트로 반환
sapply() #이건 벡터, 행렬 또는 배열로 변환
tapply() #벡터에 있는 데이터를 특정 기준에 따라 그룹으로 묶고, 그룹마다 함수 적용, 결과 반환
mapply() #sapply 확장 버전, 여러개의 벡터, 리스트를 인자로 받아 첫째 요소들을 적용한 결과, 둘째 요소들을 적용한 결과, 셋쨰 요소들을 적용한 결과 등을 반환

apply(
  X,#배열 또는 행렬
MARGIN, #함수를 적용하는 방향, 1 행방향 2 열방향
FUN # 적용할 함수
)

#ex
sum(1:10)
d<-matrix(1:9, ncol=3)
d
apply(d, 1, sum)
apply(d,2,sum)

rowSums(x, na.rm = FALSE) #행 합
rowMeans(x, na.rm = FALSE)#열 합

#lapply
lapply(X, FUN, ...) # 위 apply와 비슷함

unlist(X, #리스트 또는 벡터
       recursive=FALSE, #x에 포함된 리스트 역시 재귀적으로 변환할지 여부
       use.names=TRUE #리스트 내 값을 보존할지
       ) #리스트 구조를 벡터로 변환한다.

do.call(what, #호출 함수
        args, #함수에 전달할 인자의 리스트
        ) #함수를 리스트로 주어진 인자로 적용하여 결과로 반환함

#ex

(result<-lapply(1:3, function(x) { x*2}))
unlist(result)

#데이터 프레임을 처리한 결과를 리스트로 얻은 뒤 해당 리스트를 다시 데이터 프레임으로 변환하기
#1. unlist() 통해 리스트를 벡터로 변환
#2. matrix()를 통해 벡터를 행렬로 변환
#3. as.data.frame()을 사용해 행렬을 데이터프레임으로 변환
#4. names()를 사용해 리스트로부터 변수명을 얻어와 데이터 프레임의 각 컬럼에 이름 부여

#sapply lapply와 유사하지만, 리스트 대신 행렬, 벡터 등의 데이터 타입으로 결과를 반환

sapply(
  X, #벡터, 리스트, 표현식 또는 데이터 프레임
  FUN, #적용할 함수
  ... # 추가 인자, 해당 인자들은 FUN에 전달됨
)


#tapply 그룹별로 함수 적용하기 위함
tapply(
  X, #벡터
  INDEX, #데이터를 그룹으로 묶을 색인, 팩터로 지정해야 함
  FUN,
  ...
)

#데이터를 그룹으로 묶은 후 함수 호출하기

doBy::summaryBy() #데이터 프레임을 컬럼 값에 따라 그룹으로 묶은 후 요약 값 계산
doBy::orderBy() #지정된 칼럼 값에 따라 데이터 프레임을 정렬
doBy::sampleBy() #데이터 프레임을 특정 칼럼 값에 따라 그룹으로 묶은 후 각 그룹에서 샘플 추출

install.packages("doBy")
library(doBy)

base::summary() #다양한 모델링 함수 결과의 요약 결과 반환

sampleBy() #데이터를 그룹으로 묶은 후 각 그룹에서 샘플을 추출하는 함수

sample(x, #샘플을 뽑울 데이터 벡터
       size,
       replace=FALSE, #복원 추출 여부
       prob#데이터가 뽑힐 가중치
        )

doBy::sampleBy(
  formula, #우측에 나열한 이름에 따라 데이터가 묶임
  frac=0.1, #추출할 샘플의 비율, 기본은 10%
  reaplce=FALSE, #복원 추출 여부
  data=parent.frame(), #데이터 프레임
  systematic=FALSE #계통 추출 사용할지 여부
)

#데이터 분리&병합

split() #주어진 조건에 따라 분리
subset() #주어진 조건을 만족하는 데이터를 선택
merge() #데이터를 공통된 값에 기준해 병합

split(x, #분리할 벡터 또는 데이터 프레임 
      f #분리할 기준을 정한 벡터
)

subset(x,#일부를 취할 객체
       subset, #데이터를 취할 것인지 여부
       select #선택하고자 하는 칼럼
       )

merge(
  x, #병합할 데이터1 
  y, #병합할 데이터2
  by, #병합 기준으로 사용할 칼럼
  by.x = by,
  by.y = by,
  #x,y가 병합에 사용할 칼럼이 다르다면 by.x, by.y에 이를 저장
  #all은 공통된 값이 x,y 중 한 쪽에 없을 때의 처리, 기본 값은 FALSE, x,y 모두에 공통된 데이터가 있을 때만 병합
  #TRUE면 한 쪽은 NA로 병합, 공통된 데이터 없어도 병합
  all=FALSE,
  all.x,
  all.y #이 둘을 통해 x,y중 특정 쪽에 공통된 값이 없더라도 항상 결과에 포함되게 할 수 있다.
)

#데이터 정렬

sort(x, #정렬할 벡터
     decreasing = FALSE, #내림차순 여부
     #na.last : NA 값을 정렬한 결과의 어디에 둘 것인지를 제어함
     # TRUE는 결과의 마지막, FALSE는 처음 값
     #기본값인 na.last = NA는 정렬 결과에서 제외
     na.last=NA
     )

order() # 인자 정렬하기 위한 각 요소의 인덱스 반환

which(x) #조건이 참임 색은 반환
which.max(x) #최댓값의 위치 반환

#그룹별 연산

aggreage(x, by, #그룹으로 묶을 값의 리스트
         FUN#그룹별로 요약치 계산에 사용될 함수
         )

