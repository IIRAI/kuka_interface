function rp_angle = dm2rp_velvet(dm_angle)
%DM2RP_VELVET convert the angle ZYX from the Dual Manipulation to the Reverse Priority reference system.
%   INPUT:
%       -`dm_angle`: vector 3x1 with angle ZYX with respect Dual Manipulation
%                    reference system.
%   OUTPUT:
%       -`rp_angle`: vector 3x1 with angle ZYX with respect Reverse Priority
%                    reference system.

% ZYX angle in dual manipulation
dmZ = dm_angle(1);
dmY = dm_angle(2);
if dmY <= 0.01 && dmY >= -0.01
    dmY = 0;
end
dmX = dm_angle(3);

% evaluate ZX in reverse priority
tan_rpZ = sin(dmX) / tan(dmY);
sin_rpX = - cos(dmZ) * cos(dmY);

rpZ = atan(tan_rpZ);
rpX = asin(sin_rpX);

% evaluate Y
cos_rpY = ((sin(dmZ) * sin(dmX)) + (cos(dmZ) * cos(dmX) * sin(dmY))) / cos(rpX);

rpY = acos(cos_rpY);

% set up the output
rp_angle = [rpZ; rpY; rpX];

end

