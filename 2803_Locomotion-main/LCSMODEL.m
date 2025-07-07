function [v_mod, beta] = LCSMODEL(r,d,l,theta,w)
%VELOCITY This function intakes the parameters and outputs a velocity
%vector for the b slider
%r in m
%d in m
%l in m 
%theta in rad
%w in rad/s
beta = asin ( (d - r * sin(theta)) / (l));
v_mod = -w.*r.* ( sin (theta) + tan ( asin ( (d - r.*sin(theta) ) / (l) ) .* cos (theta) ));
end