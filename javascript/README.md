# JavaScript guide

## Node
* Create a `package.json` using the `npm init` command.
* All node packages are installed by default in a `node_modules` directory in the project directory itself. Verify this with the `npm root` command.
    * To install a node package globally (not recommended) use: `npm install -g <package>`. You can view where global packages are installed using the `npm root -g` command.
* Use `npm install --save-dev <package>` to install a package as a dev dependency.
* Run the `scripts` in your `package.json` file by executing: `npm run <script-name>`.


## Python vs JS tools

|  | python      | js |
| ------ | ----------- | ----------- |
| linter | `flake8` | `eslint` |
| fixer | `black` | `prettier` |
| package manager | `pip` | `npm` | 
| unit tests | `pytest`   | `jest` |
| coverage | `coverage.py` | `jest` |
| docs | `mkdocs` | `docusaurus` |
| typing | `pytype` | `typescript` |
| pre-commit hooks| `pre-commit` | `husky` |
