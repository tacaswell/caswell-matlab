function eth = changer(title,pos,fh,fun_handle)
%makes a panal in a gui that contains a text box and up and down arrows
    
count = -1;
%fh = figure;
ph = uipanel('Parent',fh,'Title',title,...
             'Units','pixels','Position',[pos 80 80]);

eth = uicontrol(ph,'Style','edit',...
                'Units','normalized',...
                'String',num2str(count),...
                'Position',[.5 .15 .4 .7]);
set(eth,'callback',{@text_callback,eth})
pbh1 = uicontrol(ph,'Style','pushbutton','String','u',...
                'Units','normalized',...
                'Position',[.1 .55 .4 .3],...
                 'callback',{@up_callback,eth});
pbh2 = uicontrol(ph,'Style','pushbutton','String','d',...
                'Units','normalized',...
                'Position',[.1 .15 .4 .3],'callback',...
                 {@down_callback,eth});

function text_callback(ohand, ed,txt_h)
    count = (str2num(get(ohand,'string')));
    count = fun_handle(count);
    %set(txt_h,'string',num2str(count));
end

function up_callback(ohand, ed, txt_h)
% tic
    count = str2num(get(eth,'string')) + 1;
    count=fun_handle(count);
    set(txt_h,'string',num2str(count));
    %   toc
end
function down_callback(ohand, ed, txt_h)
    count = str2num(get(eth,'string')) - 1;
    count = fun_handle(count);
    set(txt_h,'string',num2str(count));

end
end
