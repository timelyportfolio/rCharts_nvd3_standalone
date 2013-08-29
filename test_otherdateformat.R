#shows how this is not flexible for various date formats

require(quantmod)
require(reshape2)
require(rCharts)
#get sp500 prices from Yahoo! Finance
sp500 <- getSymbols("^GSPC", auto.assign = FALSE)
#add 200 day moving average
sp500$ma <- runMean( sp500[,4], n = 200)
#get date, close, and 200day mov avg as a data.frame
sp500.df <- data.frame(index(sp500),coredata(sp500)[,c(4,7)])
colnames(sp500.df) <- c("date","close","200dMovAvg")
#melt to long format
sp500.melt <- melt( sp500.df, id.vars = 1 )


#get dates to a javascript favorite format
sp500.melt$date <- format(sp500.melt$date,"%Y-%m-%d")




#do a NVD3 lineWithFocus chart
n1 <- nPlot(
  y = "value",
  x = "date",
  group = "variable",
  data = sp500.melt,
  type = "lineWithFocusChart",
  height = 400,
  width = 600
)
#set xAxis up to format dates
n1$xAxis(tickFormat = 
           "#!function(d) {return d3.time.format('%b %Y')(d3.time.format('%Y-%m-%d').parse(d))}!#"
         )

#set yAxis up to format numbers
n1$yAxis(tickFormat = "#!function(d) {return d3.format('0,.0')(d)}!#")
n1