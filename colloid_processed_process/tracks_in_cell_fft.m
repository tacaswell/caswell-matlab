function out = tracks_in_cell_fft(in,track_length)
    tmp = cell(size(in));
    for j = 1:prod(size(tmp))
        tmp{j} = track_length;
    end
    out = cellfun(@internal_proc,in,tmp,'UniformOutput',0);
    out = out(~cellfun(@isempty,out));
end

function out= internal_proc(in,track_length)
    if size(in,1)<track_length
        out = [];
        return
    end
    in = in(1:track_length,:);
    out = power_from_disp(in);
    
end