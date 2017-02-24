function distMat=distancePlot(x,y)
if size(x)==size(y)
else
    error ('The input matrices must be of the same size')
end
temp=sqrt(sum((x-y).^2,2));
distMat=temp;
temp=temp./max(temp);
temp=temp*6;
temp=(7-temp)/2;
% temp=ceil(temp);
figure
for i=1:size(x,1)
    line([x(i,1) y(i,1)],[x(i,2) y(i,2)],'LineWidth',temp(i))
    hold on
end
scatter(x(:,1),x(:,2),'r')
hold on
scatter(y(:,1),y(:,2),'g')
% axis([-0.4 0.6 -0.4 0.5])
    