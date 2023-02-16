# Disparity-Index-Data-Storage-and-Code
This repository contains the code, data, and files used in "Quantifying Disparities in Public Potable Water and Wastewater Systems using a Disparity Index."
This repository contains the following files:

Excel files of the data used in the Drinking Water Disparity Index

Excel files of the data used in the Wastewater Disparity Index

Meta files used for the Drinking Water Disparity Index and Wastewater Disparity Index

Example data files and meta files for others to use

R Code used to run the analysis for both of the Disparity Indices

Here is what each file in the repository does:

COINrTesting.R - The actual code used in the creation of the Disparity Indices.

ExampleDataFile.xlsx - Is a blank data file for others to use. It is set up with an explanation on how to use it, what each indicator means, and how it should be formatted. It also has the equations already built in, so data can be enetered immediately.

ExampleMetaFile.xlsx - Is a blank meta file for others to use. It is formatted to meet the requirements for use in COINr. 

ExampleRFile.R - An R file that contains the example code and explanations of the process of index creation. Users can modify this code to fit their needs and analysis.

ImputedWastewaterTreatmentPlantData.xlsx and ImputedWaterTreatmentPlantData.xlsx - These files contain the imputed data for the drinking water and wastewater treatment plants used in the construction of the Disparity Indices. It is recommended that users make a new Excel file to contain their imputed data, so changes can be easily noticed.

NoCorrelationWaterMeta.xlsx - This file is the altered version of WaterMeta.xlsx that removed the "Operator" indicator from the analysis. Everything else is the same as WaterMeta.xlsx.

NoCorrelationWaterTreatmentPlantData.xlsx - This file is the altered version of the ImputedWaterTreatmentPlantData.xlsx. This file is the same as ImputedWaterTreatmentPlantData.xlsx, with the only difference being that Operators are removed from NoCorrelationWaterTreatmentPlantData.xlsx.

NoDistributionWaterTreatmentPlantData.xlsx - This is the original data file that was compiled for drinking water treatment plants. This file contains the raw data gathered for the analysis, before any imputation or correlation testing was conducted.

WastewaterMeta.xlsx - This file contains the meta file for the Wastewater Disparity Index. Since no significant correlations were found within the data, a separate meta file was not needed.

WastewaterTreatentPlantData.xlsx - This is the original data file that was compiled for wastewater treatment plants. This file contains te raw data gathered for the analysis, before any imputation or correlation testing was conducted.

WaterMeta.xlsx - This is the original meta file for the Drinking Water Disparity Index, before any correlation testing had taken place.

Here is a list of packages used in this analysis, as well as who created them and where to find more information about them:

tidyverse: Contians several R packages, including ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, and forcats. Developed by Hadley Wickham, Mara Averick, Jennifer Bryan, Winston Chang, Lucy D'Agostino McGowan, Romain François, Garrett Grolemund, Alex Hayes, Lionel Henry, Jim Hester, Max Kuhn, Thomas Lin Pedersen, Evan Miller, Stephan Milton Bache, Kirill Müller, Jeroen Ooms, David Robinson, Dana Paige Seidel, Vitalie Spinu, Kohske Takahashi, Davis Vaughan, Claus Wilke, Kara Woo, and Hiroaki Yutani. More information can be found here: https://www.tidyverse.org/packages/

ggplot2: Used to create plots and charts in the Thesis. Developed by Hadley Wickham. More information can be found here: https://cran.r-project.org/web/packages/ggplot2/index.html

readxl: Used to import Excel files into R. Developed by Hadley Wickham and Jennifer Bryan. More information can be found here: https://readxl.tidyverse.org/

nortest: Used to conduct the Anderson-Darling Normality Test. Developed by Juergen Gross and Uwe Ligges. More information can be found here: https://CRAN.R-project.org/package=nortest

dplyr: Used to manipulate data. Developed by Hadley Wickham, Romain François, Lionel Henry, Kirill Müller, and Davis Vaughan. More information can be found here: https://CRAN.R-project.org/package=dplyr and https://dplyr.tidyverse.org/

mosaic: Used to simplify data manipulation. Developed by Randall Pruim, Daniel T. Kaplan, and Nicholas J. Horton. More information can be found here: https://CRAN.R-project.org/package=mosaic 

devtools: Used to install packages. Developed by Hadley Wickham, Jim Hester, Winston Chang, and Jennifer Bryan. More information can be found here: https://CRAN.R-project.org/package=devtools and https://devtools.r-lib.org/

COINr: Used to develop the index equations and complete the construction processes. Developed by William Becker. More information can be found here: https://bluefoxr.github.io/COINr/index.html and https://bluefoxr.github.io/COINrDoc/

gridExtra: Used to create arrange multiple graphs into 1 figure. Developed by Baptiste Auguie and Anton Antonov. More information can be found here: https://CRAN.R-project.org/package=gridExtra

DiagrammeR: Used to create flowcharts that describe the processes. Developed by Richard Iannone. More information can be found here: https://CRAN.R-project.org/package=DiagrammeR

DiagrammeRsvg: Used to export DiagrammeR objects as SVGs. Developed by Richard Iannone. More information can be found here: https://CRAN.R-project.org/package=DiagrammeRsvg

rsvg: Used to manipulate svg files. Developed by Jeroen Ooms. More information can be found here: https://CRAN.R-project.org/package=rsvg

magrittr: Used as part of svg creation. Developed by Stefan Milton Bache and Hadley Wickham. More information can be found here: https://magrittr.tidyverse.org/
