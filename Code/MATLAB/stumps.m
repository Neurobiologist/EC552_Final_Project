
function [jn,th]=stumps(Xtr,ytr,D)
Fn=inf;
[m,d]=size(Xtr);
for j=1:d
    [~,I]=sort(Xtr(:,j));
    Xtr=Xtr(I,:);
    D=D(I);
    
    ytr=ytr(I);

F=sum(D(ytr==1));
    if F<Fn 
        Fn=F;
        if j~=1
            th=Xtr(1,j-1);
        else
            th=Xtr(1,j);
        end
        jn=j;
    end
    for i=1:m
        F=F-ytr(i)*D(i);
        if i~=m
            if F<Fn && (Xtr(i,j)~=Xtr(i+1,j))
                Fn=F;
                th=0.5*(Xtr(i,j)+Xtr(i+1,j));
                jn=j;
            end
        elseif j~=d
            if F<Fn && (Xtr(i,j)~=Xtr(i,j+1))
                Fn=F;
                th=0.5*(Xtr(i,j)+Xtr(i,j+1));
                jn=j;
            end
        end
    end
        
        
    
end
%{
ss=Xtr(:,jn);
ss1=ss(ytr==1);
sy1=ytr(ytr==1);
ss2=ss(ytr==-1);
sy2=ytr(ytr==-1);
scatter(sy1,ss1,'o')
hold on
scatter(sy2,ss2,'x')
hold on
plot([-1,1],[th,th])


Xte=Xte';
yte=yte';
m=length(yte);
c=Xte(:,jn);
I4=c<th;
ypred=zeros(m,1);
ypred(I4)=1;
ypred(I4==0)=-1;
mean(yte==ypred)

%}