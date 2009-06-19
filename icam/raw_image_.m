function raw_image_(pr)
    
% $$$ 
% $$$     pr = load('~/collids/processed_data/20090502/processed_30um_28-1_0.mat');
    
% $$$     pr2 = load(['~/collids/processed_data/20090502/' ...
% $$$                 'processed_30um_29-7_0.mat']);
% $$$     pr3 = load(['~/collids/processed_data/20090502/' ...
% $$$                 'processed_30um_27-2_0.mat']);
% $$$     
    
    pr = load(['~/collids/processed_data/20090502/' ...
                'processed_30um_29-7_0.mat']);
    
    save_ = true;
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    r.setId(pr.fname);
    
    frame = 15;
    img = extract_image(r,frame);
    f = figure;
    imagesc(img)
    colormap(gray)
    tmp = pr.all_pks_trim(pr.all_pks_trim(:,end)==(frame+1),:);
    hold on
    plot(tmp(:,3)+1,tmp(:,2)+1,'xr')
    axis image;
    axis([600 800 200 400 ])
    
    tmp = cell2mat(regexpi(pr.fname,['[0-' ...
                        '9]{2}-[0-9]'],'match'))

% $$$     caxis([11000 13000])                % 28-1
    caxis([4100 4800])                  % 29-7
% $$$     caxis([10000 12500])                % 27-2

% $$$     caxis([9000 11000])                 % 28.9
    axis off

    t_date = cell2mat(regexpi(pr.fname,'[0-9]{8}', ...
                              'match'));
    
    if save_
        save_figure(strcat('raw_image_',t_date,'_', tmp),[5 5],f);
    end
    
end