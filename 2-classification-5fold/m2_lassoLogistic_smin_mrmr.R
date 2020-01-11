# Logistic regression with five-fold cross validation

rm(list = ls())
ptm <- proc.time()

library(glmnet)
library(ROCR)
library(MLmetrics)
library(mRMRe)
#set.seed(1)

meanAUC = 0;
for (i in 1:5) {
  set.seed(1)
  mydata = read.table(paste0('res_m1_data_train', i, '.txt'), header = FALSE)
  mydata = data.matrix(mydata)
  s1Tr = nrow(mydata)
  s2Tr = ncol(mydata)
  yTr = mydata[, 1]
  xTr = mydata[, 2:s2Tr]
  
  mydata = read.table(paste0('res_m1_data_test', i, '.txt'), header = FALSE)
  mydata = data.matrix(mydata)
  s1Te = nrow(mydata)
  s2Te = ncol(mydata)
  yTe = mydata[, 1]
  xTe = mydata[, 2:s2Te]
  
  wei = numeric(s1Tr)
  wei[yTr==1] = 1 #sum(yTr==0)/sum(yTr==1)
  wei[yTr==0] = 1
  
  # Feature selection
  df = data.frame(yTr, xTr)
  dd = mRMR.data(data = df)
  sel = mRMR.ensemble(data = dd, target_indices = c(1), solution_count = 1, feature_count = 30)
  feaInd = sel@filters[[1]] - 1
  
  cvfit = cv.glmnet(xTr[, feaInd], yTr, weights = wei, family = "binomial", type.measure = 'class', maxit = 500000)
  prob = predict(cvfit, newx = rbind(xTe[, feaInd]), s = 'lambda.min', type="response")
  pred = predict(cvfit, newx = rbind(xTe[, feaInd]), s = 'lambda.min', type="class")
  
  imFeaName = read.table('../data/imFeaName.txt', header = T)
  iuiuCoef = coef(cvfit, s = 'lambda.min')
  nameSel = imFeaName[feaInd]
  nameSel = nameSel[iuiuCoef@i[-1]]
  model = data.frame(feaName = c('intercept', nameSel), coef = iuiuCoef@x)
  
  predObj <- prediction(prob, yTe)
  perf <- performance(predObj, "tpr", "fpr")
  
  spe = 1 - perf@x.values[[1]]
  sen = perf@y.values[[1]]
  speSenSum = sen+spe
  iuiuYouden = data.frame(sen, spe, speSenSum)
  
  rNames = c('auc', 'sen', 'spe', 'f1', 'precision');
  resMetrics = matrix(0, nrow = length(rNames), ncol = 1, dimnames = list(rNames, c()))
  resMetrics[1] = AUC(y_pred = prob, y_true = yTe)
  resMetrics[2] = Sensitivity(y_pred = pred, y_true = yTe, positive = "1")
  resMetrics[3] = Specificity(y_pred = pred, y_true = yTe, positive = "1")
  confMat_iuiu = ConfusionMatrix(y_pred = pred, y_true = yTe)
  
  resMetrics[4] = F1_Score(y_pred = pred, y_true = yTe, positive = "1")
  resMetrics[5] = Precision(y_pred = pred, y_true = yTe, positive = "1")
  print(resMetrics)
  
  # Plot roc
  par(pty="s")
  plot(perf, asp=1)
  text(0.5, 0.1, paste0('AUC=', resMetrics[1]), pos = 4, cex = 1)
  grid()
  
  meanAUC = meanAUC + resMetrics[1]
  save(resMetrics, iuiuCoef, iuiuYouden, model, file = paste0('res_m2_logistic_smin_mrmr', i, '.RData'))
}

meanAUC = meanAUC/5
print(paste0('mean AUC of five-fold cross validation is: ', meanAUC))

print(proc.time() - ptm)