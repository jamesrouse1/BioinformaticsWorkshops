############################### R Basic commands/functions #####################
# Printing
print("Hello World")

# Variable assignment and operations
x <- 5  # Integer
y <- 3  # Integer

# Arithmetic operations
print(x + y)  # Addition
print(x * y)  # Multiplication
print(x ^ y)  # Exponentiation
print(x / y)  # Division

# Assigning result to a new variable
z <- x + y
print(z)

# Logical comparisons
print(x > y)  # Greater than
print(x == y)  # Equal to
print(x != y)  # Not equal to

# Combining variables into a vector
all_variables <- c(x, y, z)
print(all_variables)

# Different types of variables
int_var <- 10L  # Integer
num_var <- 10.5  # Numeric (double)
char_var <- "Hello"  # Character
bool_var <- TRUE  # Logical (Boolean)

# Checking variable class
print(class(int_var))
print(class(num_var))
print(class(char_var))
print(class(bool_var))

# Vectors (One-dimensional data structures)
vec_num <- c(1, 2, 3, 4, 5)  # Numeric vector
vec_char <- c("A", "B", "C")  # Character vector
vec_logical <- c(TRUE, FALSE, TRUE)  # Logical vector

# Lists (Heterogeneous data structures)
list_var <- list(int_var, num_var, char_var, bool_var)
print(list_var)

# Matrices (Two-dimensional numeric structures)
mat <- matrix(1:9, nrow = 3, ncol = 3)
print(mat)


# Data frames (Tabular structures)
count_data <- data.frame(
  Gene = c("Gene1", "Gene2"),
  Sample1 = c(100, 200),
  Sample2 = c(150, 250)
)
print(count_data)
################################################################################
##########################Example data with count matrix########################

# Reading libraries
install.packages("dplyr")
library(dplyr)      # For data manipulation
install.packages("gsheet")
library(gsheet)     # For reading URL from Google Sheets

# Storing URL as a variable and reading in the data
url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vQZ4ic6NPh0NC3YzftHXzr8qJOz2kJ4pNwKrRuZAYdPk4edNK_Y1PP0ww2PtZJDk8C5PHmxGyLZWY5q/pub?gid=1605311698&single=true&output=csv"
counts <- read.csv(url)

str(counts)
library(googlesheets4)

url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vRoWKt_En92S-mZV9UEY1YW6KoYuoFg-jF0ftPsvQ_zcysPDDMq5_TvNw-FQqV-8bZigfBYALtEUgRY/pub?output=csv"
dat <- read_sheet(url)
# Preview the data
print("Data Preview:")
print(head(counts))

# Convert gene column to row names
rownames(counts) <- counts$Gene

counts$Gene

counts <- counts[, -1]  # Remove the Gene column from the data frame

counts <- read.csv(url, row.names = 1)
?read.csv

str(counts)


# Step 3: CPM Normalization
# Calculate the total counts per sample
total_counts <- colSums(counts)
total_counts
# Divide each count by the total counts for its column and multiply by 1e6
cpm <- counts / total_counts * 1e6

# Write the new file to a csv
write.csv(cpm, "~/Tumor_vs_Normal_CPM.csv")
#print(normalizePath("~"))





# Indexing data frames
cpm[, 1]
cpm [1,]

cpm[, c(1:3)]
cpm[, c(4:6)]

cpm[1,1]


# Define thresholds
min_threshold <- 20000  # Minimum CPM value
min_samples <- 2        # Minimum number of samples with CPM above threshold

# Create logical filters
average_filter <- rowMeans(cpm) >= min_threshold  # Average CPM below max threshold (optional)
rowMeans(cpm)
rowMeans(cpm) >= min_threshold
average_filter

# per sample filter
per_sample_filter <- rowSums(cpm >= min_threshold) > min_samples  # At least `min_samples` columns above threshold
cpm >= min_threshold
rowSums(cpm >= min_threshold)
rowSums(cpm >= min_threshold) > min_samples
per_sample_filter
# Apply AND (`&`) or OR (`|`) conditions
filtered_cpm <- cpm[per_sample_filter & average_filter, ]  # AND condition: both must be true
per_sample_filter & average_filter
filtered_cpm_or <- cpm[per_sample_filter | average_filter, ]  # OR condition: at least one must be true
per_sample_filter | average_filter

# View the filtered data
dim(filtered_cpm)  # Check dimensions after filtering
dim(filtered_cpm_or)

nrow(filtered_cpm)
nrow(filtered_cpm_or)


########## Calculating averages ################################
Tumor_Mean <- rowMeans(cpm[, c(1:3)])
Normal_Mean <- rowMeans(cpm[, c(4:6)])



## Creating data frame with calculated averages
combined_avg <- data.frame(
  Tumor_Mean = Tumor_Mean,
  Normal_Mean = Normal_Mean
)


#########################################################################
#############################dplyr#######################################
## SELECT
library(dplyr)
tumor_data <- combined_avg %>%
  select(Tumor_Mean)

tumor_data <- select(combined_avg, Tumor_Mean)



### MUTATE
mutated_data <- combined_avg %>%
  mutate(Difference = Tumor_Mean - Normal_Mean)

head(mutated_data)


##### FILTER
filtered_data <- combined_avg %>%
  filter(abs(Tumor_Mean - Normal_Mean) > 2000)

nrow(filtered_data)



####### Joining
# Example meta data 1
meta_data_1 <- data.frame(
  Sample = c("Normal_1", "Normal_2", "Normal_3", "Tumor_1"),
  Group = c("Normal", "Normal", "Normal", "Tumor"),
  Condition = c("Healthy", "Healthy", "Healthy", "Cancer")
)

# Example meta data 2
meta_data_2 <- data.frame(
  Sample = c("Normal_2", "Tumor_1", "Tumor_2", "Tumor_3"),
  Batch = c("A", "B", "B", "C")
)

# Left join: Keep only all rows in first data frame mentioned and add columns that
# match from the second
left_join_result <- left_join(meta_data_1, meta_data_2, by = "Sample")

# Left join: Keep only all rows in second data frame mentioned and add columns that
# match from the first. (Rarely used, usualy mention rows you want to keep first)
right_join_result <- right_join(meta_data_1, meta_data_2, by = "Sample")


# Takes all samples and joins all information
full_join_result <- full_join(meta_data_1, meta_data_2, by = "Sample")

# Outputs only samples that are present in both data frames
inner_join_result <- inner_join(meta_data_1, meta_data_2, by = "Sample")

print("Left Join Result:")
print(left_join_result)

print("Right Join Result:")
print(right_join_result)

print("Full Join Result:")
print(full_join_result)

print("Inner Join Result:")
print(inner_join_result)
