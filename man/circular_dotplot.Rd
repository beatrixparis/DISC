% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/circular_dotplot.R
\name{circular_dotplot}
\alias{circular_dotplot}
\title{Circular dotplot}
\usage{
circular_dotplot(x, bin = 5, ...)
}
\arguments{
\item{x}{vector of angles, assumed to be bearings (in degrees, from North). A simple numeric vector is supplied, it is assumed to follow the conventions of bearings. When a vector of class "\code{circular}" is supplied, it is converted to bearings}

\item{bin}{bin width in degrees}

\item{...}{passed to \code{\link[ggplot2]{geom_point}}}
}
\description{
Circular dotplot
}
\examples{
circular_dotplot(rnorm(100, 0, 20))
library("circular")
circular_dotplot(rvonmises(100, 0, 10))
circular_dotplot(rvonmises(100, pi/2, 10))
}
\seealso{
\code{\link{as.bearing}} for the conversion in bearings
}

