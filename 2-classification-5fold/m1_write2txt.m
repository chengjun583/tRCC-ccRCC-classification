% Prepare data for five-fold cross validation using the IU dataset
% 50 tRCC cases and 50 ccRCC cases.

clear
rng('default');

load('../data/allData.mat', 'iu_trImFeas', 'iu_ccImFeas');

x = [iu_trImFeas; iu_ccImFeas];
y = [zeros(size(iu_trImFeas, 1), 1)+1; zeros(size(iu_ccImFeas, 1), 1)];

cvind = crossvalind('Kfold', y, 5);
for i = 1:5    
    indTe = cvind == i;
    indTr = ~indTe;

    train = [y(indTr), x(indTr, :)];
    test = [y(indTe), x(indTe, :)];
    
%     save(sprintf('res_m1_data_trainTest%d.mat', i), 'train', 'test');
    dlmwrite(sprintf('res_m1_data_train%d.txt', i), train, '\t');
    dlmwrite(sprintf('res_m1_data_test%d.txt', i), test, '\t');
end




