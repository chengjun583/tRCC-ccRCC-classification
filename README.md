# tRCC-ccRCC-classification
Xp11.2 translocation renal cell carcinoma (tRCC) generally progresses more aggressively compared with other RCC subtypes, but it is difficult to diagnose tRCC by traditonal visual inspection of histopathological images. In this project, we used computational pathological analysis and machine learning to distinguish tRCC from clear cell renal cell carcinoma (ccRCC, the most common RCC subtype).  

We extracted 150 morphological features from H&E stained whole-slide images and conducted the following three experiments. 

Experiment 1: comparing each feature between the two subtypes
---
(This corresponds to the folder "1-uTest")<br>
The Mann-Whitney U test was used to compare the 150 image features between tRCC and ccRCC, and the false discovery rate procedure was used for multiple testing corrections.

Experiment 2: evaluating the performance of four classifiers on dataset 1 with five-fold cross validation 
---
(This corresponds to the folder "2-classification-5fold")<br>
Dataset 1 is an internal dataset from Indiana University, containing 50 tRCC cases and 50 ccRCC cases with matched gender and tumor grade. Based on the image features, we trained and tested four classifiers (logistic regression, random forest, SVM with Gaussian kernel, and SVM with linear kernel) with five-fold cross validation to classify tRCC and ccRCC. 

Experiment 3: evaluating the performance of four classifiers on an external validation set (dataset 2) 
---
(This corresponds to the folder "3-classification-extVal")<br>
Dataset 2 is an external validation dataset from the Univeristy of Michigan and TCGA, containing 24 tRCC cases and 24 ccRCC cases with matched gender and tumor grade. Based on the image features, we trained the four classifiers using dataset 1 and test them using dataset 2.

What is each folder for?
---
Folders "1-uTest", "2-classification-5fold", and "3-classification-extVal" correspond to the three experiments explained above. "data" contains the image features extracted from whole-slide images, and "tools" contains a third-party matlab function for multiple testing correction.

How to run the code
---
For the three abovementioned experiments, run the scripts in the corresponding folders sequentially as indicated by the file names (run "m1_xxx" first, then 'm2_xxx').

Contact information
---
If you have any questions, feel free to contact me.

Jun Cheng<br>
Shenzhen University, Shenzhen, China <br>
E-mail: chengjun583@qq.com

