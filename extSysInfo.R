######################################################################
# VectrunRsnippets
#  
# extSysInfo.R: prints summary of system/session info
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

function <- extSysInfo() {

	# convenience function.
	# extended system info, based on Sys.Info and sessionInfo

	cat("date:",date(),"\n") 
	print(sessionInfo(),locale=FALSE)
	systeminfo<-Sys.info()
	cat("\nmachine:",systeminfo[["machine"]],
		systeminfo[["version"]],"\n")
	cat("user:",systeminfo[["user"]],"@",
		systeminfo[["nodename"]],"\n")
}

