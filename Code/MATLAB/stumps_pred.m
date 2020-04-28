function [ypred]=stumps_pred(jn,th,Xte)
[m,~]=size(Xte);
c=Xte(:,jn);
I4=c<th;
ypred=zeros(m,1);
ypred(I4)=1;
ypred(I4==0)=-1;