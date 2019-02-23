# Registered User Guide

[![Ubuntu Version](https://img.shields.io/badge/Ubuntu%20Server-16.04-yellowgreen.svg)](https://launchpad.net/ubuntu/+mirror/releases.ubuntu.csg.uzh.ch-releases)
[![Anaconda Version](https://img.shields.io/badge/Miniconda-4.5-orange.svg)](https://repo.anaconda.com/miniconda/)
[![CUDA Version](https://img.shields.io/badge/CUDA-9.0-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![CUDA Version](https://img.shields.io/badge/CUDA-10.0-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![cuDNN Version](https://img.shields.io/badge/cuDNN-7.5-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![TensorFlow Version](https://img.shields.io/badge/TensorFlow-1.12-yellow.svg)](https://www.tensorflow.org/)
[![Keras Version](https://img.shields.io/badge/Keras-2.2.4-yellow.svg)](https://keras.io/)
[![PyTorch Version](https://img.shields.io/badge/PyTorch-1.0.1-yellow.svg)](http://pytorch.org/)
[![Chainer Version](https://img.shields.io/badge/Chainer-5.2.0-yellow.svg)](http://chainer.org/)
[![DMLC Version](https://img.shields.io/badge/xgboost-0.81-yellow.svg)](https://xgboost.readthedocs.io/en/latest/)
[![DMLC Version](https://img.shields.io/badge/mxnet-1.3.1-yellow.svg)](https://mxnet.incubator.apache.org/)


## General Message

__Please read this paragraph carefully before installation__

+ The machine is for everyone, so please do not dump big files on the machine.
If you need to connect an external hard disk on the machine, please talk to Yuhuang Hu.

+ It is intended to have separate workspace for everyone. So please setup your own Python
distribution (Anaconda is recommended) instead of messing with the system python.

+ No, you are not granted with `sudo` access.

+ If you are gonna install anything with `sudo`, or edit protected system folder (e.g. `/usr`, `/etc`, etc),
please tell Yuhuang before you do it.

+ If you want to access the machine outside of INI, then please connect INI's VPN.
Find the Wiki to setup.

+ It is intended that there is no GUI on these machines. And please don't install one as it would consume GPU power for rendering.

+ We have a calendar for managing usage of GPU machines, please send your Gmail (or similar) account to `yuhuang.hu@ini.uzh.ch`.
He will share the calendar to you.

+ You can only use the machine if you booked it. Otherwise, the current user has the
right of terminating your program without consulting with you.

+ Generally, you can still do some low-cost jobs when there is someone using the machine.
But please consult with the person.

+ Please do not `reboot` for no good reasons.

+ DO NOT UPDATE THE MACHINE VIA `sudo apt-get upgrade`

+ Please backup your data, experiment logs regularly. (__VERY IMPORTANT__)

+ Generally, your account will be deleted after you finished your project.
Your data will only be there if:
    + You still need to run some more experiments
    + You will use your account in later projects (but still, please remove out-dated data)

+ Your account will be deleted if it's no longer active and the admin has connected you and failed to get response.

+ DO NOT SHARE THE ACCOUNT WITH SOMEONE ELSE, THERE ARE SECURITY LESSONS IF YOU DID SO.

## Access The Machine

Access the machine via ssh

```
$ ssh yourusername@machinename.url
```

The username and password will be sent through email.

The available machine names are:

+ `zucca`
+ `zpaghetti`
+ `zabaglione`
+ `zampone`

For first time `*nix` user, checkout this useful [cheat sheet](https://www.cheatography.com/davechild/cheat-sheets/linux-command-line/) for commandline help.

## Setup Home

Run following scripts

```
$ mkdir $HOME/Downloads
$ mkdir $HOME/workspace
```

The above is preferred configuration so that all your downloaded files are
at `Downloads` and all your projects are at `workspace`

## Setup Deep Learning Environment

We have develop a working setup script for setting up your DL environment.
This script is a runnable script 

1. Clone the repo

    ```
    $ git clone https://github.com/duguyue100/NSC-GPU-GUIDE
    $ cd NSC-GPU-GUIDE/setup
    $ cp user-conf-template.sh user-conf.sh
    ```
2. Configure the template. The default configuration is a GPU setup with Python 2. TensorFlow, PyTorch and Keras are installed. The configuration file is as follows:

    ```bash
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
    ENABLE_PYTORCH=true
    # true to install Chainer
    ENABLE_CHAINER=false
    # true to install Keras
    ENABLE_KERAS=true
    # true to install DMLC packages (xgboost, mxnet)
    ENABLE_DMLC=false
    ```

    You can customize this file that fits you needs. _For example, if you want to install all the libraries, just change `ENABLE_DL_ALL` to `true`._

3. Run the installation script!

    ```
    $ ./user-setup.sh
    ```

4. The installation will take about 10min, grab a coffee and wait!

5. Source the new bash profile

    ```
    $ source $HOME/.bashrc
    ```

    And you are all set!


### Reset the environment

By running `user-setup-clean.sh`, you can hit the reset button of your environment.
This is for easy re-setup and a life-saver option if you messed up the environment somehow.

```
$ ./user-setup-clean.sh
```

## Contacts

Yuhuang Hu  
Email: yuhuang.hu@ini.uzh.ch
