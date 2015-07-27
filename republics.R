# list of republics, and start and end dates from wikipedia at:
# https://en.wikipedia.org/wiki/List_of_republics
repubs <- read.csv("list of republics.csv", row.names=1)

# clean up unknown dates and republics that still exist today
repubs <- repubs[-27,]
del1 <- which(repubs$to == "present")
del2 <- which(repubs$to == "")
repubs <- repubs[-c(del1, del2),]

start <- repubs$from
end <- repubs$to

# get rid of weird spaces next to the values
start <- sub("  ", "", start)
start <- sub(" ", "", start)

end <- sub("  ", "", end)
end <- sub(" ", "", end)

# clean up data by taking out anything that's not a number
# these are the from and to columns, to they will be the same for both start and end meaning it only needs to be done for one of them
del3 <- which(start=="from")
start <- start[-del3]
end <- end[-del3]

# turn into numbers
start <- as.numeric(start)
end <- as.numeric(end)

# calculate length of existence
rep.len <- end-start
# invert sign for BC dates
rep.len[1:4] <- -rep.len[1:4]

# mean length of a republic. the spread is so large that this is meaningless though
# probably should only use the dates that are above 100 years.
mean(rep.len)

# there is a clear divide between 100s of year lengths and a handfull of year lengths.
# extract lengths greater than 100 years.
use <- which(rep.len > 100)
large.len <- rep.len[use]

# from these simple statistics, it appears we still have some time left.
mean(large.len)
median(large.len)
boxplot(large.len)

# Should probably keep all these dates linked to the actual republic.