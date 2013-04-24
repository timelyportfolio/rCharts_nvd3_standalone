require(rCharts)
require(reshape2)
require(PerformanceAnalytics)

data(managers)


data <- t(table.AnnualizedReturns(managers))
data <- data.frame(rownames(data),data, row.names=NULL)

colnames(data)[1] <- "series"
colnames(data) <- c("series","y","x")

#add a size variable for instance pct of assets in a portfolio context
#data$size <- data$x

#remove . from column names
colnames(data) <- sapply(colnames(data), gsub, pattern="\\.", replacement="")

p2 <- nvd3Plot(y ~ x,
               group = "series",
               data = data,
               type = "scatterChart")
p2$chart(showDistX = TRUE)
p2$chart(showDistY = TRUE)
#tooltip behavior is odd in this model so leave magnify on even though I do not like it
p2$chart(showControls = TRUE)
p2