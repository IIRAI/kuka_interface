function [qr,ql]=optimize(q_R,q_L,scale)
import casadi.*
sz_R = max(size(q_R));
sz_L = max(size(q_L));
if(sz_R>sz_L)
    q_L = [q_L, repmat(q_L(:,end),[1,sz_R-sz_L])];
else
        q_R = [q_R, repmat(q_R(:,end),[1,sz_L-sz_R])];
end
kuka_jdmax = 0.95*[2.3, 2.3, 3.07, 3.07, 4.75, 4.22, 4.22, 2.3, 2.3, 3.07, 3.07, 4.75, 4.22, 4.22];   % official
qdd_bound = 25;
qdd_bound1 = 1;
if(nargin==3)
    if(scale==0)
        scale =1;
    end
kuka_jdmax = kuka_jdmax./scale;
qdd_bound = qdd_bound/scale;
end
s = 0:1/(size(q_R,2)-1):1;
sm = (s(2:end)+s(1:end-1))/2;


ds = s(2:end)-s(1:end-1);
% a = sdpvar((size(sm,2)),1,'full');
% b = sdpvar((size(s,2)),1,'full');
% x = [b;a];

q_full = [q_R;q_L];
q = (q_full(:,2:end)+q_full(:,1:end-1))/2;
for i=1:size(q,1)
qp(i,:) = gradient(q(i,:),sm);
qpp(i,:) = gradient(qp(i,:),sm);
end

b_bound = [];
for i=1:size(q_full,1)
qps(i,:) = gradient(q_full(i,:),s);
end
for i=1:size(qps,2)
    b_bound(i) = min((kuka_jdmax.^2).'./qps(:,i).^2);
end

opti = casadi.Opti();

b = opti.variable((size(s,2)));

acc = opti.variable(14, size(sm,2));
dacc = opti.variable(14, size(sm,2)-1);

f = 0;
f = 2*ds(1)/(b(1)^(0.5)+b(2)^(0.5));
for i=2:size(b,1)-2
    f = f+2*ds(i)/((b(i))^(0.5)+b(i+1)^(0.5));
end
f = f+2*ds(end)/((b(end-1))^(0.5)+b(end)^(0.5));
opti.minimize( f  )
i = 1;
   opti.subject_to( qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2<=qdd_bound1);
   opti.subject_to( qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2>=-qdd_bound1);

for i = 2:size(qp,2)-1
   opti.subject_to( qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2<=qdd_bound);
   opti.subject_to( qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2>=-qdd_bound);
   acc(:,i) = qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2;
end
i = size(qp,2);
   opti.subject_to( qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2<=qdd_bound1);
   opti.subject_to( qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2>=-qdd_bound1);
   acc(:,i) = qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2;

dacc = (acc(:,2:end)-acc(:,1:end-1));
opti.subject_to(     -1.5<=dacc<=1.5 );
   opti.subject_to(     b_bound'>=b>=0 );
opti.set_initial(b, [ones(size(b))])
opti.subject_to(       b(1) == 1e-4 )
opti.subject_to(       b(end) == 1e-4 )
opti.solver('ipopt')
p_opts = struct('expand',true);
s_opts = struct('max_iter',10000);
opti.solver('ipopt',p_opts,s_opts);



sol = opti.solve();

% sol = optimize(Constraints,Objective,ops);

%%
bk = sol.value(b);
t = 0;
t = cumsum(2*ds.'./(sqrt(bk(2:end))+sqrt(bk(1:end-1))));

t_tot = [0 t.'];
for i = 1:7
qr(i,:) = interp1(t_tot,q_R(i,:),0:0.1:t_tot(end),'linear');
ql(i,:) = interp1(t_tot,q_L(i,:),0:0.1:t_tot(end),'linear');
end
qr = [qr q_R(:,end)];

ql = [ql q_L(:,end)];

end