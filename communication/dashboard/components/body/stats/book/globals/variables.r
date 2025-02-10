modules::export("caption_book")
caption_book <- glue::glue("
This page shows descriptive statistics for the book dataset. The results are shown 
by reporting frequency starting with the stattistics for the firms reporting annually,
followed by those for the firms reporting semi-annually, and finally the statistics 
for all firms combined. For each year the statistics are shown for each reporting 
period. Results for annually reporting firms naturally show only 1 reporting period, 
while those for semi-annually reporting firms show 2 reporting periods. The 'n' 
statistic documents the number of available observations for the correpsonding 
variable-year-reporting period combination.
")