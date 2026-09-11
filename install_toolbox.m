function install_toolbox()
% INSTALL_TOOLBOX Permanently installs the Root-Free Laplace Toolbox into MATLAB
%
%   install_toolbox()
%
%   Performs the following automated operations:
%     1. Adds toolbox directories (+laplace, app, examples, tests, doc) to the active path.
%     2. Permanently saves the updated path with savepath.
%     3. Runs a self-diagnostic verification test to confirm functional integrity.
%     4. Updates MATLAB toolbox and documentation caches.
%
%   To uninstall, run: uninstall_toolbox()
%
%   Part of the Root-Free Laplace Inversion Toolbox.

clc;
fprintf('=================================================================\n');
fprintf('     INSTALADOR DE LA TOOLBOX ROOT-FREE LAPLACE PARA MATLAB      \n');
fprintf('=================================================================\n\n');

toolbox_root = fileparts(mfilename('fullpath'));

% Define folders to add
folders_to_add = {
    toolbox_root, ...
    fullfile(toolbox_root, 'examples'), ...
    fullfile(toolbox_root, 'tests'), ...
    fullfile(toolbox_root, 'app'), ...
    fullfile(toolbox_root, 'doc')
};

fprintf('1. Registrando directorios en el MATLAB path...\n');
for k = 1:length(folders_to_add)
    folder = folders_to_add{k};
    if exist(folder, 'dir')
        addpath(folder);
        fprintf('   [+] %s\n', folder);
    end
end

fprintf('\n2. Guardando el path de forma permanente...\n');
save_status = savepath();
if save_status == 0
    fprintf('   [OK] Path guardado permanentemente con éxito.\n');
else
    % If default pathdef cannot be modified (permission issue), try userpath
    user_pathdef = fullfile(userpath, 'pathdef.m');
    save_user = savepath(user_pathdef);
    if save_user == 0
        fprintf('   [OK] Path guardado en el directorio de usuario: %s\n', user_pathdef);
    else
        fprintf('   [AVISO] No se pudo escribir en pathdef.m (posibles permisos de administrador).\n');
        fprintf('           La toolbox estará activa en esta sesión. Para hacerla permanente,\n');
        fprintf('           ejecute MATLAB como Administrador y repita install_toolbox.\n');
    end
end

% 2.5 Check and build MEX kernels if needed
src_dir = fullfile(toolbox_root, 'src');
if exist(src_dir, 'dir') && exist(fullfile(toolbox_root, 'build_mex.m'), 'file')
    fprintf('\n3. Verificando aceleradores nativos MEX...\n');
    test_mex = fullfile(toolbox_root, '+laplace', ['eval_laguerre_mex.', mexext]);
    if ~exist(test_mex, 'file')
        fprintf('   [i] Compilando núcleos MEX nativos para esta plataforma...\n');
        try
            build_mex(false);
            fprintf('   [OK] Núcleos MEX compilados exitosamente.\n');
        catch ME_bld
            fprintf('   [i] Usando fallback puro vectorizado (sin compilador C): %s\n', ME_bld.message);
        end
    else
        fprintf('   [OK] Binarios MEX detectados y listos para la arquitectura actual (Nivel 3).\n');
    end
end

fprintf('\n4. Ejecutando prueba de verificación funcional inmediata...\n');
try
    z_test = [0.0, 1.0];
    [f_test, info_test] = laplace.invert([1], [1, 2, 2], z_test);
    f_ref = exp(-z_test) .* sin(z_test);
    err_test = max(abs(f_test - f_ref));
    
    if err_test < 1e-4
        fprintf('   [OK] Inversión de prueba exitosa (Motor: %s, Error L_inf: %.2e).\n', ...
            info_test.engine, err_test);
    else
        warning('La prueba de verificación dio un error superior al umbral: %.2e', err_test);
    end
catch ME
    fprintf('   [ERROR] Falló la verificación funcional: %s\n', ME.message);
    return;
end

% Rehash cache if available
try
    rehash toolboxcache;
catch
end

fprintf('\n=================================================================\n');
fprintf('     ¡INSTALACIÓN COMPLETADA CON ÉXITO!                          \n');
fprintf('=================================================================\n');
fprintf('Comandos principales listos para usar:\n');
fprintf('  >> LaplaceGUI           %% Abre la Interfaz Gráfica interactiva\n');
fprintf('  >> run_all_tests        %% Ejecuta la batería de pruebas de validación\n');
fprintf('  >> ex01_basic_rational  %% Ejecuta el Ejemplo 1 (Racional de 2º orden)\n');
fprintf('  >> ex02_harmonic_5000   %% Ejecuta el Ejemplo 2 (5000 resonadores armónicos)\n');
fprintf('  >> ex03_chebyshev1000000%% Ejecuta el Ejemplo 3 (1,000,000 polos Chebyshev)\n');
fprintf('  >> ex04_diffusion_step  %% Ejecuta el Ejemplo 4 (Difusión térmica)\n');
fprintf('  >> doc root_free_laplace%% Abre la documentación en el navegador de ayuda\n');
fprintf('=================================================================\n\n');

end
