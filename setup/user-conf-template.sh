#!/usr/bin/env bash

# True if NVIDIA CUDA is installed.
ENABLE_GPU=true

# True if you need Python, support from Anaconda
ENABLE_PYTHON=false
# 2 is Python 2.7, 3 is Python 3.6
PYTHON_VERSION=2

# True if you want to install all libraries locally
ENABLE_DL_ALL=false

# true to install TensorFlow
ENABLE_TENSORFLOW=false
# true to install Theano
ENABLE_THEANO=false
# true to install PyTorch
ENABLE_PYTORCH=false
# true to install Keras
ENABLE_KERAS=false
# true to install DMLC packages (xgboost, mxnet)
ENABLE_DMLC=false
# true to install Caffe (without Python)
ENABLE_CAFFE=false
# true to install Caffe2 (without Python)
ENABLE_CAFFE2=false
# true to install Torch 7
ENABLE_TORCH=false
