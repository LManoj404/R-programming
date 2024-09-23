titanic=read.csv("train.csv")
head(titanic)

sapply(train, class)

train$Survived=as.factor(train$Survived)
train$Sex=as.factor(train$Sex)
sapply(train, class)

summary(train)

sum(is.na(train))

dropnull_train=train[rowSums(is.na(train))<=0,]

survivedlist=dropnull_train[dropnull_train$Survived == 1,]
notsurvivedlist=dropnull_train[dropnull_train$Survived == 0,]

mytable <- table(titanic$Survived)
lbls <- paste(names(mytable), "\n", mytable, sep="")
pie(mytable,
    labels = lbls,
    main="Pie Chart of Survived column data\n (with sample sizes)") 

hist(survivedlist$Age,
     xlab="gender",
     ylab="frequency")

barplot(table(notsurvivedlist$Sex),
        xlab="gender",
        ylab="frequency")

temp<-density(table(titanic$Fare))
plot(temp, type="n",
     main="Fare charged from Passengers")
polygon(temp, col="lightgray",
        border="gray")

boxplot(titanic$Fare,
        main="Fare charged from passengers")

