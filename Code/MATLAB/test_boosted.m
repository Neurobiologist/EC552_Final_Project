function [ypred,margin] = test_boosted(Xte, alpha, DTCell)
[m,~]=size(Xte);

T=length(alpha);

  
s=0;
n=0;
for j=1:T
    s=s+alpha(j)*stumps_pred(DTCell(j,1),DTCell(j,2),Xte);
    n=n+abs(alpha(j));
end
ypred=sign(s);
margin=s/n;