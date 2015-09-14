######################################################################
# VectrunRsnippets
#
# example for rmse.R and rmoutlier.R
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



# load functions
source("../rmse.R")
source("../rmoutlier.R")

# set seed for reprodicible output
set.seed(1234)

#first create 'horzontal' data.frame.

# create test dataset
n <- 30 # population size
sample.size <- 25 # sample size

# calculate exact response
pop <- 1:n
res.exact <- pop*2+3

# add error
res.error <- rnorm(length(pop),sd=1)
res <- res.exact+res.error

# add outlier 30%
samp <- sample(1:n,size=n*0.3)
res.outlier <- rnorm(length(samp),sd=50)
res[samp] <- res[samp]+res.outlier

# create data.frame
d <- data.frame(pop=pop,res=res)
print(summary(d$res))
print(summary(rmoutlier(d$res)))

# ordinary linear model
m <- lm(res~pop,data=d)
m.predict <- predict(m)

m.rmse <- rmse(m.predict,d$res)
print(m.rmse)
m.rmse.o <- rmse(m.predict,d$res,removeOutlier=FALSE)
print(m.rmse.o)


