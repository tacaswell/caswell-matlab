function out =  merge_img_gofr(handle,base_frame,avg_range,prams)
    img = extract_image(handle,base_frame);
    for j = 1:avg_range
        img = img + extract_image(handle,base_frame+j);
    end
    pks = matlab_process(img,prams)';
    extr = [pks(:,[3 2]), zeros(size(pks,1),1)];
    [val,bin] = basic_static(extr,1390,1040,1,100,2000);
    out = {bin,val,img};
end
