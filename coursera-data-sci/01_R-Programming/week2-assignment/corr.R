corr <- function(directory, threshold = 0){
        
        correlations <- numeric()
        
        #list.files(dirpath, pattern = "*.csv")
        
        #  create a dataframe of file id and number of complete cases in each file
        #  use the complete() function created in previous exercise
        compnobs.df <- complete(directory)
        
        # verify the nobs with the threshold and create a "good" data frame
        good.df <- compnobs.df[compnobs.df$nobs > threshold, ]
        
        # derive a vector of good ids
        good.ids <- good.df$id
        
        # loop through the good ids vector and read the corresponding file
        dirpath <- paste0(getwd(), "/", directory, "/")
        
        for(i in good.ids) {
                
                # construct the file name and read file into data frame
                temp.df <- read.csv(paste0(dirpath, formatC(i, width = 3, flag = 0), ".csv"))    
                
                # derive complete case data frame
                compcase.df <- temp.df[complete.cases(temp.df), ]
                
                # derive sulfates and nitrates vectors from complete case observations
                sulf.vector <- compcase.df$sulfate
                nitr.vector <- compcase.df$nitrate
                
                # calculate correlations and create a vector
                correlations <- c(correlations, cor(sulf.vector, nitr.vector))
        }
                
        correlations
        
}
