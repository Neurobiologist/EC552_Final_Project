T=100;
TT=1000;
Xtr=zeros(TT,3);
ytr=zeros(TT,1);
for i=1:TT;
f=0.7+(2-0.7)*rand; %bloodflow
 q=0.005+(0.02-0.005)*rand;
 p=0.01+(0.99-0.01)*rand;
 %blood=0.7:0.01:2;
%immune=0.01:0.01:0.99;
%permeability=0.005:0.001:0.02;
%r=zeros(1,length(blood));
%for i=1:length(blood)
  %  f=blood(i);
%p=immune(i);
%q=permeability(i);
ct=zeros(1,100);
mt=zeros(1,100);



for n=2:300
    ct(n)=ct(n-1)+q*(f*T-p*ct(n-1));
    if ct(n-1)<50;
        s=0;
    else
        s=q*(ct(n-1)-50)+q*mt(n-1);
    end
    mt(n)=mt(n-1)+s;
   
end
%{
plot(ct,'r')
hold on
plot(mt)
set(gca,'fontsize', 24)
legend('CTCs','metastasized tumor cells')
xlabel('unit time')
ylabel('unit level')
%}




a=abs(mt(300)+normrnd(0,100));
if a<1000
    ytr(i)=1;
elseif a>1000 && a<10000
    ytr(i)=2;
else
    ytr(i)=3;
end
    
Xtr(i,:)=[f,q,p];

end

 %{
%1000   10000
a1=ytr==1;
a2=ytr==2;
a3=ytr==3;
x1=Xtr(a1,1);
x2=Xtr(a2,1);
x3=Xtr(a3,1);
y1=Xtr(a1,2);
y2=Xtr(a2,2);
y3=Xtr(a3,2);
z1=Xtr(a1,3);
z2=Xtr(a2,3);
z3=Xtr(a3,3);
s1=scatter3(x1,y1,z1);
set(s1,'markeredgecolor','g')

hold on
s2=scatter3(x2,y2,z2);
set(s2,'markeredgecolor','b')
hold on
s3=scatter3(x3,y3,z3);
set(s3,'markeredgecolor','r')
l={'Low','Mid','Severe'};
legend([s1,s2,s3],l)
xlabel('capillaries proliferation')
ylabel('permeability')
zlabel('immunity')
set(gca,'fontsize', 24)
%}

Xtr=[Xtr,-1*Xtr];
ytr1=zeros(TT,1);
ytr2=zeros(TT,1);
ytr3=zeros(TT,1);
ytr1(ytr==1)=1;
ytr1(ytr~=1)=-1;
ytr2(ytr==2)=1;
ytr2(ytr~=2)=-1;
ytr3(ytr==3)=1;
ytr3(ytr~=3)=-1;

idx=randperm(numel(ytr));
Xtr=Xtr(idx,:);
ytr=ytr(idx);
ytr1=ytr1(idx);
ytr2=ytr2(idx);
ytr3=ytr3(idx);


a=round(TT*0.8);
X1=Xtr(1:a,:);
X2=Xtr(a+1:TT,:);
y1=ytr1(1:a);
y2=ytr2(1:a);
y3=ytr3(1:a);
Y2=ytr(a+1:TT);
Y1=ytr(1:a);
[alpha1, DTCell1] = Train_boosted(X1, y1, 100);
[alpha2, DTCell2] = Train_boosted(X1, y2, 100);
[alpha3, DTCell3] = Train_boosted(X1, y3, 100);
%ypred=zeros(TT-a,3);
%margin=zeros(TT-a,3);
yp=zeros(TT-a,1);
yp1=zeros(length(Y1),1);
test=zeros(100,1);
train=zeros(100,1);
for i=1:100

[~,margin(:,1)] = test_boosted(X2, alpha1(1:i), DTCell1(1:i,:));
[~,margin(:,2)] = test_boosted(X2, alpha2(1:i), DTCell2(1:i,:));
[~,margin(:,3)] = test_boosted(X2, alpha3(1:i), DTCell3(1:i,:));
for j=1:length(Y2)
    [~,yp(j)]=max(margin(j,:));
end
test(i)=mean(yp~=Y2)*100;


[~,margin1(:,1)] = test_boosted(X1, alpha1(1:i), DTCell1(1:i,:));
[~,margin1(:,2)] = test_boosted(X1, alpha2(1:i), DTCell2(1:i,:));
[~,margin1(:,3)] = test_boosted(X1, alpha3(1:i), DTCell3(1:i,:));
for j=1:length(Y1)
    [~,yp1(j)]=max(margin1(j,:));
end
train(i)=mean(yp1~=Y1)*100;



end


plot(train,'b')
hold on
plot(test,'r')
legend('training error','testing error')
xlabel('rounds of boosting')
ylabel('% error')
set(gca,'fontsize', 24)



%{
idx=randperm(numel(ytr));
Xtr=Xtr(idx,:);
ytr=ytr(idx);

a=round(TT*0.8);
X1=Xtr(1:a,:);
y1=ytr(1:a);
X2=Xtr(a+1:TT,:);
y2=ytr(a+1:TT);

a1=y1==1;
s1=sum(a1);
a2=y1==2;
s2=sum(a2);
a3=y1==3;
s3=sum(a3);
x1=X1(a1,:);
x2=X1(a2,:);
x3=X1(a3,:);


ss=min([s1,s2,s3]);
xx1=[x1(1:ss,:);x2(1:ss,:);x3(1:ss,:)];
yy1=[ones(ss,1);ones(ss,1)*2;ones(ss,1)*3];

Mdl = fitcknn(xx1,yy1);
 ypred=predict(Mdl,X2);
error=mean(ypred~=y2)



 scatter3(x1(1:ss,1),x1(1:ss,2),x1(1:ss,3),'r')
hold on
scatter3(x2(1:ss,1),x2(1:ss,2),x2(1:ss,3),'g')
hold on
scatter3(x3(1:ss,1),x3(1:ss,2),x3(1:ss,3),'b')
%}
%}