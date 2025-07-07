function [meanError, stdError, cleanedMeanError, cleanedStdError] = residuals()
%model only does v
%calculate residuals for v between LCSDATA and LCSMODEL
%LCSData is the experimemtal, LCSModel is model data

%outliers are anything above 3 std deviations

 % Call LCSData function to get experimental velocity
figure(101);
tl2 = tiledlayout(3,2);
for i = 5:10
filename = strcat("Test1_",num2str(i),"pt5V");
nexttile
[theta_exp, w_exp, v_exp, time] = LCSDATA(filename);

r = 0.0775 ; %m 7.75cm
d = 0.1525 ; %m 15.25
l = 0.255 ; %m 25.5cm
w = w_exp*(pi/180);
theta = theta_exp*(pi/180);

%call LCSMODEL
[v_mod, ~] = LCSMODEL(r,d,l,theta,w) ; %output is in m/s
v_mod = (v_mod'*1000)' ; %change to mm/s

% Calculate residuals
Residuals = v_exp - v_mod;

% Plot residuals vs. time
    plot(time, Residuals);
    hold on;
    title(strcat(num2str(i),".5V"));
    xlabel('Time (s)');
    ylabel('Residual (m/s)');
    grid on;

 % Calculate initial statistics
    meanError = mean(Residuals);
    stdError = std(Residuals);
 % Add Mean Error Line
    yline(meanError);
    hold off;

    % Identify outliers using modified Z-score method
    medianResidual = median(Residuals);
    madValue = median(abs(Residuals - medianResidual));
    
    % Avoid division by zero
    if madValue == 0
        modifiedZScores = zeros(size(Residuals));
    else
        modifiedZScores = 0.6745 * (Residuals - medianResidual) / madValue;
    end
    
    % Remove outliers
    outlierMask = abs(modifiedZScores) > 3;
    cleanedResiduals = Residuals(~outlierMask);
    
    % Calculate cleaned statistics
    cleanedMeanError = mean(cleanedResiduals);
    cleanedStdError = std(cleanedResiduals);
    
    % Create a table with results
    T = table(...
        [meanError; cleanedMeanError], ...
        [stdError; cleanedStdError], ...
        'VariableNames', {'Mean', 'StandardDeviation'}, ...
        'RowNames', {'With Outliers', 'Without Outliers'});
    
    % Display results with proper significant figures
    disp('Residual Analysis Results:');
    disp('==========================');
    disp(['Mean with outliers: ', num2str(meanError, '%.6g')]);
    disp(['Std with outliers: ', num2str(stdError, '%.6g')]);
    fprintf('\n');
    disp(['Mean without outliers: ', num2str(cleanedMeanError, '%.6g')]);
    disp(['Std without outliers: ', num2str(cleanedStdError, '%.6g')]);
    
    % Also display formatted table
    disp('==========================');
    disp(T);

end
title(tl2, "Signed Residual")

%Absolute Residual Plotting
figure(102);
tl3 = tiledlayout(3,2);
for i = 5:10
filename = strcat("Test1_",num2str(i),"pt5V");
nexttile
[theta_exp, w_exp, v_exp, time] = LCSDATA(filename);

r = 0.0775 ; %m 7.75cm
d = 0.1525 ; %m 15.25
l = 0.255 ; %m 25.5cm
w=w_exp*(pi/180);
theta=theta_exp*(pi/180);

%call LCSMODEL
[v_mod, ~] = LCSMODEL(r,d,l,theta,w) ; %output is in m/s
v_mod = (v_mod'*1000)' ; %change to mm/s

% Calculate residuals
Residuals = abs(v_exp - v_mod);

% Plot residuals vs. time
    plot(time, Residuals);
    hold on
    title(strcat(num2str(i),".5V"));
    xlabel('Time (s)');
    ylabel('Residual (m/s)');
    grid on;

 % Calculate initial statistics
    meanError = mean(Residuals);
    stdError = std(Residuals);
    yline(meanError);
    hold off;
    % Identify outliers using modified Z-score method
    medianResidual = median(Residuals);
    madValue = median(abs(Residuals - medianResidual));
    
    % Avoid division by zero
    if madValue == 0
        modifiedZScores = zeros(size(Residuals));
    else
        modifiedZScores = 0.6745 * (Residuals - medianResidual) / madValue;
    end
    
    % Remove outliers
    outlierMask = abs(modifiedZScores) > 3;
    cleanedResiduals = Residuals(~outlierMask);
    
    % Calculate cleaned statistics
    cleanedMeanError = mean(cleanedResiduals);
    cleanedStdError = std(cleanedResiduals);
    
    % Create a table with results
    T = table(...
        [meanError; cleanedMeanError], ...
        [stdError; cleanedStdError], ...
        'VariableNames', {'Mean', 'StandardDeviation'}, ...
        'RowNames', {'With Outliers', 'Without Outliers'});
    
    % Display results with proper significant figures
    disp('Residual Analysis Results:');
    disp('==========================');
    disp(['Mean with outliers: ', num2str(meanError, '%.6g')]);
    disp(['Std with outliers: ', num2str(stdError, '%.6g')]);
    fprintf('\n');
    disp(['Mean without outliers: ', num2str(cleanedMeanError, '%.6g')]);
    disp(['Std without outliers: ', num2str(cleanedStdError, '%.6g')]);
    
    % Also display formatted table
    disp('==========================');
    disp(T);

end
title(tl3, "Unsigned Residual")


% Signed residuals vs time all on one plot
figure(110);
hold on;
for i = 5:10
filename = strcat("Test1_",num2str(i),"pt5V");

[theta_exp, w_exp, v_exp, time] = LCSDATA(filename);

r = 0.0775 ; %m 7.75cm
d = 0.1525 ; %m 15.25
l = 0.255 ; %m 25.5cm
w = w_exp*(pi/180);
theta = theta_exp*(pi/180);

%call LCSMODEL
[v_mod, ~] = LCSMODEL(r,d,l,theta,w) ; %output is in m/s
v_mod = (v_mod'*1000)' ; %change to mm/s

% Calculate residuals
Residuals = v_exp - v_mod;

% Plot residuals vs. time
    plot(time, Residuals,'LineWidth',1);

end
    legend("5.5","6.5","7.5","8.5","9.5","10.5")
    title("Signed Residual vs Time");
    xlabel('Time (s)');
    ylabel('Residual (m/s)');
    grid on;
hold off;

% Signed Residual vs theta all on one
figure(120);
hold on;
for i = 5:10
filename = strcat("Test1_",num2str(i),"pt5V");

[theta_exp, w_exp, v_exp, time] = LCSDATA(filename);

r = 0.0775 ; %m 7.75cm
d = 0.1525 ; %m 15.25
l = 0.255 ; %m 25.5cm
w = w_exp*(pi/180);
theta = theta_exp*(pi/180);

%call LCSMODEL
[v_mod, ~] = LCSMODEL(r,d,l,theta,w) ; %output is in m/s
v_mod = (v_mod'*1000)' ; %change to mm/s

% Calculate residuals
Residuals = v_exp - v_mod;

% Plot residuals vs. time
    plot(theta, Residuals,'LineWidth',1);

end
    legend("5.5","6.5","7.5","8.5","9.5","10.5")
    title("Signed Residual vs Theta");
    xlabel('Theta (deg)');
    ylabel('Residual (m/s)');
    grid on;
hold off;


end
