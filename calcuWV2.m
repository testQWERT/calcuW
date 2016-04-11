function [ wN,wE ] = calcuWV2( featSum,img)
%UNTITLED Summary of this function goes here
%   wN每一行是一个patch的权重向量，不同的行代表不同的patch
pN=img.person.patchNum;
wN=zeros(img.person.num*img.person.patchNum,size(featSum,1));
wE=zeros(nchoosek(img.person.num,2)*img.person.patchNum^2,1);
for i=1:size(img.feature,2)
    wN(i,:)=(abs(img.feature(:,i)-featSum))';
    wN(i,:)=wN(i,:)./(2*median(wN(i,:)'));
    wN(i,:)=4./(1+exp(-wN(i,:)));%权重只能在1到2之间取值
end
tmp=[];
for i=1:img.person.num
    for j=1:img.person.num
        if i==j
            continue;
        else
           if j>i
               tmp=[tmp,norm(img.person.data{i,1}-img.person.data{j,1})];
           end
        end
    end
end
length=max(tmp);
unit=length/10;
for i=1:nchoosek(img.person.num,2)
    w=5-floor(tmp(i)/unit);
    w=2/(1+exp(-w));
%    w=1;
    wE((i-1)*pN^2+1:i*pN^2)=repmat(w,pN^2,1);
end
end

