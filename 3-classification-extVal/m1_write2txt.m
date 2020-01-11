% Prepare data for external validation.
% Training set: 50 IU tRCC cases and 50 IU ccRCC cases.
% External validation set: 14 Michigan tRCC cases, 10 TCGA tRCC cases, and 
% 24 TCGA ccRCC cases.

clear

% IU 50 tRCC and IU 50 ccRCC as training set
load('../data/allData.mat');
x = [iu_trImFeas; iu_ccImFeas];
y = [zeros(size(iu_trImFeas, 1), 1)+1; zeros(size(iu_ccImFeas, 1), 1)];
train = [y, x];

% 10 TCGA tRCCs, 14 Michigan tRCCs, and mathced 24 TCGA ccRCCs as external
% validation set
trImFeas = [mich_trImFeas; tcga_trImFeas];
x = [trImFeas; tcga_ccImFeas];
y = [zeros(size(trImFeas, 1), 1)+1; zeros(size(tcga_ccImFeas, 1), 1)];
test = [y, x];

dlmwrite('res_m1_data_train.txt', train, '\t');
dlmwrite('res_m1_data_test.txt', test, '\t');





