function rp_angle = dm2rp_hand(dm_angle)
%DM2RP_HAND convert the angle ZYX from the Dual Manipulation to the Reverse Priority reference system.
%   INPUT:
%       -`dm_angle`: vector 3x1 with angle ZYX with respect Dual Manipulation
%                    reference system.
%   OUTPUT:
%       -`rp_angle`: vector 3x1 with angle ZYX with respect Reverse Priority
%                    reference system.

% ZYX angle in dual manipulation
dmZ = dm_angle(1);
dmY = dm_angle(2);
dmX = dm_angle(3);

% evaluate ZY in reverse priority
tan_rpZ = sin(dmZ) / tan(dmY);
sin_rpY = - cos(dmZ) * cos(dmY);

rpZ = atan(tan_rpZ);
rpY = asin(sin_rpY);

% evaluate X
cos_rpX = ((sin(dmZ) * sin(dmX)) + (cos(dmZ) * cos(dmX) * sin(dmY))) / cos(rpY);

rpX = acos(cos_rpX);

% set up the output
rp_angle = [rpZ; rpY; rpX];

end
