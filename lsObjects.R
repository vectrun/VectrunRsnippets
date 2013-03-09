######################################################################
# VectrunRsnippets
#  
# lsObjects.R: gives list of largest objects in memory
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
# this code is blatantly stolen from Dirk Eddelbuettel's stackoverflow
# post (and assuming it is public domain): 
# http://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session



# improved list of objects
.ls.objects <- function (pos = 1, pattern, order.by,
						 decreasing=TRUE,
						 head=FALSE, n=5) {
	# this functions lists objects in memory in order of decreasing
	# memory size.
	#
	# options:
	# pos: which environment to use for listing, see 'pos' option of
	# ls()
	# pattern: only list objects containing this pattern (character)
	# order.by: order by which field.
	# decreasing: use decreasing order
	# head: use head() for printing 
	# n: how many lines should be printed
	# 

	napply <- function(names, fn) sapply(names, function(x) fn(get(x, pos
																   = pos)))
	names <- ls(pos = pos, pattern = pattern)
	obj.class <- napply(names, function(x)
						as.character(class(x))[1])
	obj.mode <- napply(names, mode)
	obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
	obj.prettysize <- napply(names, function(x) {
							 capture.output(print(object.size(x), units = "auto")) })
	obj.size <- napply(names, object.size)
	obj.dim <- t(napply(names, function(x)
						as.numeric(dim(x))[1:2]))
	vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
	obj.dim[vec, 1] <- napply(names, length)[vec]
	out <- data.frame(obj.type, obj.size,
					  obj.prettysize, obj.dim)
	names(out) <- c("Type", "Size", "PrettySize",
					"Rows", "Columns")
	if (!missing(order.by))
		out <- out[order(out[[order.by]],
						 decreasing=decreasing), ]
	if (head)
		out <- head(out, n) 

	out
}

# shorthand
lsos <- function(..., n=10) {
	.ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE,
				n=n)
}

