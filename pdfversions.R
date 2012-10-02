######################################################################
# VectrunRsnippets
#  
# pdfversions.R: convience functions to add version number on pdf file
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


psversion <- function(version) {
	# sets the option 'psversion' with a version number
	# options:
	# version: version number (numeric)

	if(!is.numeric(version)&&length(version)==1) {
		stop("invalid version")
	}

	options("psversion"=version)
}

psopen <- function(name,type="pdf") {
	# opens a pdf or eps device/filename
	# options:
	# name: a filename (excluding extension)
	# type: either pdf or eps

	# TODO: add options for page size, add code for eps 
	
	if(!is.character(name)) {
		stop("name is not character")
	}

	# get version
	psver <- getOption("psversion")
	if(is.null(psver)) {
		psversion(1)
		psver <- getOptions("psversion")
	}

	# test type, pdf or eps

	if(type=="pdf") {
		filename=paste(name,".",psver,".pdf",sep='')
		pdf(filename)
	}
}

psclose <- function() {
	# closes al graphics devices
	graphics.off()
}

