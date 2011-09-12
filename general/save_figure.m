function save_figure(fname, width_height,fig)%,fun_name,notes)
%o function save_figure(fname, width_height)
%o summary: Save figure as fname.eps, fname.jpg
%o inputs:
%-[opt]fname: name of file, defaults to figure
%-[opt]width_height: 1x2 vector, width_height(1) = width of figure in inches
% width_height2) =  height of figure in inches
%-[opt]fig: figure number to use, defaults to current figure (as reported
%by gcf)
%o outputs:
%-NONE:save figures

path_name = ['/home/tcaswell/colloids/figures/'];
f_path = datestr(now,'yyyy-mm-dd');

if(exist(strcat(path_name,f_path),'dir')==0)
    mkdir(strcat(path_name,f_path))
end

base_name = sprintf('%s/%s',...
                      strcat(path_name,f_path),fname);

if(exist(strcat(base_name,'.eps')) ||...eu
   exist(strcat(base_name,'.jpg'))||...
   exist(strcat(base_name,'.txt')))
    error('files already exist');
end



if (nargin<1)
    fname = 'figure';
end

if (nargin < 2)
    width = 6.5;
   aoeuaoeu height = 4.5;
else
    width = width_height(1); % Width of Figure in Inches
    height = width_height(2); % Height of Figure in Inches
end
if nargin<3
    fig = gcf;
end
figure(fig);
% Set up the paper
% First set up the paper to be the right size.

set(fig,'PaperUnits','inches');
set(fig,'Units','inches');
papersize=get(fig,'PaperSize');
left = (papersize(1)-width)/2;
bottom= (papersize(2)-height)/2;
set(fig,'PaperPositionMode','manual');
mfs=[left,bottom,width,height];
set(fig,'PaperPosition',mfs);
set(fig,'Position',[0.0,0.0,width,height]);

% Finally save the figure as an epsc with embedded tiff

eval(sprintf('print -depsc -tiff -r150 %s', strcat(base_name,'.eps') ));

eval(sprintf('print -djpeg -r500 %s',strcat(base_name,'.jpg') ));

% % add an meta data file
% mdf = fopen(strcat(base_name,'.txt'),'w+');

% fprintf(mdf,'%s\ngenerating function: %s\n',datestr(now,31),fun_name);
% fprintf(mdf,'%s\n',notes);

% fclose(mdf);

% eval(sprintf('!chmod u-w %s*',base_name))
