function indx = find_peaks(profile,center_i,disp_)
% FIND_PEAKS - finds local maximum that is steep enough. Assumes that
%   profile is a 1xN vector, center_i is the approximate center of the drop,
%   only look for peaks to the rigth of this
    
    if(~exist('center_i'))
        center_i = 50;
    end
    if(~exist('disp_'))
        disp_ = false;
    end
    
    threshold = .02;    
    % average slope on the right side of the peak
    range = 5;
    % how far to the right side of the peak to look at
    peak_cut = 0.1;
    % minimum peak height to be kept
    
    
    % find local max (in a window of three)
    indx = local_max(profile);
    % cut off the end to not get out of bounds errors, cut
    % off right of center
    indx = indx(indx>center_i & indx<(length(profile)-range));

    % first pass at peak culling
    k = arrayfun(@(x) keep_peak(profile,x,threshold,range),indx);


    indx = indx(k);
    
    indx = merge_peaks(indx);
    
    indx = height_cut(profile,indx,peak_cut);
    
    indx = keep_biggest(indx,profile);
    

    if disp_
        clf
        plot(profile,'-x')
        hold all;
        for j = 1:length(indx)
            plot([indx(j),indx(j)],[0,1])
        end
    end
end

function [keep val1] =keep_peak(profile,indx,thersh,range)
% KEEP_PEAK - determines if the peak is real or not, atleast to first
% order, hence the next couple of cutting functions
    val1 = -mean(diff(profile(indx:(indx+ range))));

    if val1>thersh
        keep = true;
    else
        keep = false;
    end
end

function indx_out = merge_peaks(indx)
% MERGE_PEAKS - merges peaks that are too close together
% Change min_sep to allow peaks closer or farther apart
    min_sep = 6;
    j = 1;
    k = 1;
    if(length(indx)==0)
        indx_out = indx;
    end
    while j <= length(indx)
        
        if(j==length(indx))
            indx_out(k) = indx(j);
            j = j+1;
            k = k+1;
        else
            if (indx(j+1) - indx(j))<min_sep
                indx_out(k) = floor(mean(indx(j:j+1)));
                j = j+2;
                k = k+1;
            else
                indx_out(k) = indx(j);
                j = j+1;
                k = k+1;
            end
        end
    end
    
end

function indx_out = height_cut(profile,indx,peak_cut)
% HEIGHT_CUT - cuts out all peaks less than peak_cut
    indx_out = indx(profile(indx)>peak_cut);
end

function indx_out = keep_biggest(indx,profile)
% KEEP_BIGGEST - trims to keep only the two tallest peaks
%   
    
    if length(indx )<3
        indx_out = indx;
    else
        [junk,I] = sort(profile(indx),'descend');
        
        indx_out = indx(I(1:2));
    end
end
    