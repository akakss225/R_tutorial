# 기본 변수설정
a <- 1
b <- 2
c <- 3
d <- 3.5
a+b
c * d

# 연속된 변수 설정 >> 마치 배열처럼 들어감
var1 <- c(1, 2, 5, 7, 8)
var1

var2 <- c(1:5)
var2

var3 <- seq(1,5)
var3

var4 <- seq(1,10,by=2)
var4

str5 <- c("Hellow", "World", "is", "good")
str5[1]

x <- c(1,2,3)

# 평균
mean(x)
# 합
sum(x)
# 최댓값
max(x)
# 최소값
min(x)

# 1~100 홀수의 평균
y <- seq(1,100,by=2)
mean(y)

# csv로 작성하는 법
str5_paste <- paste(str5, collapse = ",")
str5_paste

# -----------------------------------------------------------------------------
# 패키지 설치
install.packages("ggplot2")

# 설치 후 library()함수로 로딩. 다만 인식을 못하는 경우 존재 >> 다시 설치하면 됨
library(ggplot2)

x <- c("a", "a", "b", "c")
qplot(x)

# ggplot2 의 mpg(자동차 연비) 데이터로 그래프 만들기
qplot(data=mpg, x=hwy)
qplot(data=mpg, x=cty)

# x축 drv / y 축     drv >> 구동방식(r=후륜/f=전륜/4=4륜)     hwy >> 고속도로
qplot(data=mpg, x=drv, y=hwy)
qplot(data=mpg, x=drv, y=hwy, geom="boxplot")

# R의 경우 Data Frame(table)이 존재. >> 파이썬과 다른점. 파이썬은 라이브러리를 추가해서 해야함.

english <- c(90, 80, 60, 70)
math <- c(50, 60, 100, 20)
class <- c(1, 1, 2, 2)

df_midterm <- data.frame(english, math, class)

df_midterm

mean(df_midterm$english)
mean(df_midterm$math)

df_test <- data.frame(eng=c(90, 80, 60, 70),
                      mat=c(50, 60, 100, 20),
                      class=c(1, 1, 2, 2))

df_test

mean(df_test$eng)
mean(df_test$mat)


install.packages("readxl")
library(readxl)

df_exam <- read_excel("excel_exam.xlsx")
df_exam

# column name이 존재하지 않고, 바로 data가 시작되면, col_names = F 를 적어주면 된다.
df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F)
df_exam_novar

# Excel에 시트가 여러개 존재할 경우,
df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

# MySQL 에서 table export후 가져오기
df_tbl_member <- read.csv("tbl_member.csv")
df_tbl_member

# 데이터에 문자가 포함될때 >> stringsAsFactiors = F 를 넣어줌.

# Data Frame을 csv로 내보내는 방법 
# 이전에 만든 df_midterm data frame이용
write.csv(df_midterm, file="df_midterm.csv")

# RData file 로 저장하기 / 불러오기
save(df_midterm, file="df_midterm.rda")

rm(df_midterm)

load("df_midterm.rda")


# head() >> 데이터 앞부분(1~6) 출력/ 갯수 조작 가능 
# tail() >> 데이터 뒷부분(뒤에서 6개) 출력 / 갯수 조작 가능
# View() >> 데이터 미리보기
# dim() >> 몇행 몇열인지 알려줌
# str() >> 행/열 및 각 column별 타입과 데이터를 요약해서 출력
# summary() >> min : 최솟값 / 1st Qu. : 1쿼터. 25% / median : 중간값 / Mean : 평균 / 3rd Qu. 3쿼터. 75% / max : 최대

exam <- read.csv("csv_exam.csv")
head(exam)
head(exam, 10)
tail(exam)
tail(exam, 10)
View(exam)
dim(exam)
str(exam)
summary(exam)

# R에서 as가 붙으면, 변환한다는 의미임. 이를 이용해 ggplot2에 있는 mpg data를 가져오기
mpg <- as.data.frame(ggplot2::mpg)

head(mpg)
str(mpg)
summary(mpg)


# 데이터 수정하기

install.packages("dplyr")
library(dplyr)

df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))

df_new <- df_raw



