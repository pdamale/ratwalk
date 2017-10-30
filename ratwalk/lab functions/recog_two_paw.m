function [rf, lf, rr, lr] = recog_two_paw(e, rf, lf, rr, lr);

% 2 paw differenciating
w=1;
u2=0;
for n=1:75
x=e(:,1,n);
q=find(x);
[r c]=size(q);
if r==2
u2(w)=n;
w=w+1;
end;
end;
f=zeros(2,2,75);
[r1 c1]=size(u2);
for n1=1:c1
f(1:2,:,(u2(n1)))=e(1:2,:,(u2(n1)));
end;
f1=zeros(2,2);
for n2=1:c1
w2=u2(n2);
f1(:,:)=f(:,:,w2);
if f1(1,2)>310
   lr(w2,:)=f1(1,:);
else rr(w2,:)=f1(1,:);
end;
if f1(2,2)>310
    lf(w2,:)=f1(2,:);
else rf(w2,:)=f1(2,:);
end;
end;
