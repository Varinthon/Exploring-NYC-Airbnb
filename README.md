# Project Title
Exploring New Tork City Aurbnb

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
6. 
