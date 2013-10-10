
######################################################################
# VectrunRsnippets
#  
# rmoutlier: removes outliers according to Tukey's principle
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



rmoutlier<-function (x,factor=1.5,na.rm=FALSE) {
# Use Tukey's method for marking outliers as NA, which are values larger or
# smaller than 1.5 (factor) the inter quantile range plus or minus 
# quantile 2 or 4. NA values are not removed by default and will
# result in a error.
    nna <- is.na(x);
    if (any(nna)&&!na.rm) {
	stop("NA's found but na.rm=FALSE");
    }
    stats <- stats::fivenum(x, na.rm = na.rm);
    iqr <- diff(stats[c(2, 4)]);
    if (factor <= 0) {
	stop("'factor' must not be <= 0");
    }else {
	out <- x < (stats[2] - factor * iqr) |
	    x > (stats[4] +  factor * iqr);
	if (any(out[nna],na.rm=TRUE)){
	    stats[c(1, 5)] <- range(x[!out], na.rm = TRUE);
	}
	x[out]<-NA;
    }
    return(x);
}

rmoutlierdf<-function(data,factor=1.5,na.rm=FALSE, verbose=F) {
#removes outliers from each column in a data.frame
    if (verbose) { cat("Removing outliers \n")}
    for (i in 1:ncol(data)) {
	if (verbose) {cat (".")}
	if (is.numeric(data[,i])){
	    data[,i]<-rmoutlier(x=data[,i],factor=factor,na.rm=na.rm);
	}
    }
    if (verbose) { cat("\nDone!\n")}
    return(data);

}

