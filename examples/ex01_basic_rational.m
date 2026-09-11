% EX01_BASIC_RATIONAL Example 1: Inversion of standard rational fraction
%
%   Transfer function:
%       F(s) = 1 / (s^2 + 2*s + 2) = 1 / ((s + 1)^2 + 1)
%
%   Analytical solution:
%       f(z) = exp(-z) * sin(z)
%
%   Demonstrates root-free inversion in double precision with zero roots computed.

clear; clc; close all;

% Define transfer function polynomials
num = 1;
den = [1, 2, 2];

% Time grid
z = linspace(0, 10, 500);

% Compute Fujiwara bound
[R_fuj, z_fuj] = laplace.fujiwara_bound(den);
fprintf('=== EX01: INVERSION RACIONAL ESTANDAR ===\n');
fprintf('Cota espectral de Fujiwara R_fuj = %.4f rad/s\n', R_fuj);
fprintf('Horizonte causal seguro z_fuj    = %.4f s\n', z_fuj);

% Invert using root-free engine
tic;
[f_inv, info] = laplace.invert(num, den, z);
t_elapsed = toc;
fprintf('Motor empleado: %s (Terminos: %d, Tiempo: %.4f ms)\n', ...
    info.engine, info.terms, t_elapsed * 1000);

% Exact analytical benchmark
f_exact = exp(-z) .* sin(z);
err = abs(f_inv - f_exact);
max_err = max(err);
fprintf('Error maximo L_inf: %.2e\n\n', max_err);

% Plot results with high-contrast publication styling
figure('Name', 'Ex01: Racional Estandar', 'Color', 'w', ...
       'Units', 'normalized', 'Position', [0.15, 0.15, 0.70, 0.70]);

ax1 = subplot(2, 1, 1);
plot(z, f_exact, 'k--', 'LineWidth', 2, 'DisplayName', 'Exacto Analítico');
hold on;
plot(z, f_inv, 'b-', 'LineWidth', 1.5, 'DisplayName', sprintf('Root-Free (%s)', info.engine));
grid on;
xlabel('Tiempo z (s)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('f(z)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title('Inversión Numérica de Laplace sin Raíces: F(s) = 1 / (s^2 + 2s + 2)', ...
      'FontSize', 13, 'FontWeight', 'bold', 'Color', 'k');
legend('Location', 'best', 'FontSize', 11);
set(ax1, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'LineWidth', 1.2);

ax2 = subplot(2, 1, 2);
semilogy(z, max(err, 1e-18), 'r-', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo z (s)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('|f_{num}(z) - f_{exact}(z)|', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title(sprintf('Error Absoluto (Max: %.2e)', max_err), ...
      'FontSize', 13, 'FontWeight', 'bold', 'Color', 'k');
set(ax2, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'LineWidth', 1.2);

