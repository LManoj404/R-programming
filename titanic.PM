# Load necessary libraries
library(tidyverse)
library(caret)  # For createDataPartition, train, and confusionMatrix

# Load the dataset
titanic_data <- read.csv("C:/Users/Tonmoy/Downloads/titanic.csv")

# Data preprocessing
titanic_data <- titanic_data %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare)

# Convert categorical variables to numeric
titanic_data$Sex <- as.numeric(factor(titanic_data$Sex))

# Handle missing values by imputing with mean for Age
titanic_data$Age[is.na(titanic_data$Age)] <- mean(titanic_data$Age, na.rm = TRUE)

# Check for remaining missing values
missing_values <- sum(is.na(titanic_data))
print(paste("Remaining missing values after imputation:", missing_values))

# Remove rows with remaining missing values (if any)
if (missing_values > 0) {
  titanic_data <- na.omit(titanic_data)
}

# Convert Survived to factor for classification
titanic_data$Survived <- as.factor(titanic_data$Survived)

# Split the data into training and testing sets
set.seed(123)
trainIndex <- createDataPartition(titanic_data$Survived, p = .8, list = FALSE)
titanic_train <- titanic_data[trainIndex, ]
titanic_test  <- titanic_data[-trainIndex, ]

# Train a logistic regression model
model <- train(Survived ~ ., data = titanic_train, method = "glm", family = binomial)


# Make predictions on the test set
predictions <- predict(model, titanic_test)

# Ensure both factors have the same levels
levels(titanic_test$Survived) <- levels(predictions)

# Evaluate the model
conf_matrix <- confusionMatrix(predictions, titanic_test$Survived)
print(conf_matrix)
