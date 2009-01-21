function trmtest
    index = 5;
    fh = figure;
    changer('test',[15,15],fh,@handler)
    
function handler(int)
    index = int
end    
    
end    