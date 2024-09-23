# Load necessary libraries
library(tidyverse)
library(cluster)
library(factoextra)

# Load the dataset
titanic_data <- read.csv("C:/Users/Tonmoy/Downloads/titanic.csv")

# Data preprocessing
# Remove unnecessary columns
titanic_data <- titanic_data %>%
  select(PassengerId, Survived, Pclass, Sex, Age, SibSp, Parch, Fare)

# Convert categorical variables to numeric
titanic_data$Sex <- as.numeric(factor(titanic_data$Sex))

# Handle missing values
# Impute missing values for Age
titanic_data$Age[is.na(titanic_data$Age)] <- mean(titanic_data$Age, na.rm = TRUE)

# Ensure there are no remaining missing values
missing_values <- sum(is.na(titanic_data))
print(paste("Remaining missing values after imputation:", missing_values))

# If missing values still exist, handle them (e.g., impute with mean or remove rows/columns)
if (missing_values > 0) {
  # Remove rows with remaining missing values (if any)
  titanic_data <- na.omit(titanic_data)
}

# Standardize the data
titanic_scaled <- scale(titanic_data)

# Check for NaNs or Infs in the scaled data
if (any(is.nan(titanic_scaled)) || any(is.infinite(titanic_scaled))) {
  stop("Scaled data contains NaN or Inf values")
}

# Double-check the data for any anomalies
print(summary(titanic_scaled))

# Determine the optimal number of clusters
# If Elbow method still fails, manually try different k values
fviz_nbclust(titanic_scaled, kmeans, method = "wss") + labs(subtitle = "Elbow Method")

# Perform K-means clustering with the optimal number of clusters (e.g., k = 3)
set.seed(123)
kmeans_result <- kmeans(titanic_scaled, centers = 3, nstart = 25)

# Check if kmeans_result was created successfully
if (!exists("kmeans_result")) {
  stop("K-means clustering failed to create kmeans_result")
}

# Add cluster assignments to the original dataset
titanic_data$Cluster <- kmeans_result$cluster

# Visualize the clustering
fviz_cluster(kmeans_result, data = titanic_scaled, geom = "point", stand = FALSE)
