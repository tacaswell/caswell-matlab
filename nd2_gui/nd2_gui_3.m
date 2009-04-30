function circ_handles = nd2_gui_3(filename)
% MYGUI Brief description of GUI.
%       Comments displayed at the command line in response 
%       to the help command. 

% (Leave a blank line following the help.)

%  Initialization tasks
%% define constants
    threshold = 1;         %threshold for pkfnd
    p_rad = 5;           %size of particles to be looking for
    image_index = 10;
    series_index = 0;
    hwhm = 1.3;
    d_rad = 3;
    mask_rad = 4;

    shift_cut = 1.5;
    rg_cut = 8;
    e_cut = .6;

    disp_mode = 1;
    
%%set up file handle
    
%%set up file handle
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    %%uncomment to stich files
    %  r = loci.formats.FileStitcher(r);

    r.setId(filename);

    r.setSeries(series_index);
    w = r.getSizeX();
    h = r.getSizeY();
    numImages = r.getImageCount();
    %    buffer_pk = cell(1,numImages);    

%%Other handles
circ_handles = [];
    

%%set up buffers
    buffer_frames = 2;
    buffer_length = 2*buffer_frames + 1;
    buffer_index = zeros(1,buffer_length);
    buffer_current = 1;
    buffer_pix = zeros(h,w,buffer_length);
    buffer_pos = cell(1,buffer_length);
    buffer_center = 10;
    rebuild_buffer;
    
    
    
%%  Construct the components

fh = figure('position',[20 40 900 900]);

set(fh,'defaulttextinterpreter','none')
uicontrol('DeleteFcn',@clean_up)
bc = changer('buffer',[30 30] ,fh,@adjust_buffer);
ic = changer('image',[110 30] ,fh,@adjust_image);
tc = changer('threshold',[190 30] ,fh,@adjust_thresh);
pc = changer('p_rad',[270 30] ,fh,@adjust_p_rad);
dc = changer('d_rad',[350 30] ,fh,@adjust_d_rad);
mc = changer('mask_rad',[430 30] ,fh,@adjust_mask_rad);
hc = changer('hwhm',[510 30] ,fh,@adjust_hwhm);
ec = changer('ecut',[580 30] ,fh,@adjust_e_cut);
sc = changer('scut',[660 30] ,fh,@adjust_shift_cut);
rc = changer('rgcut',[740 30] ,fh,@adjust_rg_cut);
oc = changer('mode',[820 30] ,fh,@adjust_disp_mode);
set(bc,'string',num2str(buffer_center));
set(tc,'string',num2str(threshold));
set(ic,'string',num2str(image_index));
set(pc,'string',num2str(p_rad));
set(dc,'string',num2str(d_rad));
set(mc,'string',num2str(mask_rad));
set(hc,'string',num2str(hwhm));
set(ec,'string',num2str(e_cut));
set(sc,'string',num2str(shift_cut));
set(rc,'string',num2str(rg_cut));
set(oc,'string',num2str(disp_mode));

img_frame = imagesc(squeeze(buffer_pix(:,:,buffer_current)));
title(filename)
axis image
image_index_disp = uicontrol(fh,'style','text','string',image_index,...
                             'position',[ 550 20 20 20]);

colormap(gray)
hold on;
scatter_h = scatter([],[],'rx');


%%generate exctra graphs

%e v rg
fh2 = figure;
sc2 = scatter([],[],'rx');
hold on
lh2 = plot([0 0],'--k');
lv2 = plot([0 0],'--k');
xlabel('e');
ylabel('rg');
title('rg v e');

%e vs shift
fh3 = figure;
sc3 = scatter([],[],'rx');
hold on
lh3 = plot([0 0],'--k');
lv3 = plot([0 0],'--k');
xlabel('e')
ylabel('shift')
title('e v shift');

%I vs rg
fh4 = figure;
sc4 = scatter([],[],'rx');
hold on
%lh4 = plot([0 0],'--k');
lv4 = plot([0 0],'--k');
ylabel('I')
xlabel('rg')
title('I v rg');

%I vs rg
fh5 = figure;
[hist_v hist_bins] = hist(rand(1,50),0:.01:1);
hh = plot(hist_bins,hist_v);

title('disp mod 1');


update_display;


function clean_up(a,b)
    1
   r.close(); 

end
%%set up buffer controls
    
%%set up 

%  Initialization tasks

%  Callbacks for MYGUI
%%adjust threshold
function int = adjust_thresh(int)

    if int<1
        int = 1;
    elseif int>100
        int = 100;
    end
    threshold = int;            
 
   rebuild_buffer;
   update_display;
end
%%particle_sz
function int = adjust_p_rad(int)
    if int<0
        int = 0;
    end
    
    p_rad = int;
   rebuild_buffer
   update_display;
end

function int = adjust_d_rad(int)
    if int<1
        int = 1;
    end
    
    d_rad = int;
    rebuild_buffer;
   update_display;
end

function int = adjust_mask_rad(int)
    if int<d_rad
        int = d_rad;
    end
    
    mask_rad = int;
    rebuild_buffer
    update_display;
end

function int = adjust_hwhm(int)
    if int<0
        int = 0;
    elseif int>p_rad
        int = p_rad
    end
    
    
   hwhm = int;
   rebuild_buffer;
   update_display;
end

function int = adjust_shift_cut(int)
    if int<0
        int = 0;
    end
    
    
   shift_cut = int;
   update_display;
end

function int = adjust_rg_cut(int)
    if int<0
        int = 0;
    end
    
    
   rg_cut = int;
   update_display;
end

function int = adjust_e_cut(int)
    if int<0
        int = 0;
    elseif int>1
        int = 1;
    end
    
    
   e_cut = int;
   update_display;
end

function int = adjust_disp_mode(int)
    if int<1
        int = 0;
    elseif int>1
        int = 1;
    end
    
    
   disp_mode = int
   fh
   if (disp_mode==1)
       caxis([3000 10000])
   elseif (disp_mode==0)
       caxis([0 50])
   end
   
   
   rebuild_buffer;
   update_display;
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
        img = extract_image(r,buffer_index(j));
        
        tic
            [pks b_passed centers] = iden(img,[p_rad,hwhm,d_rad, ...
                            mask_rad,threshold,0]);
            
        toc
        clear iden
    
        pks = pks';

        % convert Java BufferedImage to MATLAB image
        
        if disp_mode ==0
            buffer_pix(:,:,j) = b_passed + 0*centers;
        else
            buffer_pix(:,:,j) = img;%.*(ones(size(centers))-centers);
        end
        buffer_pos{j} = pks(:,[1 3 2 4:9]);
       
        
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
        img = extract_image(r,buffer_index(j));
        
        tic
            % convert Java BufferedImage to MATLAB image
            [pks b_passed centers] = iden(img,[p_rad,hwhm,d_rad,mask_rad, ...
                                threshold,0]);
        toc
        clear iden
        pks = pks';

        % convert Java BufferedImage to MATLAB image
        if disp_mode==0
            buffer_pix(:,:,j) = b_passed + 0*centers;
        else
            buffer_pix(:,:,j) = img;%.*(ones(size(centers))-centers);
        end
        buffer_pos{j} = pks(:,[1 3 2 4:9]);

 
        
    end
    set(bc,'string',num2str(buffer_center))
    buffer_index = buffer_index_tmp
    buffer_current = buffer_current_tmp;
end



function update_display
    set(img_frame,'cdata',squeeze(buffer_pix(:,:,buffer_current)));
    tmp = buffer_pos{buffer_current};
    
    set(sc2,'xdata',tmp(:,9));
    set(sc2,'ydata',tmp(:,7));
    set(lh2,'xdata',get(get(fh2,'currentaxes'),'xlim'))
    set(lh2,'ydata',[rg_cut rg_cut]);
    set(lv2,'ydata',get(get(fh2,'currentaxes'),'ylim'))
    set(lv2,'xdata',[e_cut e_cut]);
    
    set(sc3,'xdata',tmp(:,9));
    set(sc3,'ydata',sqrt((sum(tmp(:,[4 5]).^2,2))));
    set(lh3,'xdata',get(get(fh3,'currentaxes'),'xlim'))
    set(lh3,'ydata',[shift_cut shift_cut]);
    set(lv3,'ydata',get(get(fh3,'currentaxes'),'ylim'))
    set(lv3,'xdata',[e_cut e_cut]);

    
    
    set(sc4,'xdata',tmp(:,7));    
    set(sc4,'ydata',tmp(:,6));
    set(lv4,'ydata',get(get(fh4,'currentaxes'),'ylim'))
    set(lv4,'xdata',[rg_cut rg_cut]);
    %    set(lh4,'ydata',get(get(fh3,'currentaxes'),'ylim'))
    % set(lh4,'xdata',[e_cut e_cut]);
    
    
    tmp = t_trim_md(tmp,shift_cut,rg_cut,e_cut);
    
    set(scatter_h,'xdata',tmp(:,2)+1);
    set(scatter_h,'ydata',tmp(:,3)+1);
    
    
    %    figure(fh5)

    %    htmp = zeros(size(get(hh,'ydata')));
    
    set(hh,'ydata', hist(mod(reshape(tmp(:,[4 5]),1,[]),1),0:.01:1));

    
    
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