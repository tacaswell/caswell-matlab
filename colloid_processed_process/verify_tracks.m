function verify_tracks(fname, results, region)
%o function verify_tracks(fhand, tracks)
%o summary: selects a region of the image and displays the tracks of
%particles with in that region
%o inouts:
%-fname: fully qualified path to raw data file
%-results: struct with fields tracks_trim and name
%-region: [top-left-x top-left-y x-dim y-dim] to define the region to
%watch
   
    

%  Initialization tasks
fh = figure('position',[20 40 900 900]);
uicontrol('DeleteFcn',@clean_up)


%% define constants
    threshold = 1;         %threshold for pkfnd
    p_rad = 4;           %size of particles to be looking for
    image_index = 5;
    series_index = 0;
    hwhm = 1;
    d_rad = 2;
    mask_rad = 3;

    shift_cut = 1.5;
    rg_cut = 15;
    e_cut = .4;

    

    
    %%set up file handle
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    %%uncomment to stich files
    %  r = loci.formats.FileStitcher(r);

    r.setId(fname);

    r.setSeries(series_index);
    w = r.getSizeX();
    h = r.getSizeY();
    
    numImages = r.getImageCount();



    %%set up buffers
    buffer_frames = 5;
    buffer_length = 2*buffer_frames + 1;
    buffer_index = zeros(1,buffer_length);
    buffer_current = 1;
    buffer_pix = zeros(region(3),region(4),buffer_length);
    buffer_pos = cell(1,buffer_length);
    buffer_pos2 = cell(1,buffer_length);
    buffer_trk = cell(1,buffer_length);
    buffer_center = 10;
    
    trk_hand = [];

    
trk = [results.tracks_fill,(1:size(results.tracks_fill,1))'];
trk([1:25],:)

[junk pnt_sort] = sort(trk(:,end-2));
clear junk;
pnts = trk(pnt_sort,:);

pnts2 = results.all_pks_trim(:,[2 3 end]);



trk_indx = t_trim_track_indx(trk(:,end-1),4);
trk_indx = [trk_indx trk(trk_indx(:,1),end-1)];
size(trk_indx)
pnt_indx = t_trim_track_indx(pnts(:,end-2),4);
pnt_indx2 = t_trim_track_indx(pnts2(:,end),4);
size(pnt_indx)
    
    
    
%%  Construct the components


bc = changer('buffer',[30 30] ,fh,@adjust_buffer);
ic = changer('image',[110 30] ,fh,@adjust_image);
set(bc,'string',num2str(buffer_center));
set(ic,'string',num2str(image_index));

update_buffer;
    
img_frame = imagesc(squeeze(buffer_pix(:,:,buffer_current)));

colormap(gray)
hold on;
scatter_h2 = scatter([],[],'gx');
scatter_h = scatter([],[],'rx');


update_display;
axis equal

image_index_disp = uicontrol(fh,'style','text','string',image_index,...
                             'position',[ 550 20 20 20]);








function clean_up(a,b)
    1
   r.close(); 

end
%%set up buffer controls
    
%%set up 

%  Initialization tasks

%  Callbacks for MYGUI
%%adjust threshold



%% adjust buffer range
function int = adjust_buffer(int)
    if int<1
        int = 1;
    end
    if int>numImages
        int = numImages;
    end
    buffer_center = int;
    update_buffer;
    update_display;
end


%%adjust image in buffer
function int = adjust_image(int)
    if int<1
        int = 1;
    end
    if int>numImages
        int = numImages;
    end
    buffer_current = find(buffer_index==int);
    if isempty(buffer_current)
        buffer_center = int-1;
        update_buffer;
        buffer_current = find(buffer_index==int);
    end
    image_index = buffer_index(buffer_current);
    set(image_index_disp, 'string',int2str(image_index));
    update_display;
end

%  Utility functions for MYGUI

%%fill buffer from scratch
%function rebuild_buffer
%   
%    for j = 1:buffer_length
%        img = extract_image(r,buffer_index(j));
%
%        [pks b_passed centers] = t_hello(img,[p_rad,hwhm,d_rad, ...
%                            mask_rad,threshold,0]);
%        pks = pks';
%
%         % convert Java BufferedImage to MATLAB image
%         %        buffer_pix(:,:,j) = b_passed + 50*centers;
%        buffer_pix(:,:,j) = img.*(ones(size(centers))-centers);
%        buffer_pos{j} = pks(:,[1 3 2 4:9]);
%       
%        
%    end
%    
%
%end


function update_buffer

    fprintf('spot1\n')
    buffer_current_tmp = find(buffer_index ==buffer_center);
    if isempty(buffer_current_tmp)
        if buffer_center-buffer_frames>0 && buffer_center+buffer_frames<numImages
            buffer_index_tmp =...
                (buffer_center-buffer_frames):(buffer_center+buffer_frames);
        elseif buffer_center+buffer_frames<numImages &&...
                buffer_center-buffer_frames<1
            buffer_index_tmp = 1:buffer_length;
        elseif buffer_center+buffer_frames>numImages &&...
                buffer_center-buffer_frames>0
            buffer_index_tmp = (numImages-buffer_length):buffer_length;
        end
        
        buffer_current_tmp = find(buffer_index_tmp==buffer_center);
    
        

        

    
    elseif buffer_center-buffer_frames>0 && buffer_center+buffer_frames<numImages
        %handle cases in middle of stack
        buffer_index_tmp = (buffer_center-buffer_frames):(buffer_center+buffer_frames);
        buffer_index_tmp = buffer_index_tmp(...
            mod(...
                (buffer_frames-buffer_current_tmp)+(1:buffer_length),buffer_length)...
            +1)
        
        %handle edge cases of top and bottom of stack
    elseif buffer_center+buffer_frames<numImages && buffer_center-buffer_frames<1
            buffer_index_tmp = 1:buffer_length
    elseif buffer_center+buffer_frames>numImages && buffer_center-buffer_frames>0
            buffer_index_tmp = (numImages-buffer_length):buffer_length
    end


    fprintf('spot3\n')
    %figure out what has changed and change it
    change_index = find(buffer_index ~=buffer_index_tmp);
    
    for j = change_index
        img = extract_image_gen(r,buffer_index_tmp(j)-1,region(3),region(4),region(1),region(2));
        
        
        % convert Java BufferedImage to MATLAB image
        
        buffer_pix(:,:,j) = img;
        
        %        buffer_index_tmp(j)
 

        
        tmp = pnts(pnt_indx(buffer_index_tmp(j),1): ...
                   pnt_indx(buffer_index_tmp(j),2),:);
        
        %tmp([1 end],[end-2 end-1])
        
        kp_indx =  tmp(:,1)>region(2) &...
            tmp(:,1)<(region(2)+ region(3)) & ...
            tmp(:,2)>region(1) & tmp(:,2)<(region(1) + region(4)) ;
        

        

        buffer_pos{j} = tmp(kp_indx,[1 2]);
        buffer_trk{j} = tmp(kp_indx,end-1);
        
        tmp = pnts2(pnt_indx2(buffer_index_tmp(j),1): ...
                   pnt_indx2(buffer_index_tmp(j),2),:);
        
        %tmp([1 end],[end-2 end-1])
        
        kp_indx =  tmp(:,1)>region(2) &...
            tmp(:,1)<(region(2)+ region(3)) & ...
            tmp(:,2)>region(1) & tmp(:,2)<(region(1) + region(4)) ;
        
        

        buffer_pos2{j} = tmp(kp_indx,[1 2]);
        
        
    end
    set(bc,'string',num2str(buffer_center))
    buffer_index = buffer_index_tmp
    buffer_current = buffer_current_tmp;
end



function update_display
    set(img_frame,'cdata',squeeze(buffer_pix(:,:,buffer_current)));

%    
%    set(sc2,'xdata',tmp(:,9));
%    set(sc2,'ydata',tmp(:,7));
%    set(lh2,'xdata',get(get(fh2,'currentaxes'),'xlim'))
%    set(lh2,'ydata',[rg_cut rg_cut]);
%    set(lv2,'ydata',get(get(fh2,'currentaxes'),'ylim'))
%    set(lv2,'xdata',[e_cut e_cut]);
%    
%    set(sc3,'xdata',tmp(:,9));
%    set(sc3,'ydata',sqrt((sum(tmp(:,[4 5]).^2,2))));
%    set(lh3,'xdata',get(get(fh3,'currentaxes'),'xlim'))
%    set(lh3,'ydata',[shift_cut shift_cut]);
%    set(lv3,'ydata',get(get(fh3,'currentaxes'),'ylim'))
%    set(lv3,'xdata',[e_cut e_cut]);
%
%    
%    
%    set(sc4,'xdata',tmp(:,7));    
%    set(sc4,'ydata',tmp(:,6));
%    set(lv4,'ydata',get(get(fh4,'currentaxes'),'ylim'))
%    set(lv4,'xdata',[rg_cut rg_cut]);
%    %    set(lh4,'ydata',get(get(fh3,'currentaxes'),'ylim'))
%    % set(lh4,'xdata',[e_cut e_cut]);
%    
%    
%    tmp = t_trim_md(tmp,shift_cut,rg_cut,e_cut);
%    


arrayfun(@delete,trk_hand)

trk_hand = zeros(size(buffer_trk{buffer_current}));

for k = 1:length(buffer_trk{buffer_current})
    tmp2 = buffer_trk{buffer_current};
    
    cur_trk_ind = find(trk_indx(:,3)==tmp2(k));
    trk_hand(k) = plot(trk(trk_indx(cur_trk_ind,1):trk_indx(cur_trk_ind,2),2)-region(1)+1,trk(trk_indx(cur_trk_ind,1):trk_indx(cur_trk_ind,2),1)+1-region(2),'b-');
    
    
end

    tmp = buffer_pos{buffer_current};
    set(scatter_h,'ydata',tmp(:,1)+1-region(2));
    set(scatter_h,'xdata',tmp(:,2)+1-region(1));
    
    tmp = buffer_pos2{buffer_current};
    set(scatter_h2,'ydata',tmp(:,1)+1-region(2));
    set(scatter_h2,'xdata',tmp(:,2)+1-region(1));
%    
%    
%    figure(fh5)
%
%    %    htmp = zeros(size(get(hh,'ydata')));
%    
%    set(hh,'ydata', hist(mod(reshape(tmp(:,[4 5]),1,[]),1),0:.01:1));
%
    
    
%    clear tmp;

    %  redraw_circ(buffer_current);
    %    axis equal
end

function redraw_circ(c_frame)
    arrayfun(@(x) delete(x),circ_handles);
    pos_size = size(buffer_pos{c_frame});
    circ_handles = zeros(pos_size(1),1);
    for j = 1:pos_size(1)
       circ_handles(j) = circle(buffer_pos{c_frame}(j,[1 2]), ...
                               sqrt(buffer_pos{c_frame}(j,4)),100) ;
       
    end
end

end
