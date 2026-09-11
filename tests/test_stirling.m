function test_stirling()
% TEST_STIRLING Unit test for Stirling log-gamma evaluation
fprintf('Running test_stirling...');

% Test 1: Compare with exact gammaln for moderate values
x_vals = [1.0, 2.5, 10.0, 14.9, 15.1, 20.0, 50.0, 100.0];
val_stirling = laplace.stirling_gamma(x_vals);
val_exact = gammaln(x_vals);

rel_err = abs(val_stirling - val_exact) ./ max(abs(val_exact), 1.0);
assert(max(rel_err) < 1e-10, 'Stirling expansion relative error exceeds 1e-10 for x >= 15');

% Test 2: Huge values where gammaln or factorial would overflow standard double
x_huge = 1e6;
val_huge = laplace.stirling_gamma(x_huge);
assert(~isinf(val_huge) && ~isnan(val_huge), 'Stirling must remain finite for x = 1e6');
assert(val_huge > 1.2e7, 'Stirling value for 1e6 has expected magnitude');

fprintf(' PASSED.\n');
end
