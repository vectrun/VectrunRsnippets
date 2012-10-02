######################################################################
# VectrunRsnippets
#
# example how to use functions in log.R
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


# first create log
createLog()
# now fil log with 100 lines, containing 'test 1-100'. after each 10
# lines the log is written to file

# show that it worked
print(Rlog$log)

for (i in 1:100) {
	writeLog(paste("test",i),maxrows=10)
	#Sys.sleep(1)
}

writeLog("last line")
# close log, write logfile, empty logobject

closeLog()

