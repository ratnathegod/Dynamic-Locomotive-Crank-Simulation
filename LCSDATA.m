function [theta_exp,w_exp,v_exp,time] = LCSDATA(filename)
%Import Data
data = readmatrix(strcat ("./Data/",filename));

%Calibrate data
FF = islocalmin(data(:,3));
nonzero=find(FF);
factor = data(nonzero(2),2) - 152.5;
data(:,2) = data(:,2)-factor;

for i =1:length(data(:,2))-2
    if data(1,2) < 0
        data(1,:) = [];
    end
end
data(nonzero(7):end,:) = [];
% Find the end of the 6th rotation
for i = length(data(:,2)):-1:1
    %Value used for comparison
    if (data(end,2) >= (2160))
        data(end,:) = [];
    end
end
%Export data
time = data(:,1);
v_exp = data(:,5);
w_exp = data(:,4);
theta_exp = data(:,2);
end