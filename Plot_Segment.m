function h_vec = Plot_Segment(p_minus,v_minus,acc,tbs,seg_num,is_cross,t_now,nobackup,plot_shadow)
if nargin < 9
    plot_shadow=0;
    if nargin <8
        nobackup = 1;
        if nargin<7
            t_now = tbs(1);
            if nargin <6 
                 is_cross=1;
                 if nargin < 5
                     seg_num =20;
                 end
            end             
        end            
    end  
end

ts = linspace(tbs(1),tbs(2),seg_num);
ps = 0.5*acc* (ts - t_now).^2 + v_minus*(ts - t_now) + p_minus;
if nobackup
    for k = 2: length(ps)
        ps(k) = max(ps(k),ps(k-1));
    end
end
h_vec = plot(ts,ps,'-b');
if is_cross
  h1 = plot(ts(1),ps(1),'+k');
  h2 = plot(ts(end),ps(end),'+k');
  h_vec = [h_vec;h1;h2];
end

if plot_shadow
    global tau s;
    h3 = plot(ts+tau,ps-s,':g');
    h_vec = [h_vec;h3];
end

end
    