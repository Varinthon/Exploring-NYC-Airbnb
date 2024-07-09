# Project Title
Exploring New Tork City Airbnb

# Project Description
Airbnb has revolutionized the travel industry since 2008 by providing a platform for homeowners and hosts to rent out their properties to guests seeking unique accommodation experiences, creating value through the sharing economy business model. According to Inside Airbnb, a site that scrapes Airbnb for listings data, New York City has become a big market for Airbnb, with more than 30,000 listings in the city. To explore the potential biases and factors that may influence pricing decisions on this large platform, our data project aims to analyze the New York City Airbnb dataset to identify various factors affecting Airbnb rentals and analyze the influence of independent variables. This can contribute to creating a sustainable lodging industry by providing important insights to stakeholders.

# Getting Started
This project is written in R. To get started with this project, follow these steps:

  1. Download the datasets:
  - Download the Airbnb dataset from https://www.kaggle.com/datasets/arianazmoudeh/airbnbopendata This dataset contains 102,599 Airbnb listings in New York City with detailed data for each place, which will be used in our analysis in the next step.
  - Download the gender dataset from https://catalog.data.gov/dataset/popular-baby-names This dataset contains 57,582 names of boys and girls collected and published by the New York City government.
    
  2. Import datasets into RStudio. 

  3. Data cleaning:
  - Our first aim is to identify each host's gender. We start by converting all the hosts' names and babies' names into lowercase. Next, create a list of male names and a list of female names. Find the names that appear on both lists and exclude them so we are left with only unique male and female names. After that, assign gender to the host based on their name (if the name is on the male list, then the host's gender will be male, and vice versa). Then assign the value of 1 to males and 0 to females.
- Our next goal is to get rid of unused columns, clear all the observations that have missing values, and change all the numbers (character class) into a numeric class. We deleted the columns _"house rule"_ and _"license"_ because most of the observations didn't have them. Then we assigned _NA_ to all the blank spaces and excluded all the observations that contained _NA_. We also removed the dollar sign (_$_) and comma (_,_) so we can change the numbers into a numeric class.
 - Lastly, we created a new column named _building_age_ to show the age of each Airbnb.
  
 4. Data Analysis:
 - We first create new columns for all numeric values by applying a logarithm function to solve the skewed data problem.
 - Identify independent variables (IV) and dependent variables (DV). We used _price_, _review.rate.number_, and _number.of.reviews_ as DVs, and the rest of the data will be IVs. Each of these DVs will have its own analysis model to see which IV influences it the most. In model 1, _price_ is the DV; in model 2, _review.rate.number_ is the DV; and in model 3, _number.of.reviews_ is the DV.
  
5. Data Visualization:
 - Select the IV that has a significant coefficient from the model and create a linear regression model for only the DV and that particular IV again (e.g., _price_ vs. _room_type_).
 - Extract the coefficient value from the new regression model and plot it using a bar chart.

# File Structure
The file structure of the project is as follows:
  1. README.md: Contains information about the project, including instructions and descriptions.
  2. Names: Contains names of boys and girls.
  3. Airbnb_Open_Data: Contains insight data for Airbnb listings in NYC
  4. Airbnb NYC.R: The main R file for data analysis.

# Analysis
  - Model 1: Given _price_ as the dependent variable (DV), there is only 1 independent variable (IV) that has a significant p-value: ln_service.fee (<2e-16), indicating high strength and statistical significance. The value of Multiple R-squared of 0.9999 indicates a strong relationship between the predictor variable and the outcome variable, suggesting that the model explains almost all of the variability in the DV based on the included predictors.
  - Model 2: Given _review.rate.number_ as the DV, there are 6 IVs with significant p-values: _neighbourhood.groupBrooklyn_, _neighbourhood.groupManhattan_, _room.typeShared room_, _host_identity_verifiedverified_, _calculated.host.listings.count_, and _availability.365_. However, the Multiple R-squared value is only 0.002364, indicating a model with very limited explanatory power. This suggests that the included predictors do not adequately explain the variability in the dependent variable.
  - Model 3: Given _number.of.reviews_ as the DV, there are 8 IVs with significant p-values: _Gender_, _neighbourhood.groupBrooklyn_, _neighbourhood.groupManhattan_, _room.typePrivate room_, _room.typeShared room_, _ln_minimum.nights_, _ln_service.fee_, _calculated.host.listings.count_, and _availability.365_. However, the Multiple R-squared value is only 0.05026, suggesting that the model explains about 5% of the variance in the DV using the included predictors. This indicates a modest level of explanatory power.

# Results
After using three linear regression models, we found that the service fee (IV) was the only significant predictor for price (DV), showing a strong positive impact. The review rate was influenced by neighborhood (Brooklyn and Manhattan), room type (shared room), host identity verification, host listings count, and availability, though the overall model explained little variance. The number of reviews was affected by gender, neighborhood (Brooklyn and Manhattan), room type (private and shared rooms), minimum nights, host listings count, and availability, with similar low explanatory power. These findings suggest that while price is primarily driven by service fees, the review rate and number of reviews are more complex and influenced by multiple factors. To improve the models and better predict or explain the review rate and number of reviews, more in-depth information is needed.
# Contributors
Varinthon Chowanajin, Watsayaporn , Park Jisoo, Lim Sze Chien

# Acknowledgments
Project supervisor: Professor Chung Pei Pien

# References
Data sources: 
https://www.kaggle.com/datasets/arianazmoudeh/airbnbopendata ,
https://catalog.data.gov/dataset/popular-baby-names

