require(rCharts)
require(reshape2)
require(PerformanceAnalytics)

data(edhec)

xtsMelt <- function(xtsData,metric){
  df <- data.frame(index(xtsData),coredata(xtsData),stringsAsFactors=FALSE)
  df.melt <- melt(df,id.vars=1)
  df.melt <- data.frame(df.melt,rep(metric,NROW(df.melt)))
  #little unnecessary housekeeping
  df.melt <- df.melt[,c(1,2,4,3)]
  colnames(df.melt) <- c("date","indexname","metric","value")
  df.melt$date <- as.Date(df.melt$date)
  return(df.melt)
}

edhec.melt <- xtsMelt(xtsData = cumprod(1+edhec), metric = "cumulreturn")
#remove troublesome . using modified method from this Stack Overflow
#http://stackoverflow.com/questions/2851015/convert-data-frame-columns-from-factors-to-characters
i <- sapply(edhec.melt, is.factor)
edhec.melt[i] <- lapply(edhec.melt[i], gsub, pattern="\\.", replacement="")

#get date in format that nvd3 likes
edhec.melt$date <- as.double(as.POSIXct(as.Date(edhec.melt$date),origin="1970-01-01")) * 1000

n1 <- nvd3Plot(y = "value",
               x = "date",
               group = "indexname",
               data = edhec.melt,
               type = "cumulativeLineChart")
n1$chart(showControls = FALSE) 
n1$xAxis(tickFormat='#!function(d) {return d3.time.format("%Y-%m-%d")(new Date(d));}!#') #.parse(d);}!#')
n1$yAxis(tickFormat = '#!function(d) {return d3.format(",.1%")(d)}!#')
n1
