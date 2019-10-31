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
if dmY <= 0.01 && dmY >= -0.01
    dmY = 0;
end
dmX = dm_angle(3);

% evaluate ZY in reverse priority

tan_rpZ = sin(dmZ) / tan(dmY);
sin_rpY = cos(dmZ) * cos(dmY);

rpZ = atan(tan_rpZ);
rpY = asin(sin_rpY);

% evaluate X
if cos(rpY) ~= 0
    sin_rpX = ((sin(dmZ) * cos(dmX)) - (cos(dmZ) * sin(dmX) * sin(dmY))) /...
              (cos(rpY));
    if sin_rpX <= 1 && sin_rpX >= -1
        rpX = asin(sin_rpX);
    else
        tan_rpX = ((sin(dmZ) * cos(dmX)) - (cos(dmZ) * sin(dmX) * sin(dmY))) /...
              ((sin(dmX) * sin(dmZ)) + (sin(dmY) * cos(dmX) * cos(dmZ)));
        rpX = atan(tan_rpX);
    end
else
    tan_rpX = ((sin(dmZ) * cos(dmX)) - (cos(dmZ) * sin(dmX) * sin(dmY))) /...
              ((sin(dmX) * sin(dmZ)) + (sin(dmY) * cos(dmX) * cos(dmZ)));
    rpX = atan(tan_rpX);
end

% set up the output
rp_angle = [rpZ; rpY; rpX];

end
