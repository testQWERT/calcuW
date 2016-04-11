% imA包括pic,no,person,feature,edgefeat,wN,wE。person包括patchNum,data{n,2}，num，patch{n,pN,2},patchfeature{n,pN},feature{n}
input='imgSet2(w=1).mat';
output='imgSet2(knnE).mat';
groupNum=162;
coffForSalienceLen=1;%数越大长度越重要
addpath('..');
load(['../data/',input]);
load('../peopleNum.mat');
edgeNumA=zeros(1,groupNum);
for i=2:groupNum
    edgeNumA(i)=edgeNumA(i-1)+size(imgSetA{1,i-1}.edgefeat,2);%edgeNumA2前面已经有了多少个边
end
A=[];
x=zeros(10,1);
x(1)=1;x(2)=0.4578;x(3)=0.0439;%通过跟最小距离边的相似程度来确定这个边的边长权值
for i=1:groupNum
    for j=1:size(imgSetA{1,i}.edgefeat,2)
        a=imgSetA{1,i}.edgefeat(1,j);
        b=imgSetA{1,i}.edgefeat(2,j);
        tmp2=imgSetA{1,i}.feature(:,a)./(0.001+imgSetA{1,i}.feature(:,b))+imgSetA{1,i}.feature(:,b)./(0.001+imgSetA{1,i}.feature(:,a));
        A=[A,tmp2];
        disp(['present: ',num2str(i),' ',num2str(j)]);
    end
end
dist=sqdist(A, A, 1);

for i=1:groupNum
    for j=1:size(imgSetA{1,i}.edgefeat,2)
        value2=sqdist([x imgSetA{1,i}.edgefeat(end-9:end,j)], [x imgSetA{1,i}.edgefeat(end-9:end,j)], 1);
        value2=3-value2(1,2);
        value2=value2-1.5;
        value2=1+(1/(1+exp(-value2))-0.5);
        [~,loc]=sort(dist(edgeNumA(i)+j,:),'ascend');
        offset=mean(dist(edgeNumA(i)+j,:));
        tmp=loc(round(size(loc,2)/2));
        value1=dist(edgeNumA(i)+j,tmp);
        value1=(value1-offset)/offset*30;
        value1=1+(1/(1+exp(-value1))-0.5);
        value=(value1+coffForSalienceLen*value2)/(coffForSalienceLen+1);
        imgSetA{1,i}.wE(j)=value;
    end
end
save(['../data/',output],'imgSetA','imgSetB');