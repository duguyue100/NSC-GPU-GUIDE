#!/usr/bin/env bash

# This script is to clean up all the traces of the installation.
# Author: Yuhuang Hu
# Email : yuhuang.hu@ini.uzh.ch

# Color Profile
RED='\033[0;31m'
LIGHT_BLUE='\033[1;34m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
COLOR_END='\033[0m'

# Remove Miniconda
echo -e "${RED}[MESSAGE] Removing Miniconda...${COLOR_END}"
if [ -d "$HOME/miniconda" ]; then
    rm -rf $HOME/miniconda
    rm -rf $HOME/.conda
fi

# Remove Theano file
# echo -e "${RED}[MESSAGE] Removing Theano files...${COLOR_END}"
# if [ -f "$HOME/.theanorc" ]; then
#     rm $HOME/.theanorc
# fi
# if [ -d "$HOME/.theano" ]; then
#     rm -rf $HOME/.theano
# fi

# Remove Keras file
echo -e "${RED}[MESSAGE] Removing Keras files...${COLOR_END}"
if [ -d "$HOME/.keras" ]; then
    rm -rf $HOME/.keras
fi

# Restore .bashrc file
echo -e "${RED}[MESSAGE] Restoring .bashrc profile...${COLOR_END}"
cp $HOME/.bashrc $HOME/.bashrc.bak
echo -e "${RED}[MESSAGE] Current .bashrc is backed up at $HOME/.bashrc.bak${COLOR_END}"
if [ -f "$HOME/.bashrc.dl.bak" ]; then
    cp $HOME/.bashrc.dl.bak $HOME/.bashrc
else
    echo "[MESSAGE] Backup file not found, please restore manually."
fi

echo -e "${LIGHT_BLUE}[MESSAGE]The environment is clean!${COLOR_END}"
