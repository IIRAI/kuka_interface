%{
===========================================================================
	This function computes the orientation error, for a robot task 
    execution, using axis-angle

---------------------------------------------------------------------------
INPUT
---------------------------------------------------------------------------

    -
    
---------------------------------------------------------------------------
OUTPUT
---------------------------------------------------------------------------

	eo              [3 x 1]             column with the orientation error

===========================================================================
%}

     R = x_des_cur{p} * transpose(x_cur{p}); 
     [n, th] = n_and_theta_from_R(R);
     e{p,1} = n * sin(th/2);