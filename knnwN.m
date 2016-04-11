%   imA包括pic,no,person,wE,wN。person包括data{n,2}，num，patch{n,6,2},patchfeature{n,6},feature{n},patchNum
input='imgSet2(knnE).mat';
output='imgSet2(knnN+knnE).mat';
groupNum=162;

addpath('..');
load(['../data/',input]);
load('../peopleNum.mat');
peopleNumA2=peopleNumA;peopleNumA2(1)=0;
for i=2:size(peopleNumA,2)
    peopleNumA2(i)=peopleNumA2(i-1)+peopleNumA(i-1);%peopleNumA2中每个元素储存的是前面已经有了多少个人
end
pN=imgSetA{1,1}.person.patchNum;
pNN=1:round(pN);
A=[];

for i=1:groupNum
    for j=1:imgSetA{1,i}.person.num
        A=[A,imgSetA{1,i}.feature(:,(j-1)*pN+pNN)];
    end
end
dist=sqdist(A, A, 1);
offset=max(max(dist));
for i=1:groupNum
    for j=1:imgSetA{1,i}.person.num*pN
        if (rem(j,pN)/pN<=0.5)&&(rem(j,pN)~=0)
            tmp=floor(j/pN)*round(pN/2)+rem(j,pN);
            [~,loc]=sort(dist(peopleNumA2(i)*round(pN/2)+tmp,:),'ascend');
            value=dist(peopleNumA2(i)*round(pN/2)+tmp,loc(round(size(loc,2)/2)));
            value=value-offset/2;
            value=1.1+(1/(1+exp(-value))-0.5)*0.1;
            imgSetA{1,i}.wN(j)=value;
        else
            imgSetA{1,i}.wN(j)=1;
        end
    end
end
save(['../data/',output],'imgSetA','imgSetB');