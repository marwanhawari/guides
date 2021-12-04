# Conda guide

## Description
* Conda is a package and environment manager

## Basics
* Get info on your conda install: `conda info`
* List all environments: `conda info --envs`
* Install python: `conda install python=<2/3>.<x>`
* Update python: `conda update python`
* List installed packages: `conda list`

## conda vs. pip/venv

|  | conda      | pip/venv |
| ------ | ----------- | ----------- |
| Install package | `conda install <package>` | `pip install <package>` |
| Create dependency list | `conda env export --name <venv-name> > environment.yml` | `pip freeze > requirements.txt` |
| Install environment packages | `conda env create -f environment.yml` | `pip install -r requirements.txt` | 
| Uninstall package | `conda uninstall <package>`   | `pip uninstall <package>` |
| Create a virtual environment | `conda create --name <venv-name> python=3.9` | `python3 -m venv <venv-name>` |
| Activate a virtual environment | `conda activate <venv-name>` | `source <venv-name>/bin/activate` |
| Deactivate a virtual environment | `conda deactivate` | `deactivate` |
| Delete a virtual environment | `conda remove --name <venv-name> --all` | `rm -rf <venv-name>` |
| Update the package manager | `conda update conda` | `pip install --upgrade pip` |
| Update a package | `conda update --name <venv-name> <package>` | `pip install --upgrade <package>` |
