function proc2hdf(fname)
% PROC2HDF - this function converts the .mat files output from master_script in to hdf files
%   This code pulls the trimmed data, this needs to be fixed.  This code
%   does not dump the parameter data like it should

    fout_ext = '.h5';
    
    [fpath name] = fileparts(fname);
    
    fout = fullfile(fpath,strcat(name,fout_ext))

    pks = load(fname,'all_pks_trim');
    pks = pks.all_pks_trim;
    attr_details.Name = 'fname';
    attr_details.AttachedTo = '/';
    attr_details.AttachType = 'group';
    hdf5write(fout, attr_details, fname);
    for j = 0:1199                       
        pks_tmp = single(pks(pks(:,end)==(j+1),:));
        
        dset_details.Location = sprintf('/frame%05d/',j);
        

        dset_details.Name = 'x';
        hdf5write(fout, dset_details, pks_tmp(:,2), 'WriteMode', 'append');
       
        dset_details.Name = 'y';
        hdf5write(fout, dset_details, pks_tmp(:,3), 'WriteMode', ...
                  'append');
        
        dset_details.Name = 'x_off';
        hdf5write(fout, dset_details, pks_tmp(:,4), 'WriteMode', 'append');
       
        dset_details.Name = 'y_off';
        hdf5write(fout, dset_details, pks_tmp(:,5), 'WriteMode', ...
                  'append');
        
        dset_details.Name = 'I';
        hdf5write(fout, dset_details, pks_tmp(:,6), 'WriteMode', 'append');
       
        dset_details.Name = 'r2';
        hdf5write(fout, dset_details, pks_tmp(:,7), 'WriteMode', ...
                  'append');
        
        dset_details.Name = 'e';
        hdf5write(fout, dset_details, pks_tmp(:,9), 'WriteMode', 'append');
       
        dset_details.Name = '1D';
        hdf5write(fout, dset_details, pks_tmp(:,1), 'WriteMode', 'append');

        dset_details.Name = 'mv';
        hdf5write(fout, dset_details, pks_tmp(:,8), 'WriteMode', 'append');

    end
    
end


%[1d_cord x y x_offset y_offset, total_mass, r2_val, multiplicity_val, e, frame]