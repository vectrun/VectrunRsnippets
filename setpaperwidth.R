######################################################################
# VectrunRsnippets
#  
# setpaperwidth.R: convience function to set ISO/DIN A4 paper with
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


setpaperwidth<-function(orientation="landscape") {
	# returns A4 paper sizes depending on orientation
	#
	# options:
	# orientation: paper orientation, either landscape or portrait

	# calculate wdth in inches
	widtha4<-297/10/2.54; 
	heighta4<-210/10/2.54;

	# get orientation
	if(orientation!="portrait"&&orientation!="landscape") {
		stop("wrong orientation");
	}

	# create list with sizes
	a4<-list();
	if(orientation=="landscape") {
		a4$width<-widtha4;
		a4$height<-heighta4;
	} else {
		a4$width<-heighta4;
		a4$height<-widtha4;
	}
	a4$orientation<-orientation

	# return list with width, height, and orientation
	return (a4)
}

