rm(list=ls())
require(dplyr)
require(readxl)
require(AMR)
require(stringr)
require(tibble)
require(plyr)
require(tidyr)
require(reshape2)
require(purrr)
library(cleaner)
library(arsenal)
library(knitr)
library(ggplot2)
library(lubridate)
library(stringi)
library(stringdist)

setwd("~/R/Hospital data")

#duplication function
dedup <-  function(x,window=30){
  x <- x[order(x$SPEC_DATE),]
  x$ord <- 1:nrow(x)
  # create ord data frame with 2 repeated columns for order 
  ord <- tidyr::crossing(x$ord,x$ord) %>% as.data.frame
  names(ord) <- c("order1","order2")
  # creat tmp dataframe with 2 repeated columns for date
  tmp <- tidyr::expand_grid(x[,"SPEC_DATE"],x[,"SPEC_DATE"], .name_repair = "minimal") %>% as.data.frame
  names(tmp) <- c("specdate1","specdate2")
  tmp <- cbind(tmp,ord)
  tmp <- tmp %>% filter(order2 > order1)
  tmp$datediffer <- as.Date(tmp$specdate2,"%Y-%m-%d") - as.Date(tmp$specdate1,"%Y-%m-%d")
  #tmp$datediffer <- tmp$specdate2 - tmp$specdate1
  tmp_filtered <- tmp %>% filter(datediffer > window) 
  
  if(nrow(tmp_filtered)==0) x <- x[1,]
  
  if(nrow(tmp_filtered)>0){
    
    tmp_filtered$ord <- 1:nrow(tmp_filtered)
    tmp1 <- tmp_filtered
    keep <- c(1)
    while (TRUE){
      tmp1 <- tmp1[tmp1$order1 >= tmp_filtered$order2[keep[length(keep)]],]
      if(nrow(tmp1)>0) keep <- c(keep,tmp1$ord[1])
      if(nrow(tmp1)==0) break
      
    } 
    #keep <- keep[!is.na(keep)] 
    x <- x %>% filter(ord %in% unique(c(tmp_filtered$order1[keep], tmp_filtered$order2[keep]) ))
  }
  x <- x %>% select(-ord)
  
}
hello Ha
