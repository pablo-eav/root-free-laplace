function test_hybrid_inversion()
% TEST_HYBRID_INVERSION Unit test verifying accuracy of laplace.invert
fprintf('Running test_hybrid_inversion...');

% Test 1: Simple 2nd order system F(s) = 1 / (s^2 + 2*s + 2)
% Exact: f(z) = exp(-z) * sin(z)
z_grid = linspace(0, 8, 100);
f_num = laplace.invert([1], [1, 2, 2], z_grid);
f_exact = exp(-z_grid) .* sin(z_grid);
err1 = max(abs(f_num - f_exact));
assert(err1 < 5e-3, sprintf('Error on 2nd order system too large: %.2e', err1));

% Test 2: Double pole system F(s) = 1 / (s + 2)^2
% Exact: f(z) = z * exp(-2*z)
f_num2 = laplace.invert([1], [1, 4, 4], z_grid);
f_exact2 = z_grid .* exp(-2.0 .* z_grid);
err2 = max(abs(f_num2 - f_exact2));
assert(err2 < 5e-3, sprintf('Error on double pole system too large: %.2e', err2));

% Test 3: Factored cascade F(s) = 1 / (s + 1)^10
roots_10 = -ones(10, 1);
B_fac = laplace.FactorPoly('roots', roots_10);
f_num3 = laplace.invert(1, B_fac, z_grid);
f_exact3 = (z_grid.^9 / factorial(9)) .* exp(-z_grid);
err3 = max(abs(f_num3 - f_exact3));
assert(err3 < 1e-3, sprintf('Error on 10th order cascade too large: %.2e', err3));

fprintf(' PASSED.\n');
end
