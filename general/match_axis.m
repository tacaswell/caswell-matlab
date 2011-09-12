function match_axis(f1,f2)
    set(get(f2,'children'),'xlim',get(get(f1,'children'),'xlim'))
    set(get(f2,'children'),'ylim',get(get(f1,'children'),'ylim'))
    
end