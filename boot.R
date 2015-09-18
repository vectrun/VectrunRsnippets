######################################################################
# VectrunRsnippets
#  
# boot: helper functions for bootstrapping
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


boot.summary <- function(bs,index.names=NA) {
    # this function returns a data.frame with summary statistics of
    # bootstrap object. Current statistics are mean, sd, and 95% conf.
    # intervals
    # bs: bootstrap object
    # index.names: variable names for indices in bootstrapobject, if
    # none given, names like V1, V2 etc. are used. indices with only
    # NA values are dropped

    d <- as.data.frame(bs$t)
    o <- bs$t0
    if(any(is.na(index.names))) {
	index.names <- paste("V",rep(1:ncol(d)),sep='')
    }
    res <- data.frame(statistic=index.names,original=o,
		      mean=sapply(d,FUN=mean,na.rm=TRUE),
		      sd=sapply(d,FUN=sd,na.rm=TRUE))
    # data.frame for storing result:
    res.ci <- data.frame()
    # vector to store variables
    valid.names <- c()
    for(i in 1:ncol(d)) {
	if(all(is.na(d[,i]))) {
	    # only NA values, drop variable
	    next
	}
	ci <- boot.ci(bs,index=i,type="norm")
	res.tmp <- data.frame( ci.lwr=ci$normal[2],
			      ci.upr=ci$normal[3])
	res.ci <- rbind(res.ci,res.tmp)
	# add variable
	valid.names <- append(valid.names,i)
    }
    res <- res[valid.names,]
    res <- cbind(res,res.ci)
    row.names(res) <- index.names[valid.names]
    return(res)
}







