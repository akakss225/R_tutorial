# 12 / 08 (wed) class2


install.packages("extrafont")
library(extrafont)
font_import()
theme_set(theme_grey(base_family='NanumGothic'))


library(dplyr)
library(ggplot2)
library(foreign)
library(readxl)


# KoNLP >> Text Mining을 위한 패키지 받는 법



# 현재 버전(4.0 이상) 에서는 바로 설치 불가능.. 따라서 github에서 받는방법으로
install.packages("KoNLP")
# 마찬가지..
install.packages("multilinguer")


# rJava다운로드
install.packages("rJava")
# 의존성 패키지들 다운로드
install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")


# 깃헙을 사용하기 위한 remotes 패키지 다운로드
install.packages("remotes")
# remotes를 통한 KoNLP를 깃헙에서 받아오기
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
# 같은 방법으로 multilinguer도 깃헙으로 받기
remotes::install_github("mrchypark/multilinguer")
library(KoNLP)
extractNoun('이 영화 정말 재미있다')

useNIADic()

txt <- readLines("hiphop.txt")
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
          min.freq = 10, # 최소 단어 빈도 조절 하면 나오는 단어수 바뀜
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치 여부
          rot.per = .1, # 회전 단어 비율
          scale = c(4, 0.3), # 단어 크기 범위
          colors = pal, # 색상목록
          family="AppleGothic") # 맥 한글깨짐 방지

















