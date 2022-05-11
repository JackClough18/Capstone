library(tidyverse)
library(broom)

d <- read_csv("songs_transformed.csv") %>% 
  janitor::clean_names() %>% 
  select(-x1,-lyrics,-top_10_words,-genres)

d <- d %>% 
  mutate(top_genre = fct_reorder(top_genre,popularity,mean),
         key = as_factor(key))

skimr::skim(d)

# let's rescale everything numeric to 0-100
rescale <- function(x){
  min.x <- min(x)
  max.x <- max(x)
  
  x <- (x - min.x)/(max.x - min.x) * 100
  
  return(x)
}

d <- d %>% 
  mutate(
    danceability = rescale(danceability),
    loudness = rescale(loudness),
    energy = rescale(energy),
    valence = rescale(valence),
    tempo = rescale(tempo),
    lexical_diversity = rescale(lexical_diversity)
  )

skimr::skim(d)

popularity_lm <- lm(popularity ~ top_genre + 
                      danceability + 
                      energy +
                      valence + 
                      tempo + 
                      duration_minutes + 
                      lexical_diversity + 
                      total_words + 
                      I(duration_minutes^2),
                    data = d)

tidy(popularity_lm)

anova(popularity_lm)

# here's an example of creating a new data.frame and doing some visualizations

nd <- expand_grid(
  top_genre = c("brooklyn indie","modern rock","pop punk","alternative metal","emo"),
  danceability = 50,
  energy = 50,
  valence = 50,
  tempo = 50,
  duration_minutes = 2:10,
  lexical_diversity = 50,
  total_words = 125
)

nd <- nd %>% 
  mutate(est_pop = predict(popularity_lm, newdata = nd))

ggplot(nd,
       aes(x=duration_minutes,y=est_pop,group=top_genre,color=top_genre)) + 
  geom_line() + 
  theme_minimal() + 
  labs(x="Duration",y="Estimated Song Popularity",
       color="Genre")
