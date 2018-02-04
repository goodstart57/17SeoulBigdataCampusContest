############################################
## Create My Test Data with wine data set ##
############################################

library(data.table)
library(dplyr)

wine <- fread("../Data/MyTestData/wine.data.txt")
wine.names <- c("Class", "Alcohol", "Malic acid", "Ash", "Alcalinity of ash", "Magnesium",
                "Total phenols", "Flavanoids", "Nonflavanoid phenols", "Proanthocyanins",
                "intensity", "Hue", "OD280OD315 of diluted wines", "Proline" )
names(wine) <- wine.names
head(wine)
names(wine)

###### 변수 설명
## Class         : 분류, 데이터 제공자의 임의로 분류한것으로 보임
## Alcohol       : 술의 알코올 비율, Gay Lussac식 용량분율 방법을 사용(미국은 Proof 사용)
## Malic acid    : 말산, 시큼하고 톡쏘는 맛
## Ash           : 와인에 함유된 미네랄 성분으로 1.2~3 g/L가 들어있다. 와인의 품질에 중요한 지표
## Total phenols : 페놀, 와인의 맛, 향 그리고 바디감에 영향
## intensity     : 강도, 와인의 색과 향에 영향
## hue           : 색상, 진할수록 향미도 강렬해짐
## Proline       : 아미노산의 한 종류

part.names <- c("Class", "Alcohol", "Malic acid", "Ash", "Total phenols", "intensity", "Hue", "Proline")

wine.sample <- wine %>% select(part.names)
wine.sample <- wine.sample[sample(nrow(wine.sample), 100), ]
names(wine.sample)[c(5,6)] <- c("Phenols", "Intensity")

head(wine.sample)

## write.csv(wine.sample, "../Data/MyTestData/wine.csv", row.names=F)



#################################
## Normalize as min:0 & max:10 ##
#################################

###### scale, minimum is 0 maximum is 10
scale0_10 <- function(data, col) {
  data <- as.data.frame(data)
  target <- data[,col]
  target <- (target - min(target)) * (10/(max(target) - min(target)))
  return (target)
}

summary(wine.scaled.sample)

for(i in 2:ncol(wine.scaled.sample))
  wine.scaled.sample[,i] <- scale0_10(wine.scaled.sample, i)

summary(wine.scaled.sample)

## write.csv(wine.scaled.sample, "../Data/MyTestData/wine2.csv", row.names=F)
