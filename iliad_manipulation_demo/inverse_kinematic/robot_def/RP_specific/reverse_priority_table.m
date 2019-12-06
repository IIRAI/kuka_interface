function [q, qd, e] = reverse_priority_table(N, Ts, iter_num, J_and_T_hand, q_0, qd_0, x_des, unil_constr, x_cons, param_vect)
%{
===========================================================================
    Exactly as the general reverse_priority.m, but enhanced in performance.
    On the other hand, this can be used only when all the following tasks 
    are present:

    - all 7 joints limits constraints
    - position task
    - orientation task

    J_and_T_hand is a new input containing the function handles for J and
    T.
    For further informations, see reverse_priority.m
===========================================================================
%}
    % user message
    disp('Reverse priority algorithm w/ table constraint initialization');

    % initialization (i.e. k = 1)
    q(:,1)  = q_0;
    qd(:,1) = qd_0;

    % save in a local variable the table contraint since it can change during planning
    cons_table_x = x_cons(15);
    cons_table_z = x_cons(16);


    % ---------------------------------------------------------------------
    % specific part
    
    J{1}  = [ 0, 0, 0, 0, 0, 0, 1]; % ee max unilateral constraint
    J{2}  = [ 0, 0, 0, 0, 0, 0, 1]; % ee min unilateral constraint 
    J{3}  = [ 0, 0, 0, 0, 0, 1, 0]; % joint 7 max unilateral constraint
    J{4}  = [ 0, 0, 0, 0, 0, 1, 0]; % joint 7 min unilateral constraint 
    J{5}  = [ 0, 0, 0, 0, 1, 0, 0]; % joint 6 max unilateral constraint
    J{6}  = [ 0, 0, 0, 0, 1, 0, 0]; % joint 6 min unilateral constraint 
    J{7}  = [ 0, 0, 0, 1, 0, 0, 0]; % joint 5 max unilateral constraint
    J{8}  = [ 0, 0, 0, 1, 0, 0, 0]; % joint 5 min unilateral constraint 
    J{9}  = [ 0, 0, 1, 0, 0, 0, 0]; % joint 4 max unilateral constraint
    J{10} = [ 0, 0, 1, 0, 0, 0, 0]; % joint 4 min unilateral constraint 
    J{11} = [ 0, 1, 0, 0, 0, 0, 0]; % joint 3 max unilateral constraint
    J{12} = [ 0, 1, 0, 0, 0, 0, 0]; % joint 3 min unilateral constraint 
    J{13} = [ 1, 0, 0, 0, 0, 0, 0]; % joint 2 max unilateral constraint
    J{14} = [ 1, 0, 0, 0, 0, 0, 0]; % joint 2 min unilateral constraint   
        
    % (qdMAX) error init for variable gain 
    e = cell(N,1);
    e{17,1} = (x_des{17,1} - J_and_T_hand{3}(q_0)); 
    
    % ---------------------------------------------------------------------
   
    for k = 2 : iter_num
        % -----------------------------------------------------------------
        % specific part
            q1 = q(1, k-1);
            q2 = q(2, k-1);
            q3 = q(3, k-1);
            q4 = q(4, k-1);
            q5 = q(5, k-1);
            q6 = q(6, k-1);
            q7 = q(7, k-1);

            % numeric jacobian for table constraint, on z axis --> 3rd row
            Jee_table = J_and_T_hand{1}([q1, q2, q3, q4, q5, q6, q7]);
            J{15} = Jee_table(1,:);
            J{16} = Jee_table(3,:);
            % actual x for table constraint --> position on z axis
            Tee_table = J_and_T_hand{3}([q1, q2, q3, q4, q5, q6, q7]);
            x{15,k} = Tee_table(1,:);
            x{16,k} = Tee_table(3,:);

            % check the position of the ee in the x and z axis and activate 
            % or deactivate the table constraint accordingly
            if x{15,k} < cons_table_x  % x less than table, deactivate z constraint
                x_cons(16) = 0;
            else
                x_cons(16) = cons_table_z;
            end
            if x{16,k} > cons_table_z  % z more than table, deactivate x constraint
                x_cons(15) = 10000;
            else
                x_cons(15) = cons_table_x;
            end

            % numeric jacobian
            J{18} = J_and_T_hand{2}([q1, q2, q3, q4, q5, q6, q7]); 
            J{17} = J_and_T_hand{1}([q1, q2, q3, q4, q5, q6, q7]); 

            % actual x
            x{18,k} = J_and_T_hand{4}([q1, q2, q3, q4, q5, q6, q7]);
            x{17,k} = J_and_T_hand{3}([q1, q2, q3, q4, q5, q6, q7]); 

            x{1,k}  = q7;
            x{2,k}  = q7;
            x{3,k}  = q6;
            x{4,k}  = q6;
            x{5,k}  = q5;
            x{6,k}  = q5;
            x{7,k}  = q4;
            x{8,k}  = q4;
            x{9,k}  = q3;
            x{10,k} = q3;
            x{11,k} = q2;
            x{12,k} = q2;
            x{13,k} = q1;
            x{14,k} = q1;
            
        % -----------------------------------------------------------------
        
        x_cur = x(:,k);                     % x: cell array 
        
        x_des_cur = x_des(:,k);
        x_des_prev = x_des(:,k-1); 
        
        qd_prev = qd(:,k-1);
              
        if k <= length(x_cons(:,1))
            x_cons_cur = x_cons(k,:);       % select the k-th step row
        else
            x_cons_cur = x_cons(end,:);     % works also for time-invariant
        end
        
        % compute tasks desired vel (for trajectory tracking)
        for p = N:-1:1
            
            % if x_des is a matrix (R), xd_des_cur will be an ang. vel. w:
             if size(x_des_cur{p}) == [3,3]      % it's a matrix (R)
                if x_des_cur{p} == zeros(3)     % const R
                    xd_des_cur{p} = [0; 0; 0];  % angular velocity is 0
                else 
                    xd_des_cur{p} = (x_des_cur{p} - x_des_prev{p}) / Ts;    % Rdot
                    w_ee_hat = xd_des_cur{p} * x_des_prev{p}.';             % Rdot * R.'
                    w_ee = skew_2_vect(w_ee_hat);
                    xd_des_cur{p} = w_ee;
                end
            % all the other cases    
            else
                xd_des_cur{p} = (x_des_cur{p} - x_des_prev{p}) / Ts;
            end
        end
        
        % -----------------------------------------------------------------
        % specific part
        
            % (qdMAX) scale gain by position error
            param_vect2 = param_vect;
            if norm(e{17,k-1},2) < 0.01
                param_vect2(6:6+N-1) = 10 * param_vect(6:6+N-1);
            end
            
        % -----------------------------------------------------------------
        
        % user message
%         disp('... starting computation');
        tic

        [qd_new, e_new] = reverse_priority_step(N, qd_prev, x_des_prev, ...
                                                xd_des_cur, unil_constr, ...
                                                x_cons_cur, param_vect2, ...
                                                J, x_cur);
        
        toc
        % user message
%         disp('... done');
        
        % append to vectors
        qd = [qd, qd_new];
        e  = [e, e_new];
        
        % append new q, given by integration
        q = [q, q(:,k-1) + qd_new*Ts];
        
    end
    
    % user message    
    disp('Reverse priority algorithm complete');
    
end