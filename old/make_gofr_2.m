function [dist a b] = make_gofr_2
%%set up junk
    part_sz = 17;
    window_sz = 3
    threshold = 110;
    max_disp = 11;
    mag = 60;
    t_rescale = 6.45/mag;
    tdims = [1392 1040]*t_rescale;
    %filename = ['/home/tcaswell/collids/data/polyNIPAM_batch_1/20080508/' ...
    %            'room_tmp001.nd2'];

    
     basename = '/home/tcaswell/collids/data/';
     batch_name = 'polyNIPAM_batch_1/20080522/';
     fname = 'room_tmp_jammed_2.nd2';
     filename = [basename batch_name fname]
                
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    r = loci.formats.FileStitcher(r);

    r.setId(filename);

    r.setSeries(1);
    w = r.getSizeX();
    h = r.getSizeY();
    numImages = r.getImageCount();
    times = get_times(r);
    mtime = mean(times(2:end)-times(1:(end-1)))
    
    pos = get_posistion(r,0,5);
    pos(:,[1 2]) = pos(:,[1 2])*6.45/mag;



    t_range = 15;
    [dist a b] = gofr(pos,t_range,t_range*30,tdims,part_sz*t_rescale);
    title(fname)
    ylabel('g(r)')
    xlabel('r[\mum]')




 function tracks = get_tracks

     tracks = track(pos(:,[1 2 5]),max_disp);
        
 end

function pos = get_posistion(f_h,start,stop)

    pos = [];
    k=1;
    for j = start:stop
        img = f_h.openImage(j);
        % convert Java BufferedImage to MATLAB image
        tmp = bpass(reshape(img.getData.getPixels(0, 0, w, ...
                                                     h, []),[w,h])',1,part_sz);
        [pk(:,1) pk(:,2)] = t_1d_2d_cords(find((exp(tmp- dilate(tmp.*(tmp>threshold), ...
                                                 window_sz))==1)),h);

        pk_sz = size(pk);
        pos = [pos; pk repmat(k,pk_sz(1),1)];
        clear pk
        k = k+1;
    end

    
    
end
function [disps num_pnts] = get_msd(tracks,p_len)    
    

    disps = zeros(p_len,1);
    num_pnts = zeros(p_len,1);
  for j = 1:p_len
      count = j;
      if j <5
          count = 5;
      end
      track_cell = tracks2cells(tracks,count);

      index_cell = ...
      mat2cell(repmat(j,1, length(track_cell)),1,...
               repmat(1, 1, length(track_cell)));
      num_pnts(j) = length(track_cell);
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
    mdisp = mean(sum((track(1:(end-offset),:)- track((1+offset):(end),: ...
                                                     )).^2,2));
    
end
r.close();
end
  %line
  %check x and y seperately