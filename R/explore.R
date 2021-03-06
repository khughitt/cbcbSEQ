#' Compute singular value decomposition
#'
#' @param x matrix of genes by sample (ie. the usual data matrix)
#' @return returns a list of svd components v and d
#' @export
makeSVD <- function(x){
  x <- as.matrix(x)
  s <- fast.svd(x-rowMeans(x))
  
  v <- s$v
  rownames(v) <- colnames(x)
  
  s <- list(v=v, d=s$d)
  return(s)
}


#' Compute variance of each principal component and how they correlate with batch and cond  
#'
#' @param v from makeSVD
#' @param d from makeSVD
#' @param condition factor describing experiment
#' @param batch factor describing batch
#' @return A dataframe containig variance, cum. variance, cond.R-sqrd, batch.R-sqrd
#' @export
pcRes <- function(v, d, condition=NULL, batch=NULL){
  pcVar <- round((d^2)/sum(d^2)*100,2)
  cumPcVar <- cumsum(pcVar) 
  
  if(!is.null(condition)){
    cond.R2 <- function(y) round(summary(lm(y~condition))$r.squared*100,2)
    cond.R2 <- apply(v, 2, cond.R2) 
  }
 
  if(!is.null(batch)){
    batch.R2 <- function(y) round(summary(lm(y~batch))$r.squared*100,2)
    batch.R2 <- apply(v, 2, batch.R2)
  }
  
  if(is.null(condition) & is.null(batch)){
     res <- data.frame(propVar=pcVar, 
                      cumPropVar=cumPcVar)
  }

  if(!is.null(batch) & is.null(condition)){
    res <- data.frame(propVar=pcVar, 
                      cumPropVar=cumPcVar, 
                      batch.R2=batch.R2)
  }
    
  if(!is.null(condition) & is.null(batch)){
    res <- data.frame(propVar=pcVar, 
                      cumPropVar=cumPcVar, 
                      cond.R2=cond.R2)
  }
    
  if(!is.null(condition) & !is.null(batch)){
    res <- data.frame(propVar=pcVar, 
                      cumPropVar=cumPcVar, 
                      cond.R2=cond.R2,
                      batch.R2=batch.R2)
  }
  
  return(res)
}

#' Plot first 2 principal components
#'
#' @param v from makeSVD
#' @param d from makeSVD
#' @param ... pass options to internal plot fct.
#' @return a plot 
#' @export
plotPC <- function(v, d, ...){
  pcVar <- round((d^2)/sum(d^2)*100,2)
  
  xl <- sprintf("pc 1: %.2f%% variance", pcVar[1])  
  yl <- sprintf("pc 2: %.2f%% variance", pcVar[2]) 
  
  plot(v[,1], v[,2], xlab=xl, ylab=yl, ...)
}
