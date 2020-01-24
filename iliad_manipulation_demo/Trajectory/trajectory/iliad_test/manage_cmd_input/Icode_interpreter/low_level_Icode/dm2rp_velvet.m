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
dmX = dm_angle(3);

% evaluate ZY in reverse priority

sin_rpY = -(cos(dmZ) * sin(dmX) * sin(dmY)) + (cos(dmX) * sin(dmZ));

yX = - (cos(dmY) * cos(dmZ));
xX = ((cos(dmZ) * cos(dmX) * sin(dmY)) + (sin(dmX) * sin(dmZ)));

yZ = sin(dmX) * cos(dmY);
xZ = (sin(dmZ) * sin(dmX) * sin(dmY)) + (cos(dmX) * cos(dmZ));

rpY = asin(sin_rpY);
rpX = atan2(yX, xX);
rpZ = atan2(yZ, xZ);

% fix a limit for the x rotation
if rpX < -0.90  % limite poco più di 120° 
    rpX = -0.90;
end

% limit rpZ in [0, 2*pi)
rpZ = rpZ - pi;  % manual fix from dm to pr transformation
while rpZ >= 2 * 3.14
    rpZ = rpZ - (2 * 3.14);
end
while rpZ <= - 2 * 3.14
    rpZ = rpZ + (2 * 3.14);
end


% set up the output
rp_angle = [rpZ; rpY; rpX];

end
