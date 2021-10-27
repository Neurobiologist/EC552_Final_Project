# EC552_Final_Project

## Introduction

Metastasis is a major predictor of morbidity and mortality in cancer patients, but the details of this process are poorly understood. Here we report the design and characterization of a microfluidic assay developed to quantify the proliferative index of metastatic breast cancer cells and elucidate their molecular and genetic features.
These data can be used to develop novel therapeutics to target and inhibit specific stages of metastatic progression. Full report available [here](https://github.com/Neurobiologist/EC552_Final_Project/blob/master/Microfluidics_EC552_Literature%20Review%20and%20Project%20Summary.pdf).



## Usage
COMSOL
1. Open .mph file in COMSOL
2. Under the Model Builder window, go to Study 1
3. You can either right click and click compute, or you can use the bottom at the top menu bar
4. Click Study 2
5. You can either right click and click compute, or you can use the bottom at the top menu bar
6. Click Study 3
7. You can either right click and click compute, or you can use the bottom at the top menu bar
8. To view results you can click on the Results tab in the Model Builder Window

Python
1. Run dataset.py in order to generate synthetic data. Data is already provided in the folders.
2. Run main.py in order to run the linear regression on the generated data. 
3. A loss graph as well as a list of parameter weights and the error in the console will be produced after the program is run.

MATLAB
1. Run EC552_final_project.m in MATLAB and it will generate the training/testing data in X1/Y1 X2/Y2 and the three boosting algorithm that will allow multiclass classification. 
2. The 3D scatter plot of artificial data and the training and testing error plot will be displayed at the end.
