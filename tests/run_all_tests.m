function run_all_tests()
% RUN_ALL_TESTS Master test runner for the Root-Free Laplace Toolbox
%
%   run_all_tests()
%
%   Executes the comprehensive validation suite and reports pass/fail status.

clc;
fprintf('=================================================================\n');
fprintf('   ROOT-FREE NUMERICAL LAPLACE TOOLBOX - COMPREHENSIVE TEST SUITE\n');
fprintf('=================================================================\n\n');

suite_start = tic;
failed_tests = {};

tests = {
    @test_fujiwara, ...
    @test_stirling, ...
    @test_laguerre, ...
    @test_massive_orders, ...
    @test_hybrid_inversion, ...
    @test_mex_speed_accuracy
};

for k = 1:length(tests)
    test_func = tests{k};
    test_name = func2str(test_func);
    try
        test_func();
    catch ME
        fprintf(' FAILED: %s\n', ME.message);
        failed_tests{end + 1} = struct('name', test_name, 'error', ME.message); %#ok<AGROW>
    end
end

total_time = toc(suite_start);
fprintf('\n-----------------------------------------------------------------\n');
if isempty(failed_tests)
    fprintf('SUCCESS: All %d test suites passed cleanly in %.3f seconds.\n', ...
        length(tests), total_time);
else
    fprintf('FAILURE: %d out of %d test suites failed.\n', ...
        length(failed_tests), length(tests));
    for i = 1:length(failed_tests)
        fprintf('  - %s: %s\n', failed_tests{i}.name, failed_tests{i}.error);
    end
end
fprintf('=================================================================\n');

end
