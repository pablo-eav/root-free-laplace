function test_laguerre()
% TEST_LAGUERRE Unit test for Laguerre polynomial evaluation and recurrence
fprintf('Running test_laguerre...');

% Test 1: Known low-degree polynomials
% L_0(x) = 1
% L_1(x) = 1 - x
% L_2(x) = 1 - 2*x + 0.5*x^2
% L_3(x) = 1 - 3*x + 1.5*x^2 - (1/6)*x^3
x = linspace(0, 5, 20);
assert(max(abs(laplace.eval_laguerre(0, x) - 1.0)) < 1e-14, 'L_0 mismatch');
assert(max(abs(laplace.eval_laguerre(1, x) - (1.0 - x))) < 1e-14, 'L_1 mismatch');

L2_exact = 1.0 - 2.0.*x + 0.5.*(x.^2);
assert(max(abs(laplace.eval_laguerre(2, x) - L2_exact)) < 1e-14, 'L_2 mismatch');

L3_exact = 1.0 - 3.0.*x + 1.5.*(x.^2) - (1.0/6.0).*(x.^3);
assert(max(abs(laplace.eval_laguerre(3, x) - L3_exact)) < 1e-14, 'L_3 mismatch');

% Test 2: Damped exact Laguerre evaluation for high degree (K = 1000)
z_test = linspace(0, 10, 50);
f_damped = laplace.eval_laguerre_exact(100, 1.0, z_test);
assert(~any(isnan(f_damped)) && ~any(isinf(f_damped)), 'Damped Laguerre must not NaN/overflow');

fprintf(' PASSED.\n');
end
