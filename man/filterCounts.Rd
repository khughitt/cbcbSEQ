\name{filterCounts}
\alias{filterCounts}
\title{Filter low expression genes, using independent filtering
recommended in Nature Protocols paper}
\usage{
  filterCounts(counts, lib.size = NULL, thresh = 1,
    minSamples = 2)
}
\arguments{
  \item{counts}{Count matrix}

  \item{lib.size}{library sizes, if missing or sum uses the
  total counts per samples}

  \item{thresh}{Minimum counts per million to determine
  expression}

  \item{minSamples}{Minimum number of samples where gene is
  required to be expressed. This should be set to the numer
  of samples in the smallest group of interest.}
}
\value{
  Filtered count matrix
}
\description{
  Filter low expression genes, using independent filtering
  recommended in Nature Protocols paper
}

