import os
from glob import glob

if __name__ == '__main__':

    # Notebooks that should be tested
    notebooks = sorted(glob('/home/neuro/workshop/notebooks/*'))

    # Test the notebooks
    for test in notebooks:
        cmd = 'pytest --nbval-lax --nbval-cell-timeout 7200 -v -s %s' % test
        print(cmd)
        os.system(cmd)
