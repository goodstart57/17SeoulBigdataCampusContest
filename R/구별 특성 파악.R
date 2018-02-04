## 구별 특징

library(readxl)
library(dplyr)
library(tidyr)
library(data.table)
library(lattice)
library(ggplot2)

ddm <- as.data.frame(read_excel("./Data/12_16_동대문구_사고발생지.xlsx"))
ych <- as.data.frame(read_excel("./Data/12_16_양천구_사고발생지.xlsx"))
ydp <- as.data.frame(read_excel("./Data/12_16_영등포구_사고발생지.xlsx"))
ddm <- ddm %>% separate(발생일시, c("년", "발생일시"), sep="년")
ddm <- ddm %>% separate(발생일시, c("월", "발생일시"), sep="월")
ddm <- ddm %>% separate(발생일시, c("일", "발생일시"), sep="일")
ddm <- ddm %>% separate(발생일시, c("시", "발생일시"), sep="시")
ddm <- ddm[,-6]
ddm$사상자수 <- ddm$사망자수 + ddm$중상자수 + ddm$경상자수 + ddm$부상신고자수

ych <- ych %>% separate(발생일시, c("년", "발생일시"), sep="년")
ych <- ych %>% separate(발생일시, c("월", "발생일시"), sep="월")
ych <- ych %>% separate(발생일시, c("일", "발생일시"), sep="일")
ych <- ych %>% separate(발생일시, c("시", "발생일시"), sep="시")
ych <- ych[,-6]
ych$사상자수 <- ych$사망자수 + ych$중상자수 + ych$경상자수 + ych$부상신고자수

ydp <- ydp %>% separate(발생일시, c("년", "발생일시"), sep="년")
ydp <- ydp %>% separate(발생일시, c("월", "발생일시"), sep="월")
ydp <- ydp %>% separate(발생일시, c("일", "발생일시"), sep="일")
ydp <- ydp %>% separate(발생일시, c("시", "발생일시"), sep="시")
ydp <- ydp[,-6]
ydp$사상자수 <- ydp$사망자수 + ydp$중상자수 + ydp$경상자수 + ydp$부상신고자수
head(ddm)

sort(table(ddm$발생요일), decreasing=T) ## X
sort(table(ych$발생요일), decreasing=T) ## X
sort(table(ydp$발생요일), decreasing=T) ## X


ggplot(data.frame(table(ddm$사고내용)), aes(Var1, Freq)) +
  geom_bar(stat="identity") +
  labs(x="", y="") +
  ggtitle("동대문구 심각도별 사고 발생 건수")
ggplot(data.frame(table(ych$사고내용)), aes(Var1, Freq)) +
  geom_bar(stat="identity") +
  labs(x="", y="") +
  ggtitle("양천구 심각도별 사고 발생 건수")
ggplot(data.frame(table(ydp$사고내용)), aes(Var1, Freq)) +
  geom_bar(stat="identity") +
  labs(x="", y="") +
  ggtitle("영등포구 심각도별 사고 발생 건수")

ggplot(data.frame(sort(table(ddm$사고유형), decreasing=T)), aes(Var1, Freq)) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_text(angle=22, vjust=0.8))+
  labs(x="", y="") +
  ggtitle("동대문구 사고유형별 사고 발생 건수")
ggplot(data.frame(sort(table(ych$사고유형), decreasing=T)), aes(Var1, Freq)) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_text(angle=22, vjust=0.8))+
  labs(x="", y="") +
  ggtitle("양천구 사고유형별 사고 발생 건수")
ggplot(data.frame(sort(table(ydp$사고유형), decreasing=T)), aes(Var1, Freq)) +
  geom_bar(stat="identity") +
  theme(axis.text.x=element_text(angle=22, vjust=0.7))+
  labs(x="", y="") +
  ggtitle("영등포구 사고유형별 사고 발생 건수")

table(ddm$법규위반)
sort(table(ych$법규위반), decreasing=T) ##
sort(table(ydp$법규위반), decreasing=T) ##

sort(table(ddm$노면상태), decreasing=T) ## X
sort(table(ych$노면상태), decreasing=T) ## X
sort(table(ydp$노면상태), decreasing=T) ## X

sort(table(ddm$기상상태), decreasing=T) ## X
sort(table(ych$기상상태), decreasing=T) ## X
sort(table(ydp$기상상태), decreasing=T) ## X

sort(table(ddm$도로형태), decreasing=T) ## X
sort(table(ych$도로형태), decreasing=T) ## X
sort(table(ydp$도로형태), decreasing=T) ## X

## 양천 : 자전거와 승용차의 비율이 비슷, 영등포 : 자전거가 압도적으로 높다.
sort(table(ddm$`가해운전자 차종`), decreasing=T) ## X
sort(table(ych$`가해운전자 차종`), decreasing=T) ## X
ydp_att_car <- sort(table(ydp$`가해운전자 차종`), decreasing=T) ## X
ydp_att_car <- as.data.frame(ydp_att_car)
ggplot(ydp_att_car,aes(Var1, Freq)) +
  geom_bar(stat="identity") +
  ggtitle("가해운전자 차종") +
  labs(x="", y="사상자수")

## 영등포구의 경우 나이대가 고루 분포 다른 구는 연령대가 높다.
ddm_age_vic <- data.frame(table(ddm$`가해운전자 나이대`), Gu=rep("동대문구", 9))
ych_age_vic <- data.frame(table(ych$`가해운전자 나이대`), Gu=rep("양천구", 8))
ydp_age_vic <- data.frame(table(ydp$`가해운전자 나이대`), Gu=rep("영등포구", 9))

age_vic <- rbind(ddm_age_vic, ych_age_vic, ydp_age_vic)
ggplot(age_vic, aes(Var1, Freq, fill=Gu)) +
  geom_bar(stat="identity", position="stack")

ggplot(ddm_age_vic, aes(Var1, Freq)) +
  geom_bar(stat="identity", fill="#d32828") +
  labs(x="", y="") +
  ggtitle("동대문구 가해운전자 연령대 분포")
sum(ych_age_vic$Freq)

ggplot(ych_age_vic, aes(Var1, Freq)) +
  geom_bar(stat="identity", fill="#d32828") +
  labs(x="", y="") +
  ggtitle("양천구 가해운전자 연령대 분포")
sum(ych_age_vic$Freq)

ggplot(ydp_age_vic, aes(Var1, Freq)) +
  geom_bar(stat="identity", fill="#d32828") +
  labs(x="", y="") +
  ggtitle("영등포구 가해운전자 연령대 분포")
sum(ydp_age_vic$Freq)

sort(table(ddm$`피해운전자 차종`), decreasing=T) ## X
sort(table(ych$`피해운전자 차종`), decreasing=T) ## X
sort(table(ydp$`피해운전자 차종`), decreasing=T) ## X

## 영등포구의 경우 나이대가 고루 분포 다른 구는 연령대가 높다.
sort(table(ddm$`피해운전자 나이대`), decreasing=T) ## X
sort(table(ych$`피해운전자 나이대`), decreasing=T) ## X
sort(table(ydp$`피해운전자 나이대`), decreasing=T) ## X

## 영등포구의 경우 나이대가 고루 분포 다른 구는 연령대가 높다.
ddm_age_vic <- data.frame(table(ddm$`피해운전자 나이대`))
ych_age_vic <- data.frame(table(ych$`피해운전자 나이대`))
ydp_age_vic <- data.frame(table(ydp$`피해운전자 나이대`))

ggplot(ddm_age_vic, aes(Var1, Freq)) +
  geom_bar(stat="identity", fill="#4286f4") +
  labs(x="", y="") +
  ggtitle("동대문구 피해운전자 연령대 분포")
sum(ych_age_vic$Freq)

ggplot(ych_age_vic, aes(Var1, Freq)) +
  geom_bar(stat="identity", fill="#4286f4") +
  labs(x="", y="") +
  ggtitle("양천구 피해운전자 연령대 분포")
sum(ych_age_vic$Freq)

ggplot(ydp_age_vic, aes(Var1, Freq)) +
  geom_bar(stat="identity", fill="#4286f4") +
  labs(x="", y="") +
  ggtitle("영등포구 피해운전자 연령대 분포")
sum(ydp_age_vic$Freq)

ddm_death <- ddm %>% group_by(년) %>% summarise(death=sum(사상자수))
ggplot(ddm_death, aes(년, death, fill=death)) + geom_bar(stat="identity", position="dodge")

ych_death <- ych %>% group_by(년) %>% summarise(death=sum(사상자수))
ggplot(ych_death, aes(년, death, fill=death)) + geom_bar(stat="identity", position="dodge")

ydp_death <- ydp %>% group_by(년) %>% summarise(death=sum(사상자수))
ggplot(ydp_death, aes(년, death, fill=death)) + geom_bar(stat="identity", position="dodge")



## 자전거가 가해자?피해자?
ddm$자라니 <- ifelse(ddm$`가해운전자 차종`=="자전거", "가해자", "피해자")
ddm_jarani <- ddm %>% group_by(년, 자라니) %>% summarise(jarani_num=n()) %>% arrange(desc(자라니))

ggplot(ddm_jarani, aes(년, jarani_num, fill=자라니)) +
  geom_bar(stat="identity", position=position_fill(reverse = TRUE)) +
  labs(x="년도", y="", fill="가해자여부") +
  ggtitle("동대문구 자전거 가해자 비율")

ych$자라니 <- ifelse(ych$`가해운전자 차종`=="자전거", "가해자", "피해자")
ych_jarani <- ych %>% group_by(년, 자라니) %>% summarise(jarani_num=n()) %>% arrange(desc(자라니))

ggplot(ych_jarani, aes(년, jarani_num, fill=자라니)) +
  geom_bar(stat="identity", position=position_fill(reverse = TRUE)) +
  labs(x="년도", y="", fill="가해자여부") +
  ggtitle("양천구 자전거 가해자 비율")

ydp$자라니 <- ifelse(ydp$`가해운전자 차종`=="자전거", "가해자", "피해자")
ydp_jarani <- ydp %>% group_by(년, 자라니) %>% summarise(jarani_num=n()) %>% arrange(desc(자라니))

ggplot(ydp_jarani, aes(년, jarani_num, fill=자라니)) +
  geom_bar(stat="identity", position=position_fill(reverse = TRUE)) +
  labs(x="년도", y="", fill="가해자여부") +
  ggtitle("영등포구 자전거 가해자 비율")
       
tmp <- bike_death
for(i in 1:ncol(bike_death)) if(is.character(bike_death[,i])) bike_death[,i] <- as.factor(bike_death[,i])
str(bike_death)
