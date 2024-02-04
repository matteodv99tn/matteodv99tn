import os
import sys

sys.path.insert(0, os.path.abspath('..'))

project = 'Matteo Dalle Vedove'
copyright = 'Matteo Dalle Vedove - 2023'
author = 'Matteo Dalle Vedove'
release = ''

extensions = [
              "sphinx.ext.graphviz",
              "sphinx_copybutton",
              "myst_parser"
              ]

source_suffix = ['.rst', '.md']

pygments_style = 'sphinx'

html_theme = 'furo'

