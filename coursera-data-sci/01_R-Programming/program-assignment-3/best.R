setwd("C:/RWDir/coursera-data-sci/R-Programming/program-assignment-3")

best <- function(state, outcome) {
        ## Read outcome data
        hospDf <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)
        
        hospDf[ ,11] <- as.numeric(hospDf[ ,11])
        hospDf[ ,17] <- as.numeric(hospDf[ ,17])
        hospDf[ ,23] <- as.numeric(hospDf[ ,23])
        
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
        
        # The last hospital is the worst hospital in the state
        worstHosp <- nrow(stateDf)
        bestHosp <- 1
        
        ## Return the hospital in that state with lowest 30-day death 
        ## i.e return the best hospital
        
        stateDf[bestHosp, ]$hospital
        
}