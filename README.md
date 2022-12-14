# DS 6306 - Case Study 2(Employee Predictions)
![DS 6306 - Case Study 2(Employee Predictions)](https://user-images.githubusercontent.com/92649864/206943562-84ea4138-c1aa-425d-9cf8-63d30578318c.jpg)

## Project Description
DDSAnalytics is an analytics company that specializes in talent management solutions for Fortune 100 companies. Talent management is defined as the iterative process of developing and retaining employees. It may include workforce planning, employee training programs, identifying high-potential employees and reducing/preventing voluntary employee turnover (attrition). To gain a competitive edge over its competition, DDSAnalytics is planning to leverage data science for talent management. The executive leadership has identified predicting employee turnover as its first application of data science for talent management.

In this project, I will identify the top three factors that contribute to turnover (backed up by evidence provided by analysis). The business is also interested in learning about any job role specific trends that may exist in the data set. You can also provide any other interesting trends and observations from your analysis. The analysis is backed up by robust experimentation and appropriate visualization.

The entire process will be done in R.

## Goals
There are two goals for this project:
1. Find factors that will lead to attrition and create a model that will predict it on a test dataset(CaseStudy2CompSet No Attrition (1).csv).
2. Find factors that can help us predict Monthly Income and create a linear regression model that can predict it accurately on a test dataset(CaseStudy2CompSet No Salary (2).xlsx).

Both test dataset have a total of 300 observation while CaseStudy2-data.csv will serve as our train dataset.

## Required Packages
library(dplyr) <br>
library(tidyr) <br>
library(ggplot2) <br>
library(class) <br>
library(caret) <br>
library(e1071) <br>
library(naniar) <br>
library(rmarkdown) <br>
library(readxl) <br>
library(imbalance) <br>
library(fastDummies) <br>
library(psych) <br>
library(GGally)

# Google Drive presentation
Please visit this [link](https://drive.google.com/file/d/1srzTIJI2Ow2vudsjGM2-xGMUC6uKXKr_/view?usp=sharing) for my presentation on this project.

# RShiny
Please visit this [link](https://x0s00e-danny-chang.shinyapps.io/case_study_2/?_ga=2.103113856.1268003529.1670802137-241624307.1669589829) for my RShiny app.

## Licensing and Acknowledgements
This was done as a project for Data Science 6306 at Southern Methodist University,
