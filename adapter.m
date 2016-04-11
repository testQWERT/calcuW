groupNum=162;
pN=input('please input the number of patch:');
load(['../data/imgSet',num2str(pN),'.mat']);
featSum=zeros(size(imgSetA{1,1}.feature,1),1);
nodeNum=0;
for i=1:groupNum
    featSum=featSum+sum(imgSetA{1,i}.feature,2);
    nodeNum=nodeNum+size(imgSetA{1,i}.feature,2);
end
featSum=featSum/nodeNum;
for i=1:groupNum
    imgSetA{1,i}.wN=[];
    imgSetA{1,i}.wE=[];
    [imgSetA{1,i}.wN,imgSetA{1,i}.wE]=calcuW(imgSetA{1,i});
%     imgSetA{1,i}.wN=[];
%     imgSetA{1,i}.wE=[];
%     [imgSetA{1,i}.wN,imgSetA{1,i}.wE]=calcuWV2(featSum,imgSetA{1,i});
end
save(['../data/imgSet',num2str(pN),'(upperW=2).mat'],'imgSetA','imgSetB');