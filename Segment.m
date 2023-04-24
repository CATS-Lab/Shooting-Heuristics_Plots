

hFig=figure(1);clf; 
whitebg(hFig,'white');
edge =0.0;
hAx=axes('position',[edge  edge  1-2*edge  1-2*edge]);
%set(hAx, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
% color = get(hFig,'Color');
% set(gca,'XColor',color,'YColor',color,'TickDir','out')
set(gca,'Visible','off')
hold all
FontSize=11;
set(0,'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize',FontSize,'DefaultTextFontSize',FontSize,'DefaultTextInterpreter','Latex');
w = 220;
h =220;
set(hFig,'Position',[100,100,w,h])
set(gcf, 'PaperUnits', 'centimeters');
saved_fig_size=[0 0 w/35 h/35];
set(gcf, 'PaperPosition', saved_fig_size);

x_min =0;
x_max = 5;
t_minus = 0.5;
t_plus = 3;
p = 1;
v =10;
a = 2;


t_step = 0.1;
ts_all = [x_min:t_step:x_max];
ps_all = p + v*(ts_all-t_minus)+0.5*a*(ts_all-t_minus).^2;
plot(ts_all, ps_all,'k');
t_beyond = t_plus + 0.1* (t_plus-t_minus);
p_beyond = p+ v*(t_beyond-t_minus)+0.5*a*(t_beyond-t_minus)^2;
text(t_beyond, p_beyond+7,'$(l,v,a,t'')$','Rotation',45);


ts_seg = [t_minus:t_step:t_plus];
ps_seg = p + v*(ts_seg-t_minus)+0.5*a*(ts_seg-t_minus).^2;
plot(ts_seg, ps_seg,'b','LineWidth',2);
mid_scale = 0.15;
t_mid = t_minus + mid_scale*(t_plus-t_minus);
p_mid = p+ v*(t_mid-t_minus)+0.5*a*(t_mid-t_minus)^2;
text(t_mid, p_mid+7,'$(l,v,a,t'',t'''')$','Rotation',35);
plot(t_minus, p,'r+');
%text(t_minus, p-4,'$t^-$');
text(t_minus-.1, p-4,'$(l,v,t'')$');
plot(t_plus,ps_seg(end),'r+')
text(t_plus,ps_seg(end)-4,'$t\"$');


xlim([x_min,x_max]);

pause(0.0001);

folder_fig = '../Figure/';
saveas(gcf,[folder_fig,'seg_def.eps'],'eps2c');


%



%set(gca,'XTick',[])
%set(gca,'YTick',[])