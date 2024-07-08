# Katrina Olsen
# Assignment 4

library(tidyverse)
library(psych)

# Read and preprocess the new Moses illusion data (moses_clean.csv).
moses <- read_csv("moses_clean.csv")
questions <- read_csv('questions.csv')

moses_clean <- moses |>
               inner_join(questions, by=c("ITEM", "CONDITION", "LIST")) |>
               select(ITEM, CONDITION, ID, ANSWER, CORRECT_ANSWER, LIST) |>
               mutate(ACCURATE = ifelse(CORRECT_ANSWER == ANSWER,
                           "correct",
                           ifelse(ANSWER == "dont_know",
                                       yes = "dont_know",
                                       no = "incorrect")))


# Calculate the percentage of "correct", "incorrect", and "don't know" 
#           answers in the two critical conditions.

moses_clean |>
        filter(CONDITION %in% c(1, 2)) |>
        group_by(CONDITION, ACCURATE) |>
        summarise(Count = n()) |>
        mutate(PERC = Count / length(moses_clean))

# Of all the questions in all conditions, which question was the easiest and which was the hardest?

# easiest question = most got correct

moses_clean |> group_by(ITEM, ACCURATE) |>
  summarise(Count = n()) |>
  filter(ACCURATE == 'correct') |>
  arrange(desc(Count))
  

# hardest question = most got incorrect

moses_clean |> group_by(ITEM, ACCURATE) |>
  summarise(Count = n()) |>
  filter(ACCURATE == 'incorrect') |>
  arrange(desc(Count))


# Of the Moses illusion questions, which question fooled most people?
moses_clean |>
  filter(CONDITION == 1) |>
  group_by(ITEM, ACCURATE) |>
  summarise(Count = n()) |>
  filter(ACCURATE == 'incorrect') |>
  arrange(desc(Count))


# Which participant was the best in answering questions?
moses_clean |>
  group_by(ID, ACCURATE) |>
  summarise(Count = n()) |>
  filter(ACCURATE == 'correct') |>
  arrange(desc(Count))

# Who was the worst?
moses_clean |>
  group_by(ID, ACCURATE) |>
  summarise(Count = n()) |>
  filter(ACCURATE == 'correct') |>
  arrange(Count)

# --> I'm not sure how to return just the first item in ID with this format to 
#     give the exact ID? In base R I'd do data$ID[1]


# Read and inspect the updated new noisy channel data (noisy_rt.csv and noisy_aj.csv).
noisy_rt <- read_csv("noisy_rt.csv")
noisy_aj <- read_csv("noisy_aj.csv")


# Acceptability judgment data: Calculate the mean rating in each condition. 
noisy_aj |>
  group_by(CONDITION) |>
  summarise(Mean = mean(RATING))

# How was the data spread out?
describe(noisy_aj)

# Did the participants rate the sentences differently?
noisy_aj |>
  group_by(ID) |>
  summarise(Mean = mean(RATING),
            SD = sd(RATING))
# --> yes, e.g. f1c50c4a21dd8490770f989814f3cd76 rated very high on average, with a low SD


# Reading times: calculate the average length people spent reading each sentence fragment 
#    in each condition. 
noisy_rt |>
  group_by(CONDITION) |>
  summarise(Mean = mean(RT),
            SD = sd(RT))

# Did the participant read the sentences differently in each condition

# --> yes, it on average took more time for participants to read implausible
#.    sentences than plausible ones

# Make one data frame out of both data frames. Keep all the information but remove redundancy.
noisy_rt |>
  inner_join(noisy_aj, by=c("ITEM", "CONDITION", "ID"))

# --> I don't think this has any redundany columns and each row is different from each other
#     so I think this inner join is enough?
