## Scoping Rules

lm <- function(x){
        x * x
}

# Lexical scoping
f <- function(x,y){
        x^2 + y / z
}

# Lexical scoping 2
make.power <- function(n){
        pow <- function(x){
                x^n
        }
        pow
}

# Lexical Vs. Dynamic scoping
y <- 10

f <- function(x){
        y <- 2
        y^2 + g(x)
}

g <- function(x){
        x*y
}

# Lexical Vs. Dynamic scoping 2
g <- function(x){
        a <- 3
        x + a + y
}
