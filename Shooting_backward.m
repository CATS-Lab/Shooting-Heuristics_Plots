%% forward shooting
%clear all;

p_shadow = 20;
v_shadow =10;

t_minus = 1;
t_plus = 4.5;
ts_window = [t_minus, t_plus];
a_shadow =1;
a_comfort_dec=-3.5;

p_now = p_shadow+40;
v_now = 13;
t_now = t_plus +2;
a_next = 4;
[t_m,t_tangent,t_nr] = find_max_feasible_time(p_now,v_now,t_now,a_next,p_shadow,v_shadow,ts_window,a_shadow,a_comfort_dec,-1);



hFig=figure(5);clf; 
whitebg(hFig,'white');
edge =0.0;
hAx=axes('position',[edge  edge  1-2*edge  1-2*edge]);
set(gca,'Visible','off')
hold all
FontSize=11;
set(0,'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize',FontSize,'DefaultTextFontSize',FontSize,'DefaultTextInterpreter','Latex');
w = 220;
h =220;
set(hFig,'Position',[600,400,w,h]);
set(gcf, 'PaperUnits', 'centimeters');
saved_fig_size=[0 0 w/35 h/35];
set(gcf, 'PaperPosition', saved_fig_size);
x_min=t_minus-0.5;
x_max = t_now+0.5;
xlim([x_min, x_max]);


%plot shadow
ts_shadow = linspace(t_minus,t_plus,30);
ps_shadow = p_shadow + v_shadow *(ts_shadow-t_minus) + 0.5*a_shadow*(ts_shadow-t_minus).^2;
plot(ts_shadow,ps_shadow,'b','LineWidth',2)  
plot(ts_shadow(1),ps_shadow(1),'b+');
text(ts_shadow(1)-.35,ps_shadow(1)+2,'$t''^-$');
plot(ts_shadow(end),ps_shadow(end),'b+');
text(ts_shadow(end)-.2,ps_shadow(end)+4,'$t''^+$');
ts_shadow_ext = linspace(x_min,x_max,40);
ps_shadow_ext = p_shadow + v_shadow *(ts_shadow_ext-t_minus) + 0.5*a_shadow*(ts_shadow_ext-t_minus).^2;
plot(ts_shadow_ext,ps_shadow_ext,':k'); 

mid_scale=0.3;
t_mid = t_minus + mid_scale*(t_plus-t_minus);
p_mid = p_shadow+ v_shadow*(t_mid-t_minus)+0.5*a_shadow*(t_mid-t_minus)^2;
text(t_mid, p_mid+7,'$(l'',v'',a'',t''^-,t''^+)$','Rotation',55);
y_min = ps_shadow(1)-5;
y_max = p_now+10;
ylim([y_min,y_max]);

%plot the accelerating seg
plot(t_now, p_now,'+b')
ts_now = linspace(t_m,t_now,30);
ps_now = p_now + v_now *(ts_now-t_now) + 0.5*a_next*(ts_now-t_now).^2;
plot(ts_now,ps_now,'b','LineWidth',2)  
plot(ts_now(1), ps_now(1),'+b')
text(t_now-0.1, p_now+4,'$t^-$');

mid_scale=0.3;
t_mid = t_m + mid_scale*(t_now-t_m);
p_mid = p_now+ v_now*(t_mid-t_now)+0.5*a_next*(t_mid-t_now)^2;
text(t_mid, p_mid-4,'$(l,v,a^+,t^-,t^\texttt{m})$','Rotation',40);

%plot the decelerating seg
ts_dec = linspace(t_tangent,t_m,30);
p_m = ps_now(1);
text(t_m, p_m+3,'$t^\texttt{m}$');

v_m = v_now +a_next*(t_m-t_now);
ps_dec = p_m + v_m *(ts_dec -t_m) + 0.5*a_comfort_dec*(ts_dec -t_m).^2;
plot(ts_dec,ps_dec,'--b','LineWidth',2);
plot(ts_dec(1), ps_dec(1),'+b')
text(ts_dec(1)-.2, ps_dec(1)+3,'$t^+$');
mid_scale=0.95;
t_mid = t_m + mid_scale*(t_tangent-t_m);
p_mid = p_m+ v_m*(t_mid-t_m)+0.5*a_comfort_dec*(t_mid-t_m)^2;
text(t_mid, p_mid-5,'$(l^\texttt{m},v^\texttt{m},a^-,t^\texttt{m},t^+)$','Rotation',35);

folder_fig = '../Figure/';
saveas(gcf,[folder_fig,'backward_shooting.eps'],'eps2c');







