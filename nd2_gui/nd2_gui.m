function varargout = nd2_gui(file_name)
% MYGUI This gui is to step through nd2 files

% (Leave a blank line following the help.)

%  Constants
    threshold = 200;         %threshold for pkfnd
    part_sz = 17;           %size of particles to be looking for
    image_index = 5;
    series_index = 0;

    buffer_frames = 5;
    buffer_length = 2*buffer_frames + 1;
    buffer_index = zeros(1,buffer_length);
    buffer_current = 0;
    buffer_pix = [];

    
    update_running = 0;
    
%  Initialization tasks
    
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    r = loci.formats.FileStitcher(r);

    r.setId(file_name);

    r.setSeries(series_index);
    w = r.getSizeX();
    h = r.getSizeY();
    numImages = r.getImageCount();
    buffer_pk = cell(1,numImages);    
   
    init_buffers;
%    pix = zeros(h,w);
%    
%    img = r.openImage(image_index);
%    % convert Java BufferedImage to MATLAB image
%    pix = img.getData.getPixels(0, 0, w, h, []);
%    pix = reshape(pix,[w,h])';
%
    t_fig = figure('position',[20 40 700 700]);


    %  Construct the components
    img_frame = imagesc(buffer_pix(:,:,buffer_current));
    colormap('gray');
    hold on
    pt_scatter = scatter([],[]);
    impixelinfo;
    axis off;
    axis square;
    %fname_txt = uicontrol(t_fig,'style','edit','string','Filenaame',...
    %                      'position',[20 650 300 20]);
    image_slider = uicontrol(t_fig,'style','slider','max',numImages-1,'min',0, ...
                   'sliderstep',[1/(numImages-1) 5/(numImages-1)],'value',image_index,'position',[30 20 500 20],...
                   'callback',{@image_slider_callback_buffered});

    image_index_disp = uicontrol(t_fig,'style','text','string',image_index,...
                                 'position',[ 550 20 20 20]);
    
%  Initialization tasks
%image_slider_callback(image_slider,[]);

%  Callbacks for MYGUI
%function image_slider_callback(hObject,eventdata)
%%profile on
%    tic
%    image_index = floor(get(hObject,'Value'));
%    set(hObject,'value',image_index);
%    img = r.openImage(image_index);
%    % convert Java BufferedImage to MATLAB image
%    pix = img.getData.getPixels(0, 0, w, h, []);
%    pix = reshape(pix,[w,h])';
%    pix = bpass(pix,1,part_sz);
%    %band pass for center finding
%    pk = pkfnd(pix,threshold,part_sz);
%    %find peaks
%    %pk_sp = cntrd(pix,pk,part_sz);
%   
%
%    set(img_frame,'cdata',pix);
%    set(pt_scatter,'xdata',pk(:,1));
%    set(pt_scatter,'ydata',pk(:,2));
%    set(image_index_disp,'string',image_index);
%    toc
%    %    profile off
%end
%
function image_slider_callback_buffered(hObject,eventdata)
%profile on
    tic
    image_index = floor(get(hObject,'Value'));
    set(hObject,'value',image_index);
    %    img = r.openImage(image_index);
    

    set(img_frame,'cdata',squeeze(buffer_pix(:,:,find(buffer_index==image_index))));
    %    set(pt_scatter,'xdata',pk(:,1));
    %set(pt_scatter,'ydata',pk(:,2));
    set(image_index_disp,'string',image_index);
    pause(.01)
    update_buffer;
    toc
    %    profile off
end


%  Utility functions for MYGUI
function init_buffers
%initializes the buffers, should only be called once
%only deals with single series stacks at this point
    
%define the pixel buffer
    update_running = 1;
    buffer_pix = zeros(h,w,numImages);
    %fill the buffer with the first set of images
    rebuild_buffer;
    update_running = 0;
end

function update_buffer
%    while update_running
%        fprintf("buffer stackup /n");
%        pause(.25)
%    end
    update_running = 1;
    fprintf('spot1\n')
    buffer_current_tmp = find(buffer_index ==image_index);
    if isempty(buffer_current_tmp)
        %we have jumped to an index not in the bufffer
        %rebuild 
        rebuild_buffer;
        update_running = 0;
        return;
    end
    
    fprintf('spot2\n')
    if image_index-buffer_frames>0 && image_index+buffer_frames<numImages
        %handle cases in middle of stack
        buffer_index_tmp = (image_index-buffer_frames):(image_index+buffer_frames);
        buffer_index_tmp = buffer_index_tmp(...
            mod(...
                (buffer_frames-buffer_current_tmp)+(1:buffer_length),buffer_length)...
            +1)
        
        %handle edge cases of top and bottom of stack
    elseif image_index+buffer_frames<numImages && image_index-buffer_frames<1
            buffer_index_tmp = 1:buffer_length
    elseif image_index+buffer_frames>numImages && image_index-buffer_frames>0
            buffer_index_tmp = (numImages-buffer_length):buffer_length
    end


    fprintf('spot3\n')
    %figure out what has changed and change it
    change_index = find(buffer_index ~=buffer_index_tmp);
    for j = change_index
        img = r.openImage(buffer_index(j));
        % convert Java BufferedImage to MATLAB image
        buffer_pix(:,:,j) = bpass(reshape(img.getData.getPixels(0, 0, w, h, []),[w,h])',1,part_sz);
    end
    buffer_index = buffer_index_tmp
    buffer_current = buffer_current_tmp
    update_running = 0;
end
%
function rebuild_buffer
    if image_index-buffer_frames>0 && image_index+buffer_frames<numImages
        buffer_index = (image_index-buffer_frames):(image_index+buffer_frames);
    elseif image_index+buffer_frames<numImages && image_index-buffer_frames<1
        buffer_index = 1:buffer_length;
    elseif image_index+buffer_frames>numImages && image_index-buffer_frames>0
        buffer_index = (numImages-buffer_length):buffer_length;
    end
    
    buffer_current = find(buffer_index==image_index);
    
    for j = 1:buffer_length
        img = r.openImage(buffer_index(j));
        % convert Java BufferedImage to MATLAB image
        buffer_pix(:,:,j) = bpass(reshape(img.getData.getPixels(0, 0, w, h, []),[w,h])',1,part_sz);
    end
    

end

end

