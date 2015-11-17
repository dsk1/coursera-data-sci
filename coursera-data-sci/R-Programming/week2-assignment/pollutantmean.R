# Part 1
#Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 
#The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
#Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data 
#from the directory specified in the 'directory' argument 
# and returns the mean of the pollutant across all of the monitors, 
#ignoring any missing values coded as NA. 
# #A prototype of the function is as follows


# pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
#}

################### Part 1 ##################


pollutantmean <- function(directory, pollutant, id = 1:332){
        
        pollutdata <- numeric()
        
        for(i in id){
                
                # create filepath
                monitorname <- formatC(i, flag = 0, width = 3)
                filepath <- paste0(directory, "/", monitorname, ".csv")

                # load into dataframe object
                dframe <- read.csv(filepath)

                pollutdata <- c(pollutdata, dframe[[pollutant]])
        }
        round(mean(pollutdata, na.rm = TRUE), digits = 3)
}


################### Part 2 ##################