# 
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode


# parsing with xml package
install.packages("XML")
library(XML)

url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)
html # this is not working

# something is wrong using this method
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

# read web page using GET from httr package
# this method is working
install.packages("httr")
library(httr)
html2 = GET(url)
content2 = content(html2, as = "text")
parsedHtml = htmlParse(content2, asText = T)
parsedHtml
xpathSApply(parsedHtml, "//title", xmlValue)
html2
names(html2)
