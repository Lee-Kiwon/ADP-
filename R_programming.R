#if

#기본형
if (cond){
  #cond가  참일 때 실행할 문장
} else{
  #cond가 거짓일 때 실행할 문장
}

#ifelse

ifelse(test,yes,no)

#ex
x<-c(1,2,3,4,5)
ifelse(x %%2 ==0, "even", "odd")

#반복문

for (i in data){
  #i를 사용한 문장
} #data에 들어 있는 각각의 값을 변수 i에 할당하면서 각각에 대해 블록 안의 문장을 수행한다.

while(cond){
  
} #조건 cond가 참일 때, 블록 안의 문장을 수행한다. 무한루프로 하고 싶으면 cond 안에 true 넣으면 됨

repeat{
  #반복해서 수행할 문장
}

#ex.

for (i in 1:10) {
  print(i)
}

i<-1
while (i<=10){
  print(i)
  i<-i+1
}


i<-0
while(i<=9){
  i<-i+1
  if (i %% 2 !=0){
    next
  }
  print(i)
}


i<-1
repeat {
  print(i)
  if(i>=10) {
    break
  }
  i<-i+1
}

#연산

+,=,*,/ #사칙연산
  
n %%m # n을 m으로 나눈 나머지

n %/% m #n을 m으로 나눈 몫

n^m # n의 m 승

exp(n) #e의 n승

log(x, base=exp(1)) #base가 밑, 지정되지 않으면 자연로그로 계산

sin(x), cos(x), tan(x) # 삼각함수

#NA의 처리 :데이터가 NA를 포함할 경우 어떤 연산을 해도 다 NA 로 뜸

na.rm = TRUE #na를 뺌

na.fail() #NA가 있으면 ㄱ실패
na.omit() # NA가 있으면 제외
na.exclude() #NA가 있으면 제외(하지만 제외한 행을 결과에 다시 추가)
na.pass()  # NA가 있어도 통과

#na.omit, na.exclude 차이

df<-data.frame(x=1:5,y=seq(2,10,2))
df[3,2] = NA
df
resid(lm(y~x, data=df, na.action=na.omit))
resid(lm(y~x, data=df, na.action=na.exclude))


#함수

function_name <-function(인자, 인자...){
  #함수 본문
  return(반환값) #없으면 생략
}

#ex.피보나치 함수

fibo<-function(n){
  if (n==1||n==2){
    return(1)
  }
  return(fibo(n-1) + fibo(n-2))
}
fibo(1)
fibo(5)

#중첩함수

f<-function(x,y){
  print(x)
  g<-function(y){
    print(y)
  }
  g(y)
}
f(1,2)

#스코프 : 코드에 기술한 이름이 어디에서 사용 가능한지를 정하는 규칙


