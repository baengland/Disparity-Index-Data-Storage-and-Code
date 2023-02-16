#####Set-Up Code
#install.packages("tidyverse")
#install.packages("ggplot2")
#install.packages("readxl")
#install.packages("nortest")
#install.packages("dplyr")
#install.packages("mosaic")
#install.packages("devtools")
#install.packages("COINr")
#install.packages("gridExtra")
#install.packages("DiagrammeR")
#install.packages("DiagrammeRsvg")
#install.packages("rsvg")
#install.packages("magrittr")

###Libraries Used
library(tidyverse)
library(ggplot2)
library(readxl)
library(nortest)
library(dplyr)
library(mosaic)
library(devtools)
library(COINr)
library(gridExtra)
library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)
library(magrittr)

###Framework Diagrams
DrinkingWaterIndexFramework <- grViz("digraph flowchart {
                                     node [fontname = Roman, shape = rectangle]
                                     tab1 [label = 'Drinking Water \n Disparity Index']
                                     tab2 [label = 'Access']
                                     tab3 [label = 'State of \n Infrastructure']
                                     tab4 [label = 'Affordability']
                                     tab5 [label = 'Connected Population']
                                     tab6 [label = 'Age']
                                     tab7 [label = 'Capacity']
                                     tab8 [label = 'Number of \n Violations']
                                     tab9 [label = 'Number of \n Operators']
                                     tab10 [label = 'Water Loss']
                                     tab11 [label = 'Ability to Pay Index']
                                     tab1 -> tab2; tab1 -> tab3; tab1 -> tab4;
                                     tab2 -> tab5; tab4 -> tab11; tab3 -> tab6;
                                     tab3 -> tab7; tab3 -> tab8; tab3 -> tab9;
                                     tab3 -> tab10}
                                     ")

DrinkingWaterIndexFramework %>%
  export_svg %>%
  charToRaw %>%
  rsvg_svg("DrinkingWaterIndexFramework.svg")

WastewaterIndexFramework <- grViz("digraph flowchart {
                                   node [fontname = Roman, shape = rectangle]
                                   tab1 [label = 'Wastewater \n Disparity Index']
                                   tab2 [label = 'Access']
                                   tab3 [label = 'State of \n Infrastructure']
                                   tab4 [label = 'Affordability']
                                   tab5 [label = 'Connected Population']
                                   tab6 [label = 'Age']
                                   tab7 [label = 'Capacity']
                                   tab8 [label = 'Number of \n Violations']
                                   tab9 [label = 'Number of \n Operators']
                                   tab10 [label = 'I/I']
                                   tab11 [label = 'Ability to Pay Index']
                                   tab1 -> tab2; tab1 -> tab3; tab1 -> tab4;
                                   tab2 -> tab5; tab4 -> tab11; tab3 -> tab6;
                                   tab3 -> tab7; tab3 -> tab8; tab3 -> tab9;
                                   tab3 -> tab10}
                                   ")

WastewaterIndexFramework %>%
  export_svg %>%
  charToRaw %>%
  rsvg_svg("WastewaterIndexFramework.svg")

###Process Diagram
CompositeIndicatorConstructionFlowchart <- grViz("digraph flowchart {
  graph [layout = neato]
  node[fontname = Roman, shape = rectangle]
  tab1 [label = 'Preliminary \n Work']
  tab2 [label = 'Data Imputation']
  tab3 [label = 'Normality and \n Correlation Testing']
  tab4 [label = 'Removal of \n Correlated Indicators']
  tab5 [label = 'Normalization']
  tab6 [label = 'Weighting']
  tab7 [label = 'Aggregation']
  tab8 [label = 'Uncertainty and \n Sensitivity Analysis']
  tab1 -> tab2 -> tab3 -> tab4 -> tab5 -> tab6 -> tab7 -> tab8
  }
  ")

CompositeIndicatorConstructionFlowchart %>%
  export_svg %>%
  charToRaw %>%
  rsvg_svg("CompositeIndicatorConstructionFlowchart.svg")

UASAProcessFlowchart <- grViz("digraph flowchart {
                            node[fontname = Roman, shape = rectangle]
                            tab1 [label = '@@1']
                            tab2 [label = '@@2']
                            tab3 [label = '@@3']
                            tab4 [label = '@@4']
                            tab5 [label = '@@5']
                            tab6 [label = '@@6']
                            tab7 [label = '@@7']
                            tab8 [label = '@@8']
                            tab9 [label = '@@9']
                            tab10 [label = '@@10']
                            tab11 [label = '@@11']
                            tab12 [label = '@@12']
                            tab13 [label = 'Process is repeated \n N times']
                            tab14 [label = 'For UA, index values are \n compared to nominal']
                            tab15 [label = 'For SA, sensitivity indicies \n are calculated']
                            tab1 -> tab2; tab2 -> tab3; tab2 -> tab4;
                            tab2 -> tab5; tab3 -> tab6; tab4 -> tab6;
                            tab5 -> tab6; tab6 -> tab7;
                            tab6 -> tab8; tab7 -> tab9;
                            tab8 -> tab9; tab9 -> tab10;
                            tab9 -> tab11; tab10 -> tab12; tab11 -> tab12;
                            tab12 -> tab13; tab13 -> tab2; tab13 -> tab14;
                            tab13 -> tab15
                            }
                            [1]: 'Imputed Data'
                            [2]: 'Normalization Strategy Selection'
                            [3]: 'Min-Max'
                            [4]: 'Z-Score'
                            [5]: 'Rank'
                            [6]: 'Weighting Strategy Selection'
                            [7]: 'Equal Weighting'
                            [8]: 'Set of Varied Weights'
                            [9]: 'Aggregation Strategy Selection'
                            [10]: 'Weighted Arithmetic Mean'
                            [11]: 'Weighted Geometric Mean'
                            [12]: 'Index Value'
                            ")

UASAProcessFlowchart %>%
  export_svg %>%
  charToRaw %>%
  rsvg_svg("UASAProcessFlowchart.svg")

#Drinking Water Data
WaterSummary <- read_excel("C:\\Users\\engla\\OneDrive\\Documents\\CompositeIndicatorConstruction\\Data\\ImputedWaterTreatmentPlantData.xlsx", sheet = "Summary")

#Wastewater Data
WastewaterSummary <- read_excel("C:\\Users\\engla\\OneDrive\\Documents\\CompositeIndicatorConstruction\\Data\\ImputedWastewaterTreatmentPlantData.xlsx", sheet = "Summary")

#####Drinking Water#####
###Correlation Testing
#Spearman Rank Correlation Test
cor.test(WaterSummary$Population, WaterSummary$Age, method = "spearman")
cor.test(WaterSummary$Population, WaterSummary$Capacity, method = "spearman")
cor.test(WaterSummary$Population, WaterSummary$Violations, method = "spearman")
cor.test(WaterSummary$Population, WaterSummary$Operators, method = "spearman")
cor.test(WaterSummary$Population, WaterSummary$WaterLoss, method = "spearman")
cor.test(WaterSummary$Population, WaterSummary$API, method = "spearman")
cor.test(WaterSummary$Age, WaterSummary$Capacity, method = "spearman")
cor.test(WaterSummary$Age, WaterSummary$Violations, method = "spearman")
cor.test(WaterSummary$Age, WaterSummary$Operators, method = "spearman")
cor.test(WaterSummary$Age, WaterSummary$WaterLoss, method = "spearman")
cor.test(WaterSummary$Age, WaterSummary$API, method = "spearman")
cor.test(WaterSummary$Capacity, WaterSummary$Violations, method = "spearman")
cor.test(WaterSummary$Capacity, WaterSummary$Operators, method = "spearman")
cor.test(WaterSummary$Capacity, WaterSummary$WaterLoss, method = "spearman")
cor.test(WaterSummary$Capacity, WaterSummary$API, method = "spearman")
cor.test(WaterSummary$Violations, WaterSummary$Operators, method = "spearman")
cor.test(WaterSummary$Violations, WaterSummary$WaterLoss, method = "spearman")
cor.test(WaterSummary$Violations, WaterSummary$API, method = "spearman")
cor.test(WaterSummary$Operators, WaterSummary$WaterLoss, method = "spearman")
cor.test(WaterSummary$Operators, WaterSummary$API, method = "spearman")
cor.test(WaterSummary$WaterLoss, WaterSummary$API, method = "spearman")

#2-Sample Kolmogorov-Smirnov Correlation Test
ks.test(WaterSummary$Population, WaterSummary$Age)
ks.test(WaterSummary$Population, WaterSummary$Capacity)
ks.test(WaterSummary$Population, WaterSummary$Violations)
ks.test(WaterSummary$Population, WaterSummary$Operators)
ks.test(WaterSummary$Population, WaterSummary$WaterLoss)
ks.test(WaterSummary$Population, WaterSummary$API)
ks.test(WaterSummary$Age, WaterSummary$Capacity)
ks.test(WaterSummary$Age, WaterSummary$Violations)
ks.test(WaterSummary$Age, WaterSummary$Operators)
ks.test(WaterSummary$Age, WaterSummary$WaterLoss)
ks.test(WaterSummary$Age, WaterSummary$API)
ks.test(WaterSummary$Capacity, WaterSummary$Violations)
ks.test(WaterSummary$Capacity, WaterSummary$Operators)
ks.test(WaterSummary$Capacity, WaterSummary$WaterLoss)
ks.test(WaterSummary$Capacity, WaterSummary$API)
ks.test(WaterSummary$Violations, WaterSummary$Operators)
ks.test(WaterSummary$Violations, WaterSummary$WaterLoss)
ks.test(WaterSummary$Violations, WaterSummary$API)
ks.test(WaterSummary$Operators, WaterSummary$WaterLoss)
ks.test(WaterSummary$Operators, WaterSummary$API)
ks.test(WaterSummary$WaterLoss, WaterSummary$API)

#Kendall-Tau Correlation Test
cor.test(WaterSummary$Population, WaterSummary$Age, method = "kendall")
cor.test(WaterSummary$Population, WaterSummary$Capacity, method = "kendall")
cor.test(WaterSummary$Population, WaterSummary$Violations, method = "kendall")
cor.test(WaterSummary$Population, WaterSummary$Operators, method = "kendall")
cor.test(WaterSummary$Population, WaterSummary$WaterLoss, method = "kendall")
cor.test(WaterSummary$Population, WaterSummary$API, method = "kendall")
cor.test(WaterSummary$Age, WaterSummary$Capacity, method = "kendall")
cor.test(WaterSummary$Age, WaterSummary$Violations, method = "kendall")
cor.test(WaterSummary$Age, WaterSummary$Operators, method = "kendall")
cor.test(WaterSummary$Age, WaterSummary$WaterLoss, method = "kendall")
cor.test(WaterSummary$Age, WaterSummary$API, method = "kendall")
cor.test(WaterSummary$Capacity, WaterSummary$Violations, method = "kendall")
cor.test(WaterSummary$Capacity, WaterSummary$Operators, method = "kendall")
cor.test(WaterSummary$Capacity, WaterSummary$WaterLoss, method = "kendall")
cor.test(WaterSummary$Capacity, WaterSummary$API, method = "kendall")
cor.test(WaterSummary$Violations, WaterSummary$Operators, method = "kendall")
cor.test(WaterSummary$Violations, WaterSummary$WaterLoss, method = "kendall")
cor.test(WaterSummary$Violations, WaterSummary$API, method = "kendall")
cor.test(WaterSummary$Operators, WaterSummary$WaterLoss, method = "kendall")
cor.test(WaterSummary$Operators, WaterSummary$API, method = "kendall")
cor.test(WaterSummary$WaterLoss, WaterSummary$API, method = "kendall")

###Normality Testing
#1-Sample Kolmogorov-Smirnov Normality Test
ks.test(WaterSummary$Population, "pnorm")
ks.test(WaterSummary$Age, "pnorm")
ks.test(WaterSummary$Capacity, "pnorm")
ks.test(WaterSummary$Violations, "pnorm")
ks.test(WaterSummary$Operators, "pnorm")
ks.test(WaterSummary$WaterLoss, "pnorm")
ks.test(WaterSummary$API, "pnorm")

#Shapiro-Wilk Normality Test
shapiro.test(WaterSummary$Population)
shapiro.test(WaterSummary$Age)
shapiro.test(WaterSummary$Capacity)
shapiro.test(WaterSummary$Violations)
shapiro.test(WaterSummary$Operators)
shapiro.test(WaterSummary$WaterLoss)
shapiro.test(WaterSummary$API)

#Anderson-Darling Normality Test
ad.test(WaterSummary$Population)
ad.test(WaterSummary$Age)
ad.test(WaterSummary$Capacity)
ad.test(WaterSummary$Violations)
ad.test(WaterSummary$Operators)
ad.test(WaterSummary$WaterLoss)
ad.test(WaterSummary$API)

NoCorrelationWaterSummary <- read_excel("C:\\Users\\engla\\OneDrive\\Documents\\CompositeIndicatorConstruction\\Data\\NoCorrelationWaterTreatmentPlantData.xlsx", sheet = "Summary")

###Code for Drinking Water Index
WaterMeta <- read_excel("C:\\Users\\engla\\OneDrive\\Documents\\CompositeIndicatorConstruction\\Data\\NoCorrelationWaterMeta.xlsx", sheet = 1)

WaterIndex <- new_coin(iData = NoCorrelationWaterSummary, iMeta = WaterMeta, level_names = c("Indicators", "Sub-Index", "Index"))

#Plotting Framework
plot_framework(WaterIndex)
plot_framework(WaterIndex, type = "stack", colour_level = 2)

l_Water_avail <- get_data_avail(WaterIndex, dset = "Raw", out2 = "list")
print(l_Water_avail)
min(l_Water_avail$Summary$Dat_Avail)

#Normalization
WaterIndex <- Normalise(WaterIndex,dset = "Raw", global_specs = list(f_n = "n_minmax", f_n_para = list(c(1,100))))

#Aggregation
WaterIndex <- Aggregate(WaterIndex, dset = "Normalised")

#Data Visualization
plot_bar(WaterIndex, dset = "Aggregated", iCode = "Index", axes_label = "iName")

#UA/SA Analysis Pre-Work
norm_alts <- list(list(f_n = "n_minmax", f_n_para = list(c(1,100))), list(f_n = "n_zscore", f_n_para = list(c(10,2))), list(f_n = "n_rank"))
l_norm <- list(Address = "$Log$Normalise$global_specs", Distribution = norm_alts, Type = "discrete")

w_nom <- WaterIndex$Meta$Weights$Original
noise_specs = data.frame(Level = c(1,2), NoiseFactor = c(0.25, 0.25))

noisy_wts <- get_noisy_weights(w = w_nom, noise_specs = noise_specs, Nrep = 100)

l_weights <- list(Address = "$Log$Aggregate$w", Distribution = noisy_wts, Type = "discrete")

l_agg <- list(Address = "$Log$Aggregate$f_ag", Distribution = c("a_amean", "a_gmean"), Type = "discrete")

SA_specs <- list(Normalisation = l_norm, Weights = l_weights, Aggregation = l_agg)

Alternate_Water_SA_specs <- list(Weight = l_weights, Aggregation = l_agg)

FurtherWaterUA <- get_sensitivity(WaterIndex, SA_specs = Alternate_Water_SA_specs, N = 100, SA_type = "UA", dset = "Aggregated", iCode = "Index")

FurtherWaterSA <- get_sensitivity(WaterIndex, SA_specs = Alternate_Water_SA_specs, N = 100, SA_type = "SA", dset = "Aggregated", iCode = "Index", Nboot = 100)

#Uncertainty Analysis
WaterUA <- get_sensitivity(WaterIndex, SA_specs = SA_specs, N = 100, SA_type = "UA", dset = "Aggregated", iCode = "Index")

DrinkingWaterUA <- plot_uncertainty(WaterUA)
print(WaterUA$RankStats)

DrinkingWaterUncertainty <- data.frame(x = c("Carter", "Bledsoe", "Carroll", "Scott", "Cocke", "Sullivan", "Williamson", "Lawrence", "Smith", "Houston", "Cheatham", "Davidson", "Wilson"),
                                       F = c(13,12,10,10,7,7,9,7,6,4,3,2,1),
                                       U = c(13,12,11,12,9,9,11,9,10,5,2,4,1), 
                                       L = c(13,10,8,7,5,4,5,5,5,2,3,2,1),
                                       N = c(13,12,11,10,9,8,7,6,5,4,3,2,1))
level_order <- DrinkingWaterUncertainty$x
DrinkingWaterUncertaintyPlot <- ggplot(DrinkingWaterUncertainty, aes(x = x, y = F)) + 
  geom_point(size = 2) + 
  geom_errorbar(aes(ymax = U, ymin = L)) + 
  xlab("Counties") + ylab("Rank") +
  theme_bw() + 
  theme(text = element_text(family = "Times", face = "plain", size = 14), axis.title.x = element_text(vjust = 0.5), axis.text.x = element_text(angle = 45, vjust = 0.6)) + 
  scale_y_continuous(trans = "reverse", breaks = c(13,11,9,7,5,3,1)) +
  scale_x_discrete(limits = level_order) + 
  geom_point(aes(x = x, y = N), shape = 4, size = 4)

ggsave("DrinkingWaterUncertaintyPlot.png", width = 28, height = 12, units = "cm")

#Sensitivity Analysis
WaterSA <- get_sensitivity(WaterIndex, SA_specs = SA_specs, N = 100, SA_type = "SA", dset = "Aggregated", iCode = "Index", Nboot = 100)
plot_sensitivity(WaterSA, ptype = "box")
DrinkingWaterSA <- plot_sensitivity(WaterSA, ptype = "bar")

DrinkingWaterBarPlotData <- data.frame(Method = c("Normalization", "Normalization", "Weights", "Weights", "Aggregation", "Aggregation"),
                                       Values = c(0,0.443,0.419,0.022,0.12,0.374),
                                       Type = c("Main Effect", "Interactions", "Main Effect", "Interactions", "Main Effect", "Interactions"))

DrinkingWaterBarPlot <- ggplot(DrinkingWaterBarPlotData, aes(x = Method, y = Values, fill = Type)) + 
  geom_bar(stat = "identity", position = "stack", width = 1.5) +
  xlab("Index Process") + ylab("Average Rank Change") +
  theme(text = element_text(family = "Times", face = "plain", size = 14)) +
  scale_x_discrete(limits = DrinkingWaterBarPlotData$Method)

ggsave("DrinkingWaterSABarPlot.png", width = 18, height = 12, units = "cm")

DrinkingWaterPieChartData <- data.frame(Method = c("Normalization", "Weights", "Aggregation", "Interactions"),
                                        Values = c(0,0.425,0.149,0.447),
                                        Type = c("Normalization", "Weights", "Aggregation", "Interactions"))

ggplot(DrinkingWaterPieChartData, aes(x = "", y = Values, fill = Type)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) + 
  theme_void() + 
  theme(text = element_text(family = "Times", face = "plain", size = 14))

DrinkingWaterSensitivityFirstPlot <- data.frame(Method = c("Normalization", "Weights", "Aggregation"),
                                                   Si = c(0, 0.419, 0.120),
                                                   Siq5 = c(0, 0.208, 0),
                                                   Siq95 = c(0.097, 0.608, 0.285))
DrinkingWaterSAOrder <- DrinkingWaterSensitivityFirstPlot$Method
DrinkingWaterFirstOrderSABoxPlot <- ggplot(DrinkingWaterSensitivityFirstPlot, aes(x = Method, y = Si)) + 
  geom_point(size = 2) +
  geom_errorbar(aes(ymax = Siq95, ymin = Siq5)) +
  xlab("Index Process") + ylab("Average Rank Change") +
  theme_bw() +
  theme(text = element_text(family = "Times", face = "plain", size = 14)) +
  scale_x_discrete(limits = DrinkingWaterSAOrder) + 
  scale_y_continuous(limits = c(0,0.65)) +
  ggtitle("Si") + 
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5))

DrinkingWaterSensitivitySecondPlot <- data.frame(Method = c("Normalization", "Weights", "Aggregation"),
                                                 STi = c(0.443, 0.441, 0.494),
                                                 STiq5 = c(0.394, 0.384, 0.408),
                                                 STiq95 = c(0.494, 0.501, 0.575))
DrinkingWaterTotalOrderSABoxPlot <- ggplot(DrinkingWaterSensitivitySecondPlot, aes(x = Method, y = STi)) + 
  geom_point(size = 2) + 
  geom_errorbar(aes(ymax = STiq95, ymin = STiq5)) + 
  xlab("Index Process") + ylab("") + 
  theme_bw() + 
  theme(text = element_text(family = "Times", face = "plain", size = 14)) + 
  scale_x_discrete(limits = DrinkingWaterSAOrder) + 
  scale_y_continuous(limits = c(0,0.65)) +
  ggtitle("STi") + 
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5), axis.text.y = element_blank(), axis.ticks.y = element_blank())

CombinedDrinkingWaterSAPlot <- grid.arrange(DrinkingWaterFirstOrderSABoxPlot, DrinkingWaterTotalOrderSABoxPlot, nrow = 1)

ggsave("DrinkingWaterSAConfidenceIntervalPlots.png", CombinedDrinkingWaterSAPlot, width = 25, height = 12, units = "cm")

#Removing Indicators
Water_res <- remove_elements(WaterIndex, Level = 1, dset = "Aggregated", iCode = "Index")

#Plot Making
DrinkingWaterIndicatorResults <- data.frame(County = c("Carter", "Bledsoe", "Carroll", "Scott", "Cocke", "Sullivan", "Williamson", "Lawrence", "Smith", "Houston", "Cheatham", "Davidson", "Wilson"),
                                            Index = c(19,33,40,42,46,47,48,49,50,64,68,70,78),
                                            Rurality = c("Urban", "Rural", "Rural", "Rural", "Rural", "Urban", "Urban", "Rural", "Rural", "Rural", "Rural", "Urban", "Rural"),
                                            Economic = c("At-Risk", "Distressed", "At-Risk", "Distressed", "Distressed", "Transitional", "Attainment", "Transitional", "Transitional", "At-Risk", "Competitive", "Competitive", "Competitive"))
ggplot(data = DrinkingWaterIndicatorResults, aes(x = County, y = Index, fill = Rurality)) + 
  geom_bar(stat = "identity") + 
  scale_x_discrete(limits = DrinkingWaterIndicatorResults$County) + 
  xlab("County") + ylab("Index Value") + 
  theme(text = element_text(family = "Times", face = "plain", size = 14)) + 
  scale_fill_manual(values = c("#008000", "#0000FF")) + 
  guides(fill = guide_legend(title = NULL)) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6)) + 
  geom_text(aes(label = Index, vjust = -0.5))

ggsave("DrinkingWaterResultsWithRurality.png", width = 28, height = 12, units = "cm")

DrinkingWaterIndicatorResultsEconomic <- data.frame(County = c("Carter", "Bledsoe", "Carroll", "Scott", "Cocke", "Sullivan", "Williamson", "Lawrence", "Smith", "Houston", "Cheatham", "Davidson", "Wilson"),
                                                    Index = c(19,33,40,42,46,47,48,49,50,64,68,70,78),
                                                    Economic = c("At-Risk", "Distressed", "At-Risk", "Distressed", "Distressed", "Transitional", "Attainment", "Transitional", "Transitional", "At-Risk", "Competitive", "Competitive", "Competitive"))

ggplot(data = DrinkingWaterIndicatorResultsEconomic, aes(x = County, y = Index, fill = Economic)) + 
  geom_bar(stat = "identity") + 
  scale_x_discrete(limits = DrinkingWaterIndicatorResultsEconomic$County) + 
  xlab("County") + ylab("Index Value") + 
  theme(text = element_text(family = "Times", face = "plain", size = 14)) + 
  guides(fill = guide_legend(title = NULL)) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6)) + 
  scale_fill_manual(values = c("Distressed" = "#FF0000", "At-Risk" = "#FFCC66", "Transitional" = "#76EEC6", "Competitive" = "#9999FF", "Attainment" = "#3A5FCD")) + 
  geom_text(aes(label = Index, vjust = -0.5))

ggsave("DrinkingWaterResultsWithEconomic.png", width = 28, height = 12, units = "cm")

#####Wastewater#####
###Correlation Testing
#Spearman Rank Correlation Test
cor.test(WastewaterSummary$Population, WastewaterSummary$Age, method = "spearman")
cor.test(WastewaterSummary$Population, WastewaterSummary$Capacity, method = "spearman")
cor.test(WastewaterSummary$Population, WastewaterSummary$Violations, method = "spearman")
cor.test(WastewaterSummary$Population, WastewaterSummary$Operators, method = "spearman")
cor.test(WastewaterSummary$Population, WastewaterSummary$II, method = "spearman")
cor.test(WastewaterSummary$Population, WastewaterSummary$API, method = "spearman")
cor.test(WastewaterSummary$Age, WastewaterSummary$Capacity, method = "spearman")
cor.test(WastewaterSummary$Age, WastewaterSummary$Violations, method = "spearman")
cor.test(WastewaterSummary$Age, WastewaterSummary$Operators, method = "spearman")
cor.test(WastewaterSummary$Age, WastewaterSummary$II, method = "spearman")
cor.test(WastewaterSummary$Age, WastewaterSummary$API, method = "spearman")
cor.test(WastewaterSummary$Capacity, WastewaterSummary$Violations, method = "spearman")
cor.test(WastewaterSummary$Capacity, WastewaterSummary$Operators, method = "spearman")
cor.test(WastewaterSummary$Capacity, WastewaterSummary$II, method = "spearman")
cor.test(WastewaterSummary$Capacity, WastewaterSummary$API, method = "spearman")
cor.test(WastewaterSummary$Violations, WastewaterSummary$Operators, method = "spearman")
cor.test(WastewaterSummary$Violations, WastewaterSummary$II, method = "spearman")
cor.test(WastewaterSummary$Violations, WastewaterSummary$API, method = "spearman")
cor.test(WastewaterSummary$Operators, WastewaterSummary$II, method = "spearman")
cor.test(WastewaterSummary$Operators, WastewaterSummary$API, method = "spearman")
cor.test(WastewaterSummary$II, WastewaterSummary$API, method = "spearman")

#2-Sample Kolmogorov-Smirnov Correlation Test
ks.test(WastewaterSummary$Population, WastewaterSummary$Age)
ks.test(WastewaterSummary$Population, WastewaterSummary$Capacity)
ks.test(WastewaterSummary$Population, WastewaterSummary$Violations)
ks.test(WastewaterSummary$Population, WastewaterSummary$Operators)
ks.test(WastewaterSummary$Population, WastewaterSummary$II)
ks.test(WastewaterSummary$Population, WastewaterSummary$API)
ks.test(WastewaterSummary$Age, WastewaterSummary$Capacity)
ks.test(WastewaterSummary$Age, WastewaterSummary$Violations)
ks.test(WastewaterSummary$Age, WastewaterSummary$Operators)
ks.test(WastewaterSummary$Age, WastewaterSummary$II)
ks.test(WastewaterSummary$Age, WastewaterSummary$API)
ks.test(WastewaterSummary$Capacity, WastewaterSummary$Violations)
ks.test(WastewaterSummary$Capacity, WastewaterSummary$Operators)
ks.test(WastewaterSummary$Capacity, WastewaterSummary$II)
ks.test(WastewaterSummary$Capacity, WastewaterSummary$API)
ks.test(WastewaterSummary$Violations, WastewaterSummary$Operators)
ks.test(WastewaterSummary$Violations, WastewaterSummary$II)
ks.test(WastewaterSummary$Violations, WastewaterSummary$API)
ks.test(WastewaterSummary$Operators, WastewaterSummary$II)
ks.test(WastewaterSummary$Operators, WastewaterSummary$API)
ks.test(WastewaterSummary$II, WastewaterSummary$API)

#Kendall-Tau Correlation Test
cor.test(WastewaterSummary$Population, WastewaterSummary$Age, method = "kendall")
cor.test(WastewaterSummary$Population, WastewaterSummary$Capacity, method = "kendall")
cor.test(WastewaterSummary$Population, WastewaterSummary$Violations, method = "kendall")
cor.test(WastewaterSummary$Population, WastewaterSummary$Operators, method = "kendall")
cor.test(WastewaterSummary$Population, WastewaterSummary$II, method = "kendall")
cor.test(WastewaterSummary$Population, WastewaterSummary$API, method = "kendall")
cor.test(WastewaterSummary$Age, WastewaterSummary$Capacity, method = "kendall")
cor.test(WastewaterSummary$Age, WastewaterSummary$Violations, method = "kendall")
cor.test(WastewaterSummary$Age, WastewaterSummary$Operators, method = "kendall")
cor.test(WastewaterSummary$Age, WastewaterSummary$II, method = "kendall")
cor.test(WastewaterSummary$Age, WastewaterSummary$API, method = "kendall")
cor.test(WastewaterSummary$Capacity, WastewaterSummary$Violations, method = "kendall")
cor.test(WastewaterSummary$Capacity, WastewaterSummary$Operators, method = "kendall")
cor.test(WastewaterSummary$Capacity, WastewaterSummary$II, method = "kendall")
cor.test(WastewaterSummary$Capacity, WastewaterSummary$API, method = "kendall")
cor.test(WastewaterSummary$Violations, WastewaterSummary$Operators, method = "kendall")
cor.test(WastewaterSummary$Violations, WastewaterSummary$II, method = "kendall")
cor.test(WastewaterSummary$Violations, WastewaterSummary$API, method = "kendall")
cor.test(WastewaterSummary$Operators, WastewaterSummary$II, method = "kendall")
cor.test(WastewaterSummary$Operators, WastewaterSummary$API, method = "kendall")
cor.test(WastewaterSummary$II, WastewaterSummary$API, method = "kendall")


###Normality Testing
#1-Sample Kolmogorov-Smirnov Normality Test
ks.test(WastewaterSummary$Population, "pnorm")
ks.test(WastewaterSummary$Age, "pnorm")
ks.test(WastewaterSummary$Capacity, "pnorm")
ks.test(WastewaterSummary$Violations, "pnorm")
ks.test(WastewaterSummary$Operators, "pnorm")
ks.test(WastewaterSummary$II, "pnorm")
ks.test(WastewaterSummary$API, "pnorm")

#Shapiro-Wilk Normality Test
shapiro.test(WastewaterSummary$Population)
shapiro.test(WastewaterSummary$Age)
shapiro.test(WastewaterSummary$Capacity)
shapiro.test(WastewaterSummary$Violations)
shapiro.test(WastewaterSummary$Operators)
shapiro.test(WastewaterSummary$II)
shapiro.test(WastewaterSummary$API)

#Anderson-Darling Normality Test
ad.test(WastewaterSummary$Population)
ad.test(WastewaterSummary$Age)
ad.test(WastewaterSummary$Capacity)
ad.test(WastewaterSummary$Violations)
ad.test(WastewaterSummary$Operators)
ad.test(WastewaterSummary$II)
ad.test(WastewaterSummary$API)

###Code for Wastewater Index
RedoneWastewaterMeta <- read_excel("C:\\Users\\engla\\OneDrive\\Documents\\CompositeIndicatorConstruction\\Data\\WastewaterMeta.xlsx", sheet = 1)

RedoneWastewaterIndex <- new_coin(iData = WastewaterSummary, iMeta = RedoneWastewaterMeta, level_names = c("Indicator", "Sub-Index", "Index"))

RedoneWastewaterIndex <- Normalise(RedoneWastewaterIndex, dset = "Raw", global_specs = list(f_n = "n_minmax", f_n_para = list(c(1,100))))

RedoneWastewaterIndex <- Aggregate(RedoneWastewaterIndex, dset = "Normalised")
plot_bar(RedoneWastewaterIndex, dset = "Aggregated", iCode = "Index", axes_label = "iName")
print(RedoneWastewaterIndex$Data$Aggregated$Index)
print(RedoneWastewaterIndex$Data$Aggregated$uCode)

RedoneWWnorm_alts <- list(list(f_n = "n_minmax", f_n_para = list(c(1,100))), list(f_n = "n_zscore", f_n_para = list(c(10,2))), list(f_n = "n_rank"))
RedoneWW_norm <- list(Address = "$Log$Normalise$global_specs", Distribution = RedoneWWnorm_alts, Type = "discrete")

RedoneWastewaterWeight_nom <- RedoneWastewaterIndex$Meta$Weights$Original
RedoneWWnoise_specs = data.frame(Level = c(1,2), NoiseFactor = c(0.25, 0.25))
RedoneWWnoisy_wts <- get_noisy_weights(w = RedoneWastewaterWeight_nom, noise_specs = RedoneWWnoise_specs, Nrep = 100)
RedoneWW_weights <- list(Address = "$Log$Aggregate$w", Distribution = RedoneWWnoisy_wts, Type = "discrete")

RedoneWW_agg <- list(Address = "$Log$Aggregate$f_ag", Distribution = c("a_amean", "a_gmean"), Type = "discrete")

RedoneWWSA_specs <- list(Normalisation = RedoneWW_norm, Weights = RedoneWW_weights, Aggregation = RedoneWW_agg)

RedoneWWUA <- get_sensitivity(RedoneWastewaterIndex, SA_specs = RedoneWWSA_specs, N = 100, SA_type = "UA", dset = "Aggregated", iCode = "Index", Nboot = 100)
WastewaterUA <- plot_uncertainty(RedoneWWUA)

WastewaterUncertainty <- data.frame(Name = c("Bledsoe", "Scott", "Carter", "Houston", "Cocke", "Smith", "Lawrence", "Wilson", "Carroll", "Sullivan", "Williamson", "Cheatham", "Davidson"),
                                    Median = c(13,12,9,11,10,8,6,7,6,4,3,3,1),
                                    Upper = c(13,13,11,11,11,10,7,7,7,4,4,4,2),
                                    Lower = c(12,12,8,9,8,8,5,5,5,1,1,2,1),
                                    Nominal = c(13,12,11,10,9,8,7,6,5,4,3,2,1))
WWlevel_order <- WastewaterUncertainty$Name
WastewaterUncertaintyPlot <- ggplot(WastewaterUncertainty, aes(x = Name, y = Median)) + 
  geom_point(size = 2) + 
  geom_errorbar(aes(ymax = Upper, ymin = Lower)) + 
  xlab("Counties") + ylab("Rank") +
  theme_bw() + 
  theme(text = element_text(family = "Times", face = "plain", size = 14), axis.title.x = element_text(vjust = 0.5), axis.text.x = element_text(angle = 45, vjust = 0.6)) + 
  scale_y_continuous(trans = "reverse", breaks = c(13,11,9,7,5,3,1)) + 
  scale_x_discrete(limits = WWlevel_order) + 
  geom_point(aes(x = Name, y = Nominal), shape = 4, size = 4)

ggsave("WastewaterUncertaintyPlot.png", width = 28, height = 12, units = "cm")

RedoneWWSA <- get_sensitivity(RedoneWastewaterIndex, SA_specs = RedoneWWSA_specs, N = 100, SA_type = "SA", dset = "Aggregated", iCode = "Index", Nboot = 100)
WastewaterSA <- plot_sensitivity(RedoneWWSA)
plot_sensitivity(RedoneWWSA, ptype = "box")

WastewaterSABarPlotData <- data.frame(Method = c("Normalization", "Normalization", "Weights", "Weights", "Aggregation", "Aggregation"),
                                      Value = c(0.216,0.508,0.172,0.075,0.2,0.22),
                                      Type = c("Main Effect", "Interactions", "Main Effect", "Interactions", "Main Effect", "Interactions"))

WastewaterBarPlot <- ggplot(WastewaterSABarPlotData, aes(x = Method, y = Value, fill = Type)) + 
  geom_bar(stat = "identity", position = "stack", width = 1.5) +
  xlab("Index Process") + ylab("Average Rank Change") +
  theme(text = element_text(family = "Times", face = "plain", size = 14)) +
  scale_x_discrete(limits = WastewaterSABarPlotData$Method)

ggsave("WastewaterSABarPlot.png", width = 18, height = 12, units = "cm")

WastewaterPiePlotData <- data.frame(Variable = c("Aggregation", "Interactions", "Normalization", "Weights"),
                                    Value = c(0.037,0.212,0.637,0.230))

WastewaterSensitivityPieChart <- ggplot(data = WastewaterPiePlotData, aes(x = "", y = Value, fill = Variable)) +
  geom_bar(stat = "identity", width = 2) +
  coord_polar("y", start = 0) + 
  theme_void()

WastewaterFirstOrderSensitivity <- data.frame(Method = c("Normalization", "Weights", "Aggregation"),
                                              Si = c(0.216, 0.172, 0.2),
                                              Siq5 = c(0.019, 0.069, 0.077),
                                              Siq95 = c(0.387, 0.296, 0.342))
WastewaterSensitivityOrder <- WastewaterFirstOrderSensitivity$Method
WastewaterSAFirstOrderBoxPlot <- ggplot(WastewaterFirstOrderSensitivity, aes(x = Method, y = Si)) + 
  geom_point(size = 2) + 
  geom_errorbar(aes(ymax = Siq95, ymin = Siq5)) + 
  xlab("Index Process") + ylab("Average Rank Change") + 
  theme_bw() + 
  theme(text = element_text(family = "Times", face = "plain", size = 14)) + 
  scale_x_discrete(limits = WastewaterSensitivityOrder) + 
  scale_y_continuous(limits = c(0, 0.85)) +
  ggtitle("Si") + 
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5))

WastewaterTotalOrderSensitivity <- data.frame(Method = c("Normalization", "Weights", "Aggregation"), 
                                              STi = c(0.724, 0.247, 0.420),
                                              STiq5 = c(0.640, 0.225, 0.350),
                                              STiq95 = c(0.806, 0.271, 0.504))
WastewaterSATotalOrderBoxPlot <- ggplot(WastewaterTotalOrderSensitivity, aes(x = Method, y = STi)) +
  geom_point(size = 2) + 
  geom_errorbar(aes(ymax = STiq95, ymin = STiq5)) + 
  xlab("Index Process") + ylab("") + 
  theme_bw() + 
  theme(text = element_text(family = "Times", face = "plain", size = 14)) + 
  scale_x_discrete(limits = WastewaterSensitivityOrder) + 
  scale_y_continuous(limits = c(0, 0.85)) +
  ggtitle("STi") + 
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5), axis.text.y = element_blank(), axis.ticks.y = element_blank())

CombinedWastewaterSAPlot <- grid.arrange(WastewaterSAFirstOrderBoxPlot, WastewaterSATotalOrderBoxPlot, nrow = 1)

ggsave("WastewaterSAConfidenceIntervalPlot.png", CombinedWastewaterSAPlot, width = 25, height = 12, units = "cm")

Wastewater_res <- remove_elements(RedoneWastewaterIndex, Level = 1, dset = "Aggregated", iCode = "Index")

#Plot Making
WastewaterIndexResultsWithRurality <- data.frame(County = c("Bledsoe", "Scott", "Carter", "Cocke", "Houston", "Smith", "Lawrence", "Wilson", "Carroll", "Sullivan", "Williamson", "Cheatham", "Davidson"),
                                                 Index = c(19,21,35,36,36,41,57,58,61,70,72,73,82),
                                                 Rurality = c("Rural", "Rural", "Urban", "Rural", "Rural", "Rural", "Rural", "Rural", "Rural", "Urban", "Urban", "Rural", "Urban"))

ggplot(data = WastewaterIndexResultsWithRurality, aes(x = County, y = Index, fill = Rurality)) + 
  geom_bar(stat = "identity") + 
  scale_x_discrete(limits = WastewaterIndexResultsWithRurality$County) + 
  xlab("County") + ylab("Index Value") + 
  theme(text = element_text(family = "Times", face = "plain", size = 14)) + 
  scale_fill_manual(values = c("#008000", "#0000FF")) + 
  guides(fill = guide_legend(title = NULL)) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6)) + 
  geom_text(aes(label = Index, vjust = -0.5))

ggsave("WastewaterResultsWithRurality.png", width = 28, height = 12, units = "cm")

WastewaterIndexResultsWithEconomic <- data.frame(County = c("Bledsoe", "Scott", "Carter", "Cocke", "Houston", "Smith", "Lawrence", "Wilson", "Carroll", "Sullivan", "Williamson", "Cheatham", "Davidson"),
                                                 Index = c(19,21,35,36,36,41,57,58,61,70,72,73,82),
                                                 Economic = c("Distressed", "Distressed", "At-Risk", "Distressed", "At-Risk", "Transitional", "Transitional", "Competitive", "At-Risk", "Transitional", "Attainment", "Competitive", "Competitive"))

ggplot(data = WastewaterIndexResultsWithEconomic, aes(x = County, y = Index, fill = Economic)) + 
  geom_bar(stat = "identity") + 
  scale_x_discrete(limits = WastewaterIndexResultsWithEconomic$County) + 
  xlab("County") + ylab("Index Value") + 
  theme(text = element_text(family = "Times", face = "plain", size = 14)) + 
  guides(fill = guide_legend(title = NULL)) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6)) + 
  scale_fill_manual(values = c("Distressed" = "#FF0000", "At-Risk" = "#FFCC66", "Transitional" = "#76EEC6", "Competitive" = "#9999FF", "Attainment" = "#3A5FCD")) + 
  geom_text(aes(label = Index, vjust = -0.5))

ggsave("WastewaterResultsWithEconomic.png", width = 28, height = 12, units = "cm")
