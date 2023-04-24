FontSize=11;

hFig=figure(2);clf; 
whitebg(hFig,'white');
edge =0.0;
hAx=axes('position',[edge  edge  1-2*edge  1-2*edge]);
%set(hAx, 'box','off','XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
% color = get(hFig,'Color');
% set(gca,'XColor',color,'YColor',color,'TickDir','out')
set(gca,'Visible','off')
hold all
set(0,'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize',FontSize,'DefaultTextFontSize',FontSize,'DefaultTextInterpreter','Latex');
w = 220;
h =220;
set(hFig,'Position',[400,100,w,h])
set(gcf, 'PaperUnits', 'centimeters');
saved_fig_size=[0 0 w/35 h/35];
set(gcf, 'PaperPosition', saved_fig_size);

x_min =0;
x_max = 5;

t_minus = 0.5;
t_plus = 3;
p = 20;
v =10;
a = 2;

t_step = 0.1;
ts_all = [x_min:t_step:x_max];
ps_all = p + v*(ts_all-t_minus)+0.5*a*(ts_all-t_minus).^2;
plot(ts_all, ps_all,':k','LineWidth',1);

ts_seg = [t_minus:t_step:t_plus];
ps_seg = p + v*(ts_seg-t_minus)+0.5*a*(ts_seg-t_minus).^2;
plot(ts_seg, ps_seg,'b','LineWidth',2);
mid_scale = -0.05;
t_mid = t_minus + mid_scale*(t_plus-t_minus);
p_mid = p+ v*(t_mid-t_minus)+0.5*a*(t_mid-t_minus)^2;
text(t_mid, p_mid+9,'$\mathbf{s}_1=(l_1,v_1,a_1,t''_1,t''''_1)$','Rotation',25);

plot(t_minus, p,'b+');
plot(t_plus,ps_seg(end),'b+')

t_minus_2 = 1.5;
t_plus_2 = 4;
p_2 = -10;
v_2 =18;
a_2 = -6;


ts_all = [x_min:t_step:x_max];
ps_all_2 = p_2 + v_2*(ts_all-t_minus_2)+0.5*a_2*(ts_all-t_minus_2).^2;
plot(ts_all, ps_all_2,':k','LineWidth',1);

ts_seg_2 = [t_minus_2:t_step:t_plus_2];
ps_seg_2 = p_2 + v_2*(ts_seg_2-t_minus_2)+0.5*a_2*(ts_seg_2-t_minus_2).^2;
plot(ts_seg_2, ps_seg_2,'b','LineWidth',2);
mid_scale_2 = -0.05;
t_mid_2 = t_minus_2 + mid_scale_2*(t_plus_2-t_minus_2);
p_mid_2 = p_2+ v_2*(t_mid_2-t_minus_2)+0.5*a_2*(t_mid_2-t_minus_2)^2;
text(t_mid_2, p_mid_2-7,'$\mathbf{s}_2=(l_2,v_2,a_2,t''_2,t''''_2)$','Rotation',15);

plot(t_minus_2, p_2,'b+');
plot(t_plus_2,ps_seg_2(end),'b+')


t_extreme = -((v - a*t_minus)-(v_2 - a_2*t_minus_2))/(a-a_2);
p_extreme = p+ v*(t_extreme-t_minus)+0.5*a*(t_extreme-t_minus)^2;
p_extreme_2 = p_2+ v_2*(t_extreme-t_minus_2)+0.5*a_2*(t_extreme-t_minus_2)^2;
plot([t_extreme,t_extreme],[p_extreme,p_extreme_2],'--b')

h_factor = 1.5;
text(t_extreme+0.1, (h_factor*p_extreme+p_extreme_2)/(h_factor+1),'$D($\textbf{s}$_1-\mathbf{s}_2)$');


xlim([x_min,x_max]);



folder_fig = '../Figure/';
saveas(gcf,[folder_fig,'seg_dist.eps'],'eps2c');


%



%set(gca,'XTick',[])
%set(gca,'YTick',[])