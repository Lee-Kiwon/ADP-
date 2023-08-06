#1-1)
lotto<-read.csv("lotto.csv")
lotto

#arules 패키지 설치하기
install.packages("arules")
library(arules)

sum(is.na(lotto))

library(reshape2)

#apriori 알고리즘은 transaction 데이터(2열 : 아이디, 데이터)로 이뤄져서 바꿔야함
lot_melt<-melt(lotto,id.vars=1)
lot_melt[c(1,860),]

#인덱스 제거
lot_melt2<-lot_melt[,-2]
head(lot_melt2)


#split(x1,x2) : x1데이터를 x2데이터에 따라 분리
#추첨회차를 기준으로 당첨번호를 분리하여 lot_sp에 저장
lot_sp<-split(lot_melt2$value,lot_melt$time_id)
lot_sp


tran.lotto<-as(lot_sp,"transactions")
tran.lotto

inspect(tran.lotto[1:5])

#그래프
itemFrequencyPlot(tran.lotto,topN=10,type="absolute")
itemFrequencyPlot(tran.lotto,topN=10)
#대부분의 번호가 비슷한 빈도로 추첨되며, 34번이 가장 많이 추첨됨

#2)

rules_1<-apriori(tran.lotto,parameter=list(support=0.002,confidence=0.8,maxlen=6,minlen=2))

rules_1
#679개의 규칙 생성

rules_2<-inspect(sort(rules,by=c("lift"),decreasing=T)[1:30])
str(rules_2)
rules_2df<-as.data.frame(rules_2)
rules_2df
write.csv("rules_1",row.names=FALSE)

#3)
summary(rules_1)

#2-1)
Fifa<-read.csv("Fifa.csv")
head(Fifa)
Fifa$height<-as.character(Fifa$Height)

#문자로 바꾸고 ` 앞뒤로 나눈 뒤 regexpr함수를 이용해서 `위치 반환하고 나누고 곱하기
Fifa$Height_cm<-as.numeric(substr(Fifa$Height,1,regexpr("'",Fifa$Height)-1))*30 + as.numeric(substr(Fifa$Height,regexpr("'",Fifa$Height)+1,nchar(Fifa$Height)))*2.5


Fifa<-within(Fifa,{Position_Class=character(0)
Position_Class[Position %in% c("LS","ST","RS","LW","LF","CF","RF","RW")] = 
  "Forward"
Position_Class[Position %in% c("LAM","CAM","RAM","LM","LCM","CM","RCM","RM")] = "Midfielder"
Position_Class[Position %in% c("LWB","LDM","CDM","RDM","RWB","LB","RB","LCB","RCB","CB")]="Defender"
Position_Class[Position %in% c("GK")]="GoalKeeper"})

Fifa$Position_Class<-factor(Fifa$Position_Class, levels=c("Forward","Midfielder","Defender","GoalKeeper"), labels=c("Forward","Midfielder","Defender","GoalKeeper"))

fifa_result<-aov(Value~Position_Class,data=Fifa)
summary(fifa_result)

TukeyHSD(aov(Value~Position_Class,data=Fifa))

fifa_toway_anova<-aov(Value~Preferred_Foot + Position_Class + Preferred_Foot:Position_Class,data=Fifa)
summary(fifa_toway_anova)

step(lm(Value~1,data=Fifa),scope=list(lower=~1,upper=~Age+Overall+Wage+Height_cm+Weight_lb),direction="both")

