function [rf, lf, rr, lr] = recog_three_paw(e)

%  3 paw partial differencing
w=1;
for n=1:75
x=e(:,1,n);
q=find(x);
[r c]=size(q);
if r==3
u1(w)=n;
w=w+1;
end;
end;
f=zeros(3,2,75);
[r1 c1]=size(u1);
for n1=1:c1
f(1:3,:,(u1(n1)))=e(1:3,:,(u1(n1)));
end;
f1=zeros(3,2);
for n2=1:c1
w2=u1(n2);
f1(:,:)=f(:,:,w2);
if f1(1,2)>310
lr(w2,:)=f1(1,:);
else rr(w2,:)=f1(1,:);
end;
if f1(3,2)>310
lf(w2,:)=f1(3,:);
else rf(w2,:)=f1(3,:);
end;
end;
