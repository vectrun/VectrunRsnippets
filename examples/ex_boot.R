######################################################################
# VectrunRsnippets
#
# example for boot.R
#  
# http://vectrun.github.com/VectrunRsnippets
#
######################################################################
# 
# This file is part of vectrunRSnippets.

# VectrunRsnippets are free software: you can redistribute it 
# and/or modify it under the terms of the GNU General Public 
# License as published by the Free Software Foundation, either 
# version 3 of the License, or (at your option) any later version.

# VectrunRsnippets is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with VectrunRsnippets.  If not, 
# see <http://www.gnu.org/licenses/>.

# 
# See licence.txt for full GPL v3 licence.
# 
# Copyright (C) 2012 Vectrun (vectrun at gmail dot com)
#
######################################################################
#
# No need for RTFM. Use the source, Luke!
#


######################################################################
# init
######################################################################

library(boot)
library(MASS)

source("../rmse.R")
source("../rmoutlier.R")
source("../boot.R")

######################################################################
# bootstrap functions

# model function, ordinary linear regression
m.fit <- function(f,d) {
	m <- lm(f,data=d)
	return(m)
}

# model function, robust linear regression
m.fit.rlm <- function(f,d) {
	m <- rlm(f,data=d)
	return(m)
}
# bootstrap
m.fit.boot <- function(d,i=NA,form=NA,algo="lm") {
	if(!any(is.na(i))) {
		d <- d[i,]
	} else {
		warning("no index")
	}
	if(algo=="rlm") {
		fit <- m.fit.rlm(f=form,d)
	} else {
		fit <- m.fit(f=form,d)
	}
	fit.predict <- predict(fit,d)
	res.name <- names(fit$model[1])

	fit.rmse <- rmse(d[[res.name]],fit.predict)

	stat <- c(coef(fit),fit.rmse)
	return(stat)
}

######################################################################
# start
######################################################################

################################
# create test dataset
n <- 1000 # population size
sample.size <- 25 # sample size

# calculate exact response
pop <- 1:n
res.exact <- pop*0.2+3

# add error
res.error <- rnorm(length(pop),sd=10)
res <- res.exact+res.error

# add outlier 30%
samp <- sample(1:n,size=n*0.3)
res.outlier <- rnorm(length(samp),sd=30)
res[samp] <- res[samp]+res.outlier

# create data.frame
d.res <- data.frame(pop=pop,res=res)

################################
# sample data set
samp <- sample(1:1000,size=sample.size)
d.sample <- d.res[samp,]

################################
# bootstrapping

# lm model
bs <- boot(data=d.sample,statistic=m.fit.boot,form=m.f,R=1000)
bs.ci <- boot.summary(bs,index.names=c("interc.","slope","rmse"))

# rlm model
bs2 <- boot(data=d.sample,statistic=m.fit.boot,form=m.f,algo="rlm",R=1000)
bs2.ci <- boot.summary(bs2,index.names=c("interc.","slope","rmse"))

# compare results:
print(bs.ci)
print(bs2.ci)





