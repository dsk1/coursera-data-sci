# Write a function that takes a directory of data files and a threshold for complete cases 
# and calculates the correlation between sulfate and nitrate for monitor locations 
# where the number of completely observed cases (on all variables) is greater than the threshold. 
# The function should return a vector of correlations for the monitors that meet 
# the threshold requirement. 
# If no monitors meet the threshold requirement, then the function should return a numeric vector 
# of length 0. 
# A prototype of this function follows
#
# corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
# }

corr <- function(directory, threshold = 0){
        
        correlations <- numeric()
        
        # construct the directory path
        directorypath <- paste0(getwd(), "/", directory, "/")
        
        # create a list of csv filenames
        fileslist <- list.files(directorypath, pattern = "*.csv")
        
        # loop through the list of files
        for(i in length(fileslist)){
                
                # read file into a data frame
                tempdframe <- read.csv(paste0(directorypath, fileslist[i])) 
                
                # derive a dataframe of complete case observations
                cmpdframe <- tempdframe[complete.cases(tempdframe), ] 
                
                # calculate total number of complete case observations
                cmpobs <- sum(complete.cases(tempdframe)) 
                
                # if the number of complete observations meet threshold
                # then compute correlation
                if(cmpobs > threshold){
                        
                        # create sulfate and nitrate vectors from the complete case observations data frame
                        sulfatevector <- cmpdframe$sulfate
                        nitratevector <- cmpdframe$nitrate
                        
                        # create a vector of correlations
                        correlations <- c(correlations, cor(sulfatevector, nitratevector))
                }

        }
        # return the correlations vector
        correlations
}
