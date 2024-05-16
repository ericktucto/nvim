#!/usr/bin/env xonsh
from os.path import realpath, dirname, exists

me = dirname(realpath(__file__))

# Make file and directories
ln -s @(me) $HOME/.config/nvim

