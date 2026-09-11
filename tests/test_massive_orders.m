function test_massive_orders()
% TEST_MASSIVE_ORDERS Unit test for massive order handling (K = 10,000 and K = 1,000,000)
fprintf('Running test_massive_orders...');

% Test 1: Harmonic resonators of order K = 10,000 (N = 5000)
pf_harm = laplace.harmonic_resonators(5000);
assert(pf_harm.degree() == 10000, 'Harmonic resonators degree must be 10,000');

z_pts = [0.001, 0.005, 0.01];
f_modal = pf_harm.evaluate_modal(z_pts);
f_dirichlet = laplace.eval_harmonic_resonators_exact(5000, z_pts);

err_harm = max(abs(f_modal - f_dirichlet));
assert(err_harm < 1e-10, 'Harmonic resonators modal sum must match Dirichlet kernel within 1e-10');

% Test 2: Chebyshev ladder of order N = 1,000,000
tic;
pf_cheb = laplace.chebyshev_network(1000000, 2e8);
t_build = toc;
assert(t_build < 0.5, 'Chebyshev network modal construction must take < 0.5 s');

z_cheb = [1e-8, 1e-7];
tic;
f_cheb = pf_cheb.evaluate_modal(z_cheb);
t_eval = toc;
assert(t_eval < 0.1, 'Chebyshev evaluation must be fast');
assert(~any(isnan(f_cheb)) && ~any(isinf(f_cheb)), 'Chebyshev evaluation must be finite');

fprintf(' PASSED.\n');
end
