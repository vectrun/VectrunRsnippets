######################################################################
# VectrunRsnippets
#
# options.R: read options() from file using option/value pairs
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


setOptions <- function(optiontable) {
	opts <- list()
	for (i in 1:nrow(optiontable)) {
		o <- optiontable$value[i]
		if(!is.na(suppressWarnings(as.numeric(as.character(o))))) {
	        o <- as.numeric(o)
		} else {
			o <- as.character(o)
		}
		opts[[as.character(optiontable$option[i])]]<-o
	}
	options(opts)
}

readOptions <- function(file) {

	if(!file.exists(file)) {
	   msg<-paste("option file",file,"not found")
	   stop(msg)
	}
					
	o <- read.table(file,col.name=c("option","value"))
	setOptions(o)
	invisible(o)
}


