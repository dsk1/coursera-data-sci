## Three main indications of a problem : message, warning, error
## 
## Debugging
## warning

log(-1)

printmessage <- function(x){
        if(x > 0)
                print("x is greater than 0")
        else
                print("x is less than or equal to 0")
        
        x            # invisible() returns x invisibly.
}
printmessage(1)

printmessage(NA)

# the function prints the message and returns 1 invisibly
# the ivisibly returned value can be assigned to a object
y <- printmessage(1)

y

printmessage2 <- function(x){
        if(is.na(x))
                print("x is a missing value")
        else if(x > 0)
                print("x is greater than 0")
        else
                print("x is less than or equal to 0")
        
        invisible(x)            # invisible() returns x invisibly.
}

printmessage2(1)

printmessage2(NA)

x <- log(-1)
printmessage2(x)

## Debugging Tools in R
# traceback
# debug
# browser
# trace
# recover

## traceback
rm(x)
x
mean(x)
traceback()

lm(y ~ x)
traceback()

## debug, browser, trace
debug(lm)
lm(y ~ x)

## recover
options(error = recover)
read.csv("nosuchfile")
