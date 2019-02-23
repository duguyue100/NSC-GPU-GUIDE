#!/usr/bin/env bash

# True if NVIDIA CUDA is installed.
ENABLE_GPU=true
# specify CUDA VERSION, 9 for CUDA 9, 10 for CUDA 10
CUDA_VERSION=9

# True if you need Python, support from Anaconda
ENABLE_PYTHON=true
# 2 is Python 2.7, 3 is Python 3.6
PYTHON_VERSION=2

# True if you want to install all libraries locally
ENABLE_DL_ALL=false

# true to install TensorFlow
ENABLE_TENSORFLOW=true
# true to install PyTorch
ENABLE_PYTORCH=false
# true to install Chainer
ENABLE_CHAINER=false
# true to install Keras
ENABLE_KERAS=true
# true to install DMLC packages (xgboost, mxnet)
ENABLE_DMLC=false
