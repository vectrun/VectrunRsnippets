######################################################################
# VectrunRsnippets
#  
# example file for lsObjects.R
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

source("../lsObjects.R")

# first create some large objects

x <- rnorm(1000)
y <- c(rnorm(1000),x)
z <- c(rnorm(1000),y)
a <- list(x,y)
b <- list(x,y,z)
c <- list(a,b)

# please not that in these examples the 'print' statement is used. In
# and interactive session these print statements can be omitted

# use the short lsos function to quickly print list of objects and
# objects sizes
print(lsos())

# get smallest objects first
print(.ls.objects(order.by="Size",decreasing=FALSE))

# only get objects which contain 'x' in their name
print(.ls.objects(pattern="x"))





