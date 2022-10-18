```{r}
#pub only score
pub_word_df <-
  pub_only %>%
  select(business_id, text) %>%
  unnest_tokens(word, text)
pub_word_df<-pub_word_df %>% anti_join(stop_words,by="word")#reduce useless sords
pub_word_df<-pub_word_df %>% left_join(get_sentiments("bing"),by="word")#give pos and neg
score_pub_df <- pub_word_df %>%
  group_by(business_id) %>%
  summarise(
	pos = sum(sentiment == "positive", na.rm = T),
	neg = sum(sentiment == "negative", na.rm = T),
	score = pos - neg)
score_pub_df<-score_pub_df %>% summarise(score=mean(score,na.rm=T))
#restaurant only score
rest_word_df <-
  rest_only %>%
  select(business_id, text) %>%
  unnest_tokens(word, text)
rest_word_df<-rest_word_df %>% anti_join(stop_words,by="word")
rest_word_df<-rest_word_df %>% left_join(get_sentiments("bing"),by="word")
score_rest_df <- rest_word_df %>%
  group_by(business_id) %>%
  summarise(
	pos = sum(sentiment == "positive", na.rm = T),
	neg = sum(sentiment == "negative", na.rm = T),
	score = pos - neg)
score_rest_df<-score_rest_df %>% summarise(score=mean(score,na.rm=T))
#restaurant&brunch
rest_brunch_word_df <-
  rest_brunch %>%
  select(business_id, text) %>%
  unnest_tokens(word, text)
rest_brunch_word_df<-rest_brunch_word_df %>% anti_join(stop_words,by="word")
rest_brunch_word_df<-rest_brunch_word_df %>% left_join(get_sentiments("bing"),by="word")
score_rest_brunch_df <- rest_brunch_word_df %>%
  group_by(business_id) %>%
  summarise(
	pos = sum(sentiment == "positive", na.rm = T),
	neg = sum(sentiment == "negative", na.rm = T),
	score = pos - neg)
score_rest_brunch_df<-score_rest_brunch_df %>% summarise(score=mean(score,na.rm=T))
#restaurant&pub
rest_pub_word_df <-
  rest_pub %>%
  select(business_id, text) %>%
  unnest_tokens(word, text)
rest_pub_word_df<-rest_pub_word_df %>% anti_join(stop_words,by="word")
rest_pub_word_df<-rest_pub_word_df %>% left_join(get_sentiments("bing"),by="word")
score_rest_pub_df <- rest_pub_word_df %>%
  group_by(business_id) %>%
  summarise(
	pos = sum(sentiment == "positive", na.rm = T),
	neg = sum(sentiment == "negative", na.rm = T),
	score = pos - neg)
score_rest_pub_df<-score_rest_pub_df %>% summarise(score=mean(score,na.rm=T))
#restaurant$pub&brunch
rest_pub_brunch_word_df <-
  rest_pub_brunch %>%
  select(business_id, text) %>%
  unnest_tokens(word, text)
rest_pub_brunch_word_df<- rest_pub_brunch_word_df %>% anti_join(stop_words,by="word")
rest_pub_brunch_word_df<- rest_pub_brunch_word_df %>% left_join(get_sentiments("bing"),by="word")
score_rest_pub_brunch_df <- rest_pub_brunch_word_df %>%
  group_by(business_id) %>%
  summarise(
	pos = sum(sentiment == "positive", na.rm = T),
	neg = sum(sentiment == "negative", na.rm = T),
	score = pos - neg)
score_rest_pub_brunch_df<-score_rest_pub_brunch_df %>% summarise(score=mean(score,na.rm=T))
total_score<-rbind(score_pub_df,score_rest_df,score_rest_brunch_df,score_rest_pub_df,score_rest_pub_brunch_df)
catagories=c("pub","restaurant","restaurant&brunch","restaurant&pub","restaurant&pub&brunch")
cbind(total_score,catagories)
```
