cd "C:\Users\Bautheac\Dropbox\research\projects\AGM\computations\stata"


use AGMdata.dta, clear
rename A date
rename B day
rename C trading
rename D dataavailable
rename E price
rename F low
rename G high
rename H event

format price %10s
drop J K L I
drop if date==""
drop if date=="date"

merge m:1 Company using "companynames.dta", nogenerate

gen lowcat = "integer" if low!="" & strpos(low, "-") == 0 & strpos(low, "/") == 0
replace lowcat = "fraction" if low!="" & strpos(low, "-") == 0 & strpos(low, "/") != 0
replace lowcat = "intfrac" if low!="" & strpos(low, "-") != 0 & strpos(low, "/") != 0

gen lowformatted = low if lowcat=="integer"
destring lowformatted, replace force

gen lowfracA = substr(low, 1, strpos(low, "/")-1) if strpos(low, "/") != 0 & lowcat=="fraction"
gen lowfracB = substr(low, strpos(low, "/")+1, 1000) if strpos(low, "/") != 0 & lowcat=="fraction"
destring lowfracA lowfracB, replace force
replace lowformatted = lowfracA/lowfracB if lowcat=="fraction"

gen lowhyphA = substr(low, 1, strpos(low, "-")-1) if strpos(low, "-") != 0 & lowcat=="intfrac"
gen lowhyphB = substr(low, strpos(low, "-")+1, 1000) if strpos(low, "-") != 0 & lowcat=="intfrac"

gen lowhyphfracA = substr(lowhyphB, 1, strpos(lowhyphB, "/")-1) if strpos(lowhyphB, "/") != 0 & lowcat=="intfrac"
gen lowhyphfracB = substr(lowhyphB, strpos(lowhyphB, "/")+1, 1000) if strpos(lowhyphB, "/") != 0 & lowcat=="intfrac"
destring lowhyphA lowhyphfracA lowhyphfracB, replace force
replace lowformatted = lowhyphA + lowhyphfracA/lowhyphfracB if lowcat=="intfrac"

drop lowcat lowfracA lowfracB lowhyphA lowhyphB lowhyphfracA lowhyphfracB

gen highcat = "integer" if high!="" & strpos(high, "-") == 0 & strpos(high, "/") == 0
replace highcat = "fraction" if high!="" & strpos(high, "-") == 0 & strpos(high, "/") != 0
replace highcat = "intfrac" if high!="" & strpos(high, "-") != 0 & strpos(high, "/") != 0

gen highformatted = high if highcat=="integer"
destring highformatted, replace force

gen highfracA = substr(high, 1, strpos(high, "/")-1) if strpos(high, "/") != 0 & highcat=="fraction"
gen highfracB = substr(high, strpos(high, "/")+1, 1000) if strpos(high, "/") != 0 & highcat=="fraction"
destring highfracA highfracB, replace force
replace highformatted = highfracA/highfracB if highcat=="fraction"

gen highhyphA = substr(high, 1, strpos(high, "-")-1) if strpos(high, "-") != 0 & highcat=="intfrac"
gen highhyphB = substr(high, strpos(high, "-")+1, 1000) if strpos(high, "-") != 0 & highcat=="intfrac"

gen highhyphfracA = substr(highhyphB, 1, strpos(highhyphB, "/")-1) if strpos(highhyphB, "/") != 0 & highcat=="intfrac"
gen highhyphfracB = substr(highhyphB, strpos(highhyphB, "/")+1, 1000) if strpos(highhyphB, "/") != 0 & highcat=="intfrac"
destring highhyphA highhyphfracA highhyphfracB, replace force
replace highformatted = highhyphA + highhyphfracA/highhyphfracB if highcat=="intfrac"

drop highcat highfracA highfracB highhyphA highhyphB highhyphfracA highhyphfracB

gen dateX = date(date,"MDY")
format dateX %td
encode Company, generate(CompanyX)
tsset CompanyX dateX
order CompanyX dateX

replace highformatted=130 if Company=="RL047" & dateX==-16724 		/* Correct error */

gen lowX = lowformatted
replace lowX = L1.lowX if lowformatted==.

gen highX = highformatted
replace highX = L1.highX if highformatted==.

gen midpriceX = (lowX+highX)/2
replace midpriceX=2 if CompanyX==161 & dateX==-16973		/* Correct error */

gen capgains = (midpriceX-L1.midpriceX)/L1.midpriceX

gen spread = highX - lowX
gen dspread = (spread - L1.spread)/L1.spread

save pricedata.dta, replace





/* CALCULATE VARIABLES */

use pricedata.dta, clear

gen UKMonth94 = dateX 
gen IMMID = CompanyX
tsset IMMID UKMonth94

gen LSECompanyn = 1 if midpriceX!=.
gen LSEMarketCap = 1
gen LSEPar = 1
gen LSEParWithNominal = 1
gen LSENominalWithPar = 1
gen LSETotDiv = 1
gen LSETotMarketCapWithDiv = 1
gen L1GBPPriceClose = L1.midpriceX
gen L1GBPPriceCloseDiv = L1.midpriceX
gen CapGainsPW = capgains
gen ReturnPW = capgains
gen DivPW = 0

by UKMonth94, sort : egen float L1TotalPriceClose = sum(L1GBPPriceClose)
by UKMonth94, sort : egen float L1TotalPriceCloseDiv = sum(L1GBPPriceCloseDiv)

gen WeightCGPW=L1GBPPriceClose/L1TotalPriceClose
gen WeightRPW=L1GBPPriceCloseDiv/L1TotalPriceCloseDiv

gen LSECapGainsPW=CapGainsPW*WeightCGPW
gen LSEReturnPW=ReturnPW*WeightRPW
gen LSECapGainsDPW=CapGainsPW*WeightRPW
gen LSEDivPW=DivPW*WeightRPW

collapse (count) IMMID (sum) LSECompanyn LSEMarketCap LSEPar LSEParWithNominal LSENominalWithPar LSETotDiv LSETotMarketCapWithDiv LSECapGainsPW LSEReturnPW LSECapGainsDPW LSEDivPW, by(UKMonth94)

format %td UKMonth94
keep if LSECompanyn>30

keep UKMonth94 LSECapGainsPW
rename UKMonth94 dateX
save marketcapgains.dta, replace





/* DATA */

use pricedata.dta, clear

merge m:1 dateX using "marketcapgains.dta"
drop _merge

tsset CompanyX dateX

gen L1midpriceX = L1.midpriceX
gen L2midpriceX = L2.midpriceX
gen L3midpriceX = L3.midpriceX
gen L4midpriceX = L4.midpriceX
gen L5midpriceX = L5.midpriceX
gen L6midpriceX = L6.midpriceX
gen L7midpriceX = L7.midpriceX
gen L8midpriceX = L8.midpriceX
gen L9midpriceX = L9.midpriceX
gen L10midpriceX = L10.midpriceX
gen L11midpriceX = L11.midpriceX
gen L12midpriceX = L12.midpriceX
gen L13midpriceX = L13.midpriceX
gen L14midpriceX = L14.midpriceX
gen L15midpriceX = L15.midpriceX
gen L16midpriceX = L16.midpriceX
gen L17midpriceX = L17.midpriceX
gen L18midpriceX = L18.midpriceX
gen L19midpriceX = L19.midpriceX
gen L20midpriceX = L20.midpriceX
gen L21midpriceX = L21.midpriceX
gen L22midpriceX = L22.midpriceX
gen L23midpriceX = L23.midpriceX
gen L24midpriceX = L24.midpriceX
gen L25midpriceX = L25.midpriceX
gen L26midpriceX = L26.midpriceX
gen L27midpriceX = L27.midpriceX
gen L28midpriceX = L28.midpriceX
gen L29midpriceX = L29.midpriceX
gen L30midpriceX = L30.midpriceX


gen F1midpriceX = F1.midpriceX
gen F2midpriceX = F2.midpriceX
gen F3midpriceX = F3.midpriceX
gen F4midpriceX = F4.midpriceX
gen F5midpriceX = F5.midpriceX
gen F6midpriceX = F6.midpriceX
gen F7midpriceX = F7.midpriceX
gen F8midpriceX = F8.midpriceX
gen F9midpriceX = F9.midpriceX
gen F10midpriceX = F10.midpriceX
gen F11midpriceX = F11.midpriceX
gen F12midpriceX = F12.midpriceX
gen F13midpriceX = F13.midpriceX
gen F14midpriceX = F14.midpriceX
gen F15midpriceX = F15.midpriceX
gen F16midpriceX = F16.midpriceX
gen F17midpriceX = F17.midpriceX
gen F18midpriceX = F18.midpriceX
gen F19midpriceX = F19.midpriceX
gen F20midpriceX = F20.midpriceX
gen F21midpriceX = F21.midpriceX
gen F22midpriceX = F22.midpriceX
gen F23midpriceX = F23.midpriceX
gen F24midpriceX = F24.midpriceX
gen F25midpriceX = F25.midpriceX
gen F26midpriceX = F26.midpriceX
gen F27midpriceX = F27.midpriceX
gen F28midpriceX = F28.midpriceX
gen F29midpriceX = F29.midpriceX
gen F30midpriceX = F30.midpriceX



/* MISSING DATA */

egen float DataAvailable55 = rownonmiss(midpriceX L1midpriceX-L5midpriceX F1midpriceX-F5midpriceX)
egen float DataAvailable3030 = rownonmiss(midpriceX L1midpriceX-L30midpriceX F1midpriceX-F30midpriceX)


/* CAP GAINS */

gen L1capgains = L1.capgains
gen L2capgains = L2.capgains
gen L3capgains = L3.capgains
gen L4capgains = L4.capgains
gen L5capgains = L5.capgains
gen L6capgains = L6.capgains
gen L7capgains = L7.capgains
gen L8capgains = L8.capgains
gen L9capgains = L9.capgains
gen L10capgains = L10.capgains
gen L11capgains = L11.capgains
gen L12capgains = L12.capgains
gen L13capgains = L13.capgains
gen L14capgains = L14.capgains
gen L15capgains = L15.capgains
gen L16capgains = L16.capgains
gen L17capgains = L17.capgains
gen L18capgains = L18.capgains
gen L19capgains = L19.capgains
gen L20capgains = L20.capgains
gen L21capgains = L21.capgains
gen L22capgains = L22.capgains
gen L23capgains = L23.capgains
gen L24capgains = L24.capgains
gen L25capgains = L25.capgains
gen L26capgains = L26.capgains
gen L27capgains = L27.capgains
gen L28capgains = L28.capgains
gen L29capgains = L29.capgains
gen L30capgains = L30.capgains

gen F1capgains = F1.capgains
gen F2capgains = F2.capgains
gen F3capgains = F3.capgains
gen F4capgains = F4.capgains
gen F5capgains = F5.capgains
gen F6capgains = F6.capgains
gen F7capgains = F7.capgains
gen F8capgains = F8.capgains
gen F9capgains = F9.capgains
gen F10capgains = F10.capgains
gen F11capgains = F11.capgains
gen F12capgains = F12.capgains
gen F13capgains = F13.capgains
gen F14capgains = F14.capgains
gen F15capgains = F15.capgains
gen F16capgains = F16.capgains
gen F17capgains = F17.capgains
gen F18capgains = F18.capgains
gen F19capgains = F19.capgains
gen F20capgains = F20.capgains
gen F21capgains = F21.capgains
gen F22capgains = F22.capgains
gen F23capgains = F23.capgains
gen F24capgains = F24.capgains
gen F25capgains = F25.capgains
gen F26capgains = F26.capgains
gen F27capgains = F27.capgains
gen F28capgains = F28.capgains
gen F29capgains = F29.capgains
gen F30capgains = F30.capgains

gen capgainsL30F30Chained = (1+capgains)*(1+F1capgains)*(1+F2capgains)*(1+F3capgains)*(1+F4capgains)*(1+F5capgains)*(1+F6capgains)*(1+F7capgains)*(1+F8capgains)*(1+F9capgains)*(1+F10capgains)*(1+F11capgains)*(1+F12capgains)*(1+F13capgains)*(1+F14capgains)*(1+F15capgains)*(1+F16capgains)*(1+F17capgains)*(1+F18capgains)*(1+F19capgains)*(1+F20capgains)*(1+F21capgains)*(1+F22capgains)*(1+F23capgains)*(1+F24capgains)*(1+F25capgains)*(1+F26capgains)*(1+F27capgains)*(1+F28capgains)*(1+F29capgains)*(1+F30capgains)*(1+L1capgains)*(1+L2capgains)*(1+L3capgains)*(1+L4capgains)*(1+L5capgains)*(1+L6capgains)*(1+L7capgains)*(1+L8capgains)*(1+L9capgains)*(1+L10capgains)*(1+L11capgains)*(1+L12capgains)*(1+L13capgains)*(1+L14capgains)*(1+L15capgains)*(1+L16capgains)*(1+L17capgains)*(1+L18capgains)*(1+L19capgains)*(1+L20capgains)*(1+L21capgains)*(1+L22capgains)*(1+L23capgains)*(1+L24capgains)*(1+L25capgains)*(1+L26capgains)*(1+L27capgains)*(1+L28capgains)*(1+L29capgains) - 1


gen capgainsL30F30 = (F30.midpriceX-L30.midpriceX)/L30.midpriceX
gen capgainsL30F0 = (midpriceX-L30.midpriceX)/L30.midpriceX
gen capgainsL0F30 = (F30.midpriceX-midpriceX)/midpriceX

gen capgainsL5F5 = (F5.midpriceX-L5.midpriceX)/L5.midpriceX
gen capgainsL5F0 = (midpriceX-L5.midpriceX)/L5.midpriceX
gen capgainsL0F5 = (F5.midpriceX-midpriceX)/midpriceX


egen float SumCapGainsL5F5 = rowtotal(capgains F1capgains-F5capgains L1capgains-L4capgains)
egen float SumCapGainsL30F30 = rowtotal(capgains F1capgains-F30capgains L1capgains-L29capgains)



/* ABNORMAL CAP GAINS */

gen abnormcapgains = capgains - LSECapGainsPW

gen L1abnormcapgains = L1.abnormcapgains
gen L2abnormcapgains = L2.abnormcapgains
gen L3abnormcapgains = L3.abnormcapgains
gen L4abnormcapgains = L4.abnormcapgains
gen L5abnormcapgains = L5.abnormcapgains
gen L6abnormcapgains = L6.abnormcapgains
gen L7abnormcapgains = L7.abnormcapgains
gen L8abnormcapgains = L8.abnormcapgains
gen L9abnormcapgains = L9.abnormcapgains
gen L10abnormcapgains = L10.abnormcapgains
gen L11abnormcapgains = L11.abnormcapgains
gen L12abnormcapgains = L12.abnormcapgains
gen L13abnormcapgains = L13.abnormcapgains
gen L14abnormcapgains = L14.abnormcapgains
gen L15abnormcapgains = L15.abnormcapgains
gen L16abnormcapgains = L16.abnormcapgains
gen L17abnormcapgains = L17.abnormcapgains
gen L18abnormcapgains = L18.abnormcapgains
gen L19abnormcapgains = L19.abnormcapgains
gen L20abnormcapgains = L20.abnormcapgains
gen L21abnormcapgains = L21.abnormcapgains
gen L22abnormcapgains = L22.abnormcapgains
gen L23abnormcapgains = L23.abnormcapgains
gen L24abnormcapgains = L24.abnormcapgains
gen L25abnormcapgains = L25.abnormcapgains
gen L26abnormcapgains = L26.abnormcapgains
gen L27abnormcapgains = L27.abnormcapgains
gen L28abnormcapgains = L28.abnormcapgains
gen L29abnormcapgains = L29.abnormcapgains
gen L30abnormcapgains = L30.abnormcapgains


gen F1abnormcapgains = F1.abnormcapgains
gen F2abnormcapgains = F2.abnormcapgains
gen F3abnormcapgains = F3.abnormcapgains
gen F4abnormcapgains = F4.abnormcapgains
gen F5abnormcapgains = F5.abnormcapgains
gen F6abnormcapgains = F6.abnormcapgains
gen F7abnormcapgains = F7.abnormcapgains
gen F8abnormcapgains = F8.abnormcapgains
gen F9abnormcapgains = F9.abnormcapgains
gen F10abnormcapgains = F10.abnormcapgains
gen F11abnormcapgains = F11.abnormcapgains
gen F12abnormcapgains = F12.abnormcapgains
gen F13abnormcapgains = F13.abnormcapgains
gen F14abnormcapgains = F14.abnormcapgains
gen F15abnormcapgains = F15.abnormcapgains
gen F16abnormcapgains = F16.abnormcapgains
gen F17abnormcapgains = F17.abnormcapgains
gen F18abnormcapgains = F18.abnormcapgains
gen F19abnormcapgains = F19.abnormcapgains
gen F20abnormcapgains = F20.abnormcapgains
gen F21abnormcapgains = F21.abnormcapgains
gen F22abnormcapgains = F22.abnormcapgains
gen F23abnormcapgains = F23.abnormcapgains
gen F24abnormcapgains = F24.abnormcapgains
gen F25abnormcapgains = F25.abnormcapgains
gen F26abnormcapgains = F26.abnormcapgains
gen F27abnormcapgains = F27.abnormcapgains
gen F28abnormcapgains = F28.abnormcapgains
gen F29abnormcapgains = F29.abnormcapgains
gen F30abnormcapgains = F30.abnormcapgains


gen abnormcapgainsL30F30Chained = (1+abnormcapgains)*(1+F1abnormcapgains)*(1+F2abnormcapgains)*(1+F3abnormcapgains)*(1+F4abnormcapgains)*(1+F5abnormcapgains)*(1+F6abnormcapgains)*(1+F7abnormcapgains)*(1+F8abnormcapgains)*(1+F9abnormcapgains)*(1+F10abnormcapgains)*(1+F11abnormcapgains)*(1+F12abnormcapgains)*(1+F13abnormcapgains)*(1+F14abnormcapgains)*(1+F15abnormcapgains)*(1+F16abnormcapgains)*(1+F17abnormcapgains)*(1+F18abnormcapgains)*(1+F19abnormcapgains)*(1+F20abnormcapgains)*(1+F21abnormcapgains)*(1+F22abnormcapgains)*(1+F23abnormcapgains)*(1+F24abnormcapgains)*(1+F25abnormcapgains)*(1+F26abnormcapgains)*(1+F27abnormcapgains)*(1+F28abnormcapgains)*(1+F29abnormcapgains)*(1+F30abnormcapgains)*(1+L1abnormcapgains)*(1+L2abnormcapgains)*(1+L3abnormcapgains)*(1+L4abnormcapgains)*(1+L5abnormcapgains)*(1+L6abnormcapgains)*(1+L7abnormcapgains)*(1+L8abnormcapgains)*(1+L9abnormcapgains)*(1+L10abnormcapgains)*(1+L11abnormcapgains)*(1+L12abnormcapgains)*(1+L13abnormcapgains)*(1+L14abnormcapgains)*(1+L15abnormcapgains)*(1+L16abnormcapgains)*(1+L17abnormcapgains)*(1+L18abnormcapgains)*(1+L19abnormcapgains)*(1+L20abnormcapgains)*(1+L21abnormcapgains)*(1+L22abnormcapgains)*(1+L23abnormcapgains)*(1+L24abnormcapgains)*(1+L25abnormcapgains)*(1+L26abnormcapgains)*(1+L27abnormcapgains)*(1+L28abnormcapgains)*(1+L29abnormcapgains) - 1

gen abnormcapgainsL30F0Chained = (1+abnormcapgains)*(1+L1abnormcapgains)*(1+L2abnormcapgains)*(1+L3abnormcapgains)*(1+L4abnormcapgains)*(1+L5abnormcapgains)*(1+L6abnormcapgains)*(1+L7abnormcapgains)*(1+L8abnormcapgains)*(1+L9abnormcapgains)*(1+L10abnormcapgains)*(1+L11abnormcapgains)*(1+L12abnormcapgains)*(1+L13abnormcapgains)*(1+L14abnormcapgains)*(1+L15abnormcapgains)*(1+L16abnormcapgains)*(1+L17abnormcapgains)*(1+L18abnormcapgains)*(1+L19abnormcapgains)*(1+L20abnormcapgains)*(1+L21abnormcapgains)*(1+L22abnormcapgains)*(1+L23abnormcapgains)*(1+L24abnormcapgains)*(1+L25abnormcapgains)*(1+L26abnormcapgains)*(1+L27abnormcapgains)*(1+L28abnormcapgains)*(1+L29abnormcapgains) - 1

gen abnormcapgainsL0F30Chained = (1+abnormcapgains)*(1+F1abnormcapgains)*(1+F2abnormcapgains)*(1+F3abnormcapgains)*(1+F4abnormcapgains)*(1+F5abnormcapgains)*(1+F6abnormcapgains)*(1+F7abnormcapgains)*(1+F8abnormcapgains)*(1+F9abnormcapgains)*(1+F10abnormcapgains)*(1+F11abnormcapgains)*(1+F12abnormcapgains)*(1+F13abnormcapgains)*(1+F14abnormcapgains)*(1+F15abnormcapgains)*(1+F16abnormcapgains)*(1+F17abnormcapgains)*(1+F18abnormcapgains)*(1+F19abnormcapgains)*(1+F20abnormcapgains)*(1+F21abnormcapgains)*(1+F22abnormcapgains)*(1+F23abnormcapgains)*(1+F24abnormcapgains)*(1+F25abnormcapgains)*(1+F26abnormcapgains)*(1+F27abnormcapgains)*(1+F28abnormcapgains)*(1+F29abnormcapgains)*(1+F30abnormcapgains) - 1


gen abnormcapgainsL5F5Chained = (1+abnormcapgains)*(1+F1abnormcapgains)*(1+F2abnormcapgains)*(1+F3abnormcapgains)*(1+F4abnormcapgains)*(1+F5abnormcapgains)*(1+L1abnormcapgains)*(1+L2abnormcapgains)*(1+L3abnormcapgains)*(1+L4abnormcapgains) - 1

gen abnormcapgainsL5F0Chained = (1+abnormcapgains)*(1+L1abnormcapgains)*(1+L2abnormcapgains)*(1+L3abnormcapgains)*(1+L4abnormcapgains) - 1

gen abnormcapgainsL0F5Chained = (1+abnormcapgains)*(1+F1abnormcapgains)*(1+F2abnormcapgains)*(1+F3abnormcapgains)*(1+F4abnormcapgains)*(1+F5abnormcapgains) - 1


egen float SumabnormcapgainsL5F5 = rowtotal(abnormcapgains F1abnormcapgains-F5abnormcapgains L1abnormcapgains-L4abnormcapgains)
egen float SumabnormcapgainsL30F30 = rowtotal(abnormcapgains F1abnormcapgains-F30abnormcapgains L1abnormcapgains-L29abnormcapgains)


/* TRADED */

gen Traded = 1 if capgains!=0 & capgains!=.
replace Traded = 0 if Traded==.

gen F1Traded = F1.Traded
gen F2Traded = F2.Traded
gen F3Traded = F3.Traded
gen F4Traded = F4.Traded
gen F5Traded = F5.Traded
gen F6Traded = F6.Traded
gen F7Traded = F7.Traded
gen F8Traded = F8.Traded
gen F9Traded = F9.Traded
gen F10Traded = F10.Traded
gen F11Traded = F11.Traded
gen F12Traded = F12.Traded
gen F13Traded = F13.Traded
gen F14Traded = F14.Traded
gen F15Traded = F15.Traded
gen F16Traded = F16.Traded
gen F17Traded = F17.Traded
gen F18Traded = F18.Traded
gen F19Traded = F19.Traded
gen F20Traded = F20.Traded
gen F21Traded = F21.Traded
gen F22Traded = F22.Traded
gen F23Traded = F23.Traded
gen F24Traded = F24.Traded
gen F25Traded = F25.Traded
gen F26Traded = F26.Traded
gen F27Traded = F27.Traded
gen F28Traded = F28.Traded
gen F29Traded = F29.Traded
gen F30Traded = F30.Traded

gen L1Traded = L1.Traded
gen L2Traded = L2.Traded
gen L3Traded = L3.Traded
gen L4Traded = L4.Traded
gen L5Traded = L5.Traded
gen L6Traded = L6.Traded
gen L7Traded = L7.Traded
gen L8Traded = L8.Traded
gen L9Traded = L9.Traded
gen L10Traded = L10.Traded
gen L11Traded = L11.Traded
gen L12Traded = L12.Traded
gen L13Traded = L13.Traded
gen L14Traded = L14.Traded
gen L15Traded = L15.Traded
gen L16Traded = L16.Traded
gen L17Traded = L17.Traded
gen L18Traded = L18.Traded
gen L19Traded = L19.Traded
gen L20Traded = L20.Traded
gen L21Traded = L21.Traded
gen L22Traded = L22.Traded
gen L23Traded = L23.Traded
gen L24Traded = L24.Traded
gen L25Traded = L25.Traded
gen L26Traded = L26.Traded
gen L27Traded = L27.Traded
gen L28Traded = L28.Traded
gen L29Traded = L29.Traded
gen L30Traded = L30.Traded


egen float SumTradedL30F30 = rowtotal(Traded F1Traded-F30Traded L1Traded-L29Traded)
egen float SumTradedL30F0 = rowtotal(Traded L1Traded-L29Traded)
egen float SumTradedL0F30 = rowtotal(Traded F1Traded-F30Traded)
egen float SumTradedL5F5 = rowtotal(Traded F1Traded-F5Traded L1Traded-L4Traded)
egen float SumTradedL5F0 = rowtotal(Traded L1Traded-L4Traded)
egen float SumTradedL0F5 = rowtotal(Traded F1Traded-F5Traded)

gen PropTradedL30F30 = SumTradedL30F30/60
gen PropTradedL30F0 = SumTradedL30F0/30
gen PropTradedL0F30 = SumTradedL0F30/30
gen PropTradedL5F5 = SumTradedL5F5/10
gen PropTradedL5F0 = SumTradedL5F0/5
gen PropTradedL0F5 = SumTradedL0F5/5




/* EVENTS */

gen LD = 1 if strpos(event,"LD")>0
replace LD=0 if LD==.

gen GM = 1 if strpos(event,"GM")>0
replace GM=0 if GM==.

gen FC = 1 if strpos(event,"FC")>0
replace FC=0 if FC==.

gen LC = 1 if strpos(event,"LC")>0
replace LC=0 if LC==.

gen AU = 1 if strpos(event,"AU")>0
replace AU=0 if AU==.

gen VE = 1 if strpos(event,"VE")>0
replace VE=0 if VE==.

gen XD = 1 if strpos(event,"XD")>0
replace XD=0 if XD==.

gen XR = 1 if strpos(event,"XR")>0
replace XR=0 if XR==.

gen XB = 1 if strpos(event,"XB")>0
replace XB=0 if XB==.



/* EX-DIVIDEND */

gen ExDiv = 1 if XD==1

gen F1ExDiv = F1.ExDiv
gen F2ExDiv = F2.ExDiv
gen F3ExDiv = F3.ExDiv
gen F4ExDiv = F4.ExDiv
gen F5ExDiv = F5.ExDiv
gen F6ExDiv = F6.ExDiv
gen F7ExDiv = F7.ExDiv
gen F8ExDiv = F8.ExDiv
gen F9ExDiv = F9.ExDiv
gen F10ExDiv = F10.ExDiv
gen F11ExDiv = F11.ExDiv
gen F12ExDiv = F12.ExDiv
gen F13ExDiv = F13.ExDiv
gen F14ExDiv = F14.ExDiv
gen F15ExDiv = F15.ExDiv
gen F16ExDiv = F16.ExDiv
gen F17ExDiv = F17.ExDiv
gen F18ExDiv = F18.ExDiv
gen F19ExDiv = F19.ExDiv
gen F20ExDiv = F20.ExDiv
gen F21ExDiv = F21.ExDiv
gen F22ExDiv = F22.ExDiv
gen F23ExDiv = F23.ExDiv
gen F24ExDiv = F24.ExDiv
gen F25ExDiv = F25.ExDiv
gen F26ExDiv = F26.ExDiv
gen F27ExDiv = F27.ExDiv
gen F28ExDiv = F28.ExDiv
gen F29ExDiv = F29.ExDiv
gen F30ExDiv = F30.ExDiv

gen L1ExDiv = L1.ExDiv
gen L2ExDiv = L2.ExDiv
gen L3ExDiv = L3.ExDiv
gen L4ExDiv = L4.ExDiv
gen L5ExDiv = L5.ExDiv
gen L6ExDiv = L6.ExDiv
gen L7ExDiv = L7.ExDiv
gen L8ExDiv = L8.ExDiv
gen L9ExDiv = L9.ExDiv
gen L10ExDiv = L10.ExDiv
gen L11ExDiv = L11.ExDiv
gen L12ExDiv = L12.ExDiv
gen L13ExDiv = L13.ExDiv
gen L14ExDiv = L14.ExDiv
gen L15ExDiv = L15.ExDiv
gen L16ExDiv = L16.ExDiv
gen L17ExDiv = L17.ExDiv
gen L18ExDiv = L18.ExDiv
gen L19ExDiv = L19.ExDiv
gen L20ExDiv = L20.ExDiv
gen L21ExDiv = L21.ExDiv
gen L22ExDiv = L22.ExDiv
gen L23ExDiv = L23.ExDiv
gen L24ExDiv = L24.ExDiv
gen L25ExDiv = L25.ExDiv
gen L26ExDiv = L26.ExDiv
gen L27ExDiv = L27.ExDiv
gen L28ExDiv = L28.ExDiv
gen L29ExDiv = L29.ExDiv
gen L30ExDiv = L30.ExDiv

egen float SumExDivL30F30 = rowtotal(ExDiv F1ExDiv-F30ExDiv L1ExDiv-L29ExDiv)
egen float SumExDivL30F0 = rowtotal(ExDiv L1ExDiv-L29ExDiv)
egen float SumExDivL0F30 = rowtotal(ExDiv F1ExDiv-F30ExDiv)

egen float SumExDivL5F5 = rowtotal(ExDiv F1ExDiv-F5ExDiv L1ExDiv-L4ExDiv)
egen float SumExDivL5F0 = rowtotal(ExDiv L1ExDiv-L4ExDiv)
egen float SumExDivL0F5 = rowtotal(ExDiv F1ExDiv-F5ExDiv)


gen ExDivL30F30Dummy = 1 if SumExDivL30F30>0
gen ExDivL30F0Dummy = 1 if SumExDivL30F0>0
gen ExDivL0F30Dummy = 1 if SumExDivL0F30>0
gen ExDivL5F5Dummy = 1 if SumExDivL5F5>0
gen ExDivL5F0Dummy = 1 if SumExDivL5F0>0
gen ExDivL0F5Dummy = 1 if SumExDivL0F5>0

replace ExDivL30F30Dummy=0 if ExDivL30F30Dummy!=1
replace ExDivL30F0Dummy=0 if ExDivL30F0Dummy!=1
replace ExDivL0F30Dummy=0 if ExDivL0F30Dummy!=1
replace ExDivL5F5Dummy=0 if ExDivL5F5Dummy!=1
replace ExDivL5F0Dummy=0 if ExDivL5F0Dummy!=1
replace ExDivL0F5Dummy=0 if ExDivL0F5Dummy!=1


/* WINSORING */
winsor2 capgainsL30F30 capgainsL30F0 capgainsL0F30 capgainsL5F5 capgainsL5F0 capgainsL0F5 abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5, replace cuts(2.5 97.5)


/* FULL DATA */
save FullData.dta, replace



/* -------------- */
/* EVENT ANALYSIS */
/* -------------- */

use FullData.dta, replace

drop if DataAvailable55==0
drop if DataAvailable3030==0
keep if F5.midpriceX!=. & L5.midpriceX!=.
keep if F30.midpriceX!=. & L30.midpriceX!=.


/* CHECK OVERALL - SMALL DIFFERENCE BETWEEN EQUAL AND PRICE WEIGHTING */
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained, statistics( count mean )

ttest abnormcapgainsL30F30Chained == 0
ttest abnormcapgainsL30F0Chained == 0
ttest abnormcapgainsL0F30Chained == 0
ttest abnormcapgainsL5F5Chained == 0
ttest abnormcapgainsL5F0Chained == 0
ttest abnormcapgainsL0F5Chained == 0


/* MAIN EVENTS */
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if LD==1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if GM==1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if FC==1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if LC==1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if AU==1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if XD==1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if XR==1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if XB==1, statistics( count mean )


ttest abnormcapgainsL30F30Chained == 0 if LD==1
ttest abnormcapgainsL30F30Chained == 0 if GM==1
ttest abnormcapgainsL30F30Chained == 0 if FC==1
ttest abnormcapgainsL30F30Chained == 0 if LC==1
ttest abnormcapgainsL30F30Chained == 0 if AU==1
ttest abnormcapgainsL30F30Chained == 0 if XD==1
ttest abnormcapgainsL30F30Chained == 0 if XR==1
ttest abnormcapgainsL30F30Chained == 0 if XB==1

ttest abnormcapgainsL30F0Chained == 0 if LD==1
ttest abnormcapgainsL30F0Chained == 0 if GM==1
ttest abnormcapgainsL30F0Chained == 0 if FC==1
ttest abnormcapgainsL30F0Chained == 0 if LC==1
ttest abnormcapgainsL30F0Chained == 0 if AU==1
ttest abnormcapgainsL30F0Chained == 0 if XD==1
ttest abnormcapgainsL30F0Chained == 0 if XR==1
ttest abnormcapgainsL30F0Chained == 0 if XB==1

ttest abnormcapgainsL0F30Chained == 0 if LD==1
ttest abnormcapgainsL0F30Chained == 0 if GM==1
ttest abnormcapgainsL0F30Chained == 0 if FC==1
ttest abnormcapgainsL0F30Chained == 0 if LC==1
ttest abnormcapgainsL0F30Chained == 0 if AU==1
ttest abnormcapgainsL0F30Chained == 0 if XD==1
ttest abnormcapgainsL0F30Chained == 0 if XR==1
ttest abnormcapgainsL0F30Chained == 0 if XB==1

ttest abnormcapgainsL5F5Chained == 0 if LD==1
ttest abnormcapgainsL5F5Chained == 0 if GM==1
ttest abnormcapgainsL5F5Chained == 0 if FC==1
ttest abnormcapgainsL5F5Chained == 0 if LC==1
ttest abnormcapgainsL5F5Chained == 0 if AU==1
ttest abnormcapgainsL5F5Chained == 0 if XD==1
ttest abnormcapgainsL5F5Chained == 0 if XR==1
ttest abnormcapgainsL5F5Chained == 0 if XB==1

ttest abnormcapgainsL5F0Chained == 0 if LD==1
ttest abnormcapgainsL5F0Chained == 0 if GM==1
ttest abnormcapgainsL5F0Chained == 0 if FC==1
ttest abnormcapgainsL5F0Chained == 0 if LC==1
ttest abnormcapgainsL5F0Chained == 0 if AU==1
ttest abnormcapgainsL5F0Chained == 0 if XD==1
ttest abnormcapgainsL5F0Chained == 0 if XR==1
ttest abnormcapgainsL5F0Chained == 0 if XB==1

ttest abnormcapgainsL0F5Chained == 0 if LD==1
ttest abnormcapgainsL0F5Chained == 0 if GM==1
ttest abnormcapgainsL0F5Chained == 0 if FC==1
ttest abnormcapgainsL0F5Chained == 0 if LC==1
ttest abnormcapgainsL0F5Chained == 0 if AU==1
ttest abnormcapgainsL0F5Chained == 0 if XD==1
ttest abnormcapgainsL0F5Chained == 0 if XR==1
ttest abnormcapgainsL0F5Chained == 0 if XB==1


/* INTERACTION BETWEEN AGM AND EX-DIVIDEND */

ttest abnormcapgainsL5F5Chained == 0 if GM==1 & ExDivL5F5Dummy==1
ttest abnormcapgainsL5F5Chained == 0 if GM==1 & ExDivL5F5Dummy!=1

ttest abnormcapgainsL5F0Chained == 0 if GM==1 & ExDivL5F0Dummy==1
ttest abnormcapgainsL5F0Chained == 0 if GM==1 & ExDivL5F0Dummy!=1

ttest abnormcapgainsL0F5Chained == 0 if GM==1 & ExDivL0F5Dummy==1
ttest abnormcapgainsL0F5Chained == 0 if GM==1 & ExDivL0F5Dummy!=1


ttest abnormcapgainsL30F30Chained == 0 if GM==1 & ExDivL30F30Dummy==1
ttest abnormcapgainsL30F30Chained == 0 if GM==1 & ExDivL30F30Dummy!=1

ttest abnormcapgainsL30F0Chained == 0 if GM==1 & ExDivL30F0Dummy==1
ttest abnormcapgainsL30F0Chained == 0 if GM==1 & ExDivL30F0Dummy!=1

ttest abnormcapgainsL0F30Chained == 0 if GM==1 & ExDivL0F30Dummy==1
ttest abnormcapgainsL0F30Chained == 0 if GM==1 & ExDivL0F30Dummy!=1




/* INTERACTION BETWEEN AGM AND LC */

tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if GM==1 & LC==1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if GM==1 & LC!=1, statistics( count mean )
tabstat abnormcapgainsL30F30Chained abnormcapgainsL30F0Chained abnormcapgainsL0F30Chained abnormcapgainsL5F5Chained abnormcapgainsL5F0Chained abnormcapgainsL0F5Chained if GM!=1 & LC==1, statistics( count mean )

ttest abnormcapgainsL30F30Chained == 0 if GM==1 & LC==1
ttest abnormcapgainsL30F30Chained == 0 if GM==1 & LC!=1
ttest abnormcapgainsL30F30Chained == 0 if GM!=1 & LC==1

ttest abnormcapgainsL30F0Chained == 0 if GM==1 & LC==1
ttest abnormcapgainsL30F0Chained == 0 if GM==1 & LC!=1
ttest abnormcapgainsL30F0Chained == 0 if GM!=1 & LC==1

ttest abnormcapgainsL0F30Chained == 0 if GM==1 & LC==1
ttest abnormcapgainsL0F30Chained == 0 if GM==1 & LC!=1
ttest abnormcapgainsL0F30Chained == 0 if GM!=1 & LC==1

ttest abnormcapgainsL5F5Chained == 0 if GM==1 & LC==1
ttest abnormcapgainsL5F5Chained == 0 if GM==1 & LC!=1
ttest abnormcapgainsL5F5Chained == 0 if GM!=1 & LC==1

ttest abnormcapgainsL5F0Chained == 0 if GM==1 & LC==1
ttest abnormcapgainsL5F0Chained == 0 if GM==1 & LC!=1
ttest abnormcapgainsL5F0Chained == 0 if GM!=1 & LC==1

ttest abnormcapgainsL0F5Chained == 0 if GM==1 & LC==1
ttest abnormcapgainsL0F5Chained == 0 if GM==1 & LC!=1
ttest abnormcapgainsL0F5Chained == 0 if GM!=1 & LC==1




/* TRADING */

tabstat PropTradedL30F30 PropTradedL30F0 PropTradedL0F30 PropTradedL5F5 PropTradedL5F0 PropTradedL0F5 if LD==1, statistics( count mean )
tabstat PropTradedL30F30 PropTradedL30F0 PropTradedL0F30 PropTradedL5F5 PropTradedL5F0 PropTradedL0F5 if GM==1, statistics( count mean )
tabstat PropTradedL30F30 PropTradedL30F0 PropTradedL0F30 PropTradedL5F5 PropTradedL5F0 PropTradedL0F5 if FC==1, statistics( count mean )
tabstat PropTradedL30F30 PropTradedL30F0 PropTradedL0F30 PropTradedL5F5 PropTradedL5F0 PropTradedL0F5 if LC==1, statistics( count mean )
tabstat PropTradedL30F30 PropTradedL30F0 PropTradedL0F30 PropTradedL5F5 PropTradedL5F0 PropTradedL0F5 if AU==1, statistics( count mean )
tabstat PropTradedL30F30 PropTradedL30F0 PropTradedL0F30 PropTradedL5F5 PropTradedL5F0 PropTradedL0F5 if XD==1, statistics( count mean )
tabstat PropTradedL30F30 PropTradedL30F0 PropTradedL0F30 PropTradedL5F5 PropTradedL5F0 PropTradedL0F5 if XR==1, statistics( count mean )
tabstat PropTradedL30F30 PropTradedL30F0 PropTradedL0F30 PropTradedL5F5 PropTradedL5F0 PropTradedL0F5 if XB==1, statistics( count mean )



/* SENTIMENT */

import excel "news sentiment scores.xlsx", sheet("formatted") firstrow clear
save sentiment.dta, replace

use FullData.dta, clear
gen Year = year(dateX)
merge m:1 CompanyName Year using "sentiment.dta"
keep if _merge==3
keep if GM==1

regress abnormcapgainsL30F30Chained SentimentScore if ExDivL30F30Dummy!=1, robust
outreg2 using sentiment.doc, replace bdec(3)
regress abnormcapgainsL0F30Chained SentimentScore if ExDivL0F30Dummy!=1, robust
outreg2 using sentiment.doc, bdec(3)

regress abnormcapgainsL5F5Chained SentimentScore if ExDivL5F5Dummy!=1, robust
outreg2 using sentiment.doc, bdec(3)
regress abnormcapgainsL0F5Chained SentimentScore if ExDivL0F5Dummy!=1, robust
outreg2 using sentiment.doc, bdec(3)


