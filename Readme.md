# nvd3 in R with rCharts

[rCharts](http://ramnathv.github.io/rCharts) provides an interface between R and most popular interactive Javascript visualization libraries.  Here are some quick examples using [NVD3](http://nvd3.org) to create some **PerformanceAnalytics** type graphics.  These examples are minimal.  To see a much more complete example, go to [recreate NYT baseball tutorial](http://ramnathv.github.io/rChartsNYT).

To run these, the **create_chart** function will produce a fully rendered beautiful HTML page from an .R source file.  Each of the .R source files are provided in this repo.  

```
#using StackOverflow http://stackoverflow.com/questions/14958516/looping-through-all-files-in-directory-in-r-applying-multiple-commands

#to install rCharts if you do not have it uncomment next two lines
#require(devtools)
#install_github('rCharts', 'ramnathv')
require(rCharts)

examples = c("cumulline_edhec.R",      
             "scatter_riskreturn.R")    

#change the number in examples[i] to the example you would like to run
sapply(paste0(
  "https://raw.github.com/timelyportfolio/rCharts_nvd3_standalone/master/",
  examples),
       FUN = create_chart)

#if sapply scares you or if you want to try just one, here is another way to do it
create_chart(paste0("https://raw.github.com/timelyportfolio/rCharts_nvd3_standalone/master/",examples[1]))

```