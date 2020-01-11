# tRCC-ccRCC-classification
Translocation renal cell carcinoma (tRCC) is difficult to be distinguished from other renal cell carcinoma based on visual inspection of histopathological images. In this project, we used computational pathological analysis and machine learning to distinguish tRCC from clear cell renal cell carcinoma (the most common RCC subtype).  

We extracted 150 morphological features from whole-slide images and conducted two experiments. 

Experiment 1 corresponds to the folder "exp1_Utest"
---
The Mann-Whitney U test was used to compare the 150 image features between tRCC and ccRCC, and the false discovery rate procedure was used for multiple testing corrections.

Experiment 2 corresponds to the folder "exp2_classification" 
---
We first used the MRMR algorithm to select features, and then the selected features were used to train a lasso logistic regression model to classify tRCC and ccRCC. 

How to run the code
---
In the two abovementioned folders, run the scripts sequentially as indicated by the file names (run "m1_xxx" first, then 'm2_xxx').

Contact information
---
If you have any questions, feel free to contact me.

Jun Cheng<br>
Shenzhen University, Shenzhen, China <br>
E-mail: chengjun583@qq.com

