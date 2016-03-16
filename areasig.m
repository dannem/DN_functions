function mat=areasig(pvec,alpha,consBins)
%% this functions computes significant intervals for plotting.
%optionally a number of consequtive bins may be inputted.
%Output: numberOfPeriodsX2 vector with the start and end point for
%each interval
%Author: Dan Nemrodov
outmat=[];
count=1;
i=1;
k=pvec<alpha;
while i<length(k)-consBins-1
    if k(i)==0
        i=i+1;
    else
        temp=k(i:i+consBins-1);
        if sum(temp)==consBins;
            outmat(count,1)=i;
            z=find(k(i:end)==0);
            if isempty(z)
              outmat(count,2)=length(k);
              break
            end
            outmat(count,2)=i+z(1)-2;
            i=i+z(1)-1;
            count=count+1;
        else
            z=find(temp==0);
            i=i+z(1)-1;
        end
        
    end
end
mat=outmat;
            
