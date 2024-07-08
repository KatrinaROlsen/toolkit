# Please complete the following tasks. Submit the assignment as a single R script. 
# Use comments and sections to give your file structure.

#--------------------------------------------------------
# 1. According to R, what is the type of the following:
#--------------------------------------------------------

#  "Anna" #character

# -10 #integer

# FALSE #logical

# 3.14 #numeric

# as.logical(1) #logical

#------------------------------------------
# 2. According to R, is the following true:
#------------------------------------------

#  7+0i == 7 #TRUE

# 9 == 9.0 #TRUE

# "zero" == 0L #FALSE

# "cat" == "cat" #TRUE

# TRUE == 1 #TRUE

#------------------------------------------------------------
# 3. What is the output of the following operations and why?
#------------------------------------------------------------

# 10 < 1 # FALSE, bc 10 is not less than 1

# 5 != 4 # TRUE, bc 5 does not equal 4

# 5 - FALSE # 5, bc FALSE numerically is stored as 0, so 5-0 = 5

# 1.0 == 1 # TRUE, bc even though they are different types, R isn't mean about this for ==

# 4 *9.1 # 35.4, bc 4 times 9.1 = 35.4

# "a" + 1 # Error, bc these are different types and it doesn't know how to add them

# 0/0 # NaN, because 0 divided by 0 is neither infinity nor 0, undefined aka not a number

# b* 2 #Error, we never created a variable b

# (1-2)/0 #-Inf, bc 1-2 is -1 and #/0 is infinity, so negatice infinity

# 10 <- 20 #Error, can't assign numbers as a variable

# NA == NA #NA, I guess the result of anything with NA is just NA

# -Inf == NA #NA, I guess the result of anything with NA is just NA

#--------------------------------------------------------------------------
# 4. Read and inspect the noisy.csv data. What are the meaningful columns? 
#    What should be kept and what can be discarded?
#---------------------------------------------------------------------------

# Maybe discard rows that are missing:
# - Reading time (i.e. where they're NA or NULL)
# or in other words, any time Parameter isn't 1-4, those are the rows that 
# seem to miss tons of information and nothing unique in other columns (I think)

# Potentially can be removed bc whole column is only ever one value:
# - Controller.name
# - Latin.Square.Group
# - RT
