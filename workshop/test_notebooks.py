import os
from glob import glob

if __name__ == '__main__':

    # Test workshop notebooks
    notebooks = sorted(glob('/home/neuro/workshop/notebooks/*.ipynb'))

    # Test the notebooks
    for test in notebooks:
        cmd = 'pytest --nbval-lax --nbval-cell-timeout 7200 -v -s %s' % test
        print(cmd)
        os.system(cmd)
