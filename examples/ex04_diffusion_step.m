% EX04_DIFFUSION_STEP Example 4: Heat Conduction / Diffusion Step Response
%
%   Transfer function:
%       F(s) = 1 / [ s * cosh(sqrt(s)) ]
%
%   Exact analytical step response:
%       Short time (t < 0.08): 2 * sum_{n=0}^{inf} (-1)^n * erfc((2n+1)/(2*sqrt(t)))
%       Long time  (t >= 0.08): 1 - (4/pi) * sum_{m=0}^{inf} [(-1)^m / (2m+1)] * exp(-(2m+1)^2*pi^2*t/4)
%
%   Approximated via N-pole spectral product:
%       cosh(sqrt(s)) = prod_{k=1}^N (1 + s / p_k),  p_k = (2k-1)^2 * pi^2 / 4
%   represented compactly via laplace.FactorPoly.

clear; clc; close all;

N_modes = 80;
fprintf('=== EX04: DIFUSION TERMICA UNIDIMENSIONAL (ESCALON) ===\n');

% Construct FactorPoly roots for denominator s * prod(s + p_k)
k = (1:N_modes).';
p_k = ((2.0 .* k - 1.0).^2) .* (pi^2) / 4.0;
roots_den = [0; -p_k];

% Gain to make numerator equal to prod(p_k) so DC gain = 1
gain_den = 1.0;
num_val = prod(p_k .^ (1.0 / N_modes)) ^ N_modes; % Scale-safe product

den_poly = laplace.FactorPoly('roots', roots_den, 'gain', gain_den);
num_poly = num_val;

% Time grid
z = linspace(1e-4, 2.5, 300);

% Invert using root-free engine
tic;
opts = struct('engine', 'TaylorAdaptive', 'tol', 1e-4);
[f_inv, info] = laplace.invert(num_poly, den_poly, z, opts);
t_inv = toc;
fprintf('Inversion numerica: %.4f ms (Motor: %s)\n', t_inv * 1000, info.engine);

% Exact analytical solution
f_exact = laplace.eval_diffusion_step_exact(z);

err = abs(f_inv - f_exact);
max_err = max(err);
fprintf('Error maximo L_inf frente a solucion analitica exacta: %.2e\n\n', max_err);

% Plot results with high-contrast publication styling
figure('Name', 'Ex04: Difusion Termica (Escalón)', 'Color', 'w', ...
       'Units', 'normalized', 'Position', [0.15, 0.15, 0.70, 0.70]);

ax1 = subplot(2, 1, 1);
plot(z, f_exact, 'k--', 'LineWidth', 2.0, 'DisplayName', 'Exacto (erfc + Fourier)');
hold on;
plot(z, f_inv, 'r-', 'LineWidth', 1.5, 'DisplayName', sprintf('Root-Free (%s)', info.engine));
grid on;
xlabel('Tiempo t (adimensional)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('Temperatura f(t)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title('Respuesta al Escalón en Difusión: F(s) = 1 / [s cosh(\surds)]', ...
      'FontSize', 13, 'FontWeight', 'bold', 'Color', 'k');
legend('Location', 'best', 'FontSize', 11);
set(ax1, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'LineWidth', 1.2);

ax2 = subplot(2, 1, 2);
semilogy(z, max(err, 1e-16), 'b-', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo t (adimensional)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('|f_{num}(t) - f_{exact}(t)|', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title(sprintf('Error Absoluto (Max: %.2e)', max_err), ...
      'FontSize', 13, 'FontWeight', 'bold', 'Color', 'k');
set(ax2, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'LineWidth', 1.2);

