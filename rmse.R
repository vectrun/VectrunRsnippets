
######################################################################
# VectrunRsnippets
#  
# rmse: calculate Root Mean Square Error, with or without outliers
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

rmse<-function(predicted, observed,removeOutlier=TRUE,factor=1.5) {
	# this function calculates the RMSE between predicted and observed
	# values. The RMSE is sensitive towards outliers, so this function
	# can remove outlier using the rmoutlier function from the script 
	# rmoutlier.R
	# options:
	# predicted: vector with predicted values (numeric)
	# observed: vector with observed values (numeric, same lenght as
	# predicited)
	# removeOutlier: if TRUE, remove outliers from observed values
	# factor: factor to use for rmoutlier (see rmoutlier.R)

	# check
	if (length(predicted)!=length(observed)) {
		stop("rmse: different length in observed and
			 predicted data\n\n");
	}

	# create data.frame to pair observations and predictions
	d <- data.frame(o=observed,p=predicted)
	if(removeOutlier) {
		# outliers are removed using
		# rmoutlier function
		d$o <- rmoutlier(d$o,factor,na.rm=TRUE)
		d <- na.omit(d)
	}

	# do calculations
	N<-nrow(d);
	SS<-sum(((d$o-d$p)^2));
	MSE<-SS/N;
	RMSE<-sqrt(MSE);
	return(RMSE);
}


