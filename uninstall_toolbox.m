function uninstall_toolbox()
% UNINSTALL_TOOLBOX Cleanly removes the Root-Free Laplace Toolbox from MATLAB
%
%   uninstall_toolbox()
%
%   Removes toolbox folders from MATLAB path and saves the configuration.
%
%   Part of the Root-Free Laplace Inversion Toolbox.

clc;
fprintf('=================================================================\n');
fprintf('     DESINSTALADOR DE LA TOOLBOX ROOT-FREE LAPLACE               \n');
fprintf('=================================================================\n\n');

toolbox_root = fileparts(mfilename('fullpath'));

folders_to_remove = {
    toolbox_root, ...
    fullfile(toolbox_root, 'examples'), ...
    fullfile(toolbox_root, 'tests'), ...
    fullfile(toolbox_root, 'app'), ...
    fullfile(toolbox_root, 'doc')
};

for k = 1:length(folders_to_remove)
    folder = folders_to_remove{k};
    if ~isempty(strfind(path, folder))
        rmpath(folder);
        fprintf('   [-] Removido del path: %s\n', folder);
    end
end

save_status = savepath();
if save_status == 0
    fprintf('\n[OK] Path actualizado y guardado permanentemente.\n');
else
    fprintf('\n[AVISO] No se pudo guardar el path permanentemente (permisos de archivo).\n');
end

fprintf('La toolbox Root-Free Laplace ha sido desinstalada de su sesión de MATLAB.\n\n');

end
