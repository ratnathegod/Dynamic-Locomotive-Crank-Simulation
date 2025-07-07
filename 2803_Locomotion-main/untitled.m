clc; clear; close all;

r = 0.05;  
d = 0.10;  
l = 0.30;  
theta = pi/4;  

O = [0, 0]; 
A = [-r * sin(theta), r * cos(theta)]; 
B = [d, A(2) - sqrt(l^2 - (A(1) - d)^2)]; 

figure;
hold on;
rectangle('Position',[-r, -r, 2*r, 2*r], 'Curvature', [1, 1], 'EdgeColor', 'k', 'LineWidth', 1); 
plot([O(1), A(1)], [O(2), A(2)], 'r', 'LineWidth', 2); 
plot([d, d], [-0.2, 0.2], 'k--', 'LineWidth', 1.5);
plot([A(1), B(1)], [A(2), B(2)], 'b', 'LineWidth', 2); 
scatter(B(1), B(2), 100, 'filled', 'g'); 
text(B(1), B(2) + 0.02, ' B', 'FontSize', 12, 'FontWeight', 'bold');
scatter(O(1), O(2), 100, 'filled', 'k'); 
text(O(1) - 0.02, O(2) - 0.02, ' O', 'FontSize', 12, 'FontWeight', 'bold');
scatter(A(1), A(2), 100, 'filled', 'r'); 
text(A(1) - 0.02, A(2) + 0.02, ' A', 'FontSize', 12, 'FontWeight', 'bold');

axis equal;
xlim([-0.2, 0.2]);
ylim([-0.2, 0.2]);
xlabel('X Position (m)');
ylabel('Y Position (m)');
title('Locomotive Crank Mechanism');
grid on;
hold off;
