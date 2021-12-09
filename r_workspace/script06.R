# 12 / 09 (thu) class



install.packages("extrafont")
library(extrafont)
font_import()
theme_set(theme_grey(base_family='NanumGothic'))


library(dplyr)
library(ggplot2)
library(foreign)
library(readxl)



# 깃헙을 사용하기 위한 remotes 패키지 다운로드
install.packages("remotes")
# remotes를 통한 KoNLP를 깃헙에서 받아오기
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
# 같은 방법으로 multilinguer도 깃헙으로 받기
remotes::install_github("mrchypark/multilinguer")
library(KoNLP)
extractNoun('이 영화 정말 재미있다')

useNIADic()

txt <- readLines("kim_president.txt")
head(txt)

library(stringr)

txt <- str_replace_all(txt,"\\W"," ")

nouns <- extractNoun(txt)
class(nouns)

wordcount <- table(unlist(nouns))

wordcount
# wordcount를 dataframe으로 만들기.
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word < rename(df_word, word = Var1, freq = Freq)

View(df_word)

# 두글자 이상 단어 추출
df_word <- filter(df_word, nchar(Var1) >= 2)

top_20 <- df_word %>% arrange(desc(Freq)) %>% head(20)

top_20

# 워드클라우드 만들기
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

# Dark2 색상 목록에서 8 개 색상 추출
pal <- brewer.pal(8, "Dark2")

# 난수 고정
set.seed(1234)
wordcloud(words = df_word$Var1, # 단어
          freq = df_word$Freq, # 빈도
          min.freq = 2, # 최소 단어 빈도 조절 하면 나오는 단어수 바뀜
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치 여부
          rot.per = .1, # 회전 단어 비율
          scale = c(4, 0.3), # 단어 크기 범위
          colors = pal, # 색상목록
          family="AppleGothic") # 맥 한글깨짐 방지

install.packages("ggiraphExtra")

install.packages("ggiraph")

# 안되네요
library(ggiraphExtra)

library(tibble)

install.packages("stringi")

devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

str(changeCode(korpop1))

korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)


str(changeCode(kormap1))

ggChropleth(data = kormap1,
            aes(fill = pop,
                map_id = code,
                tooltip = name),
            map = kormap1,
            interactive = T)


###########################################################################################
# 통계 분석


install.packages("plotly")


scrore <- c(90, 70, 50, 30)
avg <- mean(scrore)
avg




mpg <- as.data.frame(ggplot2::mpg)

mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

mpg_diff

# 가설 검정. 가설을 검정할 때 유의미한 자료임을 보려면 p-value를 봐야함.
# p-value 값이 0.05보다 작아야 유의미한 자료이다.
t.test(data = mpg_diff, cty ~ class, var.equal = T)




mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))

table(mpg_diff2$fl)
# 아래의 경우 p-value값이 0.28로, 0.05보다 크므로 가치가 없는 자료라는 것이다.
t.test(data = mpg_diff2, cty ~ fl, var.equal = T)


# 상관계수 : 두 변수가 얼마나 관련이 있는지 보여줌
# 0에 가까울수록 관련없음. 1에 가까울수록 관련있음.
# 양수이면 정비례, 음수이면 반비례 관계
economics <- as.data.frame(ggplot2::economics)
# 이 검증 또한 p-value값이 0.05보다 작아야 한다.
# 아래의 자료의 경우 상관계수가 0.61이 나오므로, 애매한 상관관계를 갖음을 말한다.
cor.test(economics$unemploy, economics$pce)





























































