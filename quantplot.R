######################################################################
# VectrunRsnippets
#  
# quantplot.R: create cumulative frequency diagrams with a
# percentile-scaled x-axis
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


quantplot<-function (x,title="Cumulative probability plot", percentile=0.9,
	verbose=FALSE,pch=1, log=FALSE,rug=FALSE,line=FALSE,col=1, 
	xlab="Percentile", ylab="Value",plotmad=FALSE,ylim=NA,
	cex=1) {
	# creates qqnorm probability plot but with percentiles along x-axis. A
	# line can be added add given percentile, if percentile is 0, no line
	# is added.
	# Since function is often used from automatic scripts it tries really
	# hard not to fail with a error.

	# options:
	# x: vector with data to plot
	# title: title of plot
	# percentile: show line in plot at this percentile, if 0 no line
	# is depicted
	# verbose: be verbose?
	# pch: pch to use in plot
	# log: should data be log transformed? (doesn't work well if
	# percentile >0)
	# rug: show rug in plot?
	# line: show line depicting the normal distribution?
	# col: color of points
	# xlab: label x-axis
	# ylab: label y-axis
	# plotmad: should the MAD (see ?mad) be indicated by lines?
	# ylim: limits of y-axis, NA if autmatic limits should be used
	# (see ?range)
	# cex: cex value of plot

	# log scaled y-axis?
	if (log) {
		logy="y"
	}else{
		logy="";
	}

	# check for NA values, report if verbose
	if (any(is.na(x))&&verbose) {
		cat ("Warning: NA values found\n");
	}
	
	# remove NA values
    x<-na.omit(x);

	# if no values in x, create plot but don't show points (i.e you
	# get a empty placeholde plot)
    if (length(x)<=1) {
          cat ("Warning: X zero length\n");
          x<-rnorm(100);
          type="n";
    } else {
          type="p";
    }



	# get limit y-axis
    if (any(is.na(ylim))) {
            ylim<-range(x,na.rm=TRUE);
    }


	# convert x into quantile values, convert y to associated values
	
    n<-length(x);
    x1<-qnorm(ppoints(length(x)));
    y1<-quantile(x,probs=ppoints(x),na.rm=T);
	y1 <- sort(x)

	# create x-axis labels
    xseq<-c(0.01,0.1,0.5,0.90,0.99);
    xperc<-qnorm(xseq);
    xplab<-as.character(xseq*100);

	# plot points
    plot(x1,y1,xlab=xlab,ylab=ylab,axes=F,log=logy,pch=pch,col=col,
	    main=title,ylim=ylim,cex=cex,type=type,xlim=range(xperc));

	# plot line depicting normal distribution
    if (line) {
	lines(lowess(qnorm(seq(0.01,0.99,0.01)),
		    qnorm(seq(0.01,0.99,0.01),mean=mean(x),
			sd=sd(x)),f=3/4),col=8);
    }

	#plot axes
    axis(1,at=xperc,labels=xplab,cex.axis=1.0);
    axis(2);

	# plot rug
	if (rug) {
		rug(x1);
		rug(y1,side=2);
	}

	# plot upper and lower range of 2*mad and median
	if (plotmad) {
		xmad<-c(median(x,na.rm=TRUE)-2*mad(x,na.rm=TRUE),
				median(x,na.rm=TRUE)+2*mad(x,na.rm=TRUE));
		print(xmad);
		abline(h=xmad[1],lty="dotted");
		abline(h=xmad[2],lty="dotted");
		abline(h=median(x,na.rm=TRUE));
	}

	# plot lines depicting value at certain percentile
	if (!percentile==0) {
		py<-as.numeric(quantile(x,probs=c(percentile),na.rm=T));
		if (verbose) {
			cat("Value of ", 100*percentile," percentile: ",py,"\n");
		}
		px<-qnorm(percentile);

		if(log) {
			lines(c(px,px),c(0.00000000000000000001,py),lty=2) #y[1] ~ 0
		}else{
			lines(c(px,px),c(-9999,py),lty=2) 
		}
		lines(c(-9999,px),c(py,py),lty=2);
	}

	#exit quantplot, return percentile value invisibly (if applicable)
	if (!percentile==0) {
		invisible(py);
	} else {
		invisible()
	}
}

quantpoints<-function(x,pch=1,col=1,line=FALSE,cex=1){
#plots extra series of point into quantplot figure
    x<-na.omit(x);

    if (length(x)<=1) {
	cat ("Warning: X zero length\n");
	x<-rnorm(100);
	type="n";
    } else {
	type="p";
    }


    points(qnorm(ppoints(length(x))),quantile(x,probs=ppoints(x),na.rm=T),
	    col=col,pch=pch,cex=cex,type=type); 
    if(line){
	qqline(x,col=col);
    }
}


