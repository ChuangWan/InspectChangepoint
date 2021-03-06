\name{inspect}
\alias{inspect}
\alias{plot.inspect}
\alias{summary.inspect}
\alias{print.inspect}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Informative sparse projection for estimation of changepoints (inspect)
}
\description{
This is the main function of the package InspectChangepoint. The function \code{inspect} estimates the locations of multiple changepoints in the mean structure of a multivariate time series. Multiple changepoints are estimated using a (wild) binary segmentation scheme, whereas each segmentation step uses the \code{\link{locate.change}} function. 
}
\usage{
inspect(x, lambda, threshold, schatten = c(1, 2), M)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
The input data matrix of a high-dimensional time series, with each
component time series stored as a row. 
}
  \item{lambda}{
Regularisation parameter used in \code{\link{locate.change}}.  If no value is
supplied, the dafault value is chosen to be log(log(n)*p/2), where p and
n are the number of rows and columns of the data matrix x respectively.
}
  \item{threshold}{
Threshold level for testing whether an identified changepoint is a true
changepoint. If no value is supplied, the threshold level is computed
via Monte Carlo simulation of 100 repetitions from the null model. 
}
  \item{schatten}{
The Schatten norm constraint to use in the \code{\link{locate.change}} function. Default is schatten = 2, i.e. a Frobenius norm constraint.
}
  \item{M}{
The Monte Carlo parameter used for wild binary segmentation. Default is M = 0, which means a classical binary segmentation scheme is used. 
}
}
\details{
The input time series is first standardised using the
\code{\link{rescale.variance}} function. Recursive calls of the
\code{\link{locate.change}} function then segments the multivariate time series
using (wild) binary segmentation. A changepoint at time z is defined
here to mean that the time series has constant mean structure for time
up to and including z and constant mean structure for time from z+1 onwards.

More details about model assumption and theoretical guarantees can be found in Wang and Samworth (2016). Note that Monte Carlo computation of the threshold value can be slow, especially for large p. If \code{inspect} is to be used multiple times with the same (or similar) data matrix size, it is better to precompute the threshold level via Monte Carlo simulation by calling the \code{\link{compute.threshold}} function.
}
\value{
The return value is an S3 object of class 'inspect'.
  \item{x }{The input data matrix}
  \item{changepoints }{A matrix with three columns. The first column
    contains the locations of estimated changepoints sorted in increasing order; the second column contains the maximum CUSUM statistics of the projected univariate time series associated with each estimated changepoint; the third column contains the depth of binary segmentation for each detected changepoint.}
}
\references{
Wang, T. and Samworth, R. J. (2016) High-dimensional changepoint estimation via sparse projection. Arxiv preprint: arxiv1606.06246.
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{
n <- 500; p <- 100; ks <- 30; zs <- c(125,250,375); varthetas <- c(0.1,0.15,0.2); overlap <- 0.5
obj <- multi.change(n, p, ks, zs, varthetas, overlap)
x <- obj$x
threshold <- compute.threshold(n,p)
ret <- inspect(x, threshold = threshold)
ret
summary(ret)
plot(ret)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~ts }% use one of  RShowDoc("KEYWORDS")
