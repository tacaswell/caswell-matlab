function circ_handles = mygui(filename,tracks,pts)
% MYGUI Brief description of GUI.
%       Comments displayed at the command line in response 
%       to the help command. 

% (Leave a blank line following the help.)

%  Initialization tasks
%% define constants
    image_index = 5;
    series_index = 0;

    
    minlength =0;
    track_index = t_trim_track_indx(tracks,minlength);

    pt_indx = t_trim_track_indx(pts,0);
    pt_indx(1:15,:)

    
%%set up file handle
    
%%set up file handle
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);


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
    buffer_pix = zeros(h,w,buffer_length);
    buffer_track = cell(1,buffer_length);
    %list of tracks that appears in each frame
    buffer_center = 10;
    rebuild_buffer;
    
    plot_hands = [];
    
%%  Construct the components

fh = figure('position',[20 40 900 900]);
bc = changer('buffer',[30 30] ,fh,@adjust_buffer);
ic = changer('image',[110 30] ,fh,@adjust_image);
%tc = changer('threshold',[190 30] ,fh,@adjust_thresh);
%pc = changer('p_rad',[270 30] ,fh,@adjust_p_rad);
%dc = changer('d_rad',[350 30] ,fh,@adjust_d_rad);
%mc = changer('mask_rad',[430 30] ,fh,@adjust_mask_rad);
%hc = changer('hwhm',[510 30] ,fh,@adjust_hwhm);
%ec = changer('ecut',[580 30] ,fh,@adjust_e_cut);
%sc = changer('scut',[660 30] ,fh,@adjust_shift_cut);
%rc = changer('rgcut',[740 30] ,fh,@adjust_rg_cut);
set(bc,'string',num2str(buffer_center));
%set(tc,'string',num2str(threshold));
set(ic,'string',num2str(image_index));
%set(pc,'string',num2str(p_rad));
%set(dc,'string',num2str(d_rad));
%set(mc,'string',num2str(mask_rad));
%set(hc,'string',num2str(hwhm));
%set(ec,'string',num2str(e_cut));
%set(sc,'string',num2str(shift_cut));
%set(rc,'string',num2str(rg_cut));

img_frame = imagesc(squeeze(buffer_pix(:,:,buffer_current)));
axis square
image_index_disp = uicontrol(fh,'style','text','string',image_index,...
                             'position',[ 550 20 20 20]);

colormap(gray)
hold on;
scatter_h = scatter([],[],'ro');


%%generate exctra graphs

update_display;
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
profile on;
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
    profile off;
    profile report;
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

         % convert Java BufferedImage to MATLAB image
        buffer_pix(:,:,j) = extract_image(r,buffer_index(j),h,w);
        buffer_track{j} = tracks(tracks(:,3)==j,4);
       
        
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
        % convert Java BufferedImage to MATLAB image


        % convert Java BufferedImage to MATLAB image
        buffer_pix(:,:,j) = extract_image(r,buffer_index(j),h,w);

        buffer_track{j} = tracks(tracks(:,3)==j,4);
 
        
    end
    set(bc,'string',num2str(buffer_center))
    buffer_index = buffer_index_tmp
    buffer_current = buffer_current_tmp;
end



function update_display
    set(img_frame,'cdata',squeeze(buffer_pix(:,:,buffer_current)));
    tmp = buffer_track{buffer_current};


    arrayfun(@(x) delete(x),plot_hands);
    plot_hands = [];
    for k = 1:(size(tmp,1))
        plot_hands(k) = plot(tracks(track_index(tmp(k),1):track_index(tmp(k),2),2), ...
                             tracks(track_index(tmp(k),1):track_index(tmp(k),2),1),'b-x');
    end

    set(scatter_h,'xdata',pts(pt_indx(image_index,1):pt_indx(image_index,2),3));
    set(scatter_h,'ydata',pts(pt_indx(image_index,1):pt_indx(image_index,2),2));

    
    clear tmp;
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