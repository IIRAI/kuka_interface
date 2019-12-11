function [qr]=optimize_one_arm_vel(q_R,scale)
import casadi.*
sz_R = max(size(q_R));
kuka_jdmax = 0.95*[2.3, 2.3, 3.07, 3.07, 4.75, 4.22, 4.22];
qdd_bound = 25;

if nargin==2
    if scale < 1
        scale = 1;
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

q_full = [q_R];
q = (q_full(:,2:end)+q_full(:,1:end-1))/2;
for i=1:size(q,1)
qp(i,:) = gradient(q(i,:),sm);
qpp(i,:) = gradient(qp(i,:),sm);
end

b_bound = [];
for i=1:size(q_full,1)
qps(i,:) = gradient(q_full(i,:),s);
end

 vel_max = [3;3;3]/20;
for i=1:size(qps,2)
    vel = Jee_TWO_ARMS_r_pos_function(q_full(:,i))*qps(:,i);
    b_bound(i) = min([(kuka_jdmax.^2).'./qps(:,i).^2;vel_max.^2./vel.^2]);
end

opti = casadi.Opti();

b = opti.variable((size(s,2)));

acc = opti.variable(7, size(sm,2));
dacc = opti.variable(7, size(sm,2)-1);

f = 0;
f = 2*ds(1)/(b(1)^(0.5)+b(2)^(0.5));
for i=2:size(b,1)-2
    f = f+2*ds(i)/((b(i))^(0.5)+b(i+1)^(0.5));
end
f = f+2*ds(end)/((b(end-1))^(0.5)+b(end)^(0.5));
opti.minimize( f  );

for i = 1:size(qp,2)
   opti.subject_to( qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2<=qdd_bound);
   opti.subject_to( qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2>=-qdd_bound);
   acc(:,i) = qp(:,i)*(b(i+1)-b(i))/(2*ds(i))+qpp(:,i)*(b(i)+b(i+1))/2;
end


dacc = (acc(:,2:end)-acc(:,1:end-1));
opti.subject_to(     -2<=dacc<=2 );
   opti.subject_to(     b_bound'>=b>=0 );
opti.set_initial(b, [ones(size(b))]);
opti.subject_to(       b(1) == 1e-4 );
opti.subject_to(       b(end) == 1e-4 );
opti.solver('ipopt');
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
end
qr = [qr q_R(:,end)];

end