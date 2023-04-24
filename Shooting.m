%% forward shooting
%clear all;

p_shadow = 20;
v_shadow =10;

t_minus = 1;
t_plus = 4.5;
ts_window = [t_minus, t_plus];
a_shadow =1;
a_comfort_dec=-5;

p_now = p_shadow-40;
v_now = 15;
t_now = t_minus -1;
a_next = 4;
[t_m,t_tangent,t_nr] = find_max_feasible_time(p_now,v_now,t_now,a_next,p_shadow,v_shadow,ts_window,a_shadow,a_comfort_dec);



hFig=figure(4);clf; 
whitebg(hFig,'white');
edge =0.0;
hAx=axes('position',[edge  edge  1-2*edge  1-2*edge]);
set(gca,'Visible','off')
hold all
FontSize=11;
set(0,'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize',FontSize,'DefaultTextFontSize',FontSize,'DefaultTextInterpreter','Latex');
w = 220;
h =220;
set(hFig,'Position',[400,400,w,h]);
set(gcf, 'PaperUnits', 'centimeters');
saved_fig_size=[0 0 w/35 h/35];
set(gcf, 'PaperPosition', saved_fig_size);
x_min=t_now-0.5;
x_max = t_plus+0.5;
xlim([x_min, x_max]);


%plot shadow
ts_shadow = linspace(t_minus,t_plus,30);
ps_shadow = p_shadow + v_shadow *(ts_shadow-t_minus) + 0.5*a_shadow*(ts_shadow-t_minus).^2;
plot(ts_shadow,ps_shadow,'b','LineWidth',2)  
plot(ts_shadow(1),ps_shadow(1),'b+');
plot(ts_shadow(end),ps_shadow(end),'b+');
ts_shadow_ext = linspace(x_min,x_max,40);
ps_shadow_ext = p_shadow + v_shadow *(ts_shadow_ext-t_minus) + 0.5*a_shadow*(ts_shadow_ext-t_minus).^2;
plot(ts_shadow_ext,ps_shadow_ext,':k'); 

mid_scale=0.2;
t_mid = t_minus + mid_scale*(t_plus-t_minus);
p_mid = p_shadow+ v_shadow*(t_mid-t_minus)+0.5*a_shadow*(t_mid-t_minus)^2;
text(t_mid, p_mid+7,'$(p'',v'',a'',t''^-,t''^+)$','Rotation',35);
y_min = p_now-10;
y_max = ps_shadow(end)+5;
ylim([y_min,y_max]);

%plot the accelerating seg
plot(t_now, p_now,'+b')
ts_now = linspace(t_now,t_m,30);
ps_now = p_now + v_now *(ts_now-t_now) + 0.5*a_next*(ts_now-t_now).^2;
plot(ts_now,ps_now,'b','LineWidth',2)  
plot(ts_now(end), ps_now(end),'+b')
text(t_now, p_now-4,'$t^-$');

mid_scale=0.1;
t_mid = t_now + mid_scale*(t_now-t_now);
p_mid = p_now+ v_now*(t_mid-t_now)+0.5*a_next*(t_mid-t_now)^2;
text(t_mid, p_mid+7,'$(p,v,a^+,t^-,t^\texttt{m})$','Rotation',50);

%plot the decelerating seg
ts_dec = linspace(t_m,t_tangent,30);
p_m = ps_now(end);
text(t_m-0.1, p_m+7,'$t^\texttt{m}$');

v_m = v_now +a_next*(t_m-t_now);
ps_dec = p_m + v_m *(ts_dec -t_m) + 0.5*a_comfort_dec*(ts_dec -t_m).^2;
plot(ts_dec,ps_dec,'--b','LineWidth',2);
plot(ts_dec(end), ps_dec(end),'+b')
text(ts_dec(end)+0.2, ps_dec(end),'$t^+$');
mid_scale=0.05;
t_mid = t_m + mid_scale*(t_tangent-t_m);
p_mid = p_m+ v_m*(t_mid-t_m)+0.5*a_comfort_dec*(t_mid-t_m)^2;
text(t_mid, p_mid-7,'$(p^\texttt{m},v^\texttt{m},a^-,t^\texttt{m},t^+)$','Rotation',45);

folder_fig = '../Figure/';
%saveas(gcf,[folder_fig,'forward_shooting.eps'],'eps2c');




%     [t_reverse_max, t_reverse_tangent] = find_max_feasible_time(p_reverse_now,v_reverse_now,t_reverse_now,...
%                             a_reverse_next,p_reverse_shadow,v_reverse_shadow,ts_reverse_window,a_reverse_shadow,a_reverse_comfort_dec,-1);
%     figure(14); 
%     clf;
%     hold all;
%     t_reverse_low =  min(ts_reverse_window(1),t_reverse_now);
%     if t_tangent<inf
%         t_high = max(ts_window(2), t_tangent);
%     else
%         t_high = ts_window(2);
%     end
% 
%     Plot_Segment(p_reverse_shadow, v_reverse_shadow,a_reverse_shadow,[ts_reverse_window(1),ts_reverse_window(2)],5000,0,ts_reverse_window(1),0);
%     Plot_Segment(p_reverse_now , v_reverse_now,a_reverse_next,[t_reverse_next,t_reverse_now],5000,0,t_reverse_now,0);
%     
%      if t_reverse_max < inf 
%         v_reverse_r = v_reverse_now + a_reverse_next *(t_reverse_max-t_reverse_now);
%         p_reverse_r = p_reverse_now + v_reverse_now*(t_reverse_max-t_reverse_now)+0.5*a_reverse_next*(t_reverse_max-t_reverse_now)^2;
%         Plot_Segment(p_reverse_r , v_reverse_r, a_reverse_comfort_dec,[t_reverse_tangent,t_reverse_max],5000,0,t_reverse_max,0);
%         p_reverse_inter = p_reverse_r + v_reverse_r*(t_reverse_tangent-t_reverse_max)+0.5*a_reverse_comfort_dec*(t_reverse_tangent-t_reverse_max)^2;
%         plot(t_reverse_tangent,p_reverse_inter,'r*')
%         plot(t_reverse_max,p_reverse_r,'b*')
%      end
%      p_reverse_shadow2 = p_reverse_shadow + v_reverse_shadow*(ts_reverse_window(2)-ts_reverse_window(1)) + 0.5*a_reverse_shadow*(ts_reverse_window(2)-ts_reverse_window(1))^2;
%      plot([ts_reverse_window(1),ts_reverse_window(1)],[-max(p_reverse_shadow2,p_reverse_shadow),max(p_reverse_shadow2,p_reverse_shadow)],'k:')
%      plot([ts_reverse_window(2),ts_reverse_window(2)],[-max(p_reverse_shadow2,p_reverse_shadow),max(p_reverse_shadow2,p_reverse_shadow)],'k:')





