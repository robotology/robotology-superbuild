import argparse
import jinja2
import os
import string
import yaml
import shutil

# multisheller includes
import multisheller
from multisheller import cmds
from multisheller.backend import bash, zsh, xonsh, cmdexe, powershell
import argparse, sys
import ast
from multisheller.cmds import *
from multisheller import path, sys
from multisheller.backend.utils import write_script
from pprint import pprint

def dir_path(string):
    if os.path.isdir(string):
        return string
    else:
        raise NotADirectoryError(string)


suffixes = {
    'cmdexe': '.bat',
    'bash': '.sh',
    'zsh': '.zsh',
    'xonsh': '.xsh',
    'powershell': '.ps1',
}

translators = {
    'cmdexe': cmdexe,
    'bash': bash,
    'zsh': zsh,
    'xonsh': xonsh,
    'powershell': powershell,
}

def write_script(generation_directory, name_without_extension, commands, interpreter):
    fname = generation_directory + "/" + name_without_extension + suffixes[interpreter]
    s = cmds.Script(commands)

    print(f"Writing file to {fname}")
    with open(fname, 'w') as f:
        s = translators[interpreter].to_script(s)
        f.write(s)

    f.close()
    print(f"File wrote to {fname}")

    return

# Inspired from:
#  * https://github.com/wolfv/multisheller/blob/0cc03c68d0c68d2f9cf7b07ddb68afa531419a6d/multisheller/cli/main.py
#  * https://github.com/wolfv/multisheller/blob/0cc03c68d0c68d2f9cf7b07ddb68afa531419a6d/multisheller/backend/utils.py#L21
def generate_scripts_from_multisheller_file(multisheller_file, generation_directory, name_without_extension):
    # Parse msh file
    with open(multisheller_file) as fi:
        contents = fi.read()
    contents = contents
    tree = ast.parse(contents)

    ls = locals().copy()
    cmds = []
    for expr in tree.body:
        codeobj = compile(ast.Expression(expr.value), '<string>', mode='eval')
        res = eval(codeobj, globals(), ls)
        if type(expr) == ast.Assign:
            for t in expr.targets:
                ls.update({t.id: res})
        else:
            cmds.append(res)

    # Generate scripts
    write_script(generation_directory, name_without_extension, cmds, "cmdexe")
    write_script(generation_directory, name_without_extension, cmds, "bash")
    write_script(generation_directory, name_without_extension, cmds, "zsh")
    write_script(generation_directory, name_without_extension, cmds, "xonsh")
    write_script(generation_directory, name_without_extension, cmds, "powershell")

def main():

    # Parse parameters
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--metametadata", type=str, help="metametadata .yaml file")
    parser.add_argument("-o", "--recipes_dir", type=dir_path, help="directory of generated recipes directory")
    args = parser.parse_args()

    # Get recipe templates
    recipe_template_dir = os.path.realpath(os.path.dirname(os.path.abspath(__file__)) + "/../recipe_template");
    recipe_template_files = [f for f in os.listdir(recipe_template_dir) if os.path.isfile(os.path.join(recipe_template_dir, f))]

    # Get multisheller scripts
    multisheller_scripts_dir = os.path.realpath(os.path.dirname(os.path.abspath(__file__)) + "/../multisheller");
    multisheller_scripts = [f for f in os.listdir(multisheller_scripts_dir) if os.path.isfile(os.path.join(multisheller_scripts_dir, f))]

    # Prepare Jinja templates
    file_loader = jinja2.FileSystemLoader(recipe_template_dir)
    env = jinja2.Environment(loader=file_loader)
    # Load metametadata
    metametadata = yaml.load(open(args.metametadata), Loader=yaml.FullLoader)

    for pkg in metametadata['conda-packages-metametadata']:
        print(f"generate_conda_recipes_from_metadatadata: generating recipe for package {pkg}")

        # Check if multisheller file are available for this package,
        # if available generate activate scripts

        # Get pkginfo
        pkg_info = metametadata['conda-packages-metametadata'][pkg]
        recipe_dir = os.path.join(os.path.realpath(args.recipes_dir), pkg_info['name'])
        shutil.rmtree(recipe_dir, ignore_errors=True)
        os.mkdir(recipe_dir)
        print(recipe_dir)

        # Generate activation scripts
        activation_script_msh = pkg_info['name'] + "_activate.msh"
        deactivation_script_msh = pkg_info['name'] + "_deactivate.msh"
        if activation_script_msh in multisheller_scripts and deactivation_script_msh in multisheller_scripts:
            print(f"Generating scripts for {pkg_info['name']}")
            generate_scripts_from_multisheller_file(multisheller_scripts_dir + "/" + activation_script_msh, recipe_dir, "activate")
            generate_scripts_from_multisheller_file(multisheller_scripts_dir + "/" + deactivation_script_msh, recipe_dir, "deactivate")
            # To copy the activation scripts in the recipe
            pkg_info['copy_activation_scripts'] = True
        else:
            pkg_info['copy_activation_scripts'] = False

        # Generate recipe
        for template_file in recipe_template_files:
            template = env.get_template(template_file)
            template_output = template.render(pkg_info)
            with open(os.path.join(recipe_dir, template_file), 'w') as f:
                f.write(template_output)

if __name__ == '__main__':
    main()
