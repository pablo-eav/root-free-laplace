% START_TOOLBOX Initializes the Root-Free Laplace Inversion Toolbox for MATLAB
%
%   Run this script in MATLAB to add all toolbox folders to the active path
%   and verify installation:
%
%       >> start_toolbox
%
%   Part of the Root-Free Laplace Inversion Toolbox.

clc;
toolbox_root = fileparts(mfilename('fullpath'));

% Add folders to path
addpath(toolbox_root);
addpath(fullfile(toolbox_root, 'examples'));
addpath(fullfile(toolbox_root, 'tests'));
addpath(fullfile(toolbox_root, 'app'));

% Auto-load control package if running inside GNU Octave
if exist('OCTAVE_VERSION', 'builtin') ~= 0
    try
        pkg load control;
    catch
    end
end

fprintf('=================================================================\n');
fprintf('       ROOT-FREE NUMERICAL LAPLACE TOOLBOX FOR MATLAB            \n');
fprintf('     High-Order Spectral & Orthogonal Inversion without Roots    \n');
fprintf('=================================================================\n');
fprintf('Toolbox successfully loaded into the MATLAB path.\n\n');
fprintf('Quick Start Commands:\n');
fprintf('  1. Launch Desktop Studio GUI  : >> LaplaceGUI\n');
fprintf('  2. Run Comprehensive Tests    : >> run_all_tests\n');
fprintf('  3. Invert transfer function   : >> [f, info] = laplace.invert(num, den, z);\n');
fprintf('  4. Explore Examples           : >> ex01_basic_rational\n');
fprintf('                                  >> ex02_harmonic_5000\n');
fprintf('                                  >> ex03_chebyshev_1000000\n');
fprintf('                                  >> ex04_diffusion_step\n\n');
fprintf('Package namespace: +laplace\n');
fprintf('Documentation    : See doc/README.md and doc/TECHNICAL_MANUAL.md\n');
fprintf('=================================================================\n');
