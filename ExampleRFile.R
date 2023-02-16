###DO NOT RUN THIS CODE ALL AT ONCE###
#####Set-Up Code#####
###Necessary Package Installation
#Use this code to install the necessary packages
#Once the packages are installed, you will not need to use this code

install.packages("tidyverse")
install.packages("readxl")
install.packages("nortest")
install.packages("mosaic")
install.packages("devtools")
install.packages("COINr")
install.packages("factoextra")
install.packages("gridExtra")

###Library Functions
#The following code should be run every time you start the program
#This code activates the libraries and allows it to be used later on

library(tidyverse)
library(readxl)
library(nortest)
library(mosaic)
library(devtools)
library(COINr)
library(factoextra)
library(gridExtra)

#####Data Importation#####
#This code will import the data from the Excel files into an R data frame
#To make this easy, put the necessary Excel files into the Data folder in your R folder
#General format of code:
#Variable name <- read_excel("Entire File Path\\R_Project_Name\\Data\\Excel_File.xlsx")
#If you want to import a specific sheet of the Excel File, add [, sheet = "Sheet Name"] or [, sheet = 1] to the end of the above code
#Import your Data and Meta files here
#Example code used below, this code will not work on your computer with the current file path:

WaterSummary <- read_excel("C:\\Users\\engla\\OneDrive\\Documents\\CompositeIndicatorConstruction\\Data\\ImputedWaterTreatmentPlantData.xlsx", sheet = "Summary")

#####Normality Testing#####
###This code tests the normality of the data sets
###Data will need to be imputed in Excel before this step can be completed
###All indicators must be tested
###Results can be saved and normality can be determined using the provided Excel file
###3 normality tests were conducted

###1-Sample Kolmogorov-Smirnov Normality Test
#Code Format: ks.test(SummaryVariable$Indicator, "pnorm")
#This will output a p-value; input the p-value into the Normality and Correlation Excel File
#Example Code below:

ks.test(WaterSummary$Population, "pnorm")

###Shapiro-Wilk Normality Test
#Code Format: shapiro.test(SummaryVariable$Indicator)
#Input p-value into Normality and Correlation Excel File
#Example Code below:

shapiro.test(WaterSummary$Population)

###Anderson-Darling Normality Test
#Code Format: ad.test(SummaryVariable$Indicator)
#Input p-value into Normality and Correlation Excel File
#Example Code below:

ad.test(WaterSummary$Population)

#####Correlation Testing#####
###This code tests the correlations between indicators
###All correlation methods are non-parametric, so the normality of the indicators does not matter
###All combinations of indicators must be tested; use the Normality and Correlation Excel File or your own file to keep track
###3 correlation tests were conducted

###Spearman Rank Correlation Test
#Code Format: cor.test(SummaryVariable$Indicator1, SummaryVariable$Indicator2, method = "spearman")
#This test will output a p-value and a rho value
#The p-value is used to determine if the correlation is significant
#The rho value is used to determine if the correlation is positive or negative
#Input the p-value and rho into the Normality and Correlation Excel File
#Example Code below:

cor.test(WastewaterSummary$Population, WastewaterSummary$Age, method = "spearman")

###2-Sample Kolmogorov-Smirnov Correlation Test
#Code Format: ks.test(SummaryVariable$Indicator1, SummaryVariable$Indicator2)
#This code will output a p-value
#Record the p-value in the Normality and Correlation Excel File
#Example Code below:

ks.test(WastewaterSummary$Capacity, WastewaterSummary$API)

###Kendall-Tau Correlation Test
#Code Format: cor.test(SummaryVariable$Indicator1, SummaryVariable$Indicator2, method = "kendall")
#This test will output a p-value and a tau value
#Record the p-value in the Normality and Correlation Excel File
#Example Code below:

cor.test(WastewaterSummary$Cost, WastewaterSummary$II, method = "kendall")

###If an indicator is correlated in 2 out of the 3 tests, it should be removed from further analysis
###It is recommended that another Excel file containing only non-correlated indicators be made and imported

#####Code for Index Creation#####
###The code for Index Creation uses the COINr package created by William Becker
###To create the COIN, the meta file and data file need to be properly created and imported into R
###Example data and meta files are included
###Code Format: CoinName <- new_coin(iData = DataFileVariable, iMeta = MetaFileVariable, level_names = c("LevelName1", "LevelName2", etc.))
###Example Code below:

WaterIndex <- new_coin(iData = NoCorrelationWaterSummary, iMeta = WaterMeta, level_names = c("Indicators", "Sub-Index", "Index"))

###You can check the framework of the Index to make sure it is formatted properly using the plot_framework function
###This can be done in 2 ways depending on what graph you want
###Pie Chart: plot_framework(IndexName)
###Bar Graph: plot_framework(IndexName, type = "stack", colour_level = 2)
###Example Code below:

plot_framework(WaterIndex, type = "stack", colour_level = 2)

#####Normalization#####
###This code normalizes the raw data in the COIN with the inputted method
###Several normalization methods can be used, including z-score, min-max, and rank
###All normalization types can be found in Section 9.2 here: https://bluefoxr.github.io/COINrDoc/normalisation.html#normalisation-in-coinr
###Code Format: CoinName <- Normalise(CoinName, dset = "Raw", global_specs = list(f_n = "Normalization Method", f_n_para = list(c(Necessary variables))))
##dset is the data set within the Coin that will be used, in this case, it is the raw data that was entered into the Coin
##f_n is the normalization method that will be used
##f_n_para is the parameters for the normalization method; this is not always necessary
###Once the code is run, the normalized data values are placed in CoinName$Data$Normalised
###Example Code for a few methods are shown below

##Example Code for Z-Score Normalization
#In this example code, f_n_para denotes the mean and standard deviation that the Raw data should be normalized to
#The mean is set to 10 and the standard deviation is set to 2

WaterIndex <- Normalise(WaterIndex, dset = "Raw", global_specs = list(f_n = "n_zscore", f_n_para = list(c(10,2))))

##Example Code for Min-Max Normalization
#In this example code f_n_para denotes the minimum and maximum values that the data should be normalized to
#The minimum value is set to 1, and the maximum value is set to 100

WaterIndex <- Normalise(WaterIndex, dset = "Raw", global_specs = list(f_n = "n_minmax", f_n_para = list(c(1,100))))

##Example Code for Rank Normalization
#In this example code, f_n_para is not needed, since Rank Normalization converts the raw data to ranks

WaterIndex <- Normalise(WaterIndex, dset = "Raw", global_specs = list(f_n = "n_rank"))

#####Aggregation#####
###This code aggregates the normalized data with the weights in the Meta File to give the index values
###Code Format: CoinName <- Aggregate(CoinName, dset = "Normalised", f_ag = "Aggregation Method")
###f_ag denotes the aggregation method used
###Once the code is run, the aggregated data values are placed in CoinName$Data$Aggregated
###Example Code for a couple of aggregation methods is shown below

##Example Code for Weighted Arithmetic Mean
#This can be done in 2 ways
#The following code does the same thing

WaterIndex <- Aggregate(WaterIndex, dset = "Normalised")
WaterIndex <- Aggregate(WaterIndex, dset = "Normalised", f_ag = "a_amean")

###Example Code for Weighted Geometric Mean

WaterIndex <- Aggregate(WaterIndex, dset = "Normalised", f_ag = "a_gmean")

#####Uncertainty and Sensitivity Analysis#####
###To perform UA and SA, some pre-work needs to be completed
###This includes selecting the alternate methods for normalization, weights, and aggregation

###Code to make Normalization alternates
##This code consists of making a list of normalization alternates, following the code detailed in the Normalization section
##Example Code is shown below
##This code sets the normalization alternates to be min-max, z-score, and rank, with the appropriate parameters included

norm_alts <- list(list(f_n = "n_minmax", f_n_para = list(c(1,100))), list(f_n = "n_zscore", f_n_para = list(c(10,2))), list(f_n = "n_rank"))

##Now, the norm_alts variable needs to be told what data to run the methods on
##This is done by creating another variable, as shown below

l_norm <- list(Address = "$Log$Normalise$global_specs", Distribution = norm_alts, Type = "discrete")

##This code puts the alternate normalization methods in the global_specs section of your Coin

###Code to make Alternate Sets of Weights
##The first step is to save your original weights to a variable, as shown below
##The original weights are stored in the Meta section of the Coin

w_nominal <- WaterIndex$Meta$Weights$Original

##Next, you must specify the the levels of the indicator the new weights will be applied to, as well as the noise you would like the generated weights to include
##Example code for this is shown below

noise_specs = data.frame(Level = c(1,2), NoiseFactor = c(0.25, 0.25))

##In the above code, a data frame is created that contains the levels we want the new weights to be applied to and the noise used to create the new weights
##For the Level, 1 denotes the lowest level, or the indicator level, and the highest number, which would be 3 for this Index, is the Index level
##The noise factor describes the percentage from the original weights the new weights can be
#For example, since we input 0.25, the new weights can vary between +25% or -25% of the original value
#If the original weights were 1, the value of the new weights would fall between 0.75 and 1.25

##Next, the altered weights need to be created
##This is done using the get_noisy_weights function, as shown below

noisy_wts <- get_noisy_weights(w = w_nominal, noise_specs = noise_specs, Nrep = 100)

##In the above code, "w" represents the normal weights, "noise_specs" is the specifications for creating the noise, and "Nrep" is the number of weight sets you want to create
##Similar to the normalization, these weights must be told where to go, as shown below

l_weights <- list(Address = "$Log$Aggregate$w", Distribution = noisy_wts, Type = "discrete")

###Code for Aggregation Alternatives
##This process is similar to making normalization alternatives
##You can create a variable for the alternatives, or place them directly in the alternative variable, as shown below

l_agg <- list(Address = "$Log$Aggregate$f_ag", Distribution = c("a_amean", "a_gmean"), Type = "discrete")

###Now, these alternatives need to be placed in a single variable, as shown below

SA_specs <- list(Normalisation = l_norm, Weights = l_weights, Aggregation = l_agg)

###Now, Uncertainty and Sensitivity Analysis can be conducted
###For both UA and SA, the get_sensitivity function will be used
###An example of Uncertainty Analysis is shown below

WaterUA <- get_sensitivity(WaterIndex, SA_specs = SA_specs, N = 100, SA_type = "UA", dset = "Aggregated", iCode = "Index")

##In the above code, "N" represents the number of times the analysis, whether it is UA or SA, is run
##SA_type denotes whether you want to conduct Uncertainty Analysis (UA) or Sensitivity Analysis (SA)
##iCode denotes what you want to conduct the analysis on; in this case, it is the final Index value

###Sensitivity Analysis is conducted with the same code
###The only difference is that "UA" is changed to "SA", and the Nboot is added to the end, as shown below
###Nboot is used to determine the confidnence intervals on the sensitivity analysis

WaterSA <- get_sensitivity(WaterIndex, SA_specs = SA_specs, N = 100, SA_type = "SA", dset = "Aggregated", iCode = "Index", Nboot = 100)

#####Removing Indicators#####
###To determine how each indicator affects the final index ranks, use the following code

Water_res <- remove_elements(WaterIndex, Level = 1, dset = "Aggregated", iCode = "Index")