% EX03_CHEBYSHEV_1000000 Example 3: Chebyshev Ladder of Order N = 1,000,000
%
%   Transfer function:
%       F(s) = 1 / [ U_N(1 + s/denom) - U_{N-1}(1 + s/denom) ]
%
%   Demonstrates handling of one million poles (K = 1,000,000)
%   in milliseconds using modal partial fractions without ever computing roots.

clear; clc; close all;

N = 1000000; % 1 Million poles!
denom = 2e8;
fprintf('=== EX03: RED DISTRIBUIDA CHEBYSHEV (ORDEN N = %d) ===\n', N);

% Generate modal decomposition
tic;
pf = laplace.chebyshev_network(N, denom);
t_gen = toc;
fprintf('Construccion modal O(K): %.4f ms\n', t_gen * 1000);

% Time grid
z = linspace(1e-9, 1e-6, 500);

% Invert using root-free toolbox
tic;
[f_inv, info] = laplace.invert([], pf, z);
t_inv = toc;
fprintf('Inversion numerica: %.4f ms (Motor: %s)\n', t_inv * 1000, info.engine);

% Exact reference evaluation
f_exact = laplace.eval_chebyshev_ladder_exact(N, denom, z);
err = abs(f_inv - f_exact);
max_err = max(err);
fprintf('Concordancia L_inf: %.2e\n\n', max_err);

% Plot results with high-contrast publication styling
figure('Name', 'Ex03: Red Chebyshev N = 1,000,000', 'Color', 'w', ...
       'Units', 'normalized', 'Position', [0.15, 0.15, 0.70, 0.70]);

ax1 = subplot(2, 1, 1);
plot(z * 1e6, f_inv, 'b-', 'LineWidth', 2.0, 'DisplayName', 'Toolbox Root-Free (10^6 Polos)');
grid on;
xlabel('Tiempo z (\mus)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('f(z)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title('Respuesta Impulsional de Red Chebyshev de Orden 1,000,000', ...
      'FontSize', 13, 'FontWeight', 'bold', 'Color', 'k');
legend('Location', 'best', 'FontSize', 11);
set(ax1, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'LineWidth', 1.2);

ax2 = subplot(2, 1, 2);
semilogy(z * 1e6, max(err, 1e-16), 'r-', 'LineWidth', 1.8);
grid on;
xlabel('Tiempo z (\mus)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
ylabel('|Error|', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
title(sprintf('Error frente a Referencia Modal (Max: %.2e)', max_err), ...
      'FontSize', 13, 'FontWeight', 'bold', 'Color', 'k');
set(ax2, 'Color', 'w', 'XColor', 'k', 'YColor', 'k', 'FontSize', 11, 'FontWeight', 'bold', 'LineWidth', 1.2);

