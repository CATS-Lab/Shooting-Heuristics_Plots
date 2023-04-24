FontSize=11;

hFig=figure(3);clf; 
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
set(hFig,'Position',[100,400,w,h])
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
mid_scale = 0.1;
t_mid = t_minus + mid_scale*(t_plus-t_minus);
p_mid = p+ v*(t_mid-t_minus)+0.5*a*(t_mid-t_minus)^2;
text(t_mid, p_mid+5,'$(l,v,a,t'',t'''')$','Rotation',35);

plot(t_minus, p,'b+');
plot(t_plus,ps_seg(end),'b+')


t_beyond = t_plus + 0.05* (t_plus-t_minus);
p_beyond = p+ v*(t_beyond-t_minus)+0.5*a*(t_beyond-t_minus)^2;
text(t_beyond, p_beyond+7,'$p_n$','Rotation',35);



tau = 1;
s =7;

t_minus_2 = t_minus+tau;
t_plus_2 = t_plus+tau;
p_2 = p - s;
v_2 =v;
a_2 = a;


ts_all = [x_min:t_step:x_max];
ps_all_2 = p_2 + v_2*(ts_all-t_minus_2)+0.5*a_2*(ts_all-t_minus_2).^2;
plot(ts_all, ps_all_2,':k','LineWidth',1);

ts_seg_2 = [t_minus_2:t_step:t_plus_2];
ps_seg_2 = p_2 + v_2*(ts_seg_2-t_minus_2)+0.5*a_2*(ts_seg_2-t_minus_2).^2;
plot(ts_seg_2, ps_seg_2,'b','LineWidth',2);
mid_scale_2 = 0;
t_mid_2 = t_minus_2 + mid_scale_2*(t_plus_2-t_minus_2);
p_mid_2 = p_2+ v_2*(t_mid_2-t_minus_2)+0.5*a_2*(t_mid_2-t_minus_2)^2;
text(t_mid_2, p_mid_2-5,'$(l-s,v,a,t''+\tau,t''''+\tau)$','Rotation',32);

plot(t_minus_2, p_2,'b+');
plot(t_plus_2,ps_seg_2(end),'b+')

t_beyond_2 = t_plus_2 + 0* (t_plus_2-t_minus_2);
p_beyond_2 = p_2+ v_2*(t_beyond_2-t_minus_2)+0.5*a_2*(t_beyond_2-t_minus_2)^2;
text(t_beyond_2, p_beyond_2+7,'$p^\texttt{s}_n$','Rotation',35);


plot([t_minus,t_minus+tau],[p,p],':b')
text(t_minus+tau/2, p+2,'$\tau$');
plot([t_minus+tau,t_minus+tau],[p,p-s],':b')
text(t_minus+tau-0.12, p-s/2,'$s$');


xlim([x_min,t_plus_2+0.5]);





folder_fig = '../Figure/';
saveas(gcf,[folder_fig,'shadow.eps'],'eps2c');


%



%set(gca,'XTick',[])
%set(gca,'YTick',[])