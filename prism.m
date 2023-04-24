%clear all
FontSize=11;
t_int = 0.05;
v_max = 60*0.44704; % maximum velocity - m/s
a_max = 2; % maximum acceleration speed - m/s^2
a_min = -3; % maximum deceleration speed m/s^2

l_minus = 0;
v_minus = v_max/2;
t_minus = 0;

l_minus = 0;
v_minus = v_max/2;
t_minus = 0;

l_plus = 400;
v_plus = 2*v_max/3;
t_plus = 30;

hFig=figure(7);clf; 
whitebg(hFig,'white');
edge =0;
hAx=axes('position',[edge  edge  1-2*edge  1-2*edge]);
set(gca,'Visible','off')
hold all

set(0,'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize',FontSize,'DefaultTextFontSize',FontSize,'DefaultTextInterpreter','Latex');
w = 300;
h =300;
set(hFig,'Position',[650,100,w,h]);
set(gcf, 'PaperUnits', 'centimeters');
saved_fig_size=[0 0 w/35 h/35];
set(gcf, 'PaperPosition', saved_fig_size);

% tu1 = t_minus - v/a_max;
% tu2 = t_minus + (v_max -v)/a_max;
% td1 = t_minus - (v-v_max)/a_min;
% td2 = t_minus + (-v)/a_min;



X_fill =[];
Y_fill =[];
ts_c = cell(1,14);
ps_c = cell(1,14);


%% parameters
%%upperbound critical points
%stopped
tu0 = t_minus + (-v_minus)/a_max;
lu0 = l_minus + (-v_minus^2)/(2*a_max); 

%accelerating
tu1 = t_minus + (v_max-v_minus)/a_max;
lu1 = l_minus + (v_max^2-v_minus^2)/(2*a_max); 

%stopped
tu4 = t_plus - (v_plus)/a_max;
lu4 = l_plus + v_plus*(tu4-t_plus)+0.5*a_max*(tu4-t_plus)^2;
[tu_m,tu_t]  = find_max_feasible_time(lu1,v_max,tu1,0,lu4,0,[tu4,-inf],0,a_min);

% v_max cruise
tu2 = tu_m;
lu2 = lu1 +v_max*(tu2-tu1);

%deceleracing
tu3 = tu_t;
lu3 = l_plus-v_plus^2/(2*a_max);

% cruise at v_max finally
tu5 = tu4 + v_max/a_max; 
lu5 = lu4 + v_max^2/(2*a_max);

%%lower bound critical points
%cruise at v_max till t_0
tl0 = t_minus - (v_minus-v_max)/a_min;
ll0 = l_minus - (v_minus^2-v_max^2)/(2*a_min);

%decelrating till t_1
tl1 = t_minus + (-v_minus)/a_min;
ll1 = l_minus + (-v_minus^2)/(2*a_min); 

%backward acceleraging till t_4
tl4 = t_plus -(v_plus-v_max)/a_min;
ll4 = l_plus + v_plus*(tl4-t_plus)+0.5*a_min*(tl4-t_plus)^2;

% decelerating to 0 at t_5
tl5 = t_plus + (-v_plus)/a_min; 
ll5 = ll4 + v_max^2/(-2*a_min);

% t_2 and t_3 is obtained from backward shooting
%[tlm,tl_t]  = find_max_feasible_time(ll4,v_max,tl4,0,ll1,0,[tl1,inf],0,a_max,-1);
dt_acc = v_max/a_max;
p_acc = v_max^2/(2*a_max);
dt_back_shoot = (ll4-ll1-p_acc)/v_max;
tl3 = tl4 - dt_back_shoot;
ll3 = ll4 - v_max* dt_back_shoot;
tl2 = tl3 - dt_acc;
ll2 = ll1;

% adjust the view
width = (max(tu5,tl5)-min(tu0,tl0));
t_min = min(tu0,tl0) - 0.03*width;
t_max = max(tu5,tl5) + 0.03*width;
xlim([t_min, t_max]);

%% construct the segment
%segment 1
ts = linspace(t_min,tu0,(tu0-t_min)/t_int);
ps = lu0*ones(size(ts));
%plot(ts,ps,'b','Linewidth',1.5);
%plot(ts(end),ps(end),'b+');
%text(ts(end)-6.5,ps(end)+40,'$(p-\frac{v^{2}}{2\bar{a}},0,t^{-}-\frac{v}{\bar{a}})$','Rotation',0);
X_fill =[X_fill,ts ];
Y_fill =[Y_fill,ps ];
ts_c{1} = ts;
ps_c{1} = ps;

%segment 2
ts = linspace(tu0,tu1,(tu1-tu0)/t_int);
ps = l_minus+v_minus*(ts-t_minus)+ 0.5*a_max*(ts-t_minus).^2;
X_fill =[X_fill,ts ];
Y_fill =[Y_fill,ps ];
ts_c{2} = ts;
ps_c{2} = ps;

%segment 3
ts = linspace(tu1,tu2,(tu2-tu1)/t_int);
ps = lu1+(ts-tu1)*v_max;
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts ];
Y_fill =[Y_fill,ps ];
ts_c{3} = ts;
ps_c{3} = ps;

%segment 4
ts = linspace(tu2,tu3,(tu3-tu2)/t_int);
ps = lu2+(ts-tu2)*v_max+0.5*a_min*(ts-tu2).^2;
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{4} = ts;
ps_c{4} = ps;

%segment 5
ts = linspace(tu3,tu4,(tu4-tu3)/t_int);
ps = lu3*ones(size(ts));
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts ];
Y_fill =[Y_fill,ps ];
ts_c{5} = ts;
ps_c{5} = ps;

%segment 6
ts = linspace(tu4,tu5,(tu5-tu4)/t_int);
ps = lu4+0.5*a_max*(ts-tu4).^2;
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts ];
Y_fill =[Y_fill,ps ];
ts_c{6} = ts;
ps_c{6} = ps;

%segment 7
ts = linspace(tu5,t_max,(t_max-tu5)/t_int);
ps = lu5+(ts-tu5)*v_max;
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{7} = ts;
ps_c{7} = ps;

%% lower bound



%construct the segment backward
%segment 8 stopped
ts = linspace(t_max,tl5,(t_max-tu5)/t_int);
ps = ll5*ones(size(ts));
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{8} = ts;
ps_c{8} = ps;

%segment 9 backward accelerating
ts = linspace(tl5,tl4,(tl5-tl4)/t_int);
ps = ll5+0.5*a_min*(ts-tl5).^2;
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{9} = ts;
ps_c{9} = ps;

%segment 10 backward cruise at v_bar
ts = linspace(tl4,tl3,(tl4-tl3)/t_int);
ps = ll4 + v_max*(ts-tl4);
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{10} = ts;
ps_c{10} = ps;

%segment 11 backward decelerating to 0
ts = linspace(tl3,tl2,(tl3-tl2)/t_int);
ps = ll3 + v_max*(ts-tl3)+0.5*a_max*(ts-tl3).^2;
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{11} = ts;
ps_c{11} = ps;

%segment 12 stopped
ts = linspace(tl2,tl1,(tl2-tl1)/t_int);
ps = ll2 *ones(size(ts));
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{12} = ts;
ps_c{12} = ps;

%segment 13 backward deceleration
ts = linspace(tl1,tl0,(tl1-tl0)/t_int);
ps = ll1 +0.5*a_min*(ts-tl1).^2;
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{13} = ts;
ps_c{13} = ps;

%segment 14 backward cruise at v_max
ts = linspace(tl0,t_min,(tl0 - t_min)/t_int);
ps = ll0 +v_max*(ts-tl0);
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts];
Y_fill =[Y_fill,ps];
ts_c{14} = ts;
ps_c{14} = ps;



%fill the cone;
color=[0.8,0.8,0.8];
fill(X_fill,Y_fill,color,'EdgeColor',color);

% plot the edges
is_crit=[3,4,10,11];

for i = 1: length(ts_c)
    ts = ts_c{i};
    ps = ps_c{i};
    plot(ts,ps,'b','Linewidth',1.5);
    %plot(ts(end),ps(end),'b+');
    if max(i==is_crit);
        plot(ts(end),ps(end),'b+');
    end
end

% add the text and markers
plot(t_minus,l_minus,'r+');
text(t_minus-5,l_minus,'$(l^-,v^-,t^-)$','Rotation',40);
plot(t_plus,l_plus,'r+');
text(t_plus-6,l_plus-20,'$(l^+,v^+,t^+)$','Rotation',40);

text(tu2-2,lu2+10,'$\bar{t}^\texttt{m}$');
text(tu3-1,lu3+25,'$\bar{t}^+$');
text(tu2+0.3,lu2+90,'$\bar{p}^{l^+v^+t^+}_{l^-v^-t^-}$','Rotation',40);

text(tl2-.5,ll2-30,'$\underline{t}^\texttt{m}$');
text(tl3+1,ll3-5,'$\underline{t}^+$');
text(tl2+8,ll2+15,'$\underline{p}^{l^+v^+t^+}_{l^-v^-t^-}$','Rotation',40);

%plot the input state point
%plot(t_minus,l_minus,'r+');
%text(t_minus-2.5,l_minus+20,'$(p,v,t^-)$','Rotation',20);


folder_fig = '../Figure/';
saveas(gcf,[folder_fig,'prism.eps'],'eps2c');


