function pbh = save_pram(title,pos,fh,fun_handle)
%makes a panal in a gui that contains a button that calls the 
% supplied function when pushed
    
count = -1;
%fh = figure;
ph = uipanel('Parent',fh,'Title',title,...
             'Units','pixels','Position',[pos 80 80]);

pbh = uicontrol(ph,'Style','pushbutton','String','save',...
                'Units','normalized',...
                'Position',[.1 .1 .8 .8],...
                 'callback',{@save_callback});

function save_callback(ohand, ed)
    fun_handle();
end

end