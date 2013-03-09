######################################################################
# VectrunRsnippets
#
# installFromGitHub.r: install R packages from github
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
######################################################################
#
# This code is taken from functions found in the devtools package by
# Hadley Wickham e.a.
# see: https://github.com/hadley/devtools
# 
######################################################################


# library httr depends on RCURl
library(httr)

githubUrl <- function(repo, username = git.user,
							    ref = "master", subdir = NULL, 
								...) {

	  message("Installing github repo(s) ",
			      paste(repo, ref, sep = "/", collapse = ", "),
				      " from ",
					      paste(username, collapse = ", "))
	  name <- paste(username, "-", repo, sep = "")

	    url <- paste("https://github.com/", username, "/", repo,
					     "/archive/", ref, ".zip", sep = "")
	  message("Using url ",url)
	  
	  return(url)
}

decompress <- function(src, target = tempdir()) {

	if (grepl("\\.zip$", src)) {
		unzip(src, exdir = target)
		outdir <- getdir(as.character(unzip(src, list = TRUE)$Name[1]))

	} else if (grepl("\\.(tar\\.gz|tgz)$", src)) {
		untar(src, exdir = target, compressed = "gzip")
		outdir <- getdir(untar(src, compressed = "gzip", list =
							   TRUE)[1])

	} else if (grepl("\\.(tar\\.bz2|tbz)$", src)) {
		untar(src, exdir = target, compressed = "bzip2")
		outdir <- getdir(untar(src, compressed = "bzip2", list =
							   TRUE)[1])

	} else {
		ext <- gsub("^[^.]*\\.", "", src)
		stop("Don't know how to decompress files with
			 extension ", ext,
		call. = FALSE)
	}

	file.path(target, outdir)
}

# Returns everything before the last slash in a filename
# getdir("path/to/file") returns "path/to"
# getdir("path/to/dir/") returns "path/to/dir"
getdir <- function(path) sub("/[^/]*$", "", path)

installUrl <- function(url, name = NULL, subdir = NULL,
					   ...) {
	if (is.null(name)) {
		name <- basename(url)
	}

	message("Installing ", name, " from ", url)
	bundle <- file.path(tempdir(), name)

	# Download package file
	request <- GET(url)
	stop_for_status(request)
	writeBin(content(request), bundle)
	on.exit(unlink(bundle), add = TRUE)

	unbundle <- decompress(bundle)
	on.exit(unlink(unbundle), add = TRUE)

	pkg_path <- if (is.null(subdir)) unbundle else
		file.path(unbundle, subdir)

	# Check it's an R package
	if (!file.exists(file.path(pkg_path, "DESCRIPTION"))) {
		stop("Does not appear to be an R package", call. =
			 FALSE)
	}

	cmd<-(paste("R CMD INSTALL",pkg_path));
	print(cmd)
	system(cmd)
}

