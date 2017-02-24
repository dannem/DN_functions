function output=loadAllFiles(dirc,fileFormat)
cd(dirc)
files=dir(['*.' fileFormat]);
imNum=size(files,1);
output=struct;
for i=1:imNum
%     clearvars -except files imNum 
%     a=whos;
    output(i).data=load(files(i).name);
    output(i).name=files(i).name;
end
    