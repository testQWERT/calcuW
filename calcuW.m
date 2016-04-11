function [ wN,wE ] = calcuW( img )
%UNTITLED3 Summary of this function goes here
%   imA°üÀ¨pic,no,person¡£person°üÀ¨data{n,2}£¬num£¬patch{n,6,2},patchfeature{n,6},feature{n},patchNum
pN=img.person.patchNum;
wN=zeros(img.person.num*pN,1);
wE=zeros(nchoosek(img.person.num,2)*pN^2,1);
tmp=[];
for i=1:img.person.num*pN
    %     cumu=0;
    %     from=50*img.person.data{i,2}(2)/175;
    %     to=120*img.person.data{i,2}(2)/175;
    %     for j=1:img.person.num
    %         if i==j
    %             continue;
    %         else
    %            if j>i
    %                tmp=[tmp,norm(img.person.data{i,1}-img.person.data{j,1})];
    %            end
    %            x=norm(img.person.data{i,1}-img.person.data{j,1});
    %            cumu=cumu+myLine(x,from,to);
    %         end
    %     end
    %     cumu=2/(1+exp(-cumu));
    %    cumu=1;
    %     if rem(i,2)==1
    %         wN(i)=2;
    %     else
    wN(i)=1;
    %     end
end
% length=max(tmp);
% unit=length/10;
for i=1:nchoosek(img.person.num,2)
%     w=5-floor(tmp(i)/unit);
%     w=2/(1+exp(-w));
%    w=1;
    wE((i-1)*pN^2+1:i*pN^2)=repmat(1,pN^2,1);
end
end

function [result]=myLine(x,from,to)
if x<=from
    result=1;
elseif x>to
    result=0;
else
    k=1/(from-to);
    b=-to*k;
    result=x*k+b;
end
end

