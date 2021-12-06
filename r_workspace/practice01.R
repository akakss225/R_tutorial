# 혼자서 해보기



# Q1. 시험 점수 변수 만들고 출력하기
# 다섯 명의 학생이 시험을 봤습니다. 학생 다섯 명의 시험 점수를 담고 있는 변수를 만들어 출력해 보세요. 각 학생의 시험 점수는 다음과 같습니다.
# 80, 60, 70, 50, 90
student <- c(80, 60, 70, 50, 90)
student


# Q2. 전체 평균 구하기
# 앞 문제에서 만든 변수를 이용해서 이 학생들의 전체 평균 점수를 구해보세요.
mean(student)


# Q3. 전체 평균 변수 만들고 출력하기
# 전체 평균 점수를 담고 있는 새 변수를 만들어 출력해 보세요. 앞 문제를 풀 때 사용한 코드를 응용하면 됩니다.
avg <- mean(student)
avg




# 혼자서 해보기
# Q1. data.frame()과 c()를 조합해서 표의 내용을 데이터 프레임으로 만들어 출력해보세요. 제품 가격 판매량
# 사과 1800 24
# 딸기 1500 38
# 수박 3000 13

fruits <- data.frame(fruit = c("사과", "딸기", "수박"),
                     price = c(1800, 1500, 3000),
                     amount = c(24, 38, 13))
fruits


# Q2. 앞에서 만든 데이터 프레임을 이용해서 과일 가격 평균, 판매량 평균을 구해보세요.
fruits_price_avg <- mean(fruits$price)
fruits_amount_avg <- mean(fruits$amount)
fruits_price_avg
fruits_amount_avg




# mpg 데이터의 변수명은 긴 단어를 짧게 줄인 축약어로 되어있습니다. 
# cty 변수는 도시 연비, hwy 변수는 고속도로 연비를 의미합니다. 
# 변수명을 이해하기 쉬운 단어로 바꾸려고 합니다. mpg 데이터를 이용해서 아래 문제를 해결해 보세요.
#• Q1. ggplot2 패키지의 mpg 데이터를 사용할 수 있도록 불러온 뒤 복사본을 만드세요.
#• Q2. 복사본 데이터를 이용해서 cty는 city로, hwy는 highway로 변수명을 수정하세요.
#• Q3. 데이터 일부를 출력해서 변수명이 바뀌었는지 확인해 보세요. 아래와 같은 결과물이 출력되어야 합니다.

practice_mpg <- as.data.frame(ggplot2::mpg)
practice_mpg_new <- practice_mpg
practice_mpg_new <- rename(practice_mpg_new, highway=hwy)
practice_mpg_new <- rename(practice_mpg_new, city=cty)

head(practice_mpg_new)




