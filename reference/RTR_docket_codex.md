# Codex of Research and Test Reactor Docket Numbers

Docket numbers are hard to keep track of so let `nrcadams` keep track of
them for you! This exported tibble provides the project name, and docket
number for a selection of RTRs

## Usage

``` r
RTR_docket_codex
```

## Format

A tibble with columns for project names, docket numbers.

## Value

tibble of docket numbers

## Examples

``` r
nrcadams::docket_codex
#> # A tibble: 33 × 4
#>    Project                         Company                    DocketNumber NLWR 
#>    <chr>                           <chr>                             <dbl> <lgl>
#>  1 MSRR Pre-Application            ACU                            99902088 TRUE 
#>  2 MSRR Part 50                    ACU                             5000610 TRUE 
#>  3 Shine Part 50                   SHINE Medical Technologies      5000608 TRUE 
#>  4 Shine Recycling Pre-Application SHINE Medical Technologies     99902115 TRUE 
#>  5 Xe-100 Pre-Application          X-Energy                       99902071 TRUE 
#>  6 TRISO-X Fab. Part 70            X-Energy                        7007027 TRUE 
#>  7 Long Mott Pre-Application       X-Energy                       99902117 TRUE 
#>  8 Long Mott Part 50               X-Energy                        5000614 TRUE 
#>  9 AP300                           Westinghouse                   99902111 FALSE
#> 10 Natrium Pre-Application         TerraPower                     99902100 TRUE 
#> # ℹ 23 more rows
```
