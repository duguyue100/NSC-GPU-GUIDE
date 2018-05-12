#!/usr/bin/env bash

# True if NVIDIA CUDA is installed.
ENABLE_GPU=true

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
# true to install Caffe
ENABLE_CAFFE=false
# true to install Caffe2
ENABLE_CAFFE2=false
# true to install Torch 7
ENABLE_TORCH=false
