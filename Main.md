Assessment-Sales Ratio Studies in New York City
================
William Kyeremateng
February 05, 2023

- <a href="#background" id="toc-background">Background</a>
- <a href="#data" id="toc-data">Data</a>
- <a href="#median-sales-ratio-by-property-type"
  id="toc-median-sales-ratio-by-property-type">Median Sales Ratio by
  Property Type</a>
  - <a href="#citywide-median-asr" id="toc-citywide-median-asr">Citywide
    Median ASR</a>
  - <a href="#median-asr-by-borough" id="toc-median-asr-by-borough">Median
    ASR by Borough</a>
  - <a href="#median-asr-by-property-value"
    id="toc-median-asr-by-property-value">Median ASR by Property Value</a>
- <a href="#section" id="toc-section"></a>
  - <a href="#uniformity-and-variation-of-sales-ratio"
    id="toc-uniformity-and-variation-of-sales-ratio">Uniformity and
    Variation of Sales Ratio</a>
    - <a href="#1-3-family" id="toc-1-3-family">1-3 Family</a>
    - <a href="#commercialoffice"
      id="toc-commercialoffice">Commercial/Office</a>
    - <a href="#large-rentals" id="toc-large-rentals">Large Rentals</a>
    - <a href="#small-rentals" id="toc-small-rentals">Small Rentals</a>
- <a href="#section-1" id="toc-section-1"></a>
  - <a href="#coefficient-of-dispersion"
    id="toc-coefficient-of-dispersion">Coefficient of Dispersion</a>
    - <a href="#citywide-cods" id="toc-citywide-cods">Citywide CODs</a>
    - <a href="#cods-by-borough" id="toc-cods-by-borough">CODs by Borough</a>
    - <a href="#cods-by-property-value" id="toc-cods-by-property-value">CODs
      by Property Value</a>
- <a href="#section-2" id="toc-section-2"></a>
  - <a href="#takeaways" id="toc-takeaways">Takeaways</a>
- <a href="#section-3" id="toc-section-3"></a>
  - <a href="#appendix" id="toc-appendix">Appendix</a>
    - <a href="#median-asr-by-zip-code" id="toc-median-asr-by-zip-code">Median
      ASR by Zip Code</a>
    - <a href="#cods-by-zip-code" id="toc-cods-by-zip-code">CODs by Zip
      Code</a>

<style type="text/css">
  body{
  font-size: 12pt;
}
</style>

<figure>
<img
src="/Users/aly_will_mac/Desktop/OLD%20PC/WILL/LEARNING/R/1.%20PROJECTS/Sales%20Ratio%20Studies/Cover%20Page.png"
style="width:100.0%"
alt="Picture Source: Chicago Tribue(March 16, 2018 publication)" />
<figcaption aria-hidden="true">Picture Source: Chicago Tribue(March 16,
2018 publication)</figcaption>
</figure>

## Background

Assessment to sales ratio (ASR) is the ratio a property’s market value
as estimated by the city to its actual sales prices. Ideally, the
appraised market value for tax purposes should equal the price a
property would fetch on the open market if it were put up for sale. A
ratio equal to 1 indicates that the assessor had exactly estimated the
property’s eventual sales price. In practice, that level of accuracy
could only reasonably occur by chance. More often than not, property
assessments conducted by counties for tax purposes fail to capture the
full market values of properties on a open market. For example, NYC’s
property tax roll for Fiscal 2019 showed that Chelsea Market (75 9th
Avenue) had a market value of about \$532 million in 2018 in March 2018.
However that same year, Google wound up buying the building for almost
\$2.4 billion - more than 350% more than NYC’s assessed market value.

<figure>
<img
src="/Users/aly_will_mac/Desktop/OLD%20PC/WILL/LEARNING/R/1.%20PROJECTS/Sales%20Ratio%20Studies/Chelsea%20Market.png"
style="width:100.0%" alt="Picture Source: The New York Times)" />
<figcaption aria-hidden="true">Picture Source: The New York
Times)</figcaption>
</figure>

The NYC Department of Finance estimates market values using
sophisticated models that relate prices of sold properties to unsold
properties adjusting for differences in property characteristics. As a
result there will invariably be differences between estimates of market
value and actual prices. The ASR measures this inaccuracy.

Getting the ASR right or wrong has implications not just for individual
taxpayers but for how DOF goes about its job and how the property tax is
administered more broadly. Previous research show that the valuation
method used by DOF to assess the market value of a property affects how
close the market value assessed by DOF would be to the true market
value. This also affects the taxes levied on a property, as well as the
fairness and equity of the property tax system.

**Goal of the Project**

This project seeks to determine if DOF’s property appraisals meet the
standards set by the International Association of Assessing Officers
(IAAO). Using property sales and assessment data, it estimates the
assessment-sale ratio and use it to measure how close DOF’s market
values are to true market value (sale prices). Additionally, the project
evaluates how uniform the assessment-sales ratio are across the City and
within groups by calculating the coefficient of dispersion.

## Data

This analysis uses the property sales data and property assessment roll
from the NYC Department of Finance. The sales data used in this work
covers all properties sold from calendar years 2013 to 2018. The
property assessment rolls used are from Fiscal 2014 through Fiscal 2019,
which correspond to property values as of calendar year 2013 through
2018. This goal is to ensure that DOF’s assessed market value and the
sale price of a property are from the same year.

## Median Sales Ratio by Property Type

While individual properties may experience very different ASRs, the
quality of DOF’s assessment is evaluated in the aggregate using the
median value of all ASRs. IAAO standards define a high quality
assessment for jurisdictions with a sufficiently large number of
property sales—such as New York City— as one where the median ASR lies
between 0.90 percent and 1.10 percent.

The tables below show the median assessment-sales ratio for four
property types - 1-3 Family, commercial, large rentals and small rental
properties.

The first tab shows that, overall, DOF’s assessment of 1-3 Family homes
(Class 1) is the only one that meets the IAAO standards for quality
assessment. This makes sense since DOF appraises the values of 1-3
Family properties using comparable sales method. The other property
classes are appraised using other methods which fail to capture true
market values.

### Citywide Median ASR

``` r
summary_citywide %>% 
  select(prop_type, median_asr) %>%
  mutate(median_asr = round(median_asr, 2)) %>% 
  pivot_wider(names_from = prop_type,
              values_from = median_asr) %>% 
  kbl(align = "lrrrr") %>% 
  kable_classic_2()
```

<table class=" lightable-classic-2" style="font-family: &quot;Arial Narrow&quot;, &quot;Source Sans Pro&quot;, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
1-3 Family
</th>
<th style="text-align:right;">
Commercial/Office
</th>
<th style="text-align:right;">
Large Rentals
</th>
<th style="text-align:right;">
Small Rentals
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
0.95
</td>
<td style="text-align:right;">
0.38
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.47
</td>
</tr>
</tbody>
</table>

### Median ASR by Borough

``` r
summary_boro %>% 
  select(Borough, prop_type, median_asr)%>% 
  mutate(median_asr = round(median_asr, 2)) %>% 
  pivot_wider(names_from = prop_type,
              values_from = median_asr) %>% 
  kbl(align = "lrrrr") %>% 
  kable_classic_2()
```

<table class=" lightable-classic-2" style="font-family: &quot;Arial Narrow&quot;, &quot;Source Sans Pro&quot;, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Borough
</th>
<th style="text-align:right;">
1-3 Family
</th>
<th style="text-align:right;">
Commercial/Office
</th>
<th style="text-align:right;">
Large Rentals
</th>
<th style="text-align:right;">
Small Rentals
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Brooklyn
</td>
<td style="text-align:right;">
0.98
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
0.41
</td>
</tr>
<tr>
<td style="text-align:left;">
Manhattan
</td>
<td style="text-align:right;">
1.11
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
0.36
</td>
</tr>
<tr>
<td style="text-align:left;">
Queens
</td>
<td style="text-align:right;">
0.95
</td>
<td style="text-align:right;">
0.43
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
0.52
</td>
</tr>
<tr>
<td style="text-align:left;">
Staten Island
</td>
<td style="text-align:right;">
0.89
</td>
<td style="text-align:right;">
0.49
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
0.69
</td>
</tr>
<tr>
<td style="text-align:left;">
The Bronx
</td>
<td style="text-align:right;">
0.99
</td>
<td style="text-align:right;">
0.58
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
0.76
</td>
</tr>
</tbody>
</table>

### Median ASR by Property Value

``` r
summary_deciles %>% 
  select(decile, prop_type, median_asr)%>% 
  mutate(median_asr = round(median_asr, 2)) %>% 
  mutate(decile = case_when(decile == 1 ~ "Bottom 10%", decile == 2 ~ "10%-20%", 
                            decile == 3 ~ "20%-30%", decile == 4 ~ "30%-40%",
                            decile == 5 ~ "40%-50%", decile == 6 ~ "50%-60%", 
                            decile == 7 ~ "60%-70%", decile == 8 ~"70%-80%",
                            decile == 9 ~ "80%-90%", TRUE ~ "Top 10%")) %>% 
  rename(`Sale Price` = decile) %>% 
  pivot_wider(names_from = prop_type,
              values_from = median_asr) %>% 
  kbl(align = "lrrrr") %>% 
  kable_classic_2()
```

<table class=" lightable-classic-2" style="font-family: &quot;Arial Narrow&quot;, &quot;Source Sans Pro&quot;, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Sale Price
</th>
<th style="text-align:right;">
1-3 Family
</th>
<th style="text-align:right;">
Commercial/Office
</th>
<th style="text-align:right;">
Large Rentals
</th>
<th style="text-align:right;">
Small Rentals
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Bottom 10%
</td>
<td style="text-align:right;">
1.65
</td>
<td style="text-align:right;">
1.21
</td>
<td style="text-align:right;">
6.31
</td>
<td style="text-align:right;">
1.92
</td>
</tr>
<tr>
<td style="text-align:left;">
10%-20%
</td>
<td style="text-align:right;">
1.06
</td>
<td style="text-align:right;">
0.64
</td>
<td style="text-align:right;">
1.51
</td>
<td style="text-align:right;">
0.82
</td>
</tr>
<tr>
<td style="text-align:left;">
20%-30%
</td>
<td style="text-align:right;">
0.93
</td>
<td style="text-align:right;">
0.63
</td>
<td style="text-align:right;">
1.87
</td>
<td style="text-align:right;">
0.74
</td>
</tr>
<tr>
<td style="text-align:left;">
30%-40%
</td>
<td style="text-align:right;">
0.89
</td>
<td style="text-align:right;">
0.55
</td>
<td style="text-align:right;">
1.27
</td>
<td style="text-align:right;">
0.64
</td>
</tr>
<tr>
<td style="text-align:left;">
40%-50%
</td>
<td style="text-align:right;">
0.89
</td>
<td style="text-align:right;">
0.46
</td>
<td style="text-align:right;">
0.69
</td>
<td style="text-align:right;">
0.57
</td>
</tr>
<tr>
<td style="text-align:left;">
50%-60%
</td>
<td style="text-align:right;">
0.91
</td>
<td style="text-align:right;">
0.44
</td>
<td style="text-align:right;">
0.64
</td>
<td style="text-align:right;">
0.52
</td>
</tr>
<tr>
<td style="text-align:left;">
60%-70%
</td>
<td style="text-align:right;">
0.90
</td>
<td style="text-align:right;">
0.38
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
0.45
</td>
</tr>
<tr>
<td style="text-align:left;">
70%-80%
</td>
<td style="text-align:right;">
0.84
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
0.35
</td>
<td style="text-align:right;">
0.39
</td>
</tr>
<tr>
<td style="text-align:left;">
80%-90%
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
0.33
</td>
</tr>
<tr>
<td style="text-align:left;">
Top 10%
</td>
<td style="text-align:right;">
0.94
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
0.31
</td>
</tr>
</tbody>
</table>

# 

Even when you compare property types across boroughs or sale values,
DOF’s assessment of 1-3 Family homes is the only one that meets IAAO
standards.[^1]

## Uniformity and Variation of Sales Ratio

In addition to getting the median ASR (used to measure the quality of
assessments) right, we also care about how the rest of the group is
dispersed around the median, and what kind of uniformity exists when
looking at properties by other groupings (e.g. value).

The level of uniformity in ASRs is measure using the coefficient of
dispersion (COD). The COD measures the variation in assessment around
the median ASR. Whereas the ASR measures inaccuracy, the COD measures
uniformity. Estimates can be inaccurate — that is, further from market
value — but if all properties’ assessments are equally inaccurate, then
the assessments are perfectly uniform. That is, no one property is
benefiting more or less from an inaccuracy than any other property in
the same class.

The charts below depict how uniformly the ASRs of properties of the same
type are dispersed around the median ASR (red line). The first tab shows
the sales ratios among 1-3 Family homes by the sale price. The red line
is the median ratio for 1-3 Family home citywide (0.95). Based on IAAO
standards, you hope to see a uniform grouping around the median in that
0.9 - 1.1 range.

### 1-3 Family

``` r
merge_all %>% 
  filter(prop_type == "1-3 Family") %>% 
  ggplot(aes(SALE.PRICE, value.ratio, color = SALE.PRICE, alpha = 0.4)) +
  geom_point(shape = 16, size = 1, show.legend = FALSE, 
             position=position_jitter(width=.01,height=.1)) + 
  theme_economist() +
  scale_color_gradient(low = "#0091ff", high = "#f0650e", limits = c(0, 5000000)) +
  scale_x_continuous(name="Sale Price", limits=c(0, 5000000), label = dollar) +
  scale_y_continuous(name="Sales Ratio", limits=c(0, 2)) +
  geom_hline(yintercept = median(subset(merge_all, prop_type=="1-3 Family")$value.ratio), color = "Red") +
  ggtitle("1-3 Family Homes: Sales ratios by sale price")
```

![](Main_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

### Commercial/Office

``` r
merge_all %>% 
  filter(prop_type == "Commercial/Office") %>% 
  ggplot(aes(SALE.PRICE, value.ratio, color = SALE.PRICE, alpha = 0.4)) +
  geom_point(shape = 16, size = 1, show.legend = FALSE, 
             position=position_jitter(width=.01,height=.1)) + 
  theme_economist() +
  scale_color_gradient(low = "#0091ff", high = "#f0650e", limits = c(0, 10000000)) +
  scale_x_continuous(name="Sale Price", limits=c(0, 10000000), label = dollar) +
  scale_y_continuous(name="Sales Ratio", limits=c(0, 2)) +
  geom_hline(yintercept = median(subset(merge_all, prop_type=="Commercial/Office")$value.ratio),
             color = "Red") +
  ggtitle("Commercial/Office: Sales ratios by sale price")
```

![](Main_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

### Large Rentals

``` r
merge_all %>% 
  filter(prop_type == "Large Rentals") %>% 
  ggplot(aes(SALE.PRICE, value.ratio, color = SALE.PRICE, alpha = 0.4)) +
  geom_point(shape = 16, size = 1, show.legend = FALSE, 
             position=position_jitter(width=.01,height=.1)) + 
  theme_economist() +
  scale_color_gradient(low = "#0091ff", high = "#f0650e", limits = c(0, 25000000)) +
  scale_x_continuous(name="Sale Price", limits=c(0, 25000000), label = dollar) +
  scale_y_continuous(name="Sales Ratio", limits=c(0, 2)) +
  geom_hline(yintercept = median(subset(merge_all, prop_type=="Large Rentals")$value.ratio),
              color = "Red") +
  ggtitle("Large Rentals: Sales ratios by sale price")
```

![](Main_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

### Small Rentals

``` r
merge_all %>% 
  filter(prop_type == "Small Rentals") %>% 
  ggplot(aes(SALE.PRICE, value.ratio, color = SALE.PRICE, alpha = 0.4)) +
  geom_point(shape = 16, size = 1, show.legend = FALSE, 
             position=position_jitter(width=.01,height=.1)) + 
  theme_economist() +
  scale_color_gradient(low = "#0091ff", high = "#f0650e", limits = c(0, 10000000)) +
  scale_x_continuous(name="Sale Price", limits=c(0, 10000000), label = dollar) +
  scale_y_continuous(name="Sales Ratio", limits=c(0, 2)) +
  geom_hline(yintercept = median(subset(merge_all, prop_type=="Small Rentals")$value.ratio),
              color = "Red") +
  ggtitle("Small Rentals: Sales ratios by sale price")
```

![](Main_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

# 

## Coefficient of Dispersion

Per IAAO standards, acceptable CODs fall between 5.0 and 15.0 in areas
with relatively homogenous housing.

### Citywide CODs

``` r
summary_citywide %>% 
  select(prop_type, cod) %>% 
  mutate(cod = round(cod, 1)) %>% 
  pivot_wider(names_from = prop_type,
              values_from = cod) %>% 
  kbl(align = "lrrrr") %>% 
  kable_classic_2()
```

<table class=" lightable-classic-2" style="font-family: &quot;Arial Narrow&quot;, &quot;Source Sans Pro&quot;, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
1-3 Family
</th>
<th style="text-align:right;">
Commercial/Office
</th>
<th style="text-align:right;">
Large Rentals
</th>
<th style="text-align:right;">
Small Rentals
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
25.5
</td>
<td style="text-align:right;">
6.9
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
8.2
</td>
</tr>
</tbody>
</table>

### CODs by Borough

``` r
summary_boro %>% 
  select(Borough, prop_type, cod)%>% 
  mutate(cod = round(cod, 1)) %>% 
  pivot_wider(names_from = prop_type,
              values_from = cod) %>% 
  kbl(align = "lrrrr") %>% 
  kable_classic_2()
```

<table class=" lightable-classic-2" style="font-family: &quot;Arial Narrow&quot;, &quot;Source Sans Pro&quot;, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Borough
</th>
<th style="text-align:right;">
1-3 Family
</th>
<th style="text-align:right;">
Commercial/Office
</th>
<th style="text-align:right;">
Large Rentals
</th>
<th style="text-align:right;">
Small Rentals
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Brooklyn
</td>
<td style="text-align:right;">
6.6
</td>
<td style="text-align:right;">
5.5
</td>
<td style="text-align:right;">
19.3
</td>
<td style="text-align:right;">
9.7
</td>
</tr>
<tr>
<td style="text-align:left;">
Manhattan
</td>
<td style="text-align:right;">
8.1
</td>
<td style="text-align:right;">
35.1
</td>
<td style="text-align:right;">
54.0
</td>
<td style="text-align:right;">
7.8
</td>
</tr>
<tr>
<td style="text-align:left;">
Queens
</td>
<td style="text-align:right;">
50.7
</td>
<td style="text-align:right;">
2.5
</td>
<td style="text-align:right;">
41.2
</td>
<td style="text-align:right;">
7.2
</td>
</tr>
<tr>
<td style="text-align:left;">
Staten Island
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
24.8
</td>
<td style="text-align:right;">
3.2
</td>
</tr>
<tr>
<td style="text-align:left;">
The Bronx
</td>
<td style="text-align:right;">
20.1
</td>
<td style="text-align:right;">
2.4
</td>
<td style="text-align:right;">
9.9
</td>
<td style="text-align:right;">
5.7
</td>
</tr>
</tbody>
</table>

### CODs by Property Value

``` r
summary_deciles %>% 
  select(decile, prop_type, cod)%>% 
  mutate(cod = round(cod, 1)) %>% 
  mutate(decile = case_when(decile == 1 ~ "Bottom 10%", decile == 2 ~ "10%-20%", 
                            decile == 3 ~ "20%-30%", decile == 4 ~ "30%-40%",
                            decile == 5 ~ "40%-50%", decile == 6 ~ "50%-60%", 
                            decile == 7 ~ "60%-70%", decile == 8 ~"70%-80%",
                            decile == 9 ~ "80%-90%", TRUE ~ "Top 10%")) %>% 
  rename(`Sale Price` = decile) %>% 
  pivot_wider(names_from = prop_type,
              values_from = cod) %>% 
  kbl(align = "lrrrr") %>% 
  kable_classic_2()
```

<table class=" lightable-classic-2" style="font-family: &quot;Arial Narrow&quot;, &quot;Source Sans Pro&quot;, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Sale Price
</th>
<th style="text-align:right;">
1-3 Family
</th>
<th style="text-align:right;">
Commercial/Office
</th>
<th style="text-align:right;">
Large Rentals
</th>
<th style="text-align:right;">
Small Rentals
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Bottom 10%
</td>
<td style="text-align:right;">
55.8
</td>
<td style="text-align:right;">
23.1
</td>
<td style="text-align:right;">
50.7
</td>
<td style="text-align:right;">
13.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10%-20%
</td>
<td style="text-align:right;">
34.4
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
7.0
</td>
<td style="text-align:right;">
1.3
</td>
</tr>
<tr>
<td style="text-align:left;">
20%-30%
</td>
<td style="text-align:right;">
30.5
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
11.6
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
30%-40%
</td>
<td style="text-align:right;">
11.3
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
10.5
</td>
<td style="text-align:right;">
1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
40%-50%
</td>
<td style="text-align:right;">
8.0
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
14.1
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
50%-60%
</td>
<td style="text-align:right;">
3.1
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
7.7
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
60%-70%
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
17.4
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
70%-80%
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
8.2
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
80%-90%
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
1.3
</td>
</tr>
<tr>
<td style="text-align:left;">
Top 10%
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
</tbody>
</table>

# 

## Takeaways

- Sales ratios differ greatly between property types and assessment
  methods.

- Within the same property types, variation is not terrible, though
  these results are also mixed.

- Regardless of tax class or assessment method, DOF’s assessments tend
  to overvalue lower-value properties.

- Comparing DOF market values between classes should be done with
  caution.

- Converting to sales-based methods could have big effects on the way
  the property tax works.

# 

## Appendix

The tables gives a breakdown of median assessment ratios and
coefficients of dispersion by zip code.[^2]1

### Median ASR by Zip Code

``` r
summary_zip %>% 
  select(ZIP.CODE, prop_type, median_asr)%>% 
  mutate(median_asr = round(median_asr, 1)) %>% 
  pivot_wider(names_from = prop_type,
              values_from = median_asr) %>% 
  kbl(align = "lrrrr") %>% 
  kable_classic_2() %>% 
  scroll_box(width = "100%", height = "300px")
```

<div
style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; overflow-x: scroll; width:100%; ">

<table class=" lightable-classic-2" style="font-family: &quot;Arial Narrow&quot;, &quot;Source Sans Pro&quot;, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">
ZIP.CODE
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
1-3 Family
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
Commercial/Office
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
Large Rentals
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
Small Rentals
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
10001
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10002
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10003
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10004
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10005
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
10006
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10007
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10009
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10010
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10011
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10012
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10013
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10014
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10016
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10017
</td>
<td style="text-align:right;">
1.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10018
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10019
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10021
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10022
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10023
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10024
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10025
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10026
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10027
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10028
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10029
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10030
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10031
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10032
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10033
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10034
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10035
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10036
</td>
<td style="text-align:right;">
2.3
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10037
</td>
<td style="text-align:right;">
3.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10038
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10039
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10040
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10065
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10069
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
10075
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
38.8
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10128
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10301
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10302
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10303
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
12.7
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10304
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10305
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10306
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10307
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10308
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10309
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
10310
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10312
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10314
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10451
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10452
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10453
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10454
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10455
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10456
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10457
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10458
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10459
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10460
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10461
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10462
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10463
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10464
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10465
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10466
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10467
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10468
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10469
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
1.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10470
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10471
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10472
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10473
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10474
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10475
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
1.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11001
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11004
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11040
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11101
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11102
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11103
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11104
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11105
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11106
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11201
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11203
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11204
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11205
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11206
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11207
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11208
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11209
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11210
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11211
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11212
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11213
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11214
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11215
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11216
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11217
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11218
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11219
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11220
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11221
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11222
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11223
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11224
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11225
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11226
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11227
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11228
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11229
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11230
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11231
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11232
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11233
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11234
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11235
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11236
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11237
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11238
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11239
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11249
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11354
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11355
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11356
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11357
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11358
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11360
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11361
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
1.8
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11362
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11363
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11364
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11365
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
10.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11366
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11367
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11368
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11369
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11370
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11372
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11373
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11374
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11375
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11377
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11378
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11379
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11385
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11411
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11412
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11413
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11414
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11415
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11416
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11417
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11418
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11419
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11420
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11421
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11422
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11423
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11426
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11427
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11428
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11429
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11430
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11432
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11433
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11434
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11435
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11436
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11691
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11692
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11693
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
40.6
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11694
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11697
</td>
<td style="text-align:right;">
523.6
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
</tbody>
</table>

</div>

### CODs by Zip Code

``` r
summary_zip %>% 
  select(ZIP.CODE, prop_type, cod)%>% 
  mutate(cod = round(cod, 1)) %>% 
  pivot_wider(names_from = prop_type,
              values_from = cod) %>% 
  kbl(align = "lrrrr") %>% 
  kable_classic_2() %>% 
  scroll_box(width = "100%", height = "300px")
```

<div
style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; overflow-x: scroll; width:100%; ">

<table class=" lightable-classic-2" style="font-family: &quot;Arial Narrow&quot;, &quot;Source Sans Pro&quot;, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">
ZIP.CODE
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
1-3 Family
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
Commercial/Office
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
Large Rentals
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
Small Rentals
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
10001
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.4
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
9.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10002
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
2.6
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10003
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
48.3
</td>
<td style="text-align:right;">
9.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10004
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
8.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10005
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10006
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10007
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
3.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10009
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
26.2
</td>
<td style="text-align:right;">
10.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10010
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
13.5
</td>
<td style="text-align:right;">
8.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10011
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
16.0
</td>
<td style="text-align:right;">
8.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10012
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
10.5
</td>
<td style="text-align:right;">
18.3
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10013
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
4.0
</td>
<td style="text-align:right;">
3.3
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10014
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
1174.7
</td>
<td style="text-align:right;">
7.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10016
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
189.2
</td>
<td style="text-align:right;">
0.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10017
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
4.7
</td>
<td style="text-align:right;">
0.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10018
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
10.3
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10019
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
93.2
</td>
<td style="text-align:right;">
6.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10021
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
643.9
</td>
<td style="text-align:right;">
4.6
</td>
<td style="text-align:right;">
1.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10022
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
10023
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
3.3
</td>
<td style="text-align:right;">
9.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10024
</td>
<td style="text-align:right;">
5.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
27.6
</td>
<td style="text-align:right;">
3.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10025
</td>
<td style="text-align:right;">
1.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
6.2
</td>
<td style="text-align:right;">
12.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10026
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
9.2
</td>
<td style="text-align:right;">
2.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10027
</td>
<td style="text-align:right;">
2.7
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
19.2
</td>
<td style="text-align:right;">
17.1
</td>
</tr>
<tr>
<td style="text-align:left;">
10028
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
1.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10029
</td>
<td style="text-align:right;">
5.2
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
5.0
</td>
<td style="text-align:right;">
3.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10030
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
177.6
</td>
<td style="text-align:right;">
2.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10031
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
10.6
</td>
<td style="text-align:right;">
11.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10032
</td>
<td style="text-align:right;">
118.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
4.2
</td>
<td style="text-align:right;">
4.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10033
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
25.0
</td>
<td style="text-align:right;">
1.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10034
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10035
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
3.8
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
29.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10036
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
5.0
</td>
<td style="text-align:right;">
7.4
</td>
<td style="text-align:right;">
1.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10037
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
39.5
</td>
<td style="text-align:right;">
55.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10038
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
28.6
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
5.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10039
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
1.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10040
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
4.0
</td>
<td style="text-align:right;">
0.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10065
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
4.0
</td>
<td style="text-align:right;">
90.6
</td>
<td style="text-align:right;">
0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10069
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
10075
</td>
<td style="text-align:right;">
23.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
30.4
</td>
<td style="text-align:right;">
1.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10128
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
18.2
</td>
<td style="text-align:right;">
1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10301
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
2.3
</td>
<td style="text-align:right;">
6.7
</td>
<td style="text-align:right;">
1.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10302
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
2.6
</td>
<td style="text-align:right;">
1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10303
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10304
</td>
<td style="text-align:right;">
2.3
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
2.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10305
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
2.7
</td>
<td style="text-align:right;">
14.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10306
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
2.3
</td>
<td style="text-align:right;">
13.6
</td>
<td style="text-align:right;">
2.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10307
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
5.0
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10308
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10309
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
10310
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
5.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
3.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10312
</td>
<td style="text-align:right;">
1.6
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
10314
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
1.6
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
2.2
</td>
</tr>
<tr>
<td style="text-align:left;">
10451
</td>
<td style="text-align:right;">
4.6
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
2.5
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10452
</td>
<td style="text-align:right;">
1.8
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
23.2
</td>
<td style="text-align:right;">
11.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10453
</td>
<td style="text-align:right;">
5.0
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
2.7
</td>
<td style="text-align:right;">
5.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10454
</td>
<td style="text-align:right;">
6.2
</td>
<td style="text-align:right;">
2.5
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
9.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10455
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
4.5
</td>
<td style="text-align:right;">
1.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10456
</td>
<td style="text-align:right;">
3.8
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
53.8
</td>
<td style="text-align:right;">
7.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10457
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.4
</td>
<td style="text-align:right;">
3.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10458
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
5.7
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.6
</td>
</tr>
<tr>
<td style="text-align:left;">
10459
</td>
<td style="text-align:right;">
1.6
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
9.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10460
</td>
<td style="text-align:right;">
3.6
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
1.4
</td>
</tr>
<tr>
<td style="text-align:left;">
10461
</td>
<td style="text-align:right;">
1.4
</td>
<td style="text-align:right;">
11.2
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
1.1
</td>
</tr>
<tr>
<td style="text-align:left;">
10462
</td>
<td style="text-align:right;">
2.3
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10463
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
2.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10464
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10465
</td>
<td style="text-align:right;">
141.6
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
45.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10466
</td>
<td style="text-align:right;">
4.9
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
1.8
</td>
</tr>
<tr>
<td style="text-align:left;">
10467
</td>
<td style="text-align:right;">
2.5
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
50.8
</td>
<td style="text-align:right;">
4.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10468
</td>
<td style="text-align:right;">
2.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
29.3
</td>
</tr>
<tr>
<td style="text-align:left;">
10469
</td>
<td style="text-align:right;">
3.2
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
4.7
</td>
</tr>
<tr>
<td style="text-align:left;">
10470
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
2.6
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
7.9
</td>
</tr>
<tr>
<td style="text-align:left;">
10471
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
6.2
</td>
<td style="text-align:right;">
0.5
</td>
</tr>
<tr>
<td style="text-align:left;">
10472
</td>
<td style="text-align:right;">
3.8
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
9.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10473
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
5.0
</td>
</tr>
<tr>
<td style="text-align:left;">
10474
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
7.2
</td>
<td style="text-align:right;">
0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
10475
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11001
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11004
</td>
<td style="text-align:right;">
1.6
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11040
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11101
</td>
<td style="text-align:right;">
3.3
</td>
<td style="text-align:right;">
4.0
</td>
<td style="text-align:right;">
9.7
</td>
<td style="text-align:right;">
1.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11102
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
4.0
</td>
<td style="text-align:right;">
3.2
</td>
<td style="text-align:right;">
9.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11103
</td>
<td style="text-align:right;">
12.6
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
4.2
</td>
<td style="text-align:right;">
4.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11104
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
3.8
</td>
<td style="text-align:right;">
10.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11105
</td>
<td style="text-align:right;">
4.7
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
14.0
</td>
<td style="text-align:right;">
2.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11106
</td>
<td style="text-align:right;">
2.2
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
18.8
</td>
<td style="text-align:right;">
2.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11201
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
4.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11203
</td>
<td style="text-align:right;">
6.1
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
7.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11204
</td>
<td style="text-align:right;">
5.3
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
13.5
</td>
<td style="text-align:right;">
4.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11205
</td>
<td style="text-align:right;">
2.5
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
10.7
</td>
<td style="text-align:right;">
14.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11206
</td>
<td style="text-align:right;">
29.2
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
3.5
</td>
<td style="text-align:right;">
11.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11207
</td>
<td style="text-align:right;">
8.7
</td>
<td style="text-align:right;">
9.7
</td>
<td style="text-align:right;">
4.8
</td>
<td style="text-align:right;">
8.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11208
</td>
<td style="text-align:right;">
3.8
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
8.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11209
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
1.6
</td>
<td style="text-align:right;">
3.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11210
</td>
<td style="text-align:right;">
3.9
</td>
<td style="text-align:right;">
2.4
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
2.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11211
</td>
<td style="text-align:right;">
2.7
</td>
<td style="text-align:right;">
12.6
</td>
<td style="text-align:right;">
6.0
</td>
<td style="text-align:right;">
10.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11212
</td>
<td style="text-align:right;">
6.2
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
15.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11213
</td>
<td style="text-align:right;">
11.9
</td>
<td style="text-align:right;">
2.4
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
6.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11214
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
4.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11215
</td>
<td style="text-align:right;">
2.9
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
13.1
</td>
<td style="text-align:right;">
25.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11216
</td>
<td style="text-align:right;">
32.6
</td>
<td style="text-align:right;">
20.9
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
24.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11217
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
25.4
</td>
<td style="text-align:right;">
12.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11218
</td>
<td style="text-align:right;">
3.1
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
8.5
</td>
<td style="text-align:right;">
3.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11219
</td>
<td style="text-align:right;">
5.3
</td>
<td style="text-align:right;">
1.4
</td>
<td style="text-align:right;">
6.8
</td>
<td style="text-align:right;">
7.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11220
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
7.9
</td>
<td style="text-align:right;">
4.9
</td>
<td style="text-align:right;">
7.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11221
</td>
<td style="text-align:right;">
9.2
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
4.5
</td>
<td style="text-align:right;">
17.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11222
</td>
<td style="text-align:right;">
1.8
</td>
<td style="text-align:right;">
4.4
</td>
<td style="text-align:right;">
9.6
</td>
<td style="text-align:right;">
4.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11223
</td>
<td style="text-align:right;">
5.4
</td>
<td style="text-align:right;">
2.9
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11224
</td>
<td style="text-align:right;">
2.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
13.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11225
</td>
<td style="text-align:right;">
5.2
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
151.2
</td>
<td style="text-align:right;">
6.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11226
</td>
<td style="text-align:right;">
6.9
</td>
<td style="text-align:right;">
9.3
</td>
<td style="text-align:right;">
3.6
</td>
<td style="text-align:right;">
1.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11227
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11228
</td>
<td style="text-align:right;">
3.3
</td>
<td style="text-align:right;">
3.1
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
1.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11229
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
12.0
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11230
</td>
<td style="text-align:right;">
13.2
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
6.7
</td>
<td style="text-align:right;">
1.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11231
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
254.3
</td>
<td style="text-align:right;">
12.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11232
</td>
<td style="text-align:right;">
12.5
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
19.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11233
</td>
<td style="text-align:right;">
8.5
</td>
<td style="text-align:right;">
1.6
</td>
<td style="text-align:right;">
47.7
</td>
<td style="text-align:right;">
9.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11234
</td>
<td style="text-align:right;">
4.7
</td>
<td style="text-align:right;">
12.4
</td>
<td style="text-align:right;">
62.2
</td>
<td style="text-align:right;">
0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11235
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
12.8
</td>
<td style="text-align:right;">
2.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11236
</td>
<td style="text-align:right;">
5.6
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
3.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11237
</td>
<td style="text-align:right;">
1.8
</td>
<td style="text-align:right;">
3.4
</td>
<td style="text-align:right;">
5.3
</td>
<td style="text-align:right;">
4.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11238
</td>
<td style="text-align:right;">
63.7
</td>
<td style="text-align:right;">
2.2
</td>
<td style="text-align:right;">
4.9
</td>
<td style="text-align:right;">
29.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11239
</td>
<td style="text-align:right;">
8.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11249
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
3.4
</td>
<td style="text-align:right;">
5.1
</td>
<td style="text-align:right;">
6.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11354
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
7.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11355
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
4.6
</td>
<td style="text-align:right;">
21.3
</td>
<td style="text-align:right;">
1.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11356
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
6.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11357
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
2.3
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
6.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11358
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
15.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11360
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11361
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
6.5
</td>
<td style="text-align:right;">
15.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11362
</td>
<td style="text-align:right;">
3.6
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11363
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11364
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11365
</td>
<td style="text-align:right;">
0.6
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
2.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11366
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
11.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11367
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11368
</td>
<td style="text-align:right;">
34.7
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
3.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11369
</td>
<td style="text-align:right;">
12.5
</td>
<td style="text-align:right;">
6.6
</td>
<td style="text-align:right;">
0.2
</td>
<td style="text-align:right;">
14.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11370
</td>
<td style="text-align:right;">
5.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
9.3
</td>
</tr>
<tr>
<td style="text-align:left;">
11372
</td>
<td style="text-align:right;">
1.5
</td>
<td style="text-align:right;">
3.5
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
9.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11373
</td>
<td style="text-align:right;">
2.8
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
46.0
</td>
<td style="text-align:right;">
8.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11374
</td>
<td style="text-align:right;">
5.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
15.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11375
</td>
<td style="text-align:right;">
3.1
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
2.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11377
</td>
<td style="text-align:right;">
2.2
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
4.7
</td>
<td style="text-align:right;">
7.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11378
</td>
<td style="text-align:right;">
0.5
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
6.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11379
</td>
<td style="text-align:right;">
2.3
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11385
</td>
<td style="text-align:right;">
5.2
</td>
<td style="text-align:right;">
1.3
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
5.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11411
</td>
<td style="text-align:right;">
5.6
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11412
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
5.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11413
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
2.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11414
</td>
<td style="text-align:right;">
6.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11415
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
86.7
</td>
<td style="text-align:right;">
0.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11416
</td>
<td style="text-align:right;">
5.8
</td>
<td style="text-align:right;">
0.3
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
22.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11417
</td>
<td style="text-align:right;">
10.0
</td>
<td style="text-align:right;">
0.7
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
16.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11418
</td>
<td style="text-align:right;">
1.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
3.8
</td>
<td style="text-align:right;">
3.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11419
</td>
<td style="text-align:right;">
2.8
</td>
<td style="text-align:right;">
1.7
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
17.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11420
</td>
<td style="text-align:right;">
2.6
</td>
<td style="text-align:right;">
4.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
9.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11421
</td>
<td style="text-align:right;">
3.1
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
5.8
</td>
<td style="text-align:right;">
4.0
</td>
</tr>
<tr>
<td style="text-align:left;">
11422
</td>
<td style="text-align:right;">
2.3
</td>
<td style="text-align:right;">
1.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11423
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
3.5
</td>
<td style="text-align:right;">
4.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11426
</td>
<td style="text-align:right;">
2.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11427
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
0.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11428
</td>
<td style="text-align:right;">
5.7
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
2.8
</td>
</tr>
<tr>
<td style="text-align:left;">
11429
</td>
<td style="text-align:right;">
5.2
</td>
<td style="text-align:right;">
0.1
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
8.5
</td>
</tr>
<tr>
<td style="text-align:left;">
11430
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
11432
</td>
<td style="text-align:right;">
2.6
</td>
<td style="text-align:right;">
1.9
</td>
<td style="text-align:right;">
113.3
</td>
<td style="text-align:right;">
1.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11433
</td>
<td style="text-align:right;">
3.1
</td>
<td style="text-align:right;">
2.7
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
5.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11434
</td>
<td style="text-align:right;">
2.2
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
1.4
</td>
</tr>
<tr>
<td style="text-align:left;">
11435
</td>
<td style="text-align:right;">
3.1
</td>
<td style="text-align:right;">
1.2
</td>
<td style="text-align:right;">
21.4
</td>
<td style="text-align:right;">
4.2
</td>
</tr>
<tr>
<td style="text-align:left;">
11436
</td>
<td style="text-align:right;">
4.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
7.6
</td>
</tr>
<tr>
<td style="text-align:left;">
11691
</td>
<td style="text-align:right;">
2.4
</td>
<td style="text-align:right;">
4.8
</td>
<td style="text-align:right;">
2.8
</td>
<td style="text-align:right;">
19.1
</td>
</tr>
<tr>
<td style="text-align:left;">
11692
</td>
<td style="text-align:right;">
2.1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11693
</td>
<td style="text-align:right;">
4.9
</td>
<td style="text-align:right;">
0.8
</td>
<td style="text-align:right;">
2.6
</td>
<td style="text-align:right;">
0.9
</td>
</tr>
<tr>
<td style="text-align:left;">
11694
</td>
<td style="text-align:right;">
4.2
</td>
<td style="text-align:right;">
0.4
</td>
<td style="text-align:right;">
2.4
</td>
<td style="text-align:right;">
6.7
</td>
</tr>
<tr>
<td style="text-align:left;">
11697
</td>
<td style="text-align:right;">
0.0
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
</tr>
</tbody>
</table>

</div>

[^1]: Caveat – the extremes on the low end may be due to outliers.
    Proxies for arms-length transactions not perfect. Even so, just
    looking at the middle 80 percent the trend is there

[^2]: NAs imply there are not any sales in the zip code to calculate
    Median ASR or COD
