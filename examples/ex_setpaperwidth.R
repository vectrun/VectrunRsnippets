######################################################################
# VectrunRsnippets
#  
# example file for setpaperwidth.R
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

source("../setpaperwidth.R")

# get size
a4 <- setpaperwidth()

# open graphics device with A4 size
pdf("test.pdf",height=a4$height,width=a4$width)
hist(rnorm(100))
dev.off()

# change orientation
a4 <- setpaperwidth(orientation="portrait")

# open graphics device with A4 size, same lines as above
pdf("test2.pdf",height=a4$height,width=a4$width)
hist(rnorm(100))
dev.off()
