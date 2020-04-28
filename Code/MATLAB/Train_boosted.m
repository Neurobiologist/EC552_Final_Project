function [alpha, DTCell] = Train_boosted(Xtr, ytr, T)
[m,~]=size(Xtr);
D=ones(1,m)/m;
alpha=zeros(T,1);
DTCell=zeros(T,2);
%tr_err=zeros(T,1);
for i=1:T
    train=i
    [DTCell(i,1),DTCell(i,2)]=stumps(Xtr,ytr,D);
  
    y=stumps_pred(DTCell(i,1),DTCell(i,2),Xtr);
    tf=ytr~=y;
    e=D*tf;
    alpha(i)=0.5*log(1/e-1);
    a=alpha(i);
    %{
    for j=1:i
        ypred = test_boosted_dt(Xtr, alpha(1:i), DTCell(1:i));
        tr_err(i) = mean(ypred~=ytr);
    end
    %}
    D=D.*(exp(-1*a*ytr.*y))';
    D=D/sum(D);
end