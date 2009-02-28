function master_script
%o function master_script
%o summary: a meta script that loops through systematic file names
%and runs the commands to do the basic analysis of time series
%the results are saved to a file based on the file name
%o inputs:
%-NONE:
%o outputs:
%-NONE:
    
    handle = loci.formats.ChannelFiller();
    handle = loci.formats.ChannelSeparator(handle);
    sargs.binnum=750;
    sargs.gofr_max=50;
    sargs.trk_max_disp = 3;
    sargs.min_trk_len = 5;
    sargs.max_msd = 700;
    
    %%for 20080808 data             
    %args.threshold = 1;            
    %args.p_rad = 4;                
    %args.d_rad = 2;                
    %args.mask_rad =3;              
    %args.hwhm = 1;                 
    %args.ecut = .4;                
    %args.scut = 1;                 
    %args.rgcut = 4;                
    %args.frame_size = '[696 520]' ;
                  


    %args.threshold = [1 15 10 5 8 8 5;5 8 8 8 8 8 8];
    %args.p_rad = [5 5 4 4 4 4 4; 6 5 5 5 5 5 5 ];
    %args.d_rad = 3
    %args.mask_rad =[4 4 3 3 3 3 3; 4 4 4 4 4 4 4]; 
    %args.hwhm = [2 2 ones(1,5); 2*ones(1,7)];
    %args.ecut = .4;
    %args.scut = 1;
    %args.rgcut = 8;
    %args.frame_size = '[1392 520]' ;
    
    
    
    args.frame_size = '[1392 520]' ;
    %for 20080808 data             
%    args.threshold = 8;            
%    args.p_rad = 7;                
%    args.d_rad = 3;                
%    args.mask_rad =5;              %for 2008/7/28 data
%    args.hwhm = 3;                 %prefix1 = {'d1' 'd2' 'rd' 'ld'};
%    args.ecut = .4;                %prefix2 = {'heating' 'cooling' 'rt'};
%    args.scut = 1;                 %fbase = '/home/tcaswell/collids/data/polyNIPAM_batch_1/20080728/js_';
%    args.rgcut = 4;                %for 2008/


%     args.fname = [20 26 28 29]'
%     args.threshold = [8 8 8 8]'
%     args.p_rad = [7 6 5 5]';   
%     args.d_rad = [3 3 3 3]';   
%     args.mask_rad =[5 5 4 4]'; 
%     args.hwhm = [3 2 2 2]';    
%     args.ecut = [.5 .5 .5 .5]' ; 
%     args.scut = [1 1 1 1]';    %    prefix1 = {'bot1' 'bot2' 'mid3'};
%     args.rgcut = [10 10 10 10]';   %    prefix2 = {'heating' 'cooling' 'rt'};
%    %    

%    args.fname = {'hot' 'cold'};
%    args.threshold = [8 8]'
%    args.p_rad = [4 4]';   
%    args.d_rad = [3 3 ]';   
%    args.mask_rad =[4 4]'; 
%    args.hwhm = [1 1 ]';    
%    args.ecut = [.6 .6]' ; 
%    args.scut = [1 1]';    %    prefix1 = {'bot1' 'bot2' 'mid3'};
%    args.rgcut = [6 6]';   %    prefix2 = {'heating' 'cooling' 'rt'};
%
    

%for 20090223 data

    args.fname     = [21];
    args.threshold = [6];
    args.p_rad     = [5];
    args.d_rad     = [3];
    args.mask_rad  = [4];
    args.hwhm      = [2];
    args.ecut      = [.7];
    args.scut      = [1.5];
    args.rgcut     = [];


    %fbase =
    %'/home/tcaswell/collids/data/polyNIPAM_batch_10/20080915/s4/';
    fbase = '/home/tcaswell/collids/data/polyNIPAM_batch_11/20081010/temp_series/';
    %fbase = '/home/tcaswell/collids/data/polyNIPAM_batch_2/20090203/';
    %prefix1 = {'bot1' 'bot2' 'mid3'};
    %prefix2 = {'heating' 'cooling'};
    prefix2 = {'slide'}
    m=0
    for j = 2
        %        for k = 1
            %            for m = 0

            %                if j==2&&m==6
            %       continue
            %   end

                
               
                
                
                %                post_fix =
                %                sprintf('%s_%s_%d',prefix1{j},prefix2{k},m);
                %post_fix = sprintf('%s_%d_%d',prefix2{j},m+1,k+1);
                
                
                
                post_fix = sprintf('%d',args.fname(j))
                %post_fix = args.fname{j};
                
                %                    if k==2&m==3
                %    post_fix = [post_fix(1:(end-1)) '2a'];
                % end
                    
                fname = [fbase post_fix '.tif']

                    
                eval(sprintf('handle.setId(fname);'))
                fprintf('handle set\n')
                

                fprintf('locate peaks\n')
                eval(sprintf(['[all_pks tms] = t_extract_peaks(handle,' ...
                              '%d,%d,%d,%d,%d);'], args.p_rad(j,m+1), ...
                             args.hwhm(j,m+1), args.d_rad(j,m+1), ...
                             args.mask_rad(j,m+1), args.threshold(j,m+1)));
                fprintf('peaks located\n')
                
                
                
                fprintf('trim peaks\n')
                eval(sprintf(['all_pks_trim = ' 't_trim_md(all_pks,%d,%d,%d);'], ...
                             args.scut(j,m+1),args.rgcut(j,m+1), args.ecut(j,m+1)));
                fprintf('peaks trimmed\n');
                    
               %     
               % 
               % fprintf('compute g(r)\n')
               % eval(sprintf(['[bin_val t_bins] = ' ...
               %               't_gofr_wm(all_pks_trim(:,2:end),%d,' ...
               %               '%d,%s);'], sargs.binnum, sargs.gofr_max, ...
               %              args.frame_size));
               % fprintf('computed g(r)\n')
               % 
               %     
%                    tic
%                        fprintf('make tracks\n')
%                        eval(sprintf(['tracks = track(all_pks_trim' ...
%                                      '(:,[2 3 10]),%d);'],sargs.trk_max_disp));
%                        fprintf('made tracks\n')
%                    toc
%                    
%                    tic
%                        fprintf('fill in memory holes\n')
%                        eval(sprintf(['tracks_fill = ' ...
%                                      't_fill_tracks(tracks,%d);'],sargs.min_trk_len));
%                        fprintf('filled in memory holes\n')
%                    toc
%                    
%                    tic
%                        fprintf('make msd \n')
%                        eval(sprintf(['[msd, msd_e] = ' ...
%                                      't_msd_sum(tracks_fill(:,[1 2 5 ' ...
%                                      '6]),%d,%d);'],sargs.max_msd,sargs.min_trk_len));
%                        fprintf('made msd \n')
%                    toc
%                    
%                    tic
%                        fprintf('make S \n')
%                        eval(sprintf(['[v_fft_y v_fft_x ] = ' ...
%                                      't_fft_mean_cord(tracks_fill);']));
%                        fprintf('made S \n')
%                    toc
%                    
%                    tic
%                        fprintf('saving \n')
%                        eval(sprintf(['save(''processed_%s'',''all_pks'', ' ...
%                                      '''all_pks_trim'',''bin_val'',' ...
%                                  '''t_bins'',''tracks'',''tracks_fill'',' ...
%                                      '''msd'',''msd_e'',''tms'',' ...
%                                      '''v_fft_x'',''v_fft_y'')'], post_fix));
%                        
%                        fprintf('saved\n')
%                    toc
               fprintf('saving \n')
                eval(sprintf(['save(''processed_%s'',''all_pks'', ' ...
                              '''all_pks_trim'',' ...
                              '''tms'',''fname'')'], ...
                             post_fix));
                
%                eval(sprintf(['save(''processed_%s'',''all_pks'', ' ...
%                              '''all_pks_trim'',''bin_val'',' ...
%                              '''t_bins'',''tms'',''fname'')'], post_fix));                        
                fprintf('saved\n')

                %                    
                handle.close();
                    



                %            end
                %        end
    end
    

    clear all   
    

    
%    tracks = track(all_pks_h1_trimed(:,[2 3 10]),3);
%
%    tracks_fill = t_fill_tracks(tracks,50);
%    
%    
%    
%    
%    
%    
%    
%    
%    handle.close
%   
end
    