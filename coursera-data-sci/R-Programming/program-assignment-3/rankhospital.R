setwd("C:/RWDir/coursera-data-sci/R-Programming/program-assignment-3")

rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        hospDf <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)

        ## Check that state and outcome are valid
        valid.outcomes <- c("heart attack", "heart failure", "pneumonia")
        valid.states <- unique(hospDf[,"State"])
        
        if(!any(valid.states == state)){
                stop("invalid state")
        }
        
        if(!any(valid.outcomes == outcome)){
                stop("invalid outcome")
        }
        
        # change outcome variable to the corresponding column index of the outcome
        if(outcome == "heart attack")
                outcomeCol <- 11
        else if(outcome == "heart failure")
                outcomeCol <- 17
        else
                outcomeCol <- 23
        
        # subset the data frame to contain only the hospital, state and outcome
        subsetDf <- hospDf[, c(2, 7, outcomeCol)]
        subsetDf <- subsetDf[complete.cases(subsetDf), ]
        
        # change the names of columns for easy readability
        names(subsetDf) <- c("hospital", "state", "outcomerate")
        
        # Sort the subset data frame on state, hospital, outcome 
        # columns in that order
        subsetDf <- subsetDf[order(subsetDf$state, subsetDf$outcomerate, subsetDf$hospital), ]
        head(subsetDf)
        
        # Derive a data frame for the Sate
        stateDf <- subsetDf[subsetDf$state == state, ]
        
        # if num is best then take the first row
        # if num is not worst take the last row
        # if num is greater than number of rows for the state or if its not 
        #       integer then return NA
        # otherwise take the num'th row
        
        if(num == "best")
                retRow <- 1
        else if(num == "worst")
                retRow <- nrow(stateDf)
        else if (num > nrow(stateDf))
                return(NA)
        else
                retRow <- num
        
        
        ## Return the hospital from the row taken above
        stateDf[retRow, ]$hospital
        
}
