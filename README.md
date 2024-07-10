# 🛏️ Exploring New Tork City Airbnb
  ![airbnb_newyork](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/6bae8cf1-8f5e-40a3-8e4f-59c714abca08)

# 🌐 Project Description
Airbnb has revolutionized the travel industry since 2008 by providing a platform for homeowners and hosts to rent out their properties to guests seeking unique accommodation experiences, creating value through the sharing economy business model. According to Inside Airbnb, a site that scrapes Airbnb for listings data, New York City has become a big market for Airbnb, with more than 30,000 listings in the city. To explore the potential biases and factors that may influence pricing decisions on this large platform, our data project aims to analyze the New York City Airbnb dataset to identify various factors affecting Airbnb rentals and analyze the influence of independent variables. This can contribute to creating a sustainable lodging industry by providing important insights to stakeholders.

# 🖥️ Getting Started
This project is written in R. To get started with this project, follow these steps:

  1. **Download the datasets**:
  - The Airbnb dataset contains 102,599 Airbnb listings in New York City with detailed data for each place, which will be used in our analysis in the next step. [Click here to download the Airbnb dataset](https://www.kaggle.com/datasets/arianazmoudeh/airbnbopendata)
  - The gender dataset contains 57,582 names of boys and girls collected and published by the New York City government. [Click here to download the Gender dataset](https://catalog.data.gov/dataset/popular-baby-names)
    
  2. **Set the working directory** to the project folder : 

      ``` setwd("/path/to/your/project/folder")  ```
 
  3. **Load the required libraries**  
     
     To run this project, you will need the following R libraries installed:
      ```library(jsonlite)
      library(plyr)
      library(dplyr)
      library(tidyr)
      library(stringr)
      library(readr)
      library(readxl)
      library(writexl)
      library(ggplot2)
      library(sf)
      library(ggspatial)
      ```
  4. **Import datasets into RStudio**
     ```
      gender_df <- read.csv("Names.csv")  
      airbnb_df <- read.csv("Airbnb_Open_Data.csv") 
     ```

  5. **Data cleaning**:
      - **Firstly, identify each host's gender**.
        We start by converting all the hosts' names and babies' names into lowercase. Next, create a list of male names and a list of female names. Find the names that appear on both lists and exclude them so we are left with only unique male and female names. After that, assign gender to the host based on their name (if the name is on the male list, then the host's gender will be male, and vice versa). Then assign the value of 1 to males and 0 to females.
      - **To get rid of unused columns**, clear all the observations that have missing values, and change all the numbers (character class) into a numeric class. We deleted the columns _"house rule"_ and _"license"_ because most of the observations didn't have them. Then we assigned _NA_ to all the blank spaces and excluded all the observations that contained _NA_. We also removed the dollar sign (_$_) and comma (_,_) so we can change the numbers into a numeric class.
     - **Lastly**, we created a new column named _building_age_ to show the age of each Airbnb.

  
 6. **Data Analysis**:
     - **We first create new columns for all numeric values** by applying a logarithm function to address the skewed data problem.
     - **Then, identify independent variables (IVs) and dependent variables (DVs).** We use _price_, _review.rate.number_, and _number.of.reviews_ as DVs, while the rest of the data serve as IVs. Each of these DVs has its own analysis model to determine which IV influences it the most:
    
       Model 1: _price_  is the DV
       
       Model 2: _review.rate.number_ is the DV
       
       Model 3: _number.of.reviews_ is the DV
              
  7. **Data Visualization**:
     - Select the IV that has a significant coefficient from the model and create a linear regression model for only the DV and that particular IV again (e.g., _price_ vs. _room_type_).
     - Extract the coefficient value from the new regression model and plot it using a bar chart.

# 📂 File Structure
| Files  | Description | 
| :---:           |:---         |
| `README.md`   | Contains information about the project, including instructions and descriptions.| 
| `Names`     | Contains names of boys and girls.|  
| `Airbnb_Open_Data` 	   |Contains insight data for Airbnb listings in NYC |
| `Airbnb NYC.R`	 | The main R file for data analysis. |

# 📊 Analysis & Data Visualization
 **Model 1:**
  - Given _price_ as the dependent variable (DV), there is only 1 independent variable (IV) that has a significant p-value: ln_service.fee (<2e-16), indicating high strength and statistical significance. The value of Multiple R-squared of 0.9999 indicates a strong relationship between the predictor variable and the outcome variable, suggesting that the model explains almost all of the variability in the DV based on the included predictors.

    ![model1_price_vs_serivcefee](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/5880f516-95f3-4256-9811-90a952b7ff9c)
   
  - The bar chart illustrates the coefficient for the independent variable (IV) ln_service.fee in relation to the dependent variable (DV) ln_price. The chart is designed to highlight the impact of the service fee on the pricing model.

    Key Highlights:
    - High Significance: The coefficient for ln_service.fee is significantly different from zero with a p-value of <2e-16, indicating a strong and statistically significant relationship between the service fee and the price.
    - Positive Coefficient: The positive value of the coefficient suggests that as the service fee increases, the price also tends to increase.
    - Coefficient Value: The exact coefficient value is approximately 0.008669, as shown in the statistical output.
   
  
      
 **Model 2:** 
 - Given _review.rate.number_ as the DV, there are 6 IVs with significant p-values: _neighbourhood.groupBrooklyn_, _neighbourhood.groupManhattan_, _room.typeShared room_, _host_identity_verifiedverified_, _calculated.host.listings.count_, and _availability.365_. However, the Multiple R-squared value is only 0.002364, indicating a model with very limited explanatory power. This suggests that the included predictors do not adequately explain the variability in the dependent variable.
   
    ![model2_reviewrate_vs_availability](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/6c0249c2-bcea-4af7-b3b4-88b16c497c10)
   
 - This bar chart illustrates the coefficient for the independent variable "availability.365" in relation to the review rate. The chart shows a negative coefficient, with the bar extending downwards to approximately -6.451e-05.
  
     Key Highlights:
    - Negative Relationship: The coefficient is negative, suggesting that as availability increases, the review rate tends to slightly decrease.
    - Statistical Significance: Despite the small magnitude, the relationship is statistically significant (p = 0.000347).

   ![model2_reviewrate_vs_calculatedhost](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/de643214-c236-49a2-bb61-6bf6ea6e0669)
   
 - This bar chart displays the coefficient for the independent variable "calculated.host.listings.count" in relation to the review rate. The chart shows a positive coefficient, with the bar extending upwards to about 8.451e-04.

   Key Highlights:
      - Positive Relationship: The coefficient is positive, indicating that as the number of host listings increases, the review rate tends to slightly increase.
      - High Statistical Significance: The relationship is highly significant (p < 0.001), as indicated in the model output.
      - Host Experience: This could suggest that hosts with more listings might receive slightly better reviews, possibly due to more experience or better management practices.




 **Model 3:** 
 - Given _number.of.reviews_ as the DV, there are 8 IVs with significant p-values: _Gender_, _neighbourhood.groupBrooklyn_, _neighbourhood.groupManhattan_, _room.typePrivate room_, _room.typeShared room_, _ln_minimum.nights_, _ln_service.fee_, _calculated.host.listings.count_, and _availability.365_. However, the Multiple R-squared value is only 0.05026, suggesting that the model explains about 5% of the variance in the DV using the included predictors. This indicates a modest level of explanatory power.

   ![model3_reviewnumber_vs_roomtype](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/b88047a5-2252-464b-9dfe-62a58a5db527)
   
 - This bar chart compares the coefficients for different room types as independent variables (IVs) in relation to the dependent variable (DV) number of reviews. The chart is structured to show the relative impact of each room type on review numbers. 

      Key Highlights:
      - Negative coefficients: All room types shown (Hotel room, Shared room, Private room) have negative coefficients, as indicated by the downward-extending red bars.
      - Varying magnitudes:
        - Hotel room has the largest negative effect, with a coefficient around -0.6.
        - Shared room has the second-largest effect, with a coefficient around -0.2.
        - Private room has the smallest negative effect, with a coefficient close to 0 but still slightly negative.
      - Comparative impact: The chart effectively illustrates the relative impact of each room type on the number of reviews, with Hotel rooms having the strongest negative association.

   
   ![model3_reviewnumber_vs_minnight](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/10691f64-34c0-466f-9d65-417bd6e1cd46)
   
 - This bar chart illustrates the coefficient for the independent variable (IV) ln_minimum_nights in relation to the dependent variable (DV) number of reviews. The chart is designed to highlight the impact of the minimum nights requirement on the number of reviews received. 

      Key Highlights:
      - Negative coefficient: The red bar extends downwards, indicating a negative relationship between minimum nights and number of reviews.
      - Magnitude: The coefficient appears to be approximately -0.2345, based on the y-axis scale.
      - Visual impact: The bar chart illustrates the negative effect, making it easy to see the direction and relative strength of the relationship.
  
   ![model3_reviewnumber_vs_minnight](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/10691f64-34c0-466f-9d65-417bd6e1cd46)
   
 - This bar chart illustrates the coefficient for the independent variable (IV) ln_minimum_nights in relation to the dependent variable (DV) number of reviews. The chart is designed to highlight the impact of the minimum nights requirement on the number of reviews received. 

      Key Highlights:
      - Negative coefficient: The red bar extends downwards, indicating a negative relationship between minimum nights and number of reviews.
      - Magnitude: The coefficient appears to be approximately -0.2345.
      - Visual impact: The bar cahrt clearly illustrates the negative effect, making it easy to see the direction and relative strength of the relationship.

   ![model3_reviewnumber_vs_availability](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/bdbb9b89-781c-492f-9b2f-3796c2deda0c)

 - This bar chart depicts the coefficient for the independent variable (IV) availability.365 in relation to the dependent variable (DV) number of reviews. The chart is designed to showcase the effect of year-round availability on review numbers. 

      Key Highlights:
      - Positive coefficient: The red bar extends upwards, indicating a positive relationship between availability.365 and number of reviews.
      - Magnitude: The coefficient appears to be approximately 0.0015.
      - Visual impact: The chart clearly illustrates the positive effect.
  
   ![model3_reviewnumber_vs_calculatedhost](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/1b187274-7490-4904-b5be-d28452adea81)

 - This bar chart illustrates the coefficient for the independent variable (IV) calculated host listings count in relation to the dependent variable (DV) number of reviews. The chart aims to demonstrate how the number of listings a host has affects the review count for individual listings.
   
      Key Highlights:
      - Negative coefficient: The red bar extends downwards, indicating a negative relationship between calculated host listings count and number of reviews.
      - Magnitude: The coefficient appears to be approximately -0.0019.
      - Visual impact: The chart clearly illustrates the negative effect.

    ![model3_review number_vs_gender](https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/06eb377c-3051-490e-97e6-8079813b0137)

 - The bar chart illustrates the coefficient for the independent variable (IV) "Gender Male" in relation to the dependent variable (DV) "Number of Reviews". The chart is designed to highlight the impact of gender on the number of reviews received.
   
      Key Highlights:
      - High Significance: The coefficient for "Gender Male" is significantly different from zero with a p-value of 1.27e-11, suggesting a strong and statistically significant relationship between gender and the number of reviews.
      - Positive Coefficient: The positive value of the coefficient (approximately 0.1001) indicates that male hosts tend to receive more reviews compared to the reference category (presumably female hosts).
      - Coefficient Value: The exact coefficient value is 0.1001, as shown in the bar chart and confirmed in the statistical output.
      - Magnitude of Effect: This coefficient suggests that, on average, listings by male hosts receive about 10.01% more reviews than those by female hosts, all other factors being equal.
  
**Gender ratio:**
   
   <img width="605" alt="Screenshot 2024-07-10 at 12 59 23 PM" src="https://github.com/Varinthon/Exploring-NYC-Airbnb/assets/96362159/b1181df3-c109-44d6-89bc-58cd1eeeec0e">
    
  The map displays the distribution of Airbnb host genders across different regions (neighborhoods) in New York City. Blue areas indicate places with more male hosts (where the gender ratio is over 100), and red areas indicate places with more female hosts. According to the New York Census, every borough in New York City has a higher percentage of women than men. Therefore, this suggests that the blue areas on the map are outliers. This map provides a starting point for further investigation into potential patterns or disparities in host gender distribution across different neighborhoods of the city.
 

# 🔎 Results
After using three linear regression models, we found that the service fee (IV) was the only significant predictor for price (DV), showing a strong positive impact. The review rate was influenced by neighborhood (Brooklyn and Manhattan), room type (shared room), host identity verification, host listings count, and availability, though the overall model explained little variance. The number of reviews was affected by gender, neighborhood (Brooklyn and Manhattan), room type (private and shared rooms), minimum nights, host listings count, and availability, with similar low explanatory power. These findings suggest that while price is primarily driven by service fees, the review rate and number of reviews are more complex and influenced by multiple factors. To improve the models and better predict or explain the review rate and number of reviews, more in-depth information is needed.

# 🧠 Contributors
| :anchor: **Team member**          | :pencil: **Role & Responsibility**            |
|-----------------------------------|-----------------------------------------------|
| Varinthon Chowanajin 廖靈通  | Data Collection, Coding, Poster, Presentation, GitHub |
| Watsayaporn Srimueanghao 史沃天 | Data Collection, Coding, Poster, Presentation, GitHub |
| Park Jisoo 朴智秀 | Data Collection, Poster, Presentation |
| Lim Sze Chien 林姿蒨 | Data Collection, Coding, Poster, Presentation |

# 👥 Acknowledgments
We would like to sincerely thank Professor Pien Chung-Pei, our instructor from the Big Data course, for his advice and assistance throughout the development of our "Exploring New York City Airbnb" project. His expertise have been invaluable in guiding our analysis and helping us overcome obstacles.

Thank you to each member of the team involved in this project. Your effort, dedication, and teamwork were essential in conducting this comprehensive analysis. Through your hard work and commitment, we have been able to create an analysis that aims to benefit Airbnb hosts, the general public, Airbnb itself, and researchers. Our project's insights into the New York City Airbnb market will hopefully contribute to informed decision-making and further research in this field.

# 📄 References
**Data sources**

Zmoudeh, A. (2022). Airbnb Open Data. Kaggle. https://www.kaggle.com/datasets/arianazmoudeh/airbnbopendata

City of New York. (2024, June 15). Popular Baby Names. data.cityofnewyork.us. https://catalog.data.gov/dataset/popular-baby-names
Inside Airbnb. (n.d.). Los Angeles. http://insideairbnb.com/los-angeles/

**Researches**

Nascimento, I. M., & Queiroz, E. P. (2023). The Linear Regression Model for Estimate the Price in Crossing Transport Services: Methodology and Application. In Proceedings of PIANC Smart Rivers 2022. https://doi.org/10.1007/978-981-19-6138-0_126

Norris, E. (2024, April 29). The Linear Regression of Time and Price. Investopedia. https://www.investopedia.com/articles/trading/09/linear-regression-time-price.asp
