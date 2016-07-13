%% this function creates indeces for separation permutation 
%into three groups: within 1, within 2, between
% inputs:   allnum: number of items in into permuation
%           firstnum: size of the first group 
%           
% output:   out structure with three fields

function out=perm_separation(allnum,firstnum)
% allnum=60;
% firstnum=54;
vec=nchoosek(1:allnum,2);
secondnum=firstnum+1:allnum;
firstnum=1:firstnum;
out.indOne=[];
out.indTwo=[];
out.indAcross=[];
for i=1:length(vec)
    if ~isempty(intersect(vec(i,:),firstnum)) && ~isempty(intersect(vec(i,:),secondnum))
        out.indAcross=[out.indAcross i];
    elseif ~isempty(intersect(vec(i,:),firstnum))
        out.indOne=[out.indOne i];
    elseif ~isempty(intersect(vec(i,:),secondnum))
        out.indTwo=[out.indTwo i];
    end
end
