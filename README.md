VectrunRsnippets
================


This is a personal collection of miscelanous R functions. Each
set of functions is fully functional and provided with
examples and some with RUnit tests.

These functions make my life with R a little easier. They work for me
and it's great if the also work for you. If not, too bad. You got
the code so enjoy hacking them to your own needs.

There is no manual. The source is well (*cough*) documented.

WEBSITE
=======

Project website: http://vectrun.github.com/VectrunRsnippets
GitHub source repository: https://github.com/vectrun/VectrunRsnippets

LICENCE and COPYRIGHT
=====================

Copyright (C) 2012 Vectrun (vectrun at gmail dot com)

VectrunRsnippets is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

VectrunRsnippets is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with VectrunRsnippets.  If not, 
see <http://www.gnu.org/licenses/>.


See licence.txt for full licence.


CONTACT Developper
==================

You can contact me, or open an issue, on GitHub.com. If you prefer
e-mail (I don't) write to vectrun at gmail dot com.

FUNCTIONS
=========

This collection contains the following functions:

You can find axamples of how to use these functions in the examples
directory. The filenames of the examples are the same as the filenames
in the collection but with the prefix ex_.

1. log.R

These are functions to log messages to a log file. The function uses
a log object to store and buffer the messages. After a maximum number
of lines are written to the buffer, or when the log is closed, the
lines are written to a log file (a csv file). Each log line contains
an time stamp, a loglevel (can be anything, user defined) and the PID
of the proces.

2. longtable.R

THis is a smal function which (rather inefficient) converts an
'horizontal' table (rows are cases, columns are variables) in to a
'vertical' notation (one row for each value/variable)

3. options.R

This is a function which makes it possible to use a configuration file
with option/values combinations. The options from the configuration
files are stored with options() and can be retrieved using
getOption()

4. pdfversions.R

These are functions to make it easier to put a version number into the
filename of a pdf. Handy when you are developping a model or dataset
and want to share the resulting graphs. When pushing many version of
these graphs to collegues, it is possible to relate to a certain
version number.

5.  quantplot.R

This is a routine to pretty print cumulative frequency diagrams, using
a normal distribution with a percentile axis on the x-axis.

6.  rmoutlier.R

This functions trims a data sets by removing ouliers. It's using
Tukey's (simple) method to identify an outlier and then sets it's 
value at NA.

7. setpaperwidth.R

Convience function. Returns A4 paper size, which can then be used with
the height/width options for a ps/pdf device.
