v_max = 60*0.44704; % maximum velocity - m/s
a_max = 2; % maximum acceleration speed - m/s^2
a_min = -3; % maximum deceleration speed m/s^2

p = 10;
v = v_max/2;
t_minus = 0;

hFig=figure(6);clf; 
whitebg(hFig,'white');
edge =0.0;
hAx=axes('position',[edge  edge  1-2*edge  1-2*edge]);
set(gca,'Visible','off')
hold all
FontSize=11;
set(0,'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize',FontSize,'DefaultTextFontSize',FontSize,'DefaultTextInterpreter','Latex');
w = 300;
h =300;
set(hFig,'Position',[650,400,w,h]);
set(gcf, 'PaperUnits', 'centimeters');
saved_fig_size=[0 0 w/35 h/35];
set(gcf, 'PaperPosition', saved_fig_size);

tu1 = t_minus - v/a_max;
tu2 = t_minus + (v_max -v)/a_max;
td1 = t_minus - (v-v_max)/a_min;
td2 = t_minus + (-v)/a_min;
t_min=min(tu1,td1)*2;
t_max =max(tu2,td2)*2;
xlim([t_min, t_max]);

t_int = 0.05;
X_fill =[];
Y_fill =[];
ts_c = cell(1,6);
ps_c = cell(1,6);
%plot upper bound
ts = linspace(t_min,tu1,(tu1-t_min)/t_int);
ps = (p-v^2/(2*a_max))*ones(size(ts));
%plot(ts,ps,'b','Linewidth',1.5);
%plot(ts(end),ps(end),'b+');
text(ts(end)-6.5,ps(end)+40,'$(l-\frac{v^{2}}{2\bar{a}},0,t^{-}-\frac{v}{\bar{a}})$','Rotation',0);
X_fill =[X_fill,ts ];
Y_fill =[Y_fill,ps ];
ts_c{1} = ts;
ps_c{1} = ps;


ts = linspace(tu1,tu2,(tu2-tu1)/t_int);
ps = p+v*(ts-t_minus)+0.5*a_max*(ts-t_minus).^2;
%plot(ts,ps,'b','Linewidth',1.5);
%plot(ts(end),ps(end),'b+');
text(ts(end)-4,ps(end)-40,'$(l+\frac{\bar{v}^{2}-v^{2}}{2\bar{a}},\bar{v},t^{-}+\frac{\bar{v}-v}{\bar{a}})$','Rotation',40);
X_fill =[X_fill,ts ];
Y_fill =[Y_fill,ps ];
ts_c{2} = ts;
ps_c{2} = ps;


ts = linspace(tu2,t_max,(t_max-tu2)/t_int);
ps = p+v_max*(ts-t_minus)-(v_max-v)^2/(2*a_max);
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts ];
Y_fill =[Y_fill,ps ];
ts_c{3} = ts;
ps_c{3} = ps;

%plot lower bound
ts = linspace(td2,t_max,(t_max-td2)/t_int);
ps = (p-v^2/(2*a_min))*ones(size(ts));
%plot(ts,ps,'b','Linewidth',1.5);
X_fill =[X_fill,ts(end:-1:1) ];
Y_fill =[Y_fill,ps(end:-1:1)];
ts_c{6} = ts;
ps_c{6} = ps;

ts = linspace(td1,td2,(td2-td1)/t_int);
ps = p+v*(ts-t_minus)+0.5*a_min*(ts-t_minus).^2;
%plot(ts,ps,'b','Linewidth',1.5);
%plot(ts(end),ps(end),'b+');
text(ts(end)-2,ps(end)-40,'$(l-\frac{v^{2}}{2\underline{a}},0,t^{-}-\frac{v}{\underline{a}})$','Rotation',0);
X_fill =[X_fill,ts(end:-1:1) ];
Y_fill =[Y_fill,ps(end:-1:1)];
ts_c{5} = ts;
ps_c{5} = ps;


ts = linspace(t_min,td1,(td1-t_min)/t_int);
ps = p + v_max*(ts-t_minus)-(v_max-v)^2/(2*a_min);
%plot(ts,ps,'b','Linewidth',1.5);
%plot(ts(end),ps(end),'b+');
text(ts(end)-6,ps(end)-200,'$(l-\frac{v^{2}-\bar{v}^2}{2\underline{a}},\bar{v},t^{-}-\frac{v-\bar{v}}{\underline{a}})$','Rotation',40);
X_fill =[X_fill,ts(end:-1:1) ];
Y_fill =[Y_fill,ps(end:-1:1)];
ts_c{4} = ts;
ps_c{4} = ps;

%fill the cone;
color=[0.8,0.8,0.8];
fill(X_fill,Y_fill,color,'EdgeColor',color);

% plot the edges
for i = 1: length(ts_c)
    ts = ts_c{i};
    ps = ps_c{i};
    plot(ts,ps,'b','Linewidth',1.5);
    if mod(i,3)
        plot(ts(end),ps(end),'b+');
    end
end

%plot the input state point
plot(t_minus,p,'r+');
text(t_minus-2.5,p+20,'$(l,v,t^-)$','Rotation',20);


folder_fig = '../Figure/';
%saveas(gcf,[folder_fig,'cone.eps'],'eps2c');


