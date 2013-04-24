require(rCharts)
require(reshape2)
require(PerformanceAnalytics)

data(managers)


data <- t(table.AnnualizedReturns(managers))
data <- data.frame(rownames(data),data, row.names=NULL)

colnames(data)[1] <- "Series"
#remove . from column names
colnames(data) <- sapply(colnames(data), gsub, pattern="\\.", replacement="")

p2 <- nvd3Plot(AnnualizedReturn ~ AnnualizedStdDev,
               group = "Series",
               data = data,
               type = "scatterChart")
p2$chart(showDistX = TRUE)
p2$chart(showDistY = TRUE)
p2$chart(showControls = FALSE)
p2