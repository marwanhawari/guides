# Python guide

* Create a virtual environment named `my_venv` with: `python3 -m venv my_venv`.
* Activate virtual enviro with: `source my_venv/bin/activate`.
* Create an empty `__init__.py` file in a directory to make the directory a module. This allows the `.py` scripts inside that directory to be imported in other python scripts.
* If you have a directory with lots of scripts and you want to be able to call `python dir` and have it execute some code rather than `python dir/script.py`, you can add a `__main__.py` file containing the code you want to run to that directory.
```
project
    dir
      __init__.py
      __main__.py
      script.py
```

`script.py`
```
import sys
def main():
    print("Hello, world!")

if __name__ == "__main__":
    sys.exit(main())
```

`__main__.py`
```
import sys
from script import main

if __name__ == "__main__":
    sys.exit(main())
```
Now you can just run `python dir` and have it execute the `script.main` function than running `python dir/script.py`
<br></br>

----------------------

This syntax is used to check if the contents of the original file (`original.py`) are being directly executed (in which case, `__name__ = "__main__"` or if they are being imported from another script (`importer.py`). When `original` is imported into `importer.py`, the `main()` function is *not* executed because the `__name__` of `original` `=` `original`. The whole point is to avoid executing the `original` code at import time, so you wrap it in the `main` function and check if `__name__ == "__main__"`.

`original.py`:
```
def main():
    print("Hello, world!")

if __name__ == "__main__":
    main()
```

`importer.py`:
```
import original
```

It's best to use `sys.exit(main())` in the if statement, because it will run main as well as return the proper exit code. This way you can still run unit tests AND have proper exit codes:
```
import sys
def main():
    x = 10
    if x != 10:
        return 1 # Error exit code
        
    return 0 # Normal exit code
    
if __name__ == "__main__":
    sys.exit(main())
```
