require(quantmod)
require(rCharts)

aapl <- getSymbols("AAPL", auto.assign = FALSE)
aapl.df <- data.frame(
  index(aapl),
  coredata(aapl)
)
colnames(aapl.df) <- c("date","open","high","low","close","volume","adjusted")
n1 <- nvd3Plot(
  x = "date",
  y = "close",
  y2 = "volume",
  data = aapl.df,
  type = "linePlusBarChart",
  height = 400,
  width = 800
)
n1$templates$script = file.path(n1$LIB$url,'layouts',"linePlusBar.html")
n1$xAxis(tickFormat =
  "#!function (d) {
            return d3.time.format('%b %d, %Y')(new Date(d));
          }!#"
)
n1
