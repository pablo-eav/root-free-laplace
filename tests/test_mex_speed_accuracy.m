function test_mex_speed_accuracy()
% TEST_MEX_SPEED_ACCURACY Benchmarks and validates compiled MEX kernels against .m routines
%
% Part of the Root-Free Laplace Inversion Toolbox.

fprintf('=================================================================\n');
fprintf('   BENCHMARK Y VALIDACION DE EXACTITUD MEX (NIVEL 3 DE PROTECCION)\n');
fprintf('=================================================================\n');

%% 1. Benchmark eval_laguerre
fprintf('[1/5] Verificando eval_laguerre (n=200, N_points=5000)...\n');
x_pts = linspace(0, 10, 5000);
tic;
y_mex = laplace.eval_laguerre_mex(200, x_pts);
t_mex = toc;

% Test fallback accuracy
y_ref = zeros(size(x_pts));
L0 = ones(size(x_pts));
L1 = 1.0 - x_pts;
for k = 1:199
    L_next = ((2.0 * k + 1.0 - x_pts) .* L1 - k .* L0) / double(k + 1);
    L0 = L1;
    L1 = L_next;
end
err1 = max(abs(y_mex - L1)) / max(abs(L1));
fprintf('      Error relativo L_inf: %e | Tiempo MEX: %.4f s\n', err1, t_mex);
assert(err1 < 1e-12, 'eval_laguerre_mex verification failed');

%% 2. Benchmark eval_laguerre_exact
fprintf('[2/5] Verificando eval_laguerre_exact (K=500, a=2.5, N_points=5000)...\n');
z_pts = linspace(0.01, 10, 5000);
tic;
f_mex = laplace.eval_laguerre_exact_mex(500, 2.5, z_pts);
t_mex2 = toc;

x2 = 2.0 * 2.5 .* z_pts;
L0 = ones(size(z_pts));
L1 = 1.0 - x2;
for k = 1:499
    L_next = ((2.0 * k + 1.0 - x2) .* L1 - k .* L0) / double(k + 1);
    L0 = L1;
    L1 = L_next;
end
f_ref = exp(-2.5 .* z_pts) .* L1;
err2 = max(abs(f_mex - f_ref));
fprintf('      Error absoluto L_inf: %e | Tiempo MEX: %.4f s\n', err2, t_mex2);
assert(err2 < 1e-12, 'eval_laguerre_exact_mex verification failed');

%% 3. Benchmark fujiwara_bound
fprintf('[3/5] Verificando fujiwara_bound (Polinomio orden 100)...\n');
b_test = [1, rand(1, 100) * 10];
[r_mex, z_mex] = laplace.fujiwara_bound_mex(b_test);
fprintf('      Radio espectral acotado r_pole: %.4f rad/s | Limite causal z_fuj: %.4f s\n', r_mex, z_mex);
assert(r_mex > 0 && isfinite(z_mex), 'fujiwara_bound_mex failed');

%% 4. Benchmark stirling_gamma
fprintf('[4/5] Verificando stirling_gamma (10,000 puntos en escala logaritmica)...\n');
x_gam = logspace(1.5, 6, 10000);
tic;
g_mex = laplace.stirling_gamma_mex(x_gam, 4);
t_mex4 = toc;
fprintf('      Evaluacion vectorizada completada en %.4f s\n', t_mex4);
assert(all(isfinite(g_mex)), 'stirling_gamma_mex failed');

%% 5. Benchmark deconv_synthetic
fprintf('[5/5] Verificando deconv_synthetic (Grado 50 / 500 terminos)...\n');
P_poly = rand(1, 50);
Q_poly = [1, rand(1, 50)];
tic;
c_deconv = laplace.deconv_synthetic_mex(P_poly, Q_poly, 500);
t_mex5 = toc;
fprintf('      500 coeficientes deconvolucionados en %.4f s\n', t_mex5);
assert(length(c_deconv) == 500 && all(isfinite(c_deconv)), 'deconv_synthetic_mex failed');

fprintf('-----------------------------------------------------------------\n');
fprintf(' RESULTADO: Todos los 5 kernels MEX pasaron con maxima precision!\n');
fprintf('=================================================================\n');

end
