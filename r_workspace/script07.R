# 12 / 09 (thu) class2

exam <- read.csv("csv_exam.csv")
exam

# 행 열 생략 결과는 exam출력 할때와 동일함.
exam[]

# 1행의 모든 열 출력
exam[1,]

# 1행 1열
exam[1,1]

# 1행의 특정 열
exam[1, "science"]

# 모든 행의 특정 열
exam[,"science"]

# 조건을 충족하는 행 추출하기
# 조건을 내부에 작성해주면 됨
# dplyr를 안써도 이런식으로 가능
exam[exam$class == 1,]

exam[exam$math >= 80,]

exam[, c("class", "math", "science")]

exam[5, "english"]

exam[exam$math >= 50, ]

# 내장함수를 이용한 문제
# 수학 점수 50 이상, 영어 80 이상학생들을 ㅐ상으로 각 반의 전과목 총평균 구하기
exam$tot <- (exam$math + exam$english + exam$science) / 3

aggregate(data = exam[exam$math >= 50 & exam$english >= 80, ], tot ~ class, mean)



# 연속 변수 
# 값이 연속적이고 크기를 의미. 연산 가능
var1 <- c(1,2,3,1,2)

# 범주 변수(factor) >> 종류를 따질때 ex) 남 or 여 / 빨 or 파 
# 연산이 불가능하다.
var2 <- factor(c(1,2,3,1,2))

var1
var2
var1 + 2
var2 + 2
class(var1)
class(var2)
levels(var1)
levels(var2)
mean(var1)
mean(var2)

# factor를 numeric으로 변환하면 연산 가능
var2 <- as.numeric(var2)
mean(var2)
class(var2)

var2 <- as.factor(var2)
class(var2)

mpg <- ggplot2::mpg
# stats가 요약을 나타냄
x <- boxplot(mpg$cty)
x





























































