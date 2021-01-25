Oikos\_Package\_Install
================
Chloe Fouilloux
1/22/2021

Hello\! Welcome to the workshop for Oikos 2021.

If you are already familiar with R, please install the following
packages (see Chunk B) before our workshop (Feb 1st. 10:00 (GMT +2)).

# 

## CHUNK A

# 

Please skip this first chunk of code if you already know how to install
packages in R.

``` r
#A. Do you know your working directory and how to set it? 
#If yes, jump to B. If no, follow the instructions below.

#This is mostly important for first-time R users. If you have already downloaded packages before, this will probably not apply to you.


getwd() #Look at the output here, for the purposes of this workshop, let's set the directory to your Desktop. Copy the output of the working directory. 
```

    ## [1] "/Users/chloefouilloux/Desktop/Oikos"

``` r
#Let's look at an example where the working directory is in a weird place:

# /Users/randomuser/homes/vasylean/My Documents"

#CHANGE ONLY THE LAST "/" TO "/Desktop"

#So, my code here would be the following
#setwd("/Users/randomuser/homes/vasylean/Desktop") #don't forget the quotation marks!

#Now set your directory!
setwd() 
```

    ## Error in setwd(): argument "dir" is missing, with no default

Still can’t set the working directory?

Solutions to working directory problems:

1.  Don’t be afraid to read error codes\! Error codes often want to
    **help** you, not hurt you. Read what the error message says and try
    to understand the instructions. If you do not understand what to do,
    try googling the message for fixes.

2.  Locked directory, 00LOCK

Follow the path (wherever the 00LOCK file can be found) output in the
error message. For example if your message read something like
“home/vasylean/My Documents/Lib/00Lock”:

Go to your documents \> find and open the **Lib** folder \> find and
delete the **00Lock** folder. You should now be able to download
packages.

# 

## CHUNK B

# 

Install necessary packages

``` r
#B. INSTALL NECESSARY PACKAGES
install.packages(c("ggplot2", "ggforce", "dplyr", "ggsignif", "png", "Hmisc"))
```

    ## Error in contrib.url(repos, "source"): trying to use CRAN without setting a mirror

Solutions to package install problems:

1.  PATIENCE\! It may take a couple of minutes to install these
    packages, especially if there is a poor internet connection. Please
    keep an eye out for the RED STOP SIGN (should show up bottom right
    corner of screen), which indicates that the system is
    loading/processing information. Just wait patiently until the stop
    sign is gone ;)

# 

## CHUNK C

# 

Make sure the pacakges have been correctly installed by loading them.

``` r
library(ggplot2)
```

    ## Warning: package 'ggplot2' was built under R version 3.6.2

``` r
library(ggforce)
```

    ## Warning: package 'ggforce' was built under R version 3.6.2

``` r
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.6.2

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggsignif)
library(png)
library(Hmisc)
```

    ## Warning: package 'Hmisc' was built under R version 3.6.2

    ## Loading required package: lattice

    ## Loading required package: survival

    ## Warning: package 'survival' was built under R version 3.6.2

    ## Loading required package: Formula

    ## 
    ## Attaching package: 'Hmisc'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     src, summarize

    ## The following objects are masked from 'package:base':
    ## 
    ##     format.pval, units
