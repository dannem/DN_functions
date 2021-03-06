% for hj=3:54
    mov.recon_im=NaN(512,95,64,3);
    
    identity=42;
    before='tb';
    after='happ';
    dirCur='/Users/dannem/Documents/Reconstruction/Recon results/Time-domain reconstruction (average)';
    cd(dirCur);
    filesList=dir('*.mat');
    for i=1:size(filesList,1)
        data=load(filesList(i).name);
        names=fieldnames(data);
        
        indB=strfind(filesList(i).name,before)+3;
        if isempty(strfind(filesList(i).name,after))
            
        else
            indA=strfind(filesList(i).name,after);
            timeBin=str2num(filesList(i).name(indB:indA-2));
            eval(['recns=data.' names{:} '.recon_mat_sq;']);
            eval(['b=data.' names{:} '.ims;']);
            eval(['c=data.' names{:} '.labout;']);
            a=recns(:,:,:,identity+60);
            b=b{identity+60};
            a=uint8(lab2rgb(a));
            mov.recon_im(timeBin,:,:,:)=a;
            mov.orig_im=b;
            if after=='neut'
                [~,~,obj_res,~]=obj_test(recns(:,:,:,1:54),c(1:54),0.05,1);
            elseif after=='happ'
                [~,~,obj_res,~]=obj_test(recns(:,:,:,61:114),c(61:114),0.05,1);
            end
            mov.accrFace(timeBin)=obj_res(identity);
            mov.accAll(timeBin)=mean(obj_res);
        end
        
    end
    counter=5;
    for i=1:512
        if isnan(mov.recon_im(i,1,1,1))
            mov.recon_im(i,:,:,:)=mov.recon_im(counter,:,:,:);
            mov.accrFace(i)=mov.accrFace(counter);
            mov.accAll(i)=mov.accAll(counter);
        else
            counter=i;
        end
    end
%     allmov(hj)=mov;
%     matacc(hj,:)=mov.accrFace;
%     matall(hj,:)=mov.accAll;
%     hj
% end
% cor=[];
% for i=1:54
%     temp=corrcoef(matacc(i,:)',matall(i,:)');
%     cor(i)=temp(2,1);
% end
%% plotting
fig = figure('position',[100 100 550 500]);
% x = 1:10;
for i = 1:512
s1=subplot(2,2,2);
imagesc(squeeze(uint8(mov.recon_im(i,:,:,:))))
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
title('Reconstructed face')
p = get(s1,'position');
p(4) = p(4)*1.20; % Add 10 percent to height
set(s1, 'position', p);
% text(55,10,num2str(round(mov.accrFace(i),2)),'Color','white','FontSize',14)
s2=subplot(2,2,1);
p = get(s2,'position');
p(4) = p(4)*1.20; % Add 10 percent to height
% p(3) = p(3)*1.10; % Add 10 percent to height
set(s2, 'position', p);
imagesc(squeeze(uint8(mov.orig_im(:,:,:))))
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
title('Original face')
subplot(2,2,[3,4]);
endPoint=i*1000/512-100
plot(linspace(-100,round(endPoint),i),mov.accAll(1:i));
hold on
plot(linspace(-100,round(endPoint),i),mov.accrFace(1:i));
hold off
axis([-100 900 0.2 0.9])
title('Average reconstruction accuracy')
% text(200,200,num2str(mov.accrFace(i)),'Color','white','FontSize',14)
legend('Average accuracy','Individual face accuracy')
f(i) = getframe(fig);
end

%% making a movie
% f=f10
movie2avi(f,'myavifile42.avi')

%% showing movie
close all
[h, w, p] = size(f(1).cdata);  % use 1st frame to get dimensions
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf, 'position', [150 150 w h]);
axis off
movie(hf,f);
implay(f)