function circ_handles = mygui(filename)
% MYGUI Brief description of GUI.
%       Comments displayed at the command line in response 
%       to the help command. 

% (Leave a blank line following the help.)

%  Initialization tasks
%% define constants
    threshold = 70;         %threshold for pkfnd
    part_sz = 15;           %size of particles to be looking for
    image_index = 5;
    series_index = 0;
    mag = 60;
    t_rescale = 6.45/mag;
    tdims = [1392 1040]*t_rescale;
    
%%set up file handle
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    r = loci.formats.FileStitcher(r);

    r.setId(filename);

    r.setSeries(series_index);
    w = r.getSizeX();
    h = r.getSizeY();
    numImages = r.getImageCount();
    buffer_pk = cell(1,numImages);    
   
%%Other handles
circ_handles = [];
    

%%set up buffers
    buffer_frames = 5;
    buffer_length = 2*buffer_frames + 1;
    buffer_index = zeros(1,buffer_length);
    buffer_current = 1;
    buffer_pix = zeros(h,w,numImages);
    buffer_pos = cell(1,buffer_length);
    buffer_center = 10;
    rebuild_buffer;
    
    
    
%%  Construct the components

fh = figure('position',[20 40 700 700]);
bc = changer('buffer',[30 30] ,fh,@adjust_buffer);
ic = changer('image',[110 30] ,fh,@adjust_image);
tc = changer('threshold',[190 30] ,fh,@adjust_thresh);
pc = changer('part_sz',[270 30] ,fh,@adjust_part_sz);
set(bc,'string',num2str(buffer_center));
set(tc,'string',num2str(threshold));
set(ic,'string',num2str(image_index));
set(pc,'string',num2str(part_sz));
img_frame = imagesc(squeeze(buffer_pix(:,:,buffer_current)));
axis equal
image_index_disp = uicontrol(fh,'style','text','string',image_index,...
                             'position',[ 550 20 20 20]);

colormap(gray)
hold on;
scatter_h = scatter([],[]);

gofr_fig = figure('position',[720 40 700 700]);
gofr_h = plot(1:5,1:5,'.');
gofr_sub(buffer_pos,15,300);
axis([0 15 0 2]);
set(gca,'xtick',0:2:15)
grid on;
ylabel('g(r)')
xlabel('r[\mum]')

update_display;
%%set up buffer controls
    
%%set up 

%  Initialization tasks

%  Callbacks for MYGUI
%%adjust threshold
function int = adjust_thresh(int)
   threshold = int
   [0 threshold]
   caxis([0 threshold]);
   rebuild_pos_buffer;
   update_display;
end
%%particle_sz
function int = adjust_part_sz(int)
    if ~mod(int,2)
        int = int+1;
    end
    part_sz = int;
   rebuild_bpass_buffer;
   update_display;
   gofr_sub(buffer_pos,20,300);
end
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
function rebuild_buffer
    if buffer_center-buffer_frames>0 && buffer_center+buffer_frames<numImages
        buffer_index =...
            (buffer_center-buffer_frames):(buffer_center+buffer_frames);
    elseif buffer_center+buffer_frames<numImages &&...
            buffer_center-buffer_frames<1
        buffer_index = 1:buffer_length;
    elseif buffer_center+buffer_frames>numImages &&...
            buffer_center-buffer_frames>0
        buffer_index = (numImages-buffer_length):buffer_length;
    end
    
    buffer_index
    buffer_current = find(buffer_index==buffer_center);
    
    for j = 1:buffer_length
        img = r.openImage(buffer_index(j));
        % convert Java BufferedImage to MATLAB image
        buffer_pix(:,:,j) = bpass(...
            reshape(img.getData.getPixels(0, 0, w, h, []),[w,h])'...
            ,1,part_sz);
        pk = pkfnd(buffer_pix(:,:,j),threshold,part_sz);
        %find peaks
        pk = cntrd(buffer_pix(:,:,j),pk,part_sz);
        buffer_pos{j} = pk;
       
        
    end
    

end

function rebuild_pos_buffer
    for j = 1:buffer_length
        pk = pkfnd(buffer_pix(:,:,j),threshold,part_sz);
        %find peaks
        pk = cntrd(buffer_pix(:,:,j),pk,part_sz);
        buffer_pos{j} = pk;
    end
    gofr_sub(buffer_pos,20,300);
end

function rebuild_bpass_buffer
    for j = 1:buffer_length
          img = r.openImage(buffer_index(j));
        % convert Java BufferedImage to MATLAB image
        buffer_pix(:,:,j) = bpass(reshape(img.getData.getPixels(0, 0, w, ...
                                                                   h, []),[w,h])',1,part_sz);
         pk = pkfnd(buffer_pix(:,:,j),threshold,part_sz);
        %find peaks
        pk = cntrd(buffer_pix(:,:,j),pk,part_sz);
        buffer_pos{j} = pk;
    end

end


function update_buffer
%    while update_running
%        fprintf("buffer stackup /n");
%        pause(.25)
%    end
    fprintf('spot1\n')
    buffer_current_tmp = find(buffer_index ==buffer_center);
    if isempty(buffer_current_tmp)
        %we have jumped to an index not in the bufffer
        %rebuild 
        rebuild_buffer;
        update_running = 0;
        set(bc,'string',num2str(buffer_center));
        return;
    end
    
    fprintf('spot2\n')
    if buffer_center-buffer_frames>0 && buffer_center+buffer_frames<numImages
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
       img = r.openImage(buffer_index(j));
        % convert Java BufferedImage to MATLAB image
        buffer_pix(:,:,j) = bpass(reshape(img.getData.getPixels(0, 0, w, ...
                                                                   h, []),[w,h])',1,part_sz);
         pk = pkfnd(buffer_pix(:,:,j),threshold,part_sz);
        %find peaks
        pk = cntrd(buffer_pix(:,:,j),pk,part_sz);
        buffer_pos{j} = pk;
       
    end
    set(bc,'string',num2str(buffer_center))
    gofr_sub(buffer_pos,20,300);
    buffer_index = buffer_index_tmp
    buffer_current = buffer_current_tmp;
end

function update_display
    set(img_frame,'cdata',squeeze(buffer_pix(:,:,buffer_current)));
    set(scatter_h,'xdata',buffer_pos{buffer_current}(:,1));
    set(scatter_h,'ydata',buffer_pos{buffer_current}(:,2));

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

function gofr_sub(poses,t_len, t_bins)
%%takes in a stack of posistion data in a cell array and returns G(r)
%%assume data is of form (x) (y) (anything else) (frame index)
    fprintf('starting to compute g(r)\n')
frame_count = buffer_length;
dist=cell(1,frame_count);
x_max = tdims(1);
y_max = tdims(2);
%frame_count = 1;
particle_count = 0;
pos_tot = 0;
for j = 1:frame_count
    frame_tmp = poses{j}(:,[1 2])*6.45/mag;
    pos_count = size(frame_tmp);
    pos_count = pos_count(1);
    pos_tot = pos_tot + pos_count;
    dist_tmp = -ones(pos_count^2,1);
    index = 1;
    for k = 1:(pos_count)
        if frame_tmp(k,1)>2*t_len &&frame_tmp(k,1)<(x_max-2*t_len)...
                &&frame_tmp(k,2)>2*t_len&&frame_tmp(k,2)<(y_max-2*t_len)
            %excludes particles too close to edge to have a full circle
            %around them
            tmp = repmat(frame_tmp(k,:),pos_count-1,1);
            dist_tmp(index:(index+pos_count-2))=...
                sqrt(sum((frame_tmp([1:(k-1) (k+1):end],:)-tmp).^2,2));
            index = index + pos_count-1;
            particle_count = particle_count+1;
        end

    end
    dist{j} = dist_tmp(dist_tmp>0);
end
dist = cell2mat(dist');
size(dist)
max(dist)
dist = dist(dist<t_len);
%figure
[a b]=hist(dist,t_bins);
bin_width = b(2)-b(1);
as = a/particle_count; %average over particles
as = as./(pi()*(([b+bin_width/2].^2)-([0 b(1:(end-1))+bin_width/2].^2)));
%scales for volume
as = as/(pos_tot/...
         ((x_max-2*part_sz*t_rescale)*(y_max-2*part_sz*t_rescale)* ...
          frame_count));
% devide by average density
set(gofr_h,'ydata',as);
set(gofr_h,'xdata',b);
fprintf('g(r) update\n')
end    



end