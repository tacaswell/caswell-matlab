function out =  fr_avg_gofr(handle,frame_count,avg_range,prams)
    cur_frame = 0
    
    gmax = (frame_count - avg_range)

    frame_count = 0;
    all_peaks = [];

    while( cur_frame < gmax )
        
        img = extract_image(handle,cur_frame);
        lmax = cur_frame + avg_range
        while (cur_frame <lmax)
            cur_frame = cur_frame+1;
            img = img + extract_image(handle,cur_frame);
        end
        pks = matlab_process(img,prams)';
        extr = [pks(:,[3 2]), frame_count*ones(size(pks,1),1)];
        frame_count = frame_count + 1
        cur_frame = cur_frame+1
        all_peaks = [all_peaks;extr];
    end
    
    if frame_count >0
        [val,bin] = basic_static(all_peaks,1390,1040,frame_count,100,2000);
        out = {bin,val};
    end
    display('done')
end