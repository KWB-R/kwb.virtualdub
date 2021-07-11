[![R-CMD-check](https://github.com/KWB-R/kwb.virtualdub/workflows/R-CMD-check/badge.svg)](https://github.com/KWB-R/kwb.virtualdub/actions?query=workflow%3AR-CMD-check)
[![pkgdown](https://github.com/KWB-R/kwb.virtualdub/workflows/pkgdown/badge.svg)](https://github.com/KWB-R/kwb.virtualdub/actions?query=workflow%3Apkgdown)
[![codecov](https://codecov.io/github/KWB-R/kwb.virtualdub/branch/main/graphs/badge.svg)](https://codecov.io/github/KWB-R/kwb.virtualdub)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/kwb.virtualdub)]()

# kwb.virtualdub

Interface to free video processing software VirtualDub (https://virtualdub.org/).

## Installation

For details on how to install KWB-R packages checkout our [installation tutorial](https://kwb-r.github.io/kwb.pkgbuild/articles/install.html).

```r
### Optionally: specify GitHub Personal Access Token (GITHUB_PAT)
### See here why this might be important for you:
### https://kwb-r.github.io/kwb.pkgbuild/articles/install.html#set-your-github_pat

# Sys.setenv(GITHUB_PAT = "mysecret_access_token")

# Install package "remotes" from CRAN
if (! require("remotes")) {
  install.packages("remotes", repos = "https://cloud.r-project.org")
}

# Install KWB package 'kwb.virtualdub' from GitHub
remotes::install_github("KWB-R/kwb.virtualdub")
```

## Documentation

Release: [https://kwb-r.github.io/kwb.virtualdub](https://kwb-r.github.io/kwb.virtualdub)

Development: [https://kwb-r.github.io/kwb.virtualdub/dev](https://kwb-r.github.io/kwb.virtualdub/dev)
