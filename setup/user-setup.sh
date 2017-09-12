#!/usr/bin/env bash

# Environment and parameters
USER_DIR=$(cd $(dirname $0); pwd)
RES_DIR=$USER_DIR/res
CONDA_BIN=$HOME/anaconda/bin
INSTALL_OPT="yes"
ENABLE_INSTALL=false
DEBUG_MODE=true

ENABLE_GPU=true

ENABLE_PYTHON=false
PYTHON_VERSION=2

ENABLE_DL_ALL=false
ENABLE_TENSORFLOW=false
ENABLE_THEANO=false
ENABLE_PYTORCH=false
ENABLE_KERAS=false
ENABLE_CHAINER=false
ENABLE_DMLC=false
ENABLE_CAFFE=false
ENABLE_CAFFE2=false
ENABLE_TORCH=false

# Color Profile
RED='\033[0;31m'
LIGHT_BLUE='\033[1;34m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
COLOR_END='\033[0m'

# Welcome Message 
echo -e "${LIGHT_BLUE}WELCOME TO GPU SETUP SCRIPT!${COLOR_END}"
echo -e "${LIGHT_BLUE}This script helps you setup your${COLOR_END}"
echo -e "${LIGHT_BLUE}desired Deep Learning environment${COLOR_END}"
echo -e "${LIGHT_BLUE}quickly and efficiently.${COLOR_END}"
echo -e "${LIGHT_BLUE}This script is hosted at https://github.com/duguyue100/NSC-GPU-GUIDE${COLOR_END}"
echo -e "${LIGHT_BLUE}Make pull requests or submit issues if you want to make changes.${COLOR_END}"
echo -e "${LIGHT_BLUE}Let's make setup easy again!${COLOR_END}"
echo -e "${LIGHT_BLUE}If you have any problems, please contact:${COLOR_END}"
echo -e "${GREEN}Yuhuang Hu${COLOR_END}"
echo -e "${GREEN}Email: yuhuang.hu@ini.uzh.ch${COLOR_END}"


# load configuration
echo -e "${RED}--------------------------------------------------${COLOR_END}"
if [ -f "$USER_DIR/user-conf.sh" ]; then
    echo -e "[MESSAGE] Loading installation configuration."
    source "$USER_DIR/user-conf.sh"
    echo "[MESSAGE] Install configuration loaded."
else
    echo "[MESSAGE] No install configuration found. Use default settings."
fi

# turn on all options if true
if [ $ENABLE_DL_ALL = true ]; then
    ENABLE_TENSORFLOW=true
    ENABLE_THEANO=true
    ENABLE_PYTORCH=true
    ENABLE_KERAS=true
    ENABLE_CHAINER=true
    ENABLE_DMLC=true
    ENABLE_CAFFE=true
    ENABLE_CAFFE2=true
    ENABLE_TORCH=true
fi

# turn off some options if there is no python support
if [ $ENABLE_PYTHON = false ]; then
    ENABLE_TENSORFLOW=false
    ENABLE_THEANO=false
    ENABLE_PYTORCH=false
    ENABLE_KERAS=false
    ENABLE_CHAINER=false
    ENABLE_DMLC=false
fi

# get anaconda link
if [ $ENABLE_PYTHON = true ]; then
    if [ $PYTHON_VERSION = 2 ]; then
        CONDA_URL="https://repo.continuum.io/archive/Anaconda2-4.4.0-Linux-x86_64.sh"
    elif [ $PYTHON_VERSION = 3 ]; then
        CONDA_URL="https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh"
    fi
fi

# setup download link to softwares
if [ $ENABLE_GPU = true ]; then
    # GPU options
    if [ $ENABLE_PYTHON = true ]; then
        if [ $PYTHON_VERSION = 2 ]; then
            TENSORFLOW_URL="https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp27-none-linux_x86_64.whl"
        elif [ $PYTHON_VERSION = 3 ]; then
            TENSORFLOW_URL="https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp36-cp36m-linux_x86_64.whl"
        fi
    fi
elif [ $ENABLE_GPU = false ]; then
    # CPU options
    if [ $ENABLE_PYTHON = true ]; then
        if [ $PYTHON_VERSION = 2 ]; then
            TENSORFLOW_URL="https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp27-none-linux_x86_64.whl"
        elif [ $PYTHON_VERSION = 3 ]; then
            TENSORFLOW_URL="https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp36-cp36m-linux_x86_64.whl"
        fi
    fi
fi 

# Functions

print_config()
{
    echo -e "${RED}[MESSAGE] Install Configuration:${COLOR_END}"
    echo "[MESSAGE] Working directory    : $USER_DIR"
    echo "[MESSAGE] Resources directory  : $RES_DIR"
    if [ $ENABLE_PYTHON = true ]; then
        echo "[MESSAGE] Python Enabled. Version: $PYTHON_VERSION"
    else
        echo "[MESSAGE] Python Disabled."
    fi
    if [ $ENABLE_GPU = true ]; then
        echo "[MESSAGE] GPU Setup."
    else
        echo "[MESSAGE] CPU Setup."
    fi
    echo -e "${RED}[MESSAGE] Deep Learning Libraries to install:${COLOR_END}"
    echo "[MESSAGE] TensorFlow                      : $ENABLE_TENSORFLOW"
    echo "[MESSAGE] Theano                          : $ENABLE_THEANO"
    echo "[MESSAGE] PyTorch                         : $ENABLE_PYTORCH"
    echo "[MESSAGE] Keras                           : $ENABLE_KERAS"
    echo "[MESSAGE] Chainer                         : $ENABLE_CHAINER"
    echo "[MESSAGE] DMLC (including xgboost, mxnet) : $ENABLE_DMLC"
    echo "[MESSAGE] Caffe (not supported yet)       : $ENABLE_CAFFE"
    echo "[MESSAGE] Caffe2 (not supported yet)      : $ENABLE_CAFFE2"
    echo "[MESSAGE] Torch (not supported yet)       : $ENABLE_TORCH"

    # waiting for installation
    echo "[MESSAGE] Do you confirm the installation options? (yes/no) [$INSTALL_OPT]"
    read input
    if [[ $input == "" ]]; then
        input=$INSTALL_OPT
    fi
    
    is_yes()
    {
        yesses={y,Y,yes,Yes,YES}
        if [[ $yesses =~ $1 ]]; then
            echo 1
        fi
    }

    if [[ $(is_yes $input) ]]; then
        ENABLE_INSTALL=true 
    fi
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
}

setup_env()
{
    echo -e "${CYAN}[MESSAGE] Setting up installation environment...${COLOR_END}"
    if [ ! -d "$RES_DIR" ]; then
        mkdir $RES_DIR
    fi

    if [ $ENABLE_GPU = true ]; then
        echo 'export PATH=$PATH:/usr/local/cuda/bin' >> $HOME/.bashrc
        echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64' >> $HOME/.bashrc
        echo 'export CUDA_ROOT=/usr/local/cuda' >> $HOME/.bashrc
    fi
    echo -e "${CYAN}[MESSAGE] Installation environment setup completed.${COLOR_END}"
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
}

setup_anaconda()
{
    echo -e "${CYAN}[MESSAGE] Setting up Python $PYTHON_VERSION ...${COLOR_END}"
    wget $CONDA_URL -O $RES_DIR/anaconda.sh
    # install anaconda
    bash $RES_DIR/anaconda.sh -b -p $HOME/anaconda
    # setup path
    echo 'export PATH="$HOME/anaconda/bin:$PATH"' >> $HOME/.bashrc

    # update conda
    $CONDA_BIN/conda update --all -y
    $CONDA_BIN/conda install -y libgcc
    $CONDA_BIN/conda clean -a -y  # clean up the cache
    echo -e "${CYAN}[MESSAGE] Python $PYTHON_VERSION is setup.${COLOR_END}"
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
}

clean_env()
{
    rm -rf $RES_DIR
    $CONDA_BIN/conda clean -a -y  # clean up the cache
}

config_dl()
{
    # common setup for python 2
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
    echo -e "${CYAN}[MESSAGE] Installing Deep Learning Libraries${COLOR_END}"
    if [ $ENABLE_PYTHON = true ]; then
        echo "[MESSAGE] Installing common packages for Python..."
        if [ $PYTHON_VERSION = 2 ]; then
            $CONDA_BIN/conda install -y h5py pydot graphviz
        elif [ $PYTHON_VERSION = 3]; then
            $CONDA_BIN/conda install -y h5py
        fi
        echo "[MESSAGE] Common packages for Python Installed..."
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
    fi

    # tensorflow
    if [ $ENABLE_TENSORFLOW = true ]; then
        echo "[MESSAGE] Installing TensorFlow..." 
        $CONDA_BIN/pip install -U $TENSORFLOW_URL
        echo "[MESSAGE] TensorFlow Installed."
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
    fi

    # theano
    if [ $ENABLE_THEANO = true ]; then
        echo "[MESSAGE] Installing Theano..."
        $CONDA_BIN/conda install -y theano
        if [ $ENABLE_GPU = true ]; then
            cp $USER_DIR/extras/theano/theanorc-gpu $HOME/.theanorc
        else
            cp $USER_DIR/extras/theano/theanorc-cpu $HOME/.theanorc
        fi
        echo "[MESSAGE] Theano Installed"
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
    fi

    # pytorch
    if [ $ENABLE_PYTORCH = true ]; then
        echo "[MESSAGE] Installing PyTorch..."
        if [ $ENABLE_GPU = true ]; then
            $CONDA_BIN/conda install -y pytorch torchvision cuda80 -c soumith
        elif [ $ENABLE_GPU = false ]; then
            $CONDA_BIN/conda install -y pytorch torchvision -c soumith
        fi
        echo "[MESSAGE] PyTorch installed."
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
    fi

    # Keras
    if [ $ENABLE_KERAS = true ]; then
        echo "[MESSAGE] Installing Keras..."
        $CONDA_BIN/pip install -U Keras
        mkdir $HOME/.keras
        cp $USER_DIR/extras/keras/keras-tensorflow.json $HOME/.keras/keras.json
        echo "[MESSAGE] Keras Installed."
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
    fi

    # Chainer
    if [ $ENABLE_CHAINER = true ]; then
        echo "[MESSAGE] Installing Chainer..."
        $CONDA_BIN/pip install -U chainer
        if [ $ENABLE_GPU = true ]; then
            $CONDA_BIN/pip install -U cupy
        fi
        echo "[MESSAGE] Chainer Installed."
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
    fi

    # DMLC
    if [ $ENABLE_DMLC = true ]; then
        echo "[MESSAGE] Installing DMLC packages (xgboost, mxnet)..."
        if [ $ENABLE_GPU = true ]; then
            $CONDA_BIN/pip install xgboost mxnet-cu80==0.11.0
        else
            $CONDA_BIN/pip install xgboost mxnet==0.11.0.rc3
        fi
        echo "[MESSAGE] DMLC packages Installed."
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
    fi

    # Caffe (no python)
    # Currently not supported

    # Caffe2 (no python)
    # Currently not supported
    
    # Torch
    # Currently not supported
    echo -e "${CYAN}[MESSAGE] Selected Deep Learning Libraries are installed.${COLOR_END}"
    echo -e "${RED}--------------------------------------------------${COLOR_END}"
}

# Work flow for setting up
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
