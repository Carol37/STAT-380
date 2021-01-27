rm(list = ls())

library(data.table)

dat <- fread("2008.csv")

# dat[i,j,by]
dim(dat)

# filter
newdat <- dat[DepDelay>0]

newdat <- dat[Dest == "YYZ"]
newdat <- dat[Dest == "TPA"]

newdat <- dat[DepDelay > 0 & Dest == 'TPA', length(NASDelay)]

newdat <- dat[DepDelay > 0 & Dest == 'TPA', .N]



library(Metrics)
library(data.table)

# Transform: adding or modifying variables. You can modify a single variable or multiple variables. 
# You can take the ln(var), sum(var1+var2)

new <- dat[,.(expDepDel = exp(DepDelay))]

# SET KEYS FOR BETTER PERFORMANCE, FASTER RUNTIME
system.time(new <- dat[Dest == "TPA"])
str(dat)

setkey(dat, Dest)
dat["TPA"]

setkey(dat, Dest, Origin)
key(dat)
dat["TPA"]
# BOTH KEYS
dat[.("CLE", "ABE")]
# MULTIPLES IN FIRST KEY
dat[.(c("CLE", "ABE"))]


# CAST AND MELT--FUNCTIONS USED TO CREATE AGGREGATE DATA OR TO SWITCH BETWEEN WIDE AND LONG FORMATS
Avg_delay_tab <- dcast(dat, Origin + UniqueCarrier ~ ., mean, na.rm = T, value.var = c("DepDelay", "ArrDelay", "CarrierDelay"))

# WIDE TO LONG
m_Avg_delay_tab <- melt(Avg_delay_tab, id = c("Origin", "UniqueCarrier"))

