source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

# write a group INTO the hdf5 file
A = matrix(1:10, nr = 5, nc =2)
A
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1, 2.0, by=0.1), dim = c(5,2,2))
B
attr(B, "scale") <- "liter"
B
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")


# writing a data frame into hdf5 file
df <- data.frame(1L:5L, seq(0,1,length.out = 5), c("abc", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
df
h5write(df, "example.h5", "df")
h5ls("example.h5")

h5write(c(12, 13, 14), "example.h5", "foo/A", index = list(1:3, 1))
h5read("example.h5", "foo/A")
h5read("example.h5", "foo/foobaa")
h5read("example.h5", "df")
H5close()
