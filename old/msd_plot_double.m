function [fit1 fit] = msd_plot
%%set up junk
    part_sz = 9;
    threshold = 100;
    max_disp = part_sz;
    mag=60;
    
    %    filename = ['/home/tcaswell/collids/data/polyNIPAM_batch_1/20080508/' ...
    %            'room_tmp.nd2'];
    filename = ['/home/tcaswell/collids/data/polyNIPAM_batch_1/20080206/' ...
                '16_e_hot.nd2'];
    
    dummy = 0
    process_files;
    fit1=fit;
    nm_pnts1 = nm_pnts;
    disp1 = disp;
    mtime=mtime1;
    clear disp;
    dummy = 1
    filename = ['/home/tcaswell/collids/data/polyNIPAM_batch_1/20080206/' ...
                '16_e_roomtmp.nd2'];
    process_files;
    dummy = 3
    make_fig_t = 1;
    if make_fig_t
    
        figure;
        subplot('Position',[.13 .35 .8 .55])
        
        
        hold on
        num_points = length(disp);
        errorbar(mtime*(1:num_points),disp,sqrt(disp./nm_pnts),'xk');
        errorbar(mtime1*(1:num_points),disp1,sqrt(disp1./nm_pnts1),'.k');
        
        pnts = mtime*(1:num_points);
        pnts1 = mtime1*(1:num_points);
        plot(pnts1,fit1(1) + (pnts1)*fit1(2),'k--');
        plot(pnts,fit(1) + (pnts)*fit(2),'k--');

        ylabel('mean sqared dispalcement [\mum^2]')
        xlabel('time [second]')
        title('Mean Squared Displacement');
        % legend({'Room Temperature','Heated','Room Fit','Heated Fit'},'location','northwest');
        
        subplot('Position',[.13 .1 .8 .1])
        
        plot((1:num_points)*mtime,disp'-(fit(1) + (pnts)*fit(2)),'xr');
        hold on

        xlabel('time [second]')
        ylabel('\Delta [\mum^2]')
        title('Residue')
    end

function process_files
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
    
    
    pos = get_posistion(r,0,numImages-1);
    tracks = get_tracks;
    [disp nm_pnts] = get_msd(tracks,50);
    disp = disp*((6.45/mag)^2);
    figure
    plot(disp,'x');
    figure
    plot(nm_pnts,'x');
    
    fit = tlinfit(disp',[repmat(1,1,length(disp)) ;mtime*(1:length(disp))]',repmat(1,1,length(disp))');
    
    r.close();
    clear r
   
    
end

    



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
        pk = pkfnd(tmp,threshold,part_sz);
        %find peaks
        pk = cntrd(tmp,pk,part_sz);
        pk_sz = size(pk);
        pos = [pos; pk repmat(k,pk_sz(1),1)];
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

%fit_a = tlinfit(data(:,1)',[repmat(1,1,length(data(:,1))) ;.09*(1: ...
%                                                  length(data(:,1)))]', ...
%                repmat(1,1,length(data(:,1)))');
fit_a = tlinfit(data(:,1)',[.09*(1: length(data(:,1)))]', repmat(1,1, ...
                                                  length(data(:,1)))');



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
end
  %line
  %check x and y seperately