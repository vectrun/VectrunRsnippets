######################################################################
# VectrunRsnippets
# 
# log.R: write messages to a logfile
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



now <- function() {
	# returns date string with current date/time

	return(as.character(date()))
}

createLog <- function(logobjname="RLog",filename="R.log") {
	# creates log object in .Globalenv and removes current logfile
	# (filename)
	# options:
	# logobjname: name of global log object.
	# filename: file name of log file

	logdf <- data.frame(time=now(),msg="Log created",level="info",
					   pid=Sys.getpid())
	RLog <- list(log=logdf,logfile=filename)
	try(unlink(filename))

	assign(logobjname,RLog,envir=.GlobalEnv)
}

writeLog <- function(msg,level="info",logobjname="RLog",maxrows=500) {
	# writes a string (msg) into the logobject. If the rows of the
	# logobject exceeds maxrows, then the lines are written to the
	# logfile (i.e. buffered output)
	# options:
	# msg: message, a string
	# level: loglevel, string, user defined
	# logobjname: name of global log object
	# maxrows: maximum rows in logobje before they are written to file

	RLog <- get(logobjname,envir=.GlobalEnv)
	RLog$log <- rbind(RLog$log,data.frame( time=now(),
										  msg=msg,level=level,
										  pid=Sys.getpid()))

	if (nrow(RLog$log)>=maxrows) {
		suppressWarnings(write.table(RLog$log,file=RLog$logfile,
								   append=TRUE,row.names=FALSE,
								   col.names=FALSE))
		RLog$log <- data.frame()
	}


	assign(logobjname,RLog,envir=.GlobalEnv)
}

closeLog <- function(logobjname="RLog") {
	# closes the log, writes remeining lines to logfile and then
	# empties the logobject
	# options:
	# logobjname: name of global logobject
	RLog <- get(logobjname,envir=.GlobalEnv)
		suppressWarnings(write.table(RLog$log,file=RLog$logfile,
				  append=TRUE,row.names=FALSE,col.names=FALSE))
		RLog$log <- data.frame()
	assign(logobjname,RLog,envir=.GlobalEnv)
}



