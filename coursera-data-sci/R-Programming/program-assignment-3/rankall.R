setwd("C:/RWDir/coursera-data-sci/R-Programming/program-assignment-3")

rankall <- function(outcome, num = "best") {
        ## Read outcome data
        hospDf <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)

        ## Check that state and outcome are valid
        valid.outcomes <- c("heart attack", "heart failure", "pneumonia")
        
        if(!any(valid.outcomes == outcome)){
                stop("invalid outcome")
        }
        
        # Get the list of states
        states <- unique(hospDf$State)
        
        print(states)
        
        
        df <- data.frame(hospital= character(), state = character())
        hospitals <- character(0)
        
        # loop through the states and find the num'th rank hospital for the outcome
        for(st in states){
                
                hsp <- rankhospital(st, outcome, num)
                # print(hsp)
                
                if(is.na(hsp)) {
                        next
                }
                else
                        hospitals <- c(hospitals, hsp)
        }
        
        data.frame(hospital = hospitals, state = states)
}
