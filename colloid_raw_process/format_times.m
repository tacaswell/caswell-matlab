function dtime = format_times(times)
%o function ftime = format_times(times)
%o summary: coverts the time stamps on metamorph tiffs to time from the
%first image
%o input:
%-times: 7xN matrix of form [YY MM DD HH MM SS SSS], such as generated
%by get_times
%o output:
%-dtime: 1xN vector of time from frame 0
    
    times = times(:,[3:end]);
    %strip off month and year
    dtime = [zeros(1,5);diff(times)];

    dtime(:,1) = abs(dtime(:,1)~=0);
    %change any change in day to 1 day, to cope with data taken across
    %midnight
    
    secs = [24*60*60 60*60 60 1 1/1000];
    dtime = dtime.*secs(ones(1,size(dtime,1)),:);
    
    dtime = cumsum(sum(dtime,2),1);
    
    
end
    