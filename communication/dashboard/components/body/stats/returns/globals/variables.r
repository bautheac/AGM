modules::export("caption_returns")
caption_returns <- glue::glue("
This page shows descriptive statistics for the returns dataset. The results are shown 
by reporting frequency starting with the statistics for the firms reporting annually,
followed by those for the firms reporting semi-annually, and finally the statistics 
for all firms combined. For each year the statistics are shown for each reporting 
period. Results for annually reporting firms naturally show only 1 reporting period, 
while those for semi-annually reporting firms show 2 reporting periods.<br>
The '# days available' family of statistics refers to the number of return days and 
non-zero return days available around corporate events. In this context, availability 
is defined as no more that 5 successive missing records.  
")

modules::export("caption_firms")
caption_firms <- glue::glue("
This table shows descriptive statistics for individual firms.
")

modules::export("caption_aggregate")
caption_aggregate <- glue::glue("
This table shows descriptive statistics for goups of firms, namely those reporting 
annually, semi-annually, and all firms combined. The statistics are shown for each 
year and reporting period. The 'n' statistic documents the number of available 
observations for the correpsonding variable-year-reporting period combination.
")