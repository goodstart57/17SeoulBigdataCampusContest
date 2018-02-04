# <center> 커널 밀도 추정<br>Kernel Density Estimation

<br>

## 밀도 추정

통계학에서 데이터와 변수의 관계를 파악하는 방법

<br>

### 1. Histogram

이산형 변수의 경우 히스토그램을 이용해서 변수의 분포를 나타낼수 있지만 bin(히스토그램의 너비)에 따라 분포가 달라질수 있고 아래와 같이 bin의 경계에서 불연속 면이 나타난다는 단점이 있다.



```R
hist(wine$`Malic acid`, xlab="Malic Acid", main = "Histogram of Wine's Malic Acid")
```

<center>

<img src="https://github.com/saebuck/17SeoulBigdataCampusContest/blob/master/Image/Histogram.PNG?raw=true" width="500">

</center>

이러한 단점을 보완하기 위해서 Gaussian 분포를 커널 함수으로 커널 밀도 추정을 하면 히스토그램을 Smoothing 하여 확률밀도함수를 얻을 수 있다.

<br>

### 2. 커널 함수를 이용한 밀도 추정(KDE; Kernel Density Estimation)

각 데이터를 커널 함수에 대치하여 매끄러운 곡선을 얻을 수 있다.

```R
hist(wine$`Malic acid`, xlab="Malic Acid", main = "KDE with gaussian distribution", prob=T) ## 히스토그램
lines(density(wine$`Malic acid`), col="red") ##KDE
rug(jitter(wine$`Malic acid`)) ##데이터의 위치
```

<center>

<img src="https://github.com/hiwooj/17SeoulBigdataCampusContest/blob/master/Image/KDEwithGaussian.PNG?raw=true" width="500">

</center>

<br>

#### KDE를 수행하기 전, 어떤 커널 함수를 사용 할 지__와 __커널 함수의 bandwidth 값인 h를 정해야 한다.

- __커널 함수__

Uniform, Triangular, Epanechnikov, Quartic, Triweight, Gaussian, Cosine 등이 있고<br>이 중 Epanechnikov이 가장 정확하며 Gaussian 분포도 함께 쓰인다.



- __커널 함수의 bandwidth 값 h__

<center>

<img src="https://github.com/hiwooj/17SeoulBigdataCampusContest/blob/master/Image/KDE_h.png?raw=true">

</center>

위의 히스토그램에서 h는 density 함수 내부에서 bw.nrd0 함수를 이용하여 구해졌으며 그 값은 0.2774124이다.



#### 히스토그램을 continuous하게 바꾸었지만, 차원이 높아질수록 문제가 생긴다.

#### => KNN(k-nearest neighbor) 이용하여 해결

<br>

### 3. KDE를 사용한 핫스팟 맵핑

지금까지 알아본 KDE를 GIS에서 사용하여 HotSpot Mapping을 이용하여 발생 빈도가 높은 영역을 강조 표시해준다. 아래 핫스팟 맵핑은 QGIS를 이용했다.

<center>

<img src="https://github.com/hiwooj/17SeoulBigdataCampusContest/blob/master/Image/HotSpotwithKDE.png?raw=true" width="800">

</center>