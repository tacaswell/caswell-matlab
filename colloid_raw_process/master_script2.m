function master_script2(fpath)
%o function master_script
%o summary: a meta script that loops through systematic file names
%and runs the commands to do the basic analysis of time series
%the results are saved to a file based on the file name
%o inputs:
%-NONE:
%o outputs:
%-NONE:
    fargs.fbase = fpath;
    fargs.fbase =['/home/tcaswell/colloids/data/polyNIPAM_batch_12/' ...
                  '20090730/'];    
    
    
    save_path = ['/home/tcaswell/colloids/processed_data/'];
    date_path = datestr(now,'yyyymmdd');
    
    if(exist(strcat(save_path,date_path),'dir')==0)
        mkdir(strcat(save_path,date_path))
    end

% $$$     fargs.fname     ={
% $$$         '29-8_mid_0'
% $$$                     }
% $$$ 

    
    handle = loci.formats.ChannelFiller();
    handle = loci.formats.ChannelSeparator(handle);
    
    
    [junk,fargs.fname] = arrayfun(@(x) fileparts(x.name), ...
                                  dir(strcat(fargs.fbase,'*.pram')), 'uniformoutput',false);
    fargs
    for k = 1:length(fargs.fname)
        tic;
            p_fname = strcat(fargs.fbase, fargs.fname{k},'.pram')
            out.stack_fname = strcat(fargs.fbase, fargs.fname{k},'.tif');

            save_name = strcat(save_path,date_path,'/processed_',fargs.fname{k})
            
            if(exist(strcat(save_name,'.mat'))) 
% $$$                 error('files already exist');
                continue
            end

            args = parse_pram(p_fname)
            out.args = args;
            handle.setId(out.stack_fname);
            fprintf('handle set\n')
            

            fprintf('locate peaks\n')
            [out.all_pks out.tms out.dims] = t_extract_peaks(handle, args.p_rad, ...
                                                    args.hwhm, args.d_rad, ...
                                                    args.mask_rad, ...
                                                    args.threshold);
            fprintf('peaks located\n')
            
            
% $$$             
% $$$             fprintf('trim peaks\n')
% $$$             out.all_pks_trim = t_trim_md(out.all_pks,args.scut, ...
% $$$                                          args.rgcut, args.ecut);
% $$$             fprintf('peaks trimmed\n');

            fprintf('saving \n')
% $$$             eval(sprintf(['save(''processed_%s'',''all_pks'', ' ...
% $$$                           '''all_pks_trim'',' ...
% $$$                           '''tms'',''fname'',''args'')'], ...
% $$$                          post_fix));

            save(save_name,'out');
            fprintf('saved\n')
            

            handle.close();
            
            movefile(p_fname, strcat(fargs.fbase, fargs.fname{k},'.done'));

        toc;

    end
    
    clear all

end
    

function args = parse_pram(p_fname)
% PARSE_PRAM - parses the pram file to get prameters
%   


    pram_file = fopen(p_fname);
    fgetl(pram_file);
    p_str =     fgetl(pram_file);
    while(p_str ~= -1)
        parts = regexp(p_str,':','split');
        switch lower(parts{1})
          case ('threshold')
            args.threshold = str2num(parts{2});
          case 'p_rad'
            args.p_rad     = str2num(parts{2});
          case 'd_rad'
            args.d_rad     = str2num(parts{2});
          case 'mask_rad'
            args.mask_rad  = str2num(parts{2});
          case 'hwhm'
            args.hwhm      = str2num(parts{2});
          case 'e_cut'
            args.ecut      = str2num(parts{2});
          case 'shift_cut'
            args.scut      = str2num(parts{2});
          case 'rg_cut'
            args.rgcut     = str2num(parts{2});
        end
        p_str =     fgetl(pram_file);
    end
    
   
end