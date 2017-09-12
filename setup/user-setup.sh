#!/usr/bin/env bash

# Environment and parameters
USER_DIR=$(cd $(dirname $0); pwd)
RES_DIR=$USER_DIR/nsc_res
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
ENABLE_DMLC=false
ENABLE_CAFFE=false
ENABLE_CAFFE2=false
ENABLE_TORCH=false

# load configuration
"$USER_DIR/user-conf.sh"

# turn on all options if true
if [ $ENABLE_DL_ALL = true ]; then
    ENABLE_TENSORFLOW=true
    ENABLE_THEANO=true
    ENABLE_PYTORCH=true
    ENABLE_KERAS=true
    ENABLE_DMLC=true
    ENABLE_CAFFE=true
    ENABLE_CAFFE2=true
    ENABLE_TORCH=true
fi

# turn off some options if there is no python support
if [ $ENABLE_PYTHON = false]; then
    ENABLE_TENSORFLOW=false
    ENABLE_THEANO=false
    ENABLE_PYTORCH=false
    ENABLE_KERAS=false
    ENABLE_DMLC=false
fi

# get anaconda link
if [ $ENABLE_PYTHON = true]; then
    if [ $PYTHON_VERSION = 2]; then
        CONDA_URL="https://repo.continuum.io/archive/Anaconda2-4.4.0-Linux-x86_64.sh"
    elif [ $PYTHON_VERSION = 3]; then
        CONDA_URL="https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh"
    fi
fi

# setup download link to softwares
if [ $ENABLE_GPU = true]; then
    # GPU options
    if [ $ENABLE_PYTHON = true]; then
        if [ $PYTHON_VERSION = 2]; then
            TENSORFLOW_URL="https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp27-none-linux_x86_64.whl"
        elif [ $PYTHON_VERSION = 3]; then
            TENSORFLOW_URL="https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp36-cp36m-linux_x86_64.whl"
        fi
    fi
elif [$ENABLE_GPU = false]; then
    # CPU options
    if [ $ENABLE_PYTHON = true]; then
        if [ $PYTHON_VERSION = 2]; then
            TENSORFLOW_URL="https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp27-none-linux_x86_64.whl"
        elif [ $PYTHON_VERSION = 3]; then
            TENSORFLOW_URL="https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.3.0-cp36-cp36m-linux_x86_64.whl"
        fi
    fi
fi 

# Functions

print_config()
{
    echo "[MESSAGE] Install Configuration:"
    echo "[MESSAGE] Working directory: $USER_DIR"
    echo "[MESSAGE] Resources directory: $RES_DIR"
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
    echo "[MESSAGE] Deep Learning Libraries to install:"
    echo "[MESSAGE] TensorFlow: $ENABLE_TENSORFLOW"
    echo "[MESSAGE] Theano: $ENABLE_THEANO"
    echo "[MESSAGE] PyTorch: $ENABLE_PYTORCH"
    echo "[MESSAGE] DMLC (including xgboost, mxnet): $ENABLE_DMLC"
    echo "[MESSAGE] Caffe: $ENABLE_CAFFE"
    echo "[MESSAGE] Caffe2: $ENABLE_CAFFE2"
    echo "[MESSAGE] Torch: $ENABLE_TORCH"

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
        $ENABLE_INSTALL=true 
    fi
}

setup_en()
{
    echo "[MESSAGE] Setting up installation environment"
    if [ ! -d "$RES_DIR" ]; then
        mkdir $RES_DIR
    fi
}

setup_anaconda()
{
    echo "[MESSAGE] Setting up Python $PYTHON_VERSION"
    wget --quiet $CONDA_URL -O $RES_DIR/anaconda.sh
    # install anaconda 2
    bash $RES_DIR/anaconda.sh -b -p
    # TODO: setup path

    # update conda
    conda update --all -y
    conda install -y libgcc
    conda clean -a -y  # clean up the cache
}

clean_env()
{
    rm -rf $USER_DIR
}

config_dl()
{
    # common setup for python 2
    if [ $ENABLE_PYTHON = true ]; then
        echo "[MESSAGE] Installing common packages for Python..."
        if [ $PYTHON_VERSION = 2 ]; then
            conda install -y h5py pydot graphviz
        elif [ $PYTHON_VERSION = 3]; then
            conda install -y h5py
        fi
        echo "[MESSAGE] Common packages for Python Installed..."
    fi

    # tensorflow
    if [ $ENABLE_TENSORFLOW = true ]; then
        echo "[MESSAGE] Installing TensorFlow..." 
        pip install -U $TENSORFLOW_URL
        echo "[MESSAGE] TensorFlow Installed."
    fi

    # theano
    if [ $ENABLE_THEANO = true ]; then
        echo "[MESSAGE] Installing Theano..."
        conda install -y theano
        echo "[MESSAGE] Theano Installed"
    fi

    # pytorch
    if [ $ENABLE_PYTORCH = true ]; then
        echo "[MESSAGE] Installing PyTorch..."
        if [ $ENABLE_GPU = true ]; then
            conda install -y pytorch torchvision cuda80 -c soumith
        elif [ $ENABLE_GPU = false ]; then
            conda install -y pytorch torchvision -c soumith
        fi
        echo "[MESSAGE] PyTorch installed."
    fi

    # Keras
    if [ $ENABLE_KERAS = true ]; then
        echo "[MESSAGE] Installing Keras..."
        pip install -U Keras
        echo "[MESSAGE] Keras Installed."
    fi

    # DMLC

    # Caffe (no python)

    # Caffe2 (no python)
    
    # Torch
}

# Workflow for setting up
if [ $DEBUG_MODE = false ]; then
    print_config

    if [ $ENABLE_INSTALL = true ]; then
        # setting up resource folder
        setup_en

        # setting up anaconda
        if [ $ENABLE_PYTHON = true ]; then
            setup_anaconda
        fi

        # setting up environment for deep learning
        config_dl

        # cleaning environment
        clean_env
    else
        echo "[MESSAGE] Installation interrupted."
    fi
else
    print_config
fi
