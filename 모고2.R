#1)-1

admission<-read.csv("Admission.csv")
admission

ad_cor<-cor(admission,use="pairwise.complete.obs",method="pearson")

sum(is.na(admission))

pairs(ad_cor)


install.packages("corrgram")

library(corrgram)

corrgram(admission,upper.panel=panel.conf)

#1)-2

adms.lm<-lm(Chance_of_Admit~.,data=admission)
summary(adms.lm)

step(adms.lm, direction="both")

adms.lm2<-lm(Chance_of_Admit~GRE++TOEFL+LOR+CGPA+Research,data=admission)
summary(adms.lm2)

install.packages("lmtest")
library(lmtest)
dwtest(adms.lm2)
shapiro.test(resid(adms.lm2))
par(mfrow=c(2,2))
plot(adms.lm2)

#2
titanic<-read.csv("titanic.csv")
str(titanic)
summary(titanic)

levels(titanic$embarked)
titanic$embarked<-ifelse(titanic$embarked=="",NA,titanic$embarked)
summary(titanic)
is.na(titanic$embarked)

table(titanic$embarked,useNA="always")

titanic$cabin<-ifelse(titanic$cabin=="",NA,titanic$cabin)

titanic$pclass<-as.factor(titanic$pclass)
titanic$name<-as.character(titanic$name)
titanic$ticket<-as.character(titanic$ticket)
titanic$cabin<-as.character(titanic$cabin)
titanic$survived<-factor(titanic$survived,levels=c(0,1),labels=c("dead","survived"))

install.packages("DMwR")
library(DMwR)
