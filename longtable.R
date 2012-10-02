######################################################################
# VectrunRsnippets
#
# longtable.R: transform 'horizontal' data.frame() into 'vertical'
# data.frame()
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



longtable<-function(d,colstart) {
	# this function converts a 'horizontal/wide' (many measurements on
	# each row) table into a 'vertical/long' (one and only one 
	# measurement on a row) table.
	# I use this with chemical measurements, that's why the columns in
	# the longtable are named comp (chemical component) and conc
	# (concentration)
	#
	#options:
	# d: data.frame to convert
	# colstart: from which column should the table be converted 

	r<-ncol(d);
	for (i in colstart:r) {
		o<-data.frame(d[1:colstart-1]);
		o<-cbind(o,comp=names(d)[i]);
		o<-cbind(o,conc=d[,i]);

		if (!exists("o2")) {
			o2<-o;
		}else{
			o2<-rbind(o2,o);
		}

	}
	return(o2);
}


