# Katrina Olsen
# Assignment 5

library(tidyverse)
library(esquisse)
library(ggplot2)


# Make 10 plots overall.
# 9 plots should visualize the data from the two in-class experiments: 
# 3 plots for the Moses illusion data (line, point, and bar), 
moses <- read_csv("moses_clean.csv")
questions <- read_csv('questions.csv')

moses.processed <-
  moses |> 
  inner_join(questions, by=c("ITEM", "CONDITION", "LIST")) |>
  select(ID, ITEM, CONDITION, QUESTION, ANSWER, CORRECT_ANSWER) |>
  mutate(ACCURATE = ifelse(CORRECT_ANSWER == ANSWER,
                           yes = "Correct",
                           no = ifelse(ANSWER == "dont_know",
                                       yes = "Don't Know",
                                       no = "Incorrect")),
         CONDITION = case_when(CONDITION == '1' ~ 'Illusion',
                               CONDITION == '2' ~ 'No Illusion',
                               CONDITION == '100' ~ 'Good Filler',
                               CONDITION == '101' ~ 'Bad Filler'))  

# 1. Count of answer types across conditions
moses.processed |>
  filter(CONDITION %in% c('Illusion', 'No Illusion')) |>
  group_by(CONDITION, ACCURATE) |>
  summarise(Count = n()) |>
  ggplot() +
  aes(x = ACCURATE, y = Count, fill = CONDITION) +
  geom_bar(stat='identity', position = "dodge") +
  scale_fill_hue(direction = 1) +
  labs(
    x = "Type of Answers",
    y = "Counts",
    title = "Moses Illusion Effect on Answer Type Counts",
    fill = "Question Type",
  ) +
  theme_minimal()

# 2. Answer Types Per Question when illusion present
moses.processed |>
  filter(CONDITION %in% c('Illusion')) |>
  group_by(ITEM, ACCURATE) |>
  summarise(Count = n()) |>
  ggplot() +
  aes(x = ITEM, y = Count, fill = ACCURATE) +
  geom_bar(position="fill", stat="identity") +
  scale_fill_hue(direction = 1) +
  labs(
    x = "Question Number",
    y = "Percentage",
    title = "Answer Type Percentages per Moses Illusion Question",
    fill = "Question Type",
  ) +
  theme_minimal()

# 3. Percentage of Anwer Types per Question Types
moses.processed |>
  group_by(CONDITION, ACCURATE) |>
  summarise(Count = n()) |>
  ggplot() +
  aes(x = CONDITION, y = Count, fill = ACCURATE) +
  geom_bar(position="dodge", stat="identity") +
  scale_fill_hue(direction = 1) +
  labs(
    x = "Question Types",
    y = "Percentage",
    title = "Percentage of Anwer Types per Question Types",
    fill = "Answer Types",
  ) +
  theme_minimal()

##### 3 plots for the noisy channel reading time data (line, point, and bar) ######
noisy_rt <- read_csv("noisy_rt.csv")

# 1. Plausability Effect on Mean Reading Time per IA of Sentence

noisy_rt |>
  group_by(IA, CONDITION) |>
  summarise(Mean = mean(RT)) |>
  ggplot() +
  aes(x = IA, y = Mean, fill = CONDITION) +
  geom_bar(position="dodge", stat="identity") +
  scale_fill_hue(direction = 1) +
  labs(
    x = "IA of Sentence",
    y = "Mean Reading Time",
    title = "Plausability Effect on Mean Reading Time per IA of Sentence",
    fill = "Sentence Type",
  ) +
  theme_minimal()

# 2. Plausibility Effect on Mean Reading Time across Sentences

noisy_rt |>
  group_by(ITEM, CONDITION) |>
  summarise(Mean = mean(RT)) |>
  ggplot() +
  aes(x = ITEM, y = Mean, fill = CONDITION) +
  geom_bar(position="fill", stat="identity") +
  scale_fill_hue(direction = 1) +
  labs(
    x = "Sentence ID #",
    y = "Mean Reading Time",
    title = "Plausibility Effect on Mean Reading Time across Sentences",
    fill = "Sentence Type",
  ) +
  theme_minimal()

# 3. Plausibility on Reading Time per IA Type

noisy_rt |>
  mutate(IA_Type = as.character(IA)) |>
  group_by(IA_Type, CONDITION) |>
  ggplot() +
  aes(x = IA_Type, y = RT, fill = CONDITION) +
  geom_boxplot() +
  scale_fill_hue(direction = 1) +
  labs(
    x = "IA of Sentence",
    y = "Reading Time",
    title = "Plausibility on Reading Time per IA Type",
    fill = "Sentence Type",
  ) +
  theme_minimal()

# 3 plots for the noisy channel acceptability rating data (line, point, and bar).
noisy_aj <- read_csv("noisy_aj.csv")

# 1. Plasibility Effect on Acceptability of Sentences

noisy_aj |>
  group_by(CONDITION) |>
  ggplot() +
  aes(x = CONDITION, y = RATING) +
  geom_boxplot(color="purple", fill="pink") +
  scale_fill_hue(direction = 1) +
  labs(
    x = "IA of Sentence",
    y = "Acceptability",
    title = "Plasibility Effect on Acceptability of Sentences",
  ) +
  theme_minimal()

# 2. Plausibility Effect on Acceptability Rating per Sentence

noisy_aj |>
  group_by(ITEM, CONDITION) |>
  summarise(Mean = mean(RATING)) |>
  ggplot() +
  aes(x = ITEM, y = Mean, fill = CONDITION) +
  geom_bar(position="dodge", stat="identity") +
  scale_fill_hue(direction = 1) +
  labs(
    x = "Sentence ID #",
    y = "Mean Acceptability Rating",
    title = "Plausibility Effect on Acceptability Rating per Sentence",
    fill = "Sentence Type",
  ) +
  theme_minimal()

# 3. Plausibility Effect on Acceptability Rating

noisy_aj |>
  group_by(CONDITION) |>
  summarise(Mean = mean(RATING)) |>
  ggplot() +
  aes(x = CONDITION, y = Mean) +
  geom_bar(position="dodge", stat="identity", fill='blue') +
  scale_fill_hue(direction = 1) +
  labs(
    x = "Sentence Type",
    y = "Mean Acceptability Rating",
    title = "Plausibility Effect on Acceptability Rating",
  ) +
  theme_minimal()

# The last plot can be based on any dataset you want and be in any shape you want. 
# It has to be ugly, unreadable, and violate as many WCOG guidelines as it can. The top 3 ugliest plots win a prize!

noisy_aj |>
  inner_join(noisy_rt, by=c("ID", "ITEM", "CONDITION")) |>
  ggplot() +
  aes(x = ID, fill = RATING, colour = SENTENCE, weight = ITEM) +
  geom_bar() +
  scale_fill_gradient() +
  scale_color_hue(direction = 1) +
  coord_polar() +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),legend.position="none",
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank())

# I found the way to remove all labeling from this stack overflor post:
#   https://stackoverflow.com/questions/6528180/ggplot2-plot-without-axes-legends-etc


