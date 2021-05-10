function install_robotology_packages(varargin)
    % Install the robotology MATLAB/Simulink packages in a local directory
    p = inputParser;
    default_install_prefix = fullfile(pwd,'robotology-matlab');
    addOptional(p,'installPrefix', default_install_prefix);
    parse(p,varargin{:});
      
    % Build package installation directory
    install_prefix = p.Results.installPrefix;

    setup_script = fullfile(pwd, 'robotology_setup.m');
      
    if exist(install_prefix)
        fprintf('Directory %s already present. Please use it or delete to proceed with the install', install_prefix);
        return;
    end

    fprintf('Installing robotology MATLAB/Simulink binaries in %s', install_prefix);
    % The install url is created following 
    mambaforge_url_prefix = 'https://github.com/conda-forge/miniforge/releases/latest/download/';
    if ispc
        mambaforge_installer_name = 'Mambaforge-Windows-x86_64.exe';
    elseif ismac
        [~, uname_m] = system('uname -m');
        % Remove newline
        uname_m = strip(uname_m);
        mambaforge_installer_name = sprintf('Mambaforge-MacOSX-%s.sh', uname_m);
    elseif isunix
        [~, uname] = system('uname');
        % Remove newline
        uname = strip(uname);
        [~, uname_m] = system('uname -m');
        % Remove newline
        uname_m = strip(uname_m);
        mambaforge_installer_name = sprintf('Mambaforge-%s-%s.sh', uname, uname_m);
    end
    mambaforge_installer_url = strcat(mambaforge_url_prefix, mambaforge_installer_name);
    websave(mambaforge_installer_name, mambaforge_installer_url);
    
    if ispc
        system(sprintf('TODO'));
        mamba_full_path = 'TODO';
    elseif isunix
        system(sprintf('sh %s -b -p %s', mambaforge_installer_name, install_prefix));
        mamba_full_path = fullfile(install_prefix, 'bin', 'mamba');
    end
    
    if ~exist(install_prefix, 'dir')
        fprintf('Installation in %s failed for unknown reason, please open an issue at https://github.com/robotology/robotology-superbuild/issues/new', install_prefix);
        return;
    end
    
    % Install all the robotology packages related to MATLAB or Simulink
    system(sprintf('%s install -y -c conda-forge -c robotology yarp-matlab-bindings idyntree wb-toolbox osqp-matlab whole-body-controllers matlab-whole-body-simulator icub-models', mamba_full_path));    
    fprintf('\t\t\t\t[done]\n');

    fprintf('Creating setup script in %s', setup_script);
    % Generate robotology_setup.m 
    setupID = fopen(setup_script,'w');
    fprintf(setupID, '%% Specify OS-specific locations\n');
    fprintf(setupID, 'if ispc\n');
    fprintf(setupID, '    rob_env_sep = ";";\n');
    fprintf(setupID, '    rob_shlib_install_dir = "bin";\n');
    fprintf(setupID, 'else\n');
    fprintf(setupID, '    rob_env_sep = ":";\n');
    fprintf(setupID, '    rob_shlib_install_dir = "lib";\n');
    fprintf(setupID, 'end\n');
    fprintf(setupID, '\n');
    fprintf(setupID, '%% Install prefix (hardcoded at generation time)\n');
    fprintf(setupID, 'robotology_install_prefix = "%s";\n', install_prefix);
    fprintf(setupID, '\n');
    fprintf(setupID, '%% Add directory to MATLAB path\n');
    fprintf(setupID, 'addpath(fullfile(robotology_install_prefix,"mex"));\n');
    fprintf(setupID, 'addpath(fullfile(robotology_install_prefix,"mex/+wbc/simulink"));\n');
    fprintf(setupID, 'addpath(fullfile(robotology_install_prefix,"share/WBToolbox"));\n');
    fprintf(setupID, 'addpath(fullfile(robotology_install_prefix,"share/WBToolbox/images"));\n');
    fprintf(setupID, '\n');
    fprintf(setupID, '%% Append required values to system environment variables\n');
    fprintf(setupID, 'setenv("PATH",strcat(fullfile(robotology_install_prefix,"bin"), rob_env_sep, getenv("PATH")));\n');
    fprintf(setupID, 'setenv("YARP_DATA_DIRS",strcat(fullfile(robotology_install_prefix,"share/yarp"), ...\n');
    fprintf(setupID, '       rob_env_sep, fullfile(robotology_install_prefix,"share/iCub"), ...\n');
    fprintf(setupID, '       rob_env_sep, fullfile(robotology_install_prefix,"share/ICUBcontrib"), ...\n');
    fprintf(setupID, '       rob_env_sep, fullfile(robotology_install_prefix,"share/RRbot")));\n');
    fprintf(setupID, 'setenv("ROS_PACKAGE_PATH",strcat(fullfile(robotology_install_prefix,"share"), rob_env_sep, getenv("ROS_PACKAGE_PATH")));\n');
    fprintf(setupID, 'setenv("BLOCKFACTORY_PLUGIN_PATH",fullfile(robotology_install_prefix,rob_shlib_install_dir,"blockfactory"));\n');
    fclose(setupID);
    fprintf('\t\t\t\t[done]\n');

    fprintf('Deleting temporary files...');
    delete(mambaforge_installer_name);
    fprintf('\t\t\t[done]\n');

    fprintf('robotology MATLAB and Simulink packages are successfully installed!\n');
    fprintf('Please run %s before using the packages, or just add that script to your startup.m file, to run it whenever you open MATLAB.\n', setup_script);
    fprintf('To uninstall these packages, just delete the folder %s.\n', install_prefix);
end
