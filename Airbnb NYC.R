library(jsonlite) 
library(WDI) 
library(censusapi) 
library(plyr) 
library(dplyr) 
library(tidyr) 
library(stringr) 
library(readr) 
library(readxl) 
library(writexl) 
library(ggplot2) 
library(dplyr) 
library(ggmap)
library(sf)

setwd("D:/University/Taiwan/NCCU/About courses/junior/Big data analysis/Final Project")

###########################################################################
########import data#######################################################
airbnb_df <- read.csv("Airbnb_Open_Data.csv") #102599 obs
gender_df <- read.csv("Names.csv") #57582 obs

###########################################################################
#######data cleaning#######################################################
#convert all the host's names into lower case 
airbnb_df <- airbnb_df|>
  mutate(host.name = tolower(host.name))

#convert all the baby names into lower case
colnames(gender_df)[4] <- "names"
gender_df <- gender_df|>
  mutate(names = tolower(names))

# Make list of male and female names (temporary name list)
male_names <- gender_df$names[gender_df$Gender == "MALE"] #29402 obs
female_names <- gender_df$names[gender_df$Gender == "FEMALE"] #28180 obs

# Remove neuter names (final name list)
common_names <- intersect(male_names, female_names) #36 obs
unique_male_names <- setdiff(male_names, common_names) #1041 obs
unique_female_names <- setdiff(female_names, common_names) #861 obs

# Add Gender column to "airbnb_df"
airbnb_df <- airbnb_df %>%
  mutate(Gender = ifelse(host.name %in% unique_male_names, "Male",
                         ifelse(host.name %in% unique_female_names, "Female", NA)))
# Change Male to 1, Female to 0
airbnb_df  <- airbnb_df |>
  mutate(Gender = ifelse(Gender == "Male", 1, 0))

# Delete house rule and license because we are not gonna use it and most of the obs didn't have it
airbnb_df <- airbnb_df|>
  select(-c(house_rules, license)) #10599 obs

#delete all of the blank space and NA values
airbnb_df2 <- airbnb_df
airbnb_df2[airbnb_df2 == ""] <- NA  
airbnb_df2 <- na.omit(airbnb_df2) #there are 41,379 obs left
sum(is.na(airbnb_df2)) #result = 0  

#change price into numeric values, get rid of $
airbnb_df2$price <- gsub("\\$", "", airbnb_df2$price)
airbnb_df2$service.fee <- gsub("\\$", "", airbnb_df2$service.fee)

#get rid of , in the price
airbnb_df2$price <- gsub(",", "", airbnb_df2$price)
airbnb_df2$service.fee <- gsub(",", "", airbnb_df2$service.fee)

#convert all of the numbers into numerical values
cols_to_convert <- c(15,16,17,18,19,21,22,23,24)
airbnb_df2[, cols_to_convert] <- lapply(airbnb_df2[, cols_to_convert], as.numeric)
class(airbnb_df2$price) #test

#create building_age: 2024 - Construction.year
airbnb_df2 <- airbnb_df2|>
  mutate(building_age = 2024-Construction.year)

##########################################################################
######analysis############################################################

#price, review.rate.number, number.of.reviews, etc are skewed, so we will use log function
df <- airbnb_df2
df$ln_price <- log(df$price)
df$ln_review.rate <- log(df$review.rate.number)
df$ln_number.of.review <- log(df$number.of.review)
df$ln_service.fee <- log(df$service.fee)
df$ln_minimum.nights <- log(df$minimum.nights)
df$ln_building_age <- log(df$building_age)

# [model1] DV = price 
model1 <- lm(ln_price ~ Gender + neighbourhood.group 
               + room.type + host_identity_verified + instant_bookable 
               + cancellation_policy + ln_building_age + ln_minimum.nights + ln_service.fee 
               + calculated.host.listings.count + availability.365, data = df )
summary(model1)

# [model2] DV = review.rate.number
model2 <- lm(ln_review.rate ~ Gender + neighbourhood.group 
             + room.type + host_identity_verified + instant_bookable 
             + cancellation_policy + ln_building_age + ln_minimum.nights + ln_service.fee
             + calculated.host.listings.count + availability.365, data = df )
summary(model2)

# [model3] DV =  number.of.reviews
model3 <- lm(ln_number.of.review ~ Gender + neighbourhood.group 
             + room.type + host_identity_verified + instant_bookable 
             + cancellation_policy + ln_building_age + ln_minimum.nights + ln_service.fee
             + calculated.host.listings.count + availability.365, data = df )
summary(model3)


##########################################################################
######visualization#######################################################
# Function to create bar chart for coefficients
create_coefficient_bar_chart <- function(data, x_var, y_var, title) {
  ggplot(data, aes(x = reorder({{x_var}}, {{y_var}}), y = {{y_var}})) +
    geom_bar(stat = "identity", fill = "red", color = "black") +
    labs(x = "", y = "Coefficient", title = title) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
} 
#model 1: price VS. Service fee
lm_price_service <- lm(ln_price ~ ln_service.fee , data = df)
# Extract coefficients from the regression model
coefficients_price_service <- coef(lm_price_service)
# Prepare data for bar chart
bar_data_price_service <- data.frame(
  ln_service.fee = names(coefficients_price_service)[-1],  # Exclude intercept
  Coefficient = coefficients_price_service[-1]  # Exclude intercept
)
# Plot bar chart using the function
create_coefficient_bar_chart(bar_data_price_service, ln_service.fee, Coefficient, "Price vs. Service Fee Coefficients")

#model2: review.rate.number VS calculated.host.listings.count
lm_review.rate_calculated.host <- lm(ln_review.rate ~ calculated.host.listings.count , data = df)
# Extract coefficients from the regression model
coefficients_review.rate_calculated.host <- coef(lm_review.rate_calculated.host)
# Prepare data for bar chart
bar_data_review.rate_calculated.host <- data.frame(
  calculated.host.listings.count = names(coefficients_review.rate_calculated.host)[-1],  # Exclude intercept
  Coefficient = coefficients_review.rate_calculated.host[-1]  # Exclude intercept
)
# Plot bar chart using the function
create_coefficient_bar_chart(bar_data_review.rate_calculated.host, calculated.host.listings.count, Coefficient, "Review rate vs. Calculated Host Listings")

#model2: review.rate.number VS availability.365 
lm_review.rate_availability.365  <- lm(ln_review.rate ~ availability.365 , data = df)
# Extract coefficients from the regression model
coefficients_review.rate_availability.365 <- coef(lm_review.rate_availability.365)
# Prepare data for bar chart
bar_data_review.rate_availability.365 <- data.frame(
  availability.365 = names(coefficients_review.rate_availability.365)[-1],  # Exclude intercept
  Coefficient = coefficients_review.rate_availability.365[-1]  # Exclude intercept
)
# Plot bar chart using the function
create_coefficient_bar_chart(bar_data_review.rate_availability.365, availability.365, Coefficient, "Review rate vs. Availability.365")


#model3: number.of.review VS Gender
lm_number.of.review_gender  <- lm(ln_number.of.review ~ Gender , data = df)
# Extract coefficients from the regression model
coefficients_number.of.review_gender <- coef(lm_number.of.review_gender)
# Prepare data for bar chart
bar_data_umber.of.review_gender <- data.frame(
  Gender = names(coefficients_number.of.review_gender)[-1],  # Exclude intercept
  Coefficient = coefficients_number.of.review_gender[-1]  # Exclude intercept
)
# Plot bar chart using the function
create_coefficient_bar_chart(bar_data_umber.of.review_gender, Gender, Coefficient, "Number of Review vs. Gender Male")

#model3: number.of.review VS Room Type
lm_number.of.review_room.type  <- lm(ln_number.of.review ~ room.type , data = df)
# Extract coefficients from the regression model
coefficients_number.of.review_room.type <- coef(lm_number.of.review_room.type)
# Prepare data for bar chart
bar_data_umber.of.review_room.type <- data.frame(
  room.type = names(coefficients_number.of.review_room.type)[-1],  # Exclude intercept
  Coefficient = coefficients_number.of.review_room.type[-1]  # Exclude intercept
)
# Plot bar chart using the function
create_coefficient_bar_chart(bar_data_umber.of.review_room.type, room.type, Coefficient, "Number of Review vs. Room type")


#model3: number.of.review VS minimum.nights
lm_number.of.review_minimum.nights <- lm(ln_number.of.review ~ ln_minimum.nights , data = df)
# Extract coefficients from the regression model
coefficients_number.of.review_minimum.nights <- coef(lm_number.of.review_minimum.nights)
# Prepare data for bar chart
bar_data_umber.of.review_minimum.nights <- data.frame(
  ln_minimum.nights = names(coefficients_number.of.review_minimum.nights)[-1],  # Exclude intercept
  Coefficient = coefficients_number.of.review_minimum.nights[-1]  # Exclude intercept
)
# Plot bar chart using the function
create_coefficient_bar_chart(bar_data_umber.of.review_minimum.nights, ln_minimum.nights, Coefficient, "Number of Review vs. Minimum Nights")

#model3: number.of.review VS calculated.host.listings.count
lm_number.of.review_calculated.host <- lm(ln_number.of.review ~ calculated.host.listings.count , data = df)
# Extract coefficients from the regression model
coefficients_number.of.review_calculated.host <- coef(lm_number.of.review_calculated.host)
# Prepare data for bar chart
bar_data_number.of.review_calculated.host <- data.frame(
  calculated.host.listings.count = names(coefficients_number.of.review_calculated.host)[-1],  # Exclude intercept
  Coefficient = coefficients_number.of.review_calculated.host[-1]  # Exclude intercept
)
# Plot bar chart using the function
create_coefficient_bar_chart(bar_data_number.of.review_calculated.host, calculated.host.listings.count, Coefficient, "Number of Review vs. Calculated Host Listings")

#model3: number.of.review VS availability.365 
lm_number.of.review_availability.365 <- lm(ln_number.of.review ~ availability.365 , data = df)
# Extract coefficients from the regression model
coefficients_number.of.review_availability.365 <- coef(lm_number.of.review_availability.365)
# Prepare data for bar chart
bar_data_number.of.review_availability.365 <- data.frame(
  availability.365 = names(coefficients_number.of.review_availability.365)[-1],  # Exclude intercept
  Coefficient = coefficients_number.of.review_availability.365[-1]  # Exclude intercept
)
# Plot bar chart using the function
create_coefficient_bar_chart(bar_data_number.of.review_availability.365, availability.365, Coefficient, "Number of Review vs. Availability.365")


###################################################################################################
##############Create NYC Map#######################################################################

setwd("D:/University/Taiwan/NCCU/About courses/junior/Big data analysis/Final Project")
map <- st_read("cb_2017_us_county_500k/cb_2017_us_county_500k.shp")
      
nyc_map <- map %>%
  filter(STATEFP == "36") %>%
  filter(COUNTYFP %in% c("005", "061", "047", "081", "085"))

airbnb_nyc <- df %>%
select(id, lat, long, price, room.type, neighbourhood, Gender)

airbnb_nyc <- airbnb_nyc %>%
  group_by(neighbourhood) %>%
  summarise(Male = sum(Gender == 1, na.rm = TRUE),
            Female = sum(Gender == 0, na.rm = TRUE)) |>
  mutate(GenderRatio = Male/Female)

result <- airbnb_nyc %>%
  left_join(df, by = "neighbourhood") %>%
  group_by(neighbourhood) %>%
  slice(1) %>%
  ungroup()

airbnb_sf <- st_as_sf(result, coords = c("long", "lat"), crs = 4326)

ggplot() +
  geom_sf(data = nyc_map, fill = "white", color = "black") +
  geom_sf(data = airbnb_sf, aes(color = ifelse(GenderRatio >= 1, "skyblue", "pink")), size = 2.5, alpha = 0.5) +
  scale_fill_manual(values = c("skyblue" = "skyblue", "pink" = "pink"), na.value = "grey50", guide = "legend", name = "Sex Ratio") +
  labs(title = "Host gender distribution by region(neighborhood)",
       subtitle = "",
       x = "Longitude",
       y = "Latitude")
