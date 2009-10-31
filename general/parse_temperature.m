function [temp_str temp_num] = parse_temperature(fname)
% PARSE_TEMPERATURE - takes in a file name and parses out the temperature
%   
    temp_str = regexpi(fname,['[0-9]{2}-' ...
                        '[0-9]'],'match');
    if(~isempty(temp_str))
        temp_str = temp_str{1};
        temp_str(3) = '.';
        temp_num = str2double(temp_str);
    else
        temp_num = 0;
    end
end
