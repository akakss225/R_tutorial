# 12 / 08 (wed) class

# 한글깨짐 해결
install.packages("extrafont") 
library(extrafont) 
font_import()

theme_set(theme_grey(base_family='NanumGothic'))







library(dplyr)
library(ggplot2)
library(foreign)
library(readxl)


# 데이터 불러오기
raw_welfare <- read.spss(file = "/Users/sumin/Desktop/R/Lecture/Doit_R-master/Lecture/RMD/Koweps_hpc10_2015_beta1.sav", to.data.frame = T)

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

welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)
# ㄴㅏ이와 월급의 관계 분석하기
table(welfare$birth)
summary(welfare$birth)

welfare$age <- 2021 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

# 연령대별 월급의 관계 분석
welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, "young", 
         ifelse(age <= 59, "middle", "old")))

ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col() + scale_x_discrete(limits = c("young", "middle", "old"))

# 연령대 및 성별 월급 평균표
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))

sex_income

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + 
  geom_col(position="dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))

sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex, age) %>% 
  summarise(mean_income = mean(income))

ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line()


# 직업별 월급분석
list_job <- read_excel("/Users/sumin/Desktop/R/Lecture/Doit_R-master/Lecture/RMD/Koweps_Codebook.xlsx",col_names = T, sheet = 2)

head(list_job)

welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>% filter(!is.na(code_job)) %>% select(code_job, job) %>% head(10)

job_income <- welfare %>% 
  filter(!is.na(income), !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

top10 <- job_income %>% arrange(desc(mean_income)) %>% head(10)

# 원래 정렬은 가나다 순으로 됨. reorder를 넣어줌으로써 수치 기준으로 정렬해준다
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) + 
  geom_col() + coord_flip()


# 성별 직업 빈도 분석하기

# 남자
job_male <- welfare %>% 
  filter(!is.na(job) & sex == "male") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_male
# 여자
job_female <- welfare %>% 
  filter(!is.na(job) & sex == "female") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_female


# 종교 유무에 따른 이혼율
table(welfare$religion)

# 보기 쉽게 종교 유무를 바꿔줌
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")

table(welfare$religion)
table(welfare$marriage)

# 기혼과 이혼을 뽑아서 새로운 column만듬
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3, "divorce", NA))

table(welfare$group_marriage)
table(is.na(welfare$group_marriage)) 

# 종교 여부와 이혼 여부를 그루핑 해서 새로운 table 생성
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n / tot_group * 100, 1))

religion_marriage

divorce <- religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(religion, pct)

divorce
ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()


# 지역별 연령대 비율 분석하기
# 1. 코드 분석

class(welfare$code_region)
table(welfare$code_region)

# 2. 전처리
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주"))

list_region

# welfare 에 지역명 변수 join
welfare <- left_join(welfare, list_region, id = "code_region")

welfare %>% select(code_region, region) %>% head

region_ageg <- welfare %>% 
  group_by(region, ageg) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n / tot_group * 100, 2))

head(region_ageg)

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) + geom_col() + coord_flip()


class(region_ageg$ageg)
region_ageg$ageg <- factor(region_ageg$ageg, level = c("old", "middle", "young"))


levels(region_ageg$ageg)

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) + 
  geom_col() + coord_flip()









