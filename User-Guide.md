# Registered User Guide

[![Ubuntu Version](https://img.shields.io/badge/Ubuntu%20Server-16.04-yellowgreen.svg)](https://launchpad.net/ubuntu/+mirror/releases.ubuntu.csg.uzh.ch-releases)
[![Anaconda Version](https://img.shields.io/badge/Anaconda-4.4.0-orange.svg)](https://repo.continuum.io/archive/Anaconda2-4.4.0-Linux-x86_64.sh)
[![CUDA Version](https://img.shields.io/badge/CUDA-8.0-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![cuDNN Version](https://img.shields.io/badge/cuDNN-5.1-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![Theano Version](https://img.shields.io/badge/Theano-0.9.0-yellow.svg)](http://deeplearning.net/software/theano/)
[![TensorFlow Version](https://img.shields.io/badge/TensorFlow-1.2.1-yellow.svg)](https://www.tensorflow.org/)
[![Keras Version](https://img.shields.io/badge/Keras-2.0.5-yellow.svg)](https://keras.io/)
[![PyTorch Version](https://img.shields.io/badge/PyTorch-0.1.12-yellow.svg)](http://pytorch.org/)

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
right of terminate your program without consulting with you.

+ Generally, you can still do some low-cost jobs when there is someone using the machine.
But please consult with them.

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

For first time `*nix` user, checkout this useful [cheat sheet](https://www.cheatography.com/davechild/cheat-sheets/linux-command-line/) for commandline help.

## Setup Home

Run following scripts

```
$ mkdir $HOME/Downloads
$ mkdir $HOME/workspace
```

The above is preferred configuration so that all your downloaded files are
at `Downloads` and all your projects are at `workspace`

## Setup GPU configuration

[![CUDA Version](https://img.shields.io/badge/CUDA-8.0-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![cuDNN Version](https://img.shields.io/badge/cuDNN-5.1-blue.svg)](https://developer.nvidia.com/cuda-downloads)

1. Edit your `bash` configuration by:

```
$ nano $HOME/.bashrc
```

_Linux Tips: `nano` is a pretty nice editor in terminal, learn and use it!_

Append following text in your `$HOME/.bashrc`

```bash
export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
export CUDA_ROOT=/usr/local/cuda
```

2. Activate the change by:

```
$ source $HOME/.bashrc
```

## Setup Anaconda

[![Anaconda Version](https://img.shields.io/badge/Anaconda-4.4.0-orange.svg)](https://repo.continuum.io/archive/Anaconda2-4.4.0-Linux-x86_64.sh)

1. Download Anaconda

```
$ cd $HOME/Downloads
$ wget https://repo.continuum.io/archive/Anaconda2-4.4.0-Linux-x86_64.sh
```

2. Install Anaconda

```
$ bash Anaconda2-4.4.0-Linux-x86_64.sh
```

Follow the instructions and install Anaconda at your `HOME` folder (the default one).
Remember to type `yes` if Anaconda asks

```
Do you wish the installer to prepend the Anaconda2 install location
to PATH in your /home/username/.bashrc ? [yes|no]
```

3. Activate Anaconda by:

```
$ source $HOME/.bashrc
```

If success, you should see this message after running `python`

```
$ python
Python 2.7.13 |Anaconda custom (64-bit)| (default, Dec 20 2016, 23:09:15)
[GCC 4.4.7 20120313 (Red Hat 4.4.7-1)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
Anaconda is brought to you by Continuum Analytics.
Please check out: http://continuum.io/thanks and https://anaconda.org
>>>
```

4. Remove Anaconda installer after installation

```
$ rm $HOME/Downloads/Anaconda2-4.4.0-Linux-x86_64.sh
```

5. Update anaconda

```
$ conda update --all
```

## Use GPU for other languages

+ For Matlab, make sure that you use the interpreter without the GUI needed.
+ For Torch 7, they have some really amazing setup script, follow the instructions.
+ For Julia, the GPU part is rather messy now, please contact admin before installing
+ For C/C++/Fortran, `nvcc` should be in the PATH by default. You can find some examples before using it.
If you cannot compile your code, please let admin know.
+ For other languages, probably there is no complier/interpreter(s) for those language as well, please
consult admin before proceed.

## (Optional) Install Theano

[![Theano Version](https://img.shields.io/badge/Theano-0.9.0-yellow.svg)](http://deeplearning.net/software/theano/)

1. Install Theano by

```
$ pip install Theano -U
```

_Note: (Optional) This command will install a recent version of numpy, you can remove conda's numpy if necessary._

2. Setup `.theanorc`. This script will specify the GPU configuration

```
$ touch $HOME/.theanorc
$ nano $HOME/.theanorc
```

Append following contents in the file
```
[global]
floatX = float32
device = gpu0

[nvcc]
fastmath = True

[cuda]
root = /usr/local/cuda
```

Save and exit, you should be all set.

## (Optional) Install TensorFlow

[![TensorFlow Version](https://img.shields.io/badge/TensorFlow-1.2.1-yellow.svg)](https://www.tensorflow.org/)

1. Install TensorFlow by:

```
$ pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp27-none-linux_x86_64.whl
```

_Note: (Optional) The installation will install some packages. You could remove conda ones if necessary._

You are all set. 


## (Optional) Install Keras

[![Keras Version](https://img.shields.io/badge/Keras-2.0.5-yellow.svg)](https://keras.io/)

1. Install Keras by

```
$ pip install Keras -U
```

2. (Optional) In case you don't have `h5py` (necessary for save models)

```
$ conda install h5py
```

3. Setup Keras configuration

```
$ mkdir $HOME/.keras
$ touch $HOME/.keras/keras.json
```

If you are using TensorFlow backend (recommended), then edit `keras.json` as


```json
{
    "image_data_format": "channels_last",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "tensorflow"
}
```

If you are using Theano backend, then edit the `keras.json` as 

```json
{
    "image_data_format": "channels_first",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}
```

## (Optional) Install PyTorch

[![PyTorch Version](https://img.shields.io/badge/PyTorch-0.1.12-yellow.svg)](http://pytorch.org/)

Install PyTorch by `conda`

```
$ conda install pytorch torchvision cuda80 -c soumith
```

_Note: Install with caution as there are some failures in installation_

## Contacts

Yuhuang Hu  
Email: yuhuang.hu@ini.uzh.ch
