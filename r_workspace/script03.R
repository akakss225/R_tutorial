# 12 / 07 (tue) class


# 파생변수 만들기
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))

df$var_sum <- df$var1 + df$var2
df$var_mean <- (df$var1 + df$var2)/2

df


mpg <- as.data.frame(ggplot2::mpg)

mpg$total <- (mpg$cty + mpg$hwy)/2

View(mpg)


# 조건문과 파생변수를 활용해 mpg다루기

summary(mpg$total)
# histogram >> x축이 범위로 산정됨. >> 연속적인 데이터
hist(mpg$total)
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
View(mpg)
# 빈도표로 합격 판정 자동차 수 살펴보기
table(mpg$test)
library(ggplot2)
# 막대그래프
qplot(mpg$test)


# 중첩조건문 사용하기
mpg$grade <- ifelse(mpg$total >= 30, "A", 
                    ifelse(mpg$total >= 25, "B" , 
                           ifelse(mpg$total >= 20, "C", "D")))

table(mpg$grade)
qplot(mpg$grade)


# 데이터 전처리 패키지 dplyr
# filter() : 행추출
# select() : 열 추출
# arrange() : 정렬
# mutate() : 변수 추가
# summarise() : 통계치 산출
# group_by() : 집단별로 나누기
# left_join() : 데이터 합치기(열)
# bind_raws() : 데이터 합치기(행)

library(dplyr)
exam <- read.csv("csv_exam.csv")
# %>% 는 dplyr에만 있는 기호. 왼쪽에서부터 오른쪽으로 읽겠다 라는 의미
exam %>% filter(class == 1)
exam %>% filter(class != 1)
exam %>% filter(class == 1 & math >= 50)
exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1, 3, 5))

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)
mean(class2$math)

head(exam %>% select(math))
head(exam %>% select(-math))

exam %>% filter(class == 1) %>% select(english)

# 오름차순 정렬
exam %>% arrange(math)
# 내림차순 정렬
exam %>% arrange(desc(math))

exam %>% arrange(class, math)

# mutate의 경우 원본을 건들지 않음
exam %>%mutate(total=math+english+science,
               mean=(math+english+science)/3) %>% head

exam %>% mutate(test = ifelse(science >= 60, "P", "F")) %>% head

exam %>% mutate(total = math + english + science) %>% arrange(total)

# 집단별로 요약하기
exam %>% summarise(mean_math = mean(math))
# 활용
exam %>% group_by(class) %>% summarise(mean_math = mean(math))

exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())

mpg %>% group_by(manufacturer, drv) %>% 
  summarise(mean_city = mean(cty)) %>% 
  head(10)

# dplyr 조합하기

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(tot = (cty + hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot))



# join

test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                      midterm = c(60, 80, 70, 90, 85))

test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by="id")
total

# union

group_a <- data.frame(id=c(1, 2, 3, 4, 5),
                      test=c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                    test = c(70, 83, 65, 95, 80))

group_all <- bind_rows(group_a, group_b)

group_all




# 결측치 찾기

df2 <- data.frame(sex = c("M", "F", NA, "M", "F"),
                  score = c(5, 4, 3, 4, NA))

table(is.na(df2$sex))
table(is.na(df2$score))

df_nomiss2 <- na.omit(df2)
df_nomiss2

exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   median_math = median(math, na.rm = T))


# 순서대로 행의 index / 열의 index이다.
exam[c(3, 8, 15), "math"] <- NA
exam[3, "math"]
exam[3, 3]

exam %>% summarise(mean_math = mean(math))
exam %>% summarise(mean_math = mean(math, na.rm = T))

mean(exam$math, na.rm = T)
# 만약 math점수가 na 이면, 55점으로 대치하고, 아니면 그대로...
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(exam$math)
table(is.na(exam$math))



# 이상한 데이터 ? 이상치 정제하기

# 성별에서 3 , 점수에서 6 이 이상치임.
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))

outlier
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)

outlier %>% filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))


boxplot(mpg$hwy)$stats

mpg %>% filter(hwy < 12)
mpg %>% filter(hwy > 37)

# 이러한 극단적인 이상치들은 통계할 때 제거함.... 아래는 그 방법
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
mpg %>% group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm=T))



# 산점도 (Scatter)
# 데이터를 x 축, y 축에 점으로 표현한 그래프
# 나이 & 소득과 같은 연속값으로 된 변수의 관계를 표현할 때 사용


# mpg 그래프에서 x축은 배기량, y축은 고속도로연비에 대한 산점도 그리기.

# 그래프 먼저 만들기
ggplot(data = mpg, aes(x = displ, y = hwy))
# 산점도 추가 geometry > geom / point > 점
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
# x축 조절 3 ~ 6
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)
# y 축 조절 10 ~ 30
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

# 막대그래프 그리기
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm=T))

df_mpg
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()
# 크기순으로 정렬
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

ggplot(data = mpg, aes(x = hwy)) + geom_bar()

# 꺾은선 그래프 (시계열 그래프)
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

# 박스 그래프 종류별로...
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()


# 데이터 분석 준비하기
install.packages("foreign")
library(dplyr)
library(ggplot2)
library(foreign)
library(readxl)

# 데이터 불러오기
raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav", to.data.frame = T)

# 복사본 만들기
welfare <- raw_welfare

head(welfare)
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)

table(is.na(welfare$sex))

welfare$sex <- ifelse(welfare$sex == 1, "male", "female")

table(welfare$sex)

qplot(welfare$sex)

summary(welfare$income)

qplot(welfare$income) + xlim(0, 1000)

welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)

table(is.na(welfare$income))

sex_income <- welfare %>% 
  filter(!is.na(welfare$income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

sex_income

ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()




