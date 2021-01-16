## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(eltr)

raw_elt <-example_elt


## -----------------------------------------------------------------------------
elt <- create_elt(raw_elt, ann_rate="rate", mu="mean", sdev_i = "sdevi" , sdev_c = "sdevc", expval = "exp")

elt

## -----------------------------------------------------------------------------
ylt <- create_ylt(elt, sims=10 ,ann_rate = "rate" , event_id = "id", expval = "exp" , mu ="mean")

ylt

## -----------------------------------------------------------------------------

# Layer 500 xs 50

ylt[ , layer1_loss := layer_loss(Loss, Excess = 50 , Limit = 500  ) ] 

ylt

## -----------------------------------------------------------------------------


ann <-ylt[, lapply( .SD , sum), by=Year, .SDcols = c("Loss","layer1_loss") ] 

ann

expected_loss <- ann[ , lapply(.SD, mean) , .SDcols = c("Loss","layer1_loss")      ]

expected_loss



## -----------------------------------------------------------------------------

ep <-create_oep_curve(ann , y= "Year", z="Loss")
ep


