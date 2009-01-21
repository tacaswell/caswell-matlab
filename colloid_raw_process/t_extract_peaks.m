function [ all_pks tm_vec]= t_extract_peaks(handle, p_rad, hwhm,d_rad,mask_rad,threshold)
%o function [ all_pks tm_vec]= t_extract_peaks(handle, p_rad, hwhm,d_rad,mask_rad,threshold)
%o summary: takes a file handle and a number of parameters and uses the
%mex file that calls peter's code
%o outputs:
%-all_pks: a matrix of all peaks of the form [1d_cord x y x_offset
%y_offset, total_mass, r2_val, multiplicity_val, e, frame]
%-tm_vec: time stamp on each image in stack
%o inputs:
%-handle: bio-formats handle for image stack
%-p_rad: particle radius, arguemnt for mex file
%-hwhm: half with half max for gaussian filter, arguemnt for mex file
%-d_rad: dilation radius, arguemnt for mex file
%-mask_rad: mask radius, arguemnt for mex file
%-threshold: threshold to set pixels below to zero, arguemnt for mex file

    handle.setSeries(0)
    w = handle.getSizeX();
    h = handle.getSizeY(); 
    numImages = handle.getImageCount();
    
    all_pks = zeros(1e6,10);
    mat_sz = 1e6;
    step_sz = 1e6;
    tm_vec = get_times(handle);
    pk_num = 0;
    for j = 1:numImages
           % for j = 1:15
    
        img = extract_image(handle,j-1);

        pks = t_hello(img,[p_rad,hwhm,d_rad,mask_rad,threshold,0])';
        pk_sz = size(pks,1);
        if (pk_sz+pk_num)>mat_sz
            all_pks = grow_mat(all_pks,step_sz);
            mat_sz = mat_sz + step_sz;
        end
        
        
        %        size(pks)

        all_pks(pk_num+1:(pk_num+pk_sz),:) = [pks,j*ones(pk_sz,1)];
        pk_num = pk_num+pk_sz;
        %    clear img

    end
    

    all_pks = all_pks(1:pk_num,:);

    %    size(all_pks)
  
    
    %  all_pks = t_trim_md(all_pks,1.5,75,.2);
    
    % tracks = track(all_pks(:,[2 3 10]),1.5*p_rad);
  %    tracks = [];
end
    
    
%  feature_radius = (int)args[0];
%  hwhm_length = args[1];
%  dilation_radius = (int)args[2];
%  mask_radius = (int)args[3];
%  pctle_threshold = args[4];
%  testmode = (int)args[5];
function out = grow_mat(in,stepsz)
    out = [in;zeros(stepsz,size(in,2))];

end
    