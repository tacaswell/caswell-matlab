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
    %    %for 20080808 data             
    %    args.threshold = 8;            
    %    args.p_rad = 7;                
    %    args.d_rad = 3;                
    %    args.mask_rad =5;              
    
    %%for 2008/7/28 data
    %    args.hwhm = 3;
    %prefix1 = {'d1' 'd2' 'rd' 'ld'};
    %    args.ecut = .4;               
    %prefix2 = {'heating' 'cooling' 'rt'};
    %    args.scut = 1;     
    %fbase = '/home/tcaswell/collids/data/polyNIPAM_batch_1/20080728/js_';
    %    args.rgcut = 4;             
    
    %    %for 2008/
    %     args.fname =     [20 26 28 29]'
    %     args.threshold = [8  8  8  8 ]'
    %     args.p_rad =     [7  6  5  5 ]';   
    %     args.d_rad =     [3  3  3  3 ]';   
    %     args.mask_rad =  [5  5  4  4 ]'; 
    %     args.hwhm =      [3  2  2  2 ]';    
    %     args.ecut =      [.5 .5 .5 .5]' ; 
    %     args.scut =      [1  1  1  1 ]';    %    prefix1 = {'bot1' 'bot2' 'mid3'};
    %     args.rgcut =     [10 10 10 10]';   %    prefix2 = {'heating' 'cooling' 'rt'};
%    %    

    %%older data
    %    args.fname = {'hot' 'cold'};
    %    args.threshold = [8 8]'
    %    args.p_rad = [4 4]';   
    %    args.d_rad = [3 3 ]';   
    %    args.mask_rad =[4 4]'; 
    %    args.hwhm = [1 1 ]';    
    %    args.ecut = [.6 .6]' ; 
    %    args.scut = [1 1]';    
    %    prefix1 = {'bot1' 'bot2' 'mid3'};
    %    args.rgcut = [6 6]';   
    %    prefix2 = {'heating' 'cooling' 'rt'};
%
    

%for 20090223 data
%     args.fname     = [21  23  26];
%     args.threshold = [6   6   6];
%     args.p_rad     = [5   5   4];
%     args.d_rad     = [3   3   2];
%     args.mask_rad  = [4   4   3];
%     args.hwhm      = [2   2   1];
%     args.ecut      = [.7  .7  .4];
%     args.scut      = [1.5 1.5 1];
%     args.rgcut     = [7   7   4];

% %for batch 12 20090331
% args.fname     = 'Z_Series';
% %args.fname     = 'sparse_room_tmp';
% args.threshold = [5 ];
% args.p_rad     = [8  ];
% args.d_rad     = [3  ];
% args.mask_rad  = [8  ];
% args.hwhm      = [4  ];
% args.ecut      = [.2 ];
% args.scut      = [1  ];
% args.rgcut     = [10 ];


%for batch 12 20090407
args.fname     = {'26-8','26-9', '27-7_2','28-7','29-6','30-6','32-0'};
args.threshold = [1   8   8   8   8   8   8  ];
args.p_rad     = [5   5   5   5   5   5   5  ]-1;
args.d_rad     = [3   3   3   3   3   3   3  ];
args.mask_rad  = [4   4   4   4   4   4   4  ]-1;
args.hwhm      = [1   1   1   1   1   1   1  ]+.5;
args.ecut      = [1   0.6 0.6 0.6 0.6 0.8 0.8];
args.scut      = [3   1.5 1.5 1.5 1.5 1.5 1.5];
args.rgcut     = [10  10  10  10  10  10  3.5];

% $$$ 
% $$$ args.fname    = {'melt_3'};
% $$$ args.threshold = 8;
% $$$ args.p_rad     = 5;
% $$$ args.d_rad     = 3;
% $$$ args.mask_rad  = 4;
% $$$ args.hwhm      = 1;
% $$$ args.ecut      = .8;
% $$$ args.scut      = 1.5;
% $$$ args.rgcut     = 12;




    
    args

    %fbase =
    %'/home/tcaswell/collids/data/polyNIPAM_batch_10/20080915/s4/';
    %    fbase =
    %    '/home/tcaswell/collids/data/polyNIPAM_batch_11/20081010/temp_series/';
%     fbase = ...
%         '/home/tcaswell/collids/data/polyNIPAM_batch_2/20090223/';
    fbase = ...
        '/home/tcaswell/collids/data/polyNIPAM_batch_12/20090407/tmp_series/';
    %fbase = '/home/tcaswell/collids/data/polyNIPAM_batch_2/20090203/';
    %prefix1 = {'bot1' 'bot2' 'mid3'};
    %prefix2 = {'heating' 'cooling'};
    %    prefix2 = {'slide'}
    m=0
    for j = 1:length(args.fname)
        tic;
            
            
            
            %post_fix = num2str(args.fname(j));
            post_fix = args.fname{j};
            fname = [fbase post_fix '.tif']

            
            handle.setId(fname);
            fprintf('handle set\n')
            

            fprintf('locate peaks\n')
            [all_pks tms] = t_extract_peaks(handle, args.p_rad(j), ...
                                            args.hwhm(j), args.d_rad(j), ...
                                            args.mask_rad(j), ...
                                            args.threshold(j));
            fprintf('peaks located\n')
            
            
            
            fprintf('trim peaks\n')
            all_pks_trim = t_trim_md(all_pks,args.scut(j), ...
                                     args.rgcut(j), args.ecut(j));
            fprintf('peaks trimmed\n');

            fprintf('saving \n')
            eval(sprintf(['save(''processed_%s'',''all_pks'', ' ...
                          '''all_pks_trim'',' ...
                          '''tms'',''fname'',''args'')'], ...
                         post_fix));
            fprintf('saved\n')


            handle.close();
            


        toc;
    end
    

    clear all   
    

end
    

