modules::export("caption_availables")
caption_availables <- glue::glue("
This page shows the same descriptive statistics as those shown in the 'book' and 
'returns' pages re-computed for firms with 'high data availability'. In this 
context, high data availability is defined in four steps. The first involves 
selecting years of interest; these are the ones for which data is available in 
both the book and return datasets, namely, 1912 and 1913. The second step involves 
selecting high data availability book firms: first the variables with are least 
150 observation for the two years of interest are selected; second firms with data 
available for these variables for both years are selected. The third involves 
selecting high data availability returns firms where firms are selected if for 
both years of interest they show at least 15 returns days available before as well 
as after at least one of their recorded corporate event. The fourth step involves 
taking the intersection of the high data availability book and high data availability 
returns firms.  
")

modules::export("caption_names")
caption_names <- glue::glue("
This table shows the high data availability firm names according to the definition 
above.  
")

modules::export("caption_book")
caption_book <- glue::glue("
This table shows the book descriptive statistics for the selection of firms outlined 
above.  
")