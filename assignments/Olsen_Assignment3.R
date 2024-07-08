# 1. What do the following evaluate to and why?
  
# !TRUE       # FALSE, bc that is what "not True" is
# FALSE + 0   # 0, bc FALSE as a number is 0, so 0+0=0
# 5 & TRUE    # TRUE, bc a non-0 number is TRUE, so TRUE & TRUE is TRUE
# 0 & TRUE    # FALSE, bc 0 is FALSE, and FALSE & TRUE is FALSE
# 1 - FALSE   # 1, bc FALSE is 0, so 1-0=1
# FALSE + 1   # 1, bc FALSE is 0, so 0+1=1
# 1 | FALSE   # TRUE, bc 1 is TRUE and TRUE OR FALSE is TRUE
# FALSE | NA  # NA,  bc I guess NA holds priority over FALSE and it's more
              #      correct to return NA still rather than TRUE? This seems weird

# 2. Have the moses.csv data saved in your environment as "moses". Why do the following fail?
library(tidyverse)  
library(psych)

Summary(moses)                               # should be lowercase summary
read_csv(moses.csv)                          # path should be in quotes
tail(moses, n==10)                           # n==10 is a TRUE/FALSE equality check, n=10 is getting 10 rows in tail
describe(Moses)                              # the variable is lowercase moses
filter(moses, CONDITION == 102)              # this doesn't fail, but per unique(select(moses, CONDITION)), CONDITION is never 102, so result is empty
arragne(moses, ID)                           # typo, arrange (also only works if we already renamed the column to ID)
mutate(moses, ITEMS = as.character("ITEM"))  # this doesn't fail, but just makes a column of "ITEM", to have the string version of ITEM, remove the ""s

# 3. Clean up the Moses illusion data like we did in the tasks in class and save it to a new data frame. 
#    Use pipes instead of saving each step to a new data frame.

# select relevant columns
# rename mislabeled columns
# remove missing data
# remove unnecessary rows
# change the item column to numeric values
# arrange by item, condition, and answer

moses_cleaned <- moses |>
  rename(c(ID = MD5.hash.of.participant.s.IP.address, ANSWER = Value, Order.number.of.item = ITEM)) |>
  na.omit() |>
  select(c(ITEM, CONDITION, ANSWER, ID, Label, Parameter)) |>
  filter(Parameter == "Final", Label != "instructions", CONDITION %in% c(1,2)) |>
  mutate(NUM = as.numeric(ITEM)) |>
  arrange(ITEM, CONDITION, desc(ANSWER))
  

# 4. From the Moses illusion data, make two new variables (printing and dont.know, respectively) with all 
#    answers which are supposed to mean "printing (press) and "don't know".

# seems like asking about for question 32, so unique(select(filter(moses_cleaned, ITEM==32), ANSWER))
printing <- c('Typing machine', 'inventing printing', 'for inventing the pressing machine', 'the book printer', 
              'inventing the book press/his bibles', 'letterpress', 'Printing', 'bookpress', 'Print', 
              'finding a way to print books', 'press', 'Book print', 'printing press', 'Printing books',
              'Letterpressing', 'book printing', 'letter press', 'Press', 'Buchdruck', 'Drucka')

dont.know <- c('who', "don't know", "Don't Know", "Don't know")

# excluding 'gf' bc that person just keysmashed, I don't think it counts as "don't know"


# 5. Preprocess noisy channel data. Make two data frames: for reading times and for acceptability judgments.

# ~~~~~ Acceptability ratings: ~~~~~~~
# - rename the ID column and column with the rating
# - only data from the experiment (see Label) and where PennElementType IS "Scale"
# - make sure the column with the rating data is numeric
# - select the relevant columns: participant ID, item, condition, rating
# - remove missing values

noisy_accept <- noisy |>
  rename(c(ID = id, ANSWER = Value)) |>
  filter(Label == "experiment", PennElementType == "Scale") |>
  mutate(RATING = as.numeric(ANSWER)) |>
  select(c(ID, ITEM, CONDITION, RATING)) |>
  na.omit()

# ~~~~~~~ Reading times: ~~~~~~
# - rename the ID column and column with the full sentence
# - select:
#      - only data from the experiment (see Label) 
#      - only data where PennElementType IS NOT "Scale" or "TextInput"
#      - only data from where Reading.time is not "NULL" (as a string)
# - make a new column with reading times as numeric values 
# - keep only those rows with realistic reading times (between 80 and 2000 ms)
# - select relevant columns: participant ID, item, condition, sentence, reading time, and Parameter
# - remove missing values

noisy_reading <- noisy |>
  rename(c(ID = id, SENTENCE = Sentence..or.sentence.MD5.)) |>
  filter(Label == "experiment", !(PennElementType == c("Scale", "TextInput")), Reading.time != "NULL") |>
  mutate(READ_TIME = as.numeric(Reading.time)) |>
  filter(READ_TIME > 80 & READ_TIME < 2000) |>
  select(c(ID, ITEM, CONDITION, SENTENCE, READ_TIME, Parameter)) |>
  na.omit()

# 6. Solve the logic exercise from the slides.

# !swim
# bird & swim
# swim & !bird
# !bird & !swim
# bird & !swim
# bird | swim
# !(bird & swim)
# bird | !bird
# bird & !bird
