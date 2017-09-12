# Registered User Guide

[![Ubuntu Version](https://img.shields.io/badge/Ubuntu%20Server-16.04-yellowgreen.svg)](https://launchpad.net/ubuntu/+mirror/releases.ubuntu.csg.uzh.ch-releases)
[![Anaconda Version](https://img.shields.io/badge/Anaconda-4.4.0-orange.svg)](https://repo.continuum.io/archive/Anaconda2-4.4.0-Linux-x86_64.sh)
[![CUDA Version](https://img.shields.io/badge/CUDA-8.0-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![cuDNN Version](https://img.shields.io/badge/cuDNN-6.0-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![Theano Version](https://img.shields.io/badge/Theano-0.9.0-yellow.svg)](http://deeplearning.net/software/theano/)
[![TensorFlow Version](https://img.shields.io/badge/TensorFlow-1.3-yellow.svg)](https://www.tensorflow.org/)
[![Keras Version](https://img.shields.io/badge/Keras-2.0.8-yellow.svg)](https://keras.io/)
[![PyTorch Version](https://img.shields.io/badge/PyTorch-0.2.0-yellow.svg)](http://pytorch.org/)
[![Chainer Version](https://img.shields.io/badge/Chainer-2.1.0-yellow.svg)](http://chainer.org/)
[![DMLC Version](https://img.shields.io/badge/xgboost-0.6.0-yellow.svg)](https://xgboost.readthedocs.io/en/latest/)
[![DMLC Version](https://img.shields.io/badge/mxnet-0.11.0-yellow.svg)](https://mxnet.incubator.apache.org/)


## General Message

__Please read this paragraph carefully before installation__

+ The machine is for everyone, so please do not dump big files on the machine.
If you need to connect an external hard disk on the machine, please talk to admin.

+ It is intended to have separate workspace for everyone. So please setup your own Python
distribution (Anaconda is recommended) instead of messing with system python.

+ Yes, you are granted with `sudo` access.

+ If you are gonna install anything with `sudo`, or edit protected system folder (e.g. `/usr`, `/etc`, etc),
please tell admin before you do it.

+ If you want to access the machine outside of INI, then please connect INI's VPN.
Find the Wiki to setup.

+ It is intended that there is no GUI on these machines. And please don't install one as it would consume GPU power for rendering.

+ `zsh` is awesome, but please __DON'T__ install and switch to it system wide.

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


## (Optional) Install Caffe

You can install Caffe with [Docker](https://www.docker.com/).
In fact, you are suggested to do it this way as Caffe is somehow always in rapid development.

Check [this page](https://github.com/BVLC/caffe/tree/master/docker) for more information.
For using official docker:

```
$ sudo nvidia-docker run -ti bvlc/caffe:gpu caffe --version
```

## Contacts

Yuhuang Hu  
Email: yuhuang.hu@ini.uzh.ch
