% EX02_HARMONIC_5000 Example 2: 5000 Harmonic Resonators (Degree K = 10,000)
%
%   Transfer function:
%       Q(s) = prod_{k=1}^{5000} (s^2 + k^2)
%       F(s) = sum_{k=1}^{5000} k / (s^2 + k^2)
%
%   Exact time-domain response:
%       f(z) = sum_{k=1}^{5000} sin(k*z)
%            = sin(5000*z/2) * sin(5001*z/2) / sin(z/2)  (Dirichlet Kernel)
%
%   Demonstrates handling of high-order undamped resonant systems without
%   polynomial overflow.

clear; clc; close all;

N = 5000;
fprintf('=== EX02: 5000 RESONADORES ARMONICOS (GRADO K = %d) ===\n', 2*N);

% Generate PartialFractions representation
tic;
pf = laplace.harmonic_resonators(N);
t_gen = toc;
fprintf('Generacion de fracciones parciales: %.4f ms\n', t_gen * 1000);

% High-resolution time grid around the initial transient
z = linspace(1e-5, 0.02, 1000);

% Invert using root-free toolbox
tic;
[f_inv, info] = laplace.invert([], pf, z);
t_inv = toc;
fprintf('Inversion numerica: %.4f ms (Motor: %s)\n', t_inv * 1000, info.engine);

% Exact analytical solution via Dirichlet kernel
f_exact = laplace.eval_harmonic_resonators_exact(N, z);

err = abs(f_inv - f_exact);
max_err = max(err);
fprintf('Error maximo L_inf frente al nucleo de Dirichlet: %.2e\n\n', max_err);

% Plot results with high-contrast publication styling
figure('Name', 'Ex02: 5000 Resonadores Armónicos', 'Color', 'w', ...
       'Units', 'normalized', 'Position', [0.15, 0.15, 0.70, 0.70]);

ax1 = subplot(2, 1, 1);
plot(z * 1000, f_exact, 'k-', 'LineWidth', 2.0, 'DisplayName', 'Núcleo de Dirichlet Exacto');
hold on;
plot(z * 1000, f_inv, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Toolbox Root-Free');
grid on;
xlabel('Tiempo z (ms)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('f(z)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title('Respuesta Impulsional de 5000 Resonadores (Grado K = 10,000)', ...
      'FontSize', 13, 'FontWeight', 'bold', 'Color', 'k');
legend('Location', 'best', 'FontSize', 11);
set(ax1, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'LineWidth', 1.2);

ax2 = subplot(2, 1, 2);
semilogy(z * 1000, max(err, 1e-16), 'b-', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo z (ms)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('|f_{num}(z) - f_{exact}(z)|', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title(sprintf('Error Absoluto (Max: %.2e)', max_err), ...
      'FontSize', 13, 'FontWeight', 'bold', 'Color', 'k');
set(ax2, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'LineWidth', 1.2);

