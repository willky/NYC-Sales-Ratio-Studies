library(foreign)
library(reshape)
library(tidyverse)
library(scales)
library(haven)
library(rgdal)
library(ggplot2)
library(plotly)
library(lubridate)

######################################## SALES ########################################

# load DoF Sales Data 2018

sales_13to17 <- read.csv("./Data/annualized sales data 2013-2017.csv") 

sales_13to17 <- sales_13to17 %>% 
  mutate(SALE.DATE = as.Date(sales_13to17$SALE.DATE, origin = "1899-12-30"),
         year = year(SALE.DATE)) %>% 
  select(-SALE.DATE)


sales_18 <- 
  read.csv(paste("./Data/sales_data_2018.csv", sep = ""),
                       header = TRUE, sep = ",") %>% 
  mutate(year = 2018) %>% 
  select(-SALE.DATE)


# Combine the data sets and clean environments

sales_orig <- rbind(sales_13to17, sales_18)

names(sales_orig)
count(sales_orig, year)


rm(sales_13to17, sales_18)


#### do some initial cleaning of sales data ####

## Remove the columns we don't need

# columns either have duplicates in another dataset, are unreliable, or both
todrop <- c("LAND.SQUARE.FEET", "GROSS.SQUARE.FEET",
            "RESIDENTIAL.UNITS", "COMMERCIAL.UNITS", "TOTAL.UNITS",
            "YEAR.BUILT")

sales_orig <- sales_orig[,!names(sales_orig) %in% todrop]


### Re-format some variables

sales_orig <- sales_orig %>% 
  mutate(TAX.CLASS.AT.PRESENT = trimws(TAX.CLASS.AT.PRESENT),
         BUILDING.CLASS.CATEGORY = trimws(BUILDING.CLASS.CATEGORY),
         BBLE = trimws(BBLE)
        )


# Has tax class changed for any property since it was sold?

sum(sales_orig$TAX.CLASS.AT.PRESENT != sales_orig$TAX.CLASS.AT.TIME.OF.SALE)      #34,409 of them

sales_orig %>% 
  filter(TAX.CLASS.AT.PRESENT != TAX.CLASS.AT.TIME.OF.SALE) %>% View()



### check for arm's length threshold and drop "giveaways"
# Check range of prices

sales_orig %>% 
  mutate(TAX.CLASS.AT.PRESENT = trimws(TAX.CLASS.AT.PRESENT)) %>% 
  group_by(TAX.CLASS.AT.PRESENT) %>% 
  summarise(MIN = min(SALE.PRICE),
            MAX = max(SALE.PRICE))


# set arms length transaction for TC4 = $30K; all others at $10K

sales_orig <- sales_orig %>% 
  mutate(TAX.CLASS.AT.PRESENT = trimws(TAX.CLASS.AT.PRESENT)) %>%
  filter(case_when(
    substr(TAX.CLASS.AT.PRESENT, 1, 1) == "4" ~ SALE.PRICE > 30000,
    TRUE ~ SALE.PRICE > 10000
                  )
        )


######################################## RPAD ########################################

########## Load RPAD Data

# 2014
rpad_14 <- 
  read.spss("./Data/RPAD_2014.sav", to.data.frame=TRUE) %>% 
  mutate(year = 2013)

# 2015
rpad_15 <- 
  read.spss("./Data/RPAD_2015.sav", to.data.frame=TRUE) %>% 
  mutate(year = 2014) %>% 
  select(-c("tav14", "aav14", "bav14", "tav15", "aav15", "bav15"))

# 2016
rpad_16 <- 
  read.spss("./Data/RPAD_2016.sav", to.data.frame=TRUE) %>% 
  mutate(year = 2015)

# 2017
rpad_17 <- 
  read.spss("./Data/RPAD_2017.sav", to.data.frame=TRUE) %>% 
  mutate(year = 2016)

# 2018
rpad_18 <- 
  read.spss("./Data/RPAD_2018.sav", to.data.frame=TRUE) %>% 
  mutate(year = 2017)

# 2019
rpad_19 <- 
  read.spss("./Data/RPAD_2019.sav", to.data.frame=TRUE) %>% 
  mutate(year = 2018)


# Combine them into one and clean environment

rpad <- rbind(rpad_14, rpad_15, rpad_16,
              rpad_17, rpad_18, rpad_19)


rm(rpad_14, rpad_15, rpad_16,
   rpad_17, rpad_18, rpad_19)


# Set and drop unwanted columns

rpaddrop <- c("CUR_FV_L", "NEW_FV_L",
              "FV_CHGDT", "CURAVL", "CURAVL_A",
              "CHGDT", "TN_AVL", "TN_AVL_A", "FCHGDT",
              "FN_AVL", "FN_AVL_A", "O_TXCL", "CBN_TXCL",
              "LFRT_DEC", "LDEP_DEC", "L_ACRE", "YRB_FLAG", "YRB_RNG",
              "YRA1", "YRA1_RNG", "YRA2", "YRA2_RNG", "LIMIT", "O_LIMIT",
              "STATUS1", "STATUS2", "NEWLOT", "DROPLOT", "DELCHG", "CORCHG", "PROTEST", 
              "PROTEST2", "EX_CHGDT", "DCHGDT", "SM_CHGDT", "tav14", "aav14", "bav14", "tav15",
              "aav15", "bav15", "YEAR4", "EASE", "CUREXL", "CUREXT", "CURAVT_A", "CUREXL_A", "CUREXT_A",
              "EXMTCL", "OWNER", "HNUM_LO", "HNUM_HI", "STR_NAME", "ZIP", "IRREG", "BFRT_DEC", "BDEP_DEC",
              "BLD_VAR", "EXT", "CORNER", "LND_AREA", "GR_SQFT", "ZONING", "YRB", "CP_BORO", "CP_DIST", "NODESC",
              "NOAV", "VALREF", "MBLDG", "CONDO_S1", "CONDO_S2", "CONDO_S3", "CONDO_A", "COMINT_L", "COMINT_B", 
              "APTNO", "AP_BORO", "AP_BLOCK", "AP_LOT", "AP_EASE", "AP_DATE", "AP_TIME", "AT_GRP", "APPLIC", "AT_GRP2",
              "APPLIC2", "O_PROTST", "O_AT_GRP", "O_APPLIC", "REUC", "GEO_RC", "EX_INDS", "EX_COUNT")


rpad <- rpad[,!names(rpad) %in% rpaddrop]



#### clean the massive, unmanageable merged rpad frame ####

count(rpad, TXCL)
count(rpad, year)

# First, clean tax classes and remove class 3s

rpad <- rpad %>%
  mutate(TXCL = trimws(TXCL)) %>% 
  filter(substr(TXCL, 1, 1) %in% c("1", "2", "4"))


# drop remaining rows with a market value of below 1000 (many are 0)

rpad <- rpad %>% filter(NEW_FV_T > 1000)


count(rpad, TXCL) 
count(rpad, year)


### Re-format some variables

rpad <- rpad %>% 
  mutate(BBLE = trimws(BBLE),
         BLDGCL = trimws(BLDGCL)
  )

######################################## Merge RPAD & Sales ######################################## 


# Check data types for columns that will be used for the join

rpad %>% select(BORO, BLOCK, LOT, BBLE, year) %>% str()

sales_orig %>% select(BOROUGH, BLOCK, LOT, BBLE, year) %>% str()

# Ensure variables used for merge are consistent in both data sets. do the following:
#1. In sales data, change column name from 'BOROUGH' to 'BORO'.
#2. For sales data, convert data types for BOROUGH, BLOCK & LOT from integer to numeric

sales_orig <-
  sales_orig %>% 
  mutate(BORO = as.numeric(BOROUGH),
         BLOCK = as.numeric(BLOCK),
         LOT = as.numeric(LOT),
         BBLE = as.character(trimws(BBLE))) %>% 
  select(-BOROUGH)


########## join sales & RPAD ##############
## In joining, I create 3 data subsets - TC1, rentals and TC4

# 1) TC1: We want most recent sale prices & mkt values 
# so I use 2018 sales and 2019 RPAD data for the join

merge_TC1 <- 
  inner_join(
            (sales_orig %>% 
               filter(year == 2018 &
                      substr(TAX.CLASS.AT.PRESENT, 1, 1) == "1")
            ),
            (rpad %>% 
               filter(year == 2018 &
                      substr(TXCL, 1, 1) == "1")
            )
  )


# check and exclude any unwanted builiding classes

count(merge_TC1, TXCL)
count(merge_TC1, BLDGCL)

merge_TC1 <- merge_TC1 %>% 
  mutate(BLDGCL = trimws(BLDGCL)) %>% 
  filter(substr(BLDGCL,1,1) %in% c("A", "B", "C", "S")
  )


## 2) Rentals Join

merge_rentals <- 
  inner_join(
          (sales_orig %>%
             filter(grepl('RENTAL', BUILDING.CLASS.CATEGORY) &
                    !grepl('CONDO', BUILDING.CLASS.CATEGORY))
           ),
          (rpad %>% 
             mutate(BBLE = trimws((BBLE))) %>% 
             filter(substr(TXCL, 1, 1) == "2")
             )
                    )


# check and exclude any unwanted tax and building classes

count(merge_rentals, BLDGCL)
count(merge_rentals, TXCL)            #All look good


## 3) TC4 Join
# Why exclude RES_UNIT?>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

merge_TC4 <- 
  inner_join(
    (sales_orig %>% 
       filter(substr(TAX.CLASS.AT.PRESENT, 1, 1) == "4")
    ),
    (rpad %>% 
       filter(substr(TXCL, 1, 1) == "4" &
              RES_UNIT > 0)
    )
  )


# check and exclude any unwanted builiding classes

count(merge_TC4, TXCL)
count(merge_TC4, BLDGCL)          #Exclude those unwanted

merge_TC4 <- merge_TC4 %>% 
  filter(substr(BLDGCL,1,1) %in% c("C", "D", "E", "L", "K", "O", "RA", "RB",
                                   "RK", "RR", "RW", "R5", "S4", "S5")
  )


## Merge all three into one big ugly and clean environment

merge_all <- rbind(merge_TC1, merge_rentals, merge_TC4)


rm(merge_TC1, merge_rentals, merge_TC4, rpad, sales_orig,
   rpaddrop, todrop)


### Group the tax classes into 4 main categories; 
# 1) 1-3 Family, 2)Small Rentals, 3) Large Rentals, 4) Commercial/Office

count(merge_all, TXCL)

merge_all <- merge_all %>% 
  mutate(prop_type = 
           case_when(
                substr(TXCL, 1, 1) == "1" ~ "1-3 Family",
                TXCL %in% c("2A", "2B") ~ "Small Rentals",
                TXCL == "2" ~ "Large Rentals",
                TXCL == "4" ~ "Commercial/Office")
        )


count(merge_all, prop_type)


## Create a column with Borough names

merge_all <- merge_all %>% 
  mutate(Borough = case_when(
    BORO == 1 ~ "Manhattan", BORO ==2 ~ "The Bronx", BORO == 3 ~ "Brooklyn",
    BORO == 4 ~ "Queens", BORO == 5 ~ "Staten Island"
  ))

######################## SALES RATIO STATS ############################## 

## Counts, distributions, medians ## 
count(merge_all, Borough) 

### Calculate 1) assessment ratios, 2) DOF mkt value to sale price, and 
# 3) diff between DOF mkt value and sales price

#NEW_FV_T is the full "market value" of property
#FN_AVT_A is Final Actual Assessed Total Value

range(merge_all$FN_AVT_A)
range(merge_all$NEW_FV_T)

merge_all <- merge_all %>% 
  mutate(assess.ratio = FN_AVT_A / NEW_FV_T,
         value.ratio = NEW_FV_T / SALE.PRICE,
         dofva = abs(NEW_FV_T - SALE.PRICE))


summary(merge_all$assess.ratio)
summary(merge_all$value.ratio)
summary(merge_all$dofva) 


## Citywide Summary: Sales Ratio Statistics

summary_citywide <- merge_all %>% 
  group_by(prop_type) %>% 
  summarise(N = n(),
            dof_value_sum = sum(NEW_FV_T),
            saleprice_sum = sum(SALE.PRICE),
            mean_asr = mean(value.ratio),
            median_asr = median(value.ratio),
            std_dev = sd(value.ratio),
            std_error = sd(value.ratio, na.rm=TRUE)/sqrt(length(value.ratio[!is.na(value.ratio)])),
            cod = (abs(mean(value.ratio-median(value.ratio)))/median(value.ratio))*10,
            prd = mean(SALE.PRICE/weighted.mean(SALE.PRICE, NEW_FV_T))
            ) 

## Borough Summary: Sales Ratio Statistics ##

summary_boro <- merge_all %>%
  group_by(Borough, prop_type) %>% 
  summarise(N = n(),
            dof_value_sum = sum(NEW_FV_T),
            saleprice_sum = sum(SALE.PRICE),
            mean_asr = mean(value.ratio),
            median_asr = median(value.ratio),
            std_dev = sd(value.ratio),
            std_error = sd(value.ratio, na.rm=TRUE)/sqrt(length(value.ratio[!is.na(value.ratio)])),
            cod = (abs(mean(value.ratio-median(value.ratio)))/median(value.ratio))*10,
            prd = mean(SALE.PRICE/weighted.mean(SALE.PRICE, NEW_FV_T))
            ) 


summary_boro %>% 
  select(Borough, prop_type, cod) %>% 
  pivot_wider(names_from = prop_type,
              values_from = cod)


## Zip Code Summary: Sales Ratio Statistics ## 

class(merge_all$ZIP.CODE)
range(merge_all$ZIP.CODE)         #1,045 props have zip code of '0'. Exclude them
count(merge_all, ZIP.CODE)

summary_zip <- merge_all %>%
  filter(ZIP.CODE != 0) %>% 
  group_by(ZIP.CODE, prop_type) %>% 
  summarise(N = n(),
            dof_value_sum = sum(NEW_FV_T),
            saleprice_sum = sum(SALE.PRICE),
            mean_asr = mean(value.ratio),
            median_asr = median(value.ratio),
            std_dev = sd(value.ratio),
            std_error = sd(value.ratio, na.rm=TRUE)/sqrt(length(value.ratio[!is.na(value.ratio)])),
            cod = (abs(mean(value.ratio-median(value.ratio)))/median(value.ratio))*10,
            prd = mean(SALE.PRICE/weighted.mean(SALE.PRICE, NEW_FV_T))
            )


## Quartiles Summary: Sales Ratio Statistics ## 

summary_quartiles <- merge_all %>%
  mutate(quartile = ntile(SALE.PRICE, 4)) %>% 
  group_by(quartile, prop_type) %>% 
  summarise(N = n(),
            dof_value_sum = sum(NEW_FV_T),
            saleprice_sum = sum(SALE.PRICE),
            mean_asr = mean(value.ratio),
            median_asr = median(value.ratio),
            std_dev = sd(value.ratio),
            std_error = sd(value.ratio, na.rm=TRUE)/sqrt(length(value.ratio[!is.na(value.ratio)])),
            cod = (abs(mean(value.ratio-median(value.ratio)))/median(value.ratio))*10,
            prd = mean(SALE.PRICE/weighted.mean(SALE.PRICE, NEW_FV_T))
            )


## Deciles Summary: Sales Ratio Statistics ##  

summary_deciles <- merge_all %>%
  mutate(decile = ntile(SALE.PRICE, 10)) %>% 
  group_by(decile, prop_type) %>% 
  summarise(N = n(),
            dof_value_sum = sum(NEW_FV_T),
            saleprice_sum = sum(SALE.PRICE),
            mean_asr = mean(value.ratio),
            median_asr = median(value.ratio),
            std_dev = sd(value.ratio),
            std_error = sd(value.ratio, na.rm=TRUE)/sqrt(length(value.ratio[!is.na(value.ratio)])),
            cod = (abs(mean(value.ratio-median(value.ratio)))/median(value.ratio))*10,
            prd = mean(SALE.PRICE/weighted.mean(SALE.PRICE, NEW_FV_T))
            )


############## Graphs #############################

# value_plot <- ggplot(merge_all, aes(x=decile, y=value.ratio)) + 
#  geom_point(shape=18, color="blue")+
#  geom_smooth(method=lm,  linetype="dashed",
#  color="darkred", fill="blue")
# value_plot

library(ggplot2)
library(fields)
library(scales)   

merge_all$density <- fields::interp.surface(
  MASS::kde2d(merge_all$SALE.PRICE, merge_all$value.ratio), merge_all[,c("SALE.PRICE", "value.ratio")])

merge_all$pc <- predict(prcomp(~ value.ratio + SALE.PRICE, merge_all))[,1]


### Graph: 1-3 Family

merge_all %>% filter(prop_type == "1-3 Family") %>% 
ggplot(aes(SALE.PRICE, value.ratio, color = SALE.PRICE, alpha = 0.4)) +
  geom_point(shape = 16, size = 1, show.legend = FALSE, position=position_jitter(width=.01,height=.1)) + 
  theme_minimal() +
  scale_color_gradient(low = "#0091ff", high = "#f0650e", limits = c(0, 5000000)) +
  scale_x_continuous(name="Sale Price", limits=c(0, 5000000), label = dollar) +
  scale_y_continuous(name="Sales Ratio", limits=c(0, 2)) +
  geom_hline(yintercept = median(subset(merge_all, prop_type=="1-3 Family")$value.ratio)) +
  ggtitle("1-3 Family Homes: Sales ratios by sale price")


### Graph: Large Rentals

merge_all %>% filter(prop_type == "Large Rentals") %>% 
  ggplot(aes(SALE.PRICE, value.ratio, color = SALE.PRICE, alpha = 0.4)) +
  geom_point(shape = 16, size = 1, show.legend = FALSE, position=position_jitter(width=.01,height=.1)) + 
  theme_minimal() +
  scale_color_gradient(low = "#0091ff", high = "#f0650e", limits = c(0, 25000000)) +
  scale_x_continuous(name="Sale Price", limits=c(0, 25000000), label = dollar) +
  scale_y_continuous(name="Sales Ratio", limits=c(0, 2)) +
  geom_hline(yintercept = median(subset(merge_all, prop_type=="Large Rentals")$value.ratio)) +
  ggtitle("Large Rentals: Sales ratios by sale price")


### Graph: Small Rentals

merge_all %>% filter(prop_type == "Small Rentals") %>% 
  ggplot(aes(SALE.PRICE, value.ratio, color = SALE.PRICE, alpha = 0.4)) +
  geom_point(shape = 16, size = 1, show.legend = FALSE, position=position_jitter(width=.01,height=.1)) + 
  theme_minimal() +
  scale_color_gradient(low = "#0091ff", high = "#f0650e", limits = c(0, 10000000)) +
  scale_x_continuous(name="Sale Price", limits=c(0, 10000000), label = dollar) +
  scale_y_continuous(name="Sales Ratio", limits=c(0, 2)) +
  geom_hline(yintercept = median(subset(merge_all, prop_type=="Small Rentals")$value.ratio)) +
  ggtitle("Small Rentals: Sales ratios by sale price")


### Graph: Commercial/Office

merge_all %>% filter(prop_type == "Commercial/Office") %>% 
  ggplot(aes(SALE.PRICE, value.ratio, color = SALE.PRICE, alpha = 0.4)) +
  geom_point(shape = 16, size = 1, show.legend = FALSE, position=position_jitter(width=.01,height=.1)) + 
  theme_minimal() +
  scale_color_gradient(low = "#0091ff", high = "#f0650e", limits = c(0, 10000000)) +
  scale_x_continuous(name="Sale Price", limits=c(0, 10000000), label = dollar) +
  scale_y_continuous(name="Sales Ratio", limits=c(0, 2)) +
  geom_hline(yintercept = median(subset(merge_all, prop_type=="Commercial/Office")$value.ratio)) +
  ggtitle("Commercial/Office: Sales ratios by sale price")


## Save objects 

save.image("./R Environments/objects_all.RData")
