install.packages(c("ggplot2", "dplyr", "tidyr", "plotly"))




# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)

# Load the Titanic dataset
# You can use the built-in Titanic dataset in R or load it from a CSV
data("Titanic")
titanic_data <- as.data.frame(Titanic)

# Basic data preprocessing
titanic_data <- titanic_data %>%
  mutate(Survived = as.factor(Survived))





1. Bar Plot: Survival Count by Gender
ggplot(titanic, aes(x = factor(Survived), fill = Sex)) +        
  geom_bar(position = "dodge") +   
  labs(title = "Survival Count by Gender", x = "Survived", y = "Count") +  
  scale_fill_manual(values = c("blue", "pink")) +      
  theme_minimal()       



2. Pie Chart: Survival Proportion
                                
titanic %>%      
group_by(Survived) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = "", y = count, fill = factor(Survived))) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y") +
  labs(title = "Survival Proportion") +
  scale_fill_manual(values = c("red", "green")) +
  theme_void()

 # titanic %>%: Uses the pipe operator to pass the titanic dataset into the next operations.
                       # group_by(Survived): Groups the data by the Survived variable.
                                       # summarize(count = n()): Calculates the number of occurrences (count) for each level of Survived.
# ggplot(aes(...)): Initializes a new ggplot object with the summarized data. The x aesthetic is set to an empty string (to create a single pie slice), y is set to the count, and fill is set to Survived.

# geom_bar(...): Creates a bar chart (which will be transformed into a pie chart). stat = "identity" uses the counts directly instead of computing them.
r
# coord_polar("y"): Converts the bar chart into a pie chart by transforming the coordinates to polar.

# theme_void(): Removes background and grid lines, leaving just the pie chart visible.


3. Histogram: Age Distribution of Passengers
ggplot(titanic, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Age Distribution of Passengers", x = "Age", y = "Count") +
  theme_minimal()




4. Box Plot: Age vs. Survival
ggplot(titanic, aes(x = factor(Survived), y = Age, fill = factor(Survived))) +
  geom_boxplot() +
  labs(title = "Age vs. Survival", x = "Survived", y = "Age") +
  scale_fill_manual(values = c("lightcoral", "lightgreen")) +
  theme_minimal()



5. Scatter Plot: Age vs. Fare
ggplot(titanic, aes(x = Age, y = Fare, color = factor(Survived))) +
  geom_point(alpha = 0.5) +
  labs(title = "Age vs. Fare", x = "Age", y = "Fare") +
  scale_color_manual(values = c("red", "green")) +
  theme_minimal()




6. Count Plot: Survival by Class
ggplot(titanic, aes(x = Pclass, fill = factor(Survived))) +
  geom_bar(position = "dodge") +
  labs(title = "Survival by Class", x = "Class", y = "Count") +
  scale_fill_manual(values = c("lightblue", "lightgreen")) +
  theme_minimal()





7. Density Plot: Age Distribution by Survival
ggplot(titanic, aes(x = Age, fill = factor(Survived))) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Age by Survival", x = "Age", y = "Density") +
  scale_fill_manual(values = c("red", "green")) +
  theme_minimal()
