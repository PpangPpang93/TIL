import sys
import yaml
with open('/Users/ppangppang/Documents/dev/TIL/setup/config.yaml') as f:
    conf = yaml.load(f, Loader=yaml.FullLoader)
dir = conf['path']
sys.path.append(dir)

from src.function1 import show_path
from src.function2 import show_path2

show_path()
show_path2()
