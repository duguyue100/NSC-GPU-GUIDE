#!/usr/bin/env bash

# This script is to setup the general system configuration.
# Author: Yuhuang Hu
# Email : yuhuang.hu@ini.uzh.ch

USER_DIR=$(cd $(dirname $0); pwd)
INSTALL_OPT="yes"
ENABLE_INSTALL=false
DEBUG_MODE=true

STATE_START=0
STATE_AFTER_UPGRADE=1
STATE_AFTER_JAVA=2

CAME_BACK_FROM_REBOOT=0


ENABLE_GPU=true

ENABLE_ALL=false
ENABLE_DEV=false
ENABLE_JAVA=false

# Color Profile
RED='\033[0;31m'
LIGHT_BLUE='\033[1;34m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
COLOR_END='\033[0m'

# Welcome Message 
echo -e "${LIGHT_BLUE}WELCOME TO MACHINE SETUP SCRIPT!${COLOR_END}"
echo -e "${LIGHT_BLUE}This script helps you setup your${COLOR_END}"
echo -e "${LIGHT_BLUE}system quickly and efficiently.${COLOR_END}"
echo -e "${LIGHT_BLUE}This script is hosted at https://github.com/duguyue100/NSC-GPU-GUIDE${COLOR_END}"
echo -e "${LIGHT_BLUE}Make pull requests or submit issues if you want to make changes.${COLOR_END}"
echo -e "${LIGHT_BLUE}Let's make setup easy again!${COLOR_END}"
echo -e "${LIGHT_BLUE}If you have any problems, please contact:${COLOR_END}"
echo -e "${GREEN}Yuhuang Hu${COLOR_END}"
echo -e "${GREEN}Email: yuhuang.hu@ini.uzh.ch${COLOR_END}"

# check user installation profile
echo -e "${RED}--------------------------------------------------${COLOR_END}"
if [ -f "$USER_DIR/admin-conf.sh" ]; then
    echo -e "[MESSAGE] Loading installation configuration."
    source "$USER_DIR/admin-conf.sh"
    echo "[MESSAGE] Install configuration loaded."
else
    echo "[MESSAGE] No install configuration found. Use default settings."
fi

# set update stage
if [ -f "$USER_DIR/admin-setup-stage.sh" ]; then
    touch $USER_DIR/admin-setup-stage.sh
    echo "#!/usr/bin/env bash" > $USER_DIR/admin-setup-stage.sh
    echo "CAME_BACK_FROM_REBOOT=0" >> "$USER_DIR/admin-setup-stage.sh"
    source $USER_DIR/admin-setup-stage.sh
fi

# set all options true if all enabled
if [ $ENABLE_ALL = true ]; then
    ENABLE_DEV=true
    ENABLE_JAVA=true
fi

# Functions

general_update()
{
    if sudo apt-get update ; then
        echo "Updated successfully."
    else
        echo "Some portion of the update is failed."
    fi

    # upgrade the system
    sudo apt-get upgrade

    # reboot the system
    echo "CAME_BACK_FROM_REBOOT=1" >> $USER_DIR/admin-setup-stage.sh
    reboot
}


if [ $DEBUG_MODE = false ]; then
    print_config

    if [ $ENABLE_INSTALL = true ]; then
        # setting up resource folder
        setup_env

        # setting up anaconda
        if [ $ENABLE_PYTHON = true ]; then
            setup_anaconda
        fi

        # setting up environment for deep learning
        config_dl

        # cleaning environment
        clean_env

        echo -e "${PURPLE}[MESSAGE] Selected Installation Completed.${COLOR_END}"
    else
        echo -e "${PURPLE}[MESSAGE] Installation interrupted.${COLOR_END}"
    fi
else
    print_config
    echo "[MESSAGE] Enable Install : $ENABLE_INSTALL"
fi
