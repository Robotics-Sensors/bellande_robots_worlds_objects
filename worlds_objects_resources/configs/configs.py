from header_imports import *

class configs(object):
    def __init__(self):
        with open("configs/robots_configs.json") as (file):
            self.config = json.load(file)
