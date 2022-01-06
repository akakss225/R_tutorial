# 실기

# 맥북용 폰트 패키지 인스톨 및 라이브러리 적용
install.packages("extrafont")
library(extrafont)
font_import()
theme_set(theme_grey(base_family='NanumGothic'))

# 사전에 필요한 라이브러리 적용
library(dplyr)
library(ggplot2)
library(foreign)
library(readxl)

# 한국어 형태소 분석 패키지
install.packages("KoNLP")

# rJava다운로드
install.packages("rJava")

# 의존성 패키지들 다운로드
install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")


# 만일 버전 문제로 위의 패키지 다운이 안될 시 아래 코드 사용
# 깃헙을 사용하기 위한 remotes 패키지 다운로드
install.packages("remotes")
# remotes를 통한 KoNLP를 깃헙에서 받아오기
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))


# KoNLP 라이브러리 적용
library(KoNLP)

# 저장된 형태소 사용
useNIADic()

# 라이브러리 적용
library(stringr)

# 김대중 대통령 연설문 read하기
txt_kim <- readLines("kim_president.txt")

# 확인 코드
head(txt)

# 데이터 정제하기
txt_kim <- str_replace_all(txt_kim,"\\W"," ")
nouns_kim <- extractNoun(txt_kim)

# 워드카운트 적용전 테이블 생성
wordcount_kim <- table(unlist(nouns_kim))

# 워드카운트를 dataframe으로 만들기
word_kim <- as.data.frame(wordcount_kim, stringsAsFactors = F)
word_kim < rename(word_kim, word = Var1, freq = Freq)

# 두글자 이상 단어 추출
word_kim <- filter(word_kim, nchar(Var1) >= 2)

# 상위 20 위 단어추출
top_20_kim <- word_kim %>% arrange(desc(Freq)) %>% head(20)
top_20_kim

# CSV 만들기
write.csv(top_20_kim , "/Users/sumin/Desktop/R/R_tutorial/r_workspace/report.csv")

# 워드카운트를 위한 패키지 다운 및 라이브러리 적용
install.packages("wordcloud")
library(RColorBrewer)
library(wordcloud)

# Dark2 색상 목록에서 8 개 색상 추출
pal <- brewer.pal(8, "Dark2")

# 난수 고정
set.seed(1234)

# 워드클라우드 실행, 상위 20개만 출력
wordcloud(words = word_kim$Var1, # 단어
          freq = word_kim$Freq, # 빈도
          min.freq = 2, # 최소 단어 빈도 조절 하면 나오는 단어수 바뀜
          max.words = 200, # 표현 단어 수
          random.order = F, # 고빈도 단어 중앙 배치 여부
          rot.per = .1, # 회전 단어 비율
          scale = c(4, 0.3), # 단어 크기 범위
          colors = pal, # 색상목록
          family="AppleGothic") # 맥 한글깨짐 방지
