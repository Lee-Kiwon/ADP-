#단순 임의 추출법

sample(n:n, 뽑을 데이터 수, repalce=TRUE,FALSE, prob=n)
#n:n의 경우 수열을 입력해야함
#TRUE 하는 경우, 복원추출 FALSE는 비복원 추출
#n에는 가중치를 지정하는 것이다. 예를 들어, 4개를 뽑을 경우 n에는 c(0.2, 0.2, 0.3, 0.3)이 들어가야 한다.

#실제 쓰이는 예시
dim(iris)

iris_sam <- sample(1:nrow(iris), 10) 
#iris의 열 개수 중 10개 숫자를 임의로 뽑음
iris_sample <- iris[iris_sam, ]
#임의로 뽑은 n번째 열을 iris에서 추출
iris_sample

#계통 추출법
score_df <- data.frame(gender = rbinom(1000, 1, 0.5), age = sample(9:12, 1000, replace = TRUE), score = rnorm(1000, 75, 7))
head(score_df)
'''
  gender age    score
1      1  11 87.13071
2      0  11 74.55566
3      1   9 74.25122
4      0   9 65.06077
5      0  12 86.81098
6      1  10 74.86740
'''
dim(score_df)              #1000, 3

N = nrow(score_df)         #모집단의 크기  
n = 100                    #표본의 크기 
k = N/n                    #표집 간격 
r = sample(1:k-1, 1)       #시작점 : 표집간격보다 작은 숫자 

seq(r, N, by = k)
'''
  [1]   9  19  29  39  49  59  69  79  89  99 109 119 129 139 149 159 169 179 189
 [20] 199 209 219 229 239 249 259 269 279 289 299 309 319 329 339 349 359 369 379
 [39] 389 399 409 419 429 439 449 459 469 479 489 499 509 519 529 539 549 559 569
 [58] 579 589 599 609 619 629 639 649 659 669 679 689 699 709 719 729 739 749 759
 [77] 769 779 789 799 809 819 829 839 849 859 869 879 889 899 909 919 929 939 949
 [96] 959 969 979 989 999 '''
 
spe_sample = score_df[seq(r, N, by = k),]  #등간격으로 객체 뽑기 
dim(spe_sample)                            #100, 3

#집락추출법
table(iris$Group)
sample(letters[1:2], 1) #군집 무작위 추출 
iris[iris$Group== "B",1]

# 층화추출법
strata(데이터, stratanames=n, 계층에서 추출할 데이터의 개수,
method=c("srswor","srswr","poisson","systematic"), pik, description=TRUE, FALSE)

stratanames : 데이터에서 계층을 구분하는 변수들
method : srswor(비복원 단순 임의추출), srswr(복원 단순 임의추출), poisson(포아송 추출), systematic(계통 추출)
pik : 데이터를 표본에 포함시킬 확률
description : 표본크기와 모집단 크기를 추출할지 여부

library(sampling)
sample<-strata(data=iris, c("Species"), size=c(20,15,15), method="srswor")

head(sample)

iris_sample<-getdata(iris,sample)

head(iris_sample)
table(iris_sample$Species)
