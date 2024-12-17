## Sedol data

### Extract

Run from repo root.  

-   Extract

``` bash
Rscript ./computations/R/extract_sedol.r sedol.xlsm
```

-   Transform

``` bash
Rscript ./computations/R/scripts/transform_sedol.r sedol-raw
```
