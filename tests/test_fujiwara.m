function test_fujiwara()
% TEST_FUJIWARA Unit test for Fujiwara spectral bound and safe causal horizon
fprintf('Running test_fujiwara...');

% Test 1: Standard polynomial (s+1)(s+2)(s+3) = s^3 + 6*s^2 + 11*s + 6
% Max root is 3.
b_poly = conv([1, 1], conv([1, 2], [1, 3]));
[R, z_fuj] = laplace.fujiwara_bound(b_poly);
assert(R >= 3.0, 'Fujiwara bound must be >= actual spectral radius');
assert(R <= 10.0, 'Fujiwara bound should not grossly overestimate for small orders');
assert(abs(z_fuj - 35.0 / R) < 1e-12, 'z_fuj formula mismatch');

% Test 2: Quadratic oscillator s^2 + 100
% Max root is 10.
b_quad = [1, 0, 100];
[R_quad, ~] = laplace.fujiwara_bound(b_quad);
assert(R_quad >= 10.0, 'Fujiwara bound must bound oscillator poles');

% Test 3: FactorPoly with 1000 poles
roots_1000 = -linspace(1, 50, 1000);
fp = laplace.FactorPoly('roots', roots_1000);
[R_fp, ~] = laplace.fujiwara_bound(fp);
assert(abs(R_fp - 50.0) < 1e-12, 'FactorPoly spectral radius must equal max root');

fprintf(' PASSED.\n');
end
