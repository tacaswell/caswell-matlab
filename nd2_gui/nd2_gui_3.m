function circ_handles = nd2_gui_3(filename)
% MYGUI Brief description of GUI.
%       Comments displayed at the command line in response 
%       to the help command. 

% (Leave a blank line following the help.)

%  Initialization tasks
%% define constants
    threshold = 1;         %threshold for pkfnd
    p_rad = 5;           %size of particles to be looking for
    image_index = 1;
    series_index = 0;
    hwhm = 1.2;
    d_rad = 4;
    mask_rad = 5;

    shift_cut = 1;
    rg_cut = 12;
    e_cut = .5;

    disp_mode = 1;
    
    top_cut = 1/1000;
    
%%set up filef handle
    
%%set up file handle
    r = loci.formats.ChannelFiller();
   
    %%uncomment to stich files
    r = loci.formats.FileStitcher(r);

    r.setId(filename);

    r.setSeries(series_index);
    w = r.getSizeX();
    h = r.getSizeY();
    numImages = r.getImageCount();
    %    buffer_pk = cell(1,numImages);    

    %%Other handles
    circ_handles = [];
    

    %%set up buffers
    buffer_frames = 1;
    buffer_length = 2*buffer_frames + 1;
    buffer_index = zeros(1,buffer_length);
    buffer_current = 1;
    buffer_pix = zeros(h,w,buffer_length);
    buffer_pix2 = zeros(h,w,buffer_length);
    buffer_pos = cell(1,buffer_length);
    buffer_center = image_index;
    rebuild_buffer;
    
    
   
%%  Construct the components

fh = figure('position',[20 40 1200 900]);

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
Ic = changer('top cut',[880 30] ,fh,@adjust_top_cut);
ps = save_pram('save param',[960 30],fh,@psave);
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
set(Ic,'string',num2str(top_cut*1000));
img_frame = imagesc(squeeze(buffer_pix(:,:,buffer_current)));
title(filename)
axis image
image_index_disp = uicontrol(fh,'style','text','string',image_index,...
                             'position',[ 550 20 20 20]);

colormap(gray)
hold on;
scatter_h2 = scatter([],[],'g*');
scatter_h3 = scatter([],[],'b.');
scatter_h = scatter([],[],'rs');
%%generate exctra graphs

%e v rg
fh2 = figure;
sc2 = imagesc([0,1],[0,25],zeros(125,250))
set(gca,'ydir','normal')
hold on
lh2 = plot([0 0],'--k');
lv2 = plot([0 0],'--k');
xlabel('e');
ylabel('rg');
title('rg v e');

%e vs shift
fh3 = figure;
sc3 = imagesc([0,1],[0,3],zeros(125,125))
set(gca,'ydir','normal')
colormap(jet)
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
[hist_v hist_bins] = hist(rand(1,50),0:.02:1);
hh = stairs(hist_bins,hist_v);
title('disp mod 1');

%value histogram;
fh6 = figure;
[val_hist_v val_hist_bins] = hist(rand(1,50),0:.02:1);
vh = stairs(val_hist_bins,val_hist_v);
title('pixel value histogram');


update_display;


function clean_up(a,b)
    
    r.close(); 
    clear r;
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
   figure(fh);
   
   tmp = buffer_pix;
   buffer_pix = buffer_pix2;
   buffer_pix2 = tmp;
   clear tmp;
% $$$    rebuild_buffer;
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

function int = adjust_top_cut(int)
    if int<0
        int = 0;
    end
    if int>100
        int = 100;
    end
    top_cut = int/1000;
    display(top_cut);
    rebuild_buffer;
    update_display;
end


function p_save = psave()
% P_SAVE - saves the parameter
%   
    
    display(filename)
    [fpath name] = fileparts(filename);

    doc_node = com.mathworks.xml.XMLUtils.createDocument('iden');
    doc_root_node = doc_node.getDocumentElement;
    doc_root_node.setAttribute('date',datestr(now,31))

    
    fprams = {
        'threshold',
        'hwhm',
        'shift_cut',
        'rg_cut',
        'e_cut',
        'top_cut'
            }
    
    iprams = {
        'p_rad',
        'd_rad',
        'mask_rad'}
    
    for j = 1:max(size(fprams))
        p = fprams{j};
        tmp_elm = doc_node.createElement('param');   
        tmp_elm.setAttribute('key',p)
        tmp_elm.setAttribute('type','float')
        tmp_elm.setAttribute('value',sprintf('%f',eval( p )))
        doc_root_node.appendChild(tmp_elm);
    end
    
    
    
    for j = 1:max(size(iprams))
        p = iprams{j};
        tmp_elm = doc_node.createElement('param');   
        tmp_elm.setAttribute('key',p)
        tmp_elm.setAttribute('type','int')
        tmp_elm.setAttribute('value',sprintf('%i',eval( p )))
        doc_root_node.appendChild(tmp_elm);
        

    end
    

    
    
    base_name = [sprintf('%s/%s',...
                         fpath,name),'.xml'];
    
    xmlwrite(base_name,doc_node);
        
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
% $$$     buffer_current = find(buffer_index==buffer_center);
    
    for j = 1:buffer_length
        fill_buffer(j);
        
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
    display(buffer_index(buffer_current_tmp));
    
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
            buffer_index_tmp = (numImages-buffer_length): ...
                buffer_length
    else
        dilspay('wtf, did not hit anything')
    end


    fprintf('spot3\n')
    %figure out what has changed and change it
    change_index = find(buffer_index ~=buffer_index_tmp);
    for j = change_index
        fill_buffer(j)
    end
    set(bc,'string',num2str(buffer_center))
    buffer_index = buffer_index_tmp
    buffer_current = buffer_current_tmp;
end


function fill_buffer(j)
    img = extract_image(r,buffer_index(j));
    
    tic
        [pks b_passed centers] = matlab_process(img,[p_rad,hwhm,d_rad, ...
                            mask_rad,threshold,top_cut]);
        
    toc
    clear matlab_process
    
    pks = pks';

    % convert Java BufferedImage to MATLAB image
    
    if disp_mode ==0
        buffer_pix(:,:,j) = b_passed + 0*centers;
        buffer_pix2(:,:,j) = img;%.*(ones(size(centers))-centers);
    else
        buffer_pix(:,:,j) = img;%.*(ones(size(centers))-centers);
        buffer_pix2(:,:,j) = b_passed + 0*centers;
    end
    buffer_pos{j} = pks(:,[1 3 2 5 4 6:9]);
    
end



function update_display
    
    display(buffer_current)
    tmp_img = squeeze(buffer_pix(:,:,buffer_current));
    % if( disp_mode ==1)
    %     sort_tmp = sort(tmp_img(:),'descend');
    %     cut_off = sort_tmp(floor(prod(size(tmp_img))*top_cut));
    %     display('number of bins cut')
    %     sum(sum(tmp_img>cut_off))
    %     display(cut_off)
    %     tmp_img(tmp_img>cut_off) = cut_off;

    % end
    [h_val h_bins] = hist(reshape( tmp_img ,1,[]),100);
    set(vh,'ydata',h_val(2:end));    
    set(vh,'xdata',h_bins(2:end));    
    
    set(img_frame,'cdata',tmp_img);
    clear tmp_img  ;

    
    tmp = buffer_pos{buffer_current};
    tmp_hist2 = histc2([tmp(:,9),tmp(:,7)],[0,1,125],[0,25,250]);
    set(sc2,'cdata',tmp_hist2);
    set(lh2,'xdata',get(get(fh2,'currentaxes'),'xlim'))
    set(lh2,'ydata',[rg_cut rg_cut]);
    set(lv2,'ydata',get(get(fh2,'currentaxes'),'ylim'))
    set(lv2,'xdata',[e_cut e_cut]);
    
    tmp_hist2 = histc2([tmp(:,9),sqrt((sum(tmp(:,[4 5]).^2,2)))],[0,1,125],[0,3,125]);
    
    set(sc3,'cdata',tmp_hist2);
    
    
    
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
    

    
    set(scatter_h2,'xdata',tmp(tmp(:,8)>1,2)+1-tmp(tmp(:,8)>1,4));
    set(scatter_h2,'ydata',tmp(tmp(:,8)>1,3)+1-tmp(tmp(:,8)>1,5));
    set(scatter_h3,'xdata',tmp(:,2)+1-tmp(:,4));
    set(scatter_h3,'ydata',tmp(:,3)+1-tmp(:,5));

    
    tmp = t_trim_md(tmp,shift_cut,rg_cut,e_cut);
    
    set(scatter_h,'xdata',tmp(:,2)+1);
    set(scatter_h,'ydata',tmp(:,3)+1);
    

    %    figure(fh5)

    %    htmp = zeros(size(get(hh,'ydata')));
    
    narp = histc(mod(reshape(tmp(:,[4 5]),1,[]),1),0:.02:1);
    sum(narp)
    set(hh,'ydata', narp);


    clear tmp;
    
    caxis auto
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