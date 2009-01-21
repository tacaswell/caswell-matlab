function msd_plot_cooling
%%set up junk
    filename = '/home/tcaswell/collids/data/polyNIPAM_batch_1/20080507/while_cooling002.nd2';
    
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    r = loci.formats.FileStitcher(r);

    r.setId(filename);

    r.setSeries(series_index);
    w = r.getSizeX();
    h = r.getSizeY();
    numImages = r.getImageCount();
 
%%determin intervals
    
%%loop over intervals

    
    

    
end


function get_tracks
    
end

function pos = get_posistion(f_h,start,stop)
    pos = zeros((stop-start+1),5);
    k=1;
    for j = start:stop
        img = f_h.openImage(j);
        % convert Java BufferedImage to MATLAB image
        tmp = bpass(reshape(img.getData.getPixels(0, 0, w, ...
                                                     h, []),[w,h])',1,part_sz);
        pk = pkfnd(tmp,threshold,part_sz);
        %find peaks
        pos(k,:) = [cntrd(tmp,pk,part_sz) k];
        k = k+1;
    end

    
    
end
function disps = get_msd(track,length)    
    
    track_cell =tracks2cells(track_room_tmp,length);
    
    disps = zeros(length,1);
    for j = 1:length

        index_cell =  mat2cell(repmat(j,1, length(hot_cell)),1,repmat(1, ...
                                                          1,length(hot_cell)));
        
        disps(j) = mean(cellfun(@(x,j) dispsq(x,j),track_cell,index_cell));
        
    end
        
    
  
end

function fit_a = get_fit(data)
    
data = data*((6.45/60)^2);

fit_a = tlinfit(data(:,1)',[repmat(1,1,length(data(:,1))) ;.09*(1: ...
                                                  length(data(:,1)))]', ...
                repmat(1,1,length(data(:,1)))');



end
  
function track_cell = tracks2cells(tracks, cut_off)
%    cut_off = 18; %number of time steps needed for the track to be kept
    
    num_tracks = max(tracks(:,4));
    track_length = zeros(1,num_tracks);
    for j = 1:num_tracks
        track_length(j) = sum(tracks(:,4)==j);
    end
    max(track_length)
    mean(track_length)
    track_cell = cell(1,sum(track_length>cut_off));
    i=1;
    for j = 1:num_tracks
        if track_length(j)>cut_off
            track_cell{i} = tracks(find(tracks(:,4) ==j),[1 2 3]);
            i = i+1;
       end
    end
    
end

function mdisp = dispsq(track,offset)
    track = track(:,[1 2]);
    trck_sz = size(track);
    if offset>trck_sz(1)
        mdisp = [];
        return;
    end
    mdisp = mean(sum((track(1:(end-offset),:)- track((1+offset):(end),:)).^2,2));
end
  %line
  %check x and y seperately