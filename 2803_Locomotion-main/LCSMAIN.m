clc
clear
close all


filename = "Test1_5pt5V";
data = readmatrix(strcat ("./Data/",filename)); %Import file

r = 0.0775 ; %m 7.75cm
d = 0.1525 ; %m 15.25
l = 0.255 ; %m 25.5cm

% Experimental data vs model plots
figure(100)
tl1 = tiledlayout(3,2);
for i = 5:10
    filename = strcat("Test1_",num2str(i),"pt5V");
    [theta_exp,w_exp,v_exp,time] = LCSDATA(filename);
    w = w_exp*(pi/180);
    theta = theta_exp*(pi/180);
    [v_mod, ~] = LCSMODEL(r,d,l,theta,w) ; %output is in m/s
    v_mod = v_mod*1000 ; %change to mm/s
    nexttile
    hold on
    theta = theta * 180/pi; %convert to deg
    plot(theta_exp,v_exp);
    plot(theta,v_mod);
    title(strcat(num2str(i),".5V"));
    xlabel("theta (deg)")
    ylabel("v_b (mm/s)")
    ylim([-2200,2200])
    xlim([0,6*360])
    legend("Experimental","Model")
    hold off
end
title(tl1,"v_b vs \theta")
subtitle(tl1,"experimenal & model comparison")
%Plotting Residuals
residuals();
%Plotting 6.5V Signed and absolute residual vs time
figure(200);
    filename = strcat("Test1_6pt5V");
    [theta_exp,w_exp,v_exp,time] = LCSDATA(filename);
    w = w_exp*(pi/180);
    theta = theta_exp*(pi/180);
    [v_mod, ~] = LCSMODEL(r,d,l,theta,w); %output is in m/s
    v_mod = v_mod*1000; %change to mm/s
    hold on
    theta = theta * 180/pi; %convert to deg
    abs_res = abs(v_exp-v_mod);
    residual = (v_exp - v_mod);
    plot(time,residual);
    hold on;
    plot(time,abs_res);
    title("Residual & Absolute Residual vs Time")
    legend("Residual","Absolute Residual");
    xlabel("Time (s)")
    ylabel("Residual (m/s)")