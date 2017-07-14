# Admin Guide

This guide is intended for helping current and future machine administrators.

__To future admin: DO NOT RECORD SECURITY INFO HERE.__

[![Ubuntu Version](https://img.shields.io/badge/Ubuntu%20Server-16.04-yellowgreen.svg)](https://launchpad.net/ubuntu/+mirror/releases.ubuntu.csg.uzh.ch-releases)
[![CUDA Version](https://img.shields.io/badge/CUDA-8.0-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![cuDNN Version](https://img.shields.io/badge/cuDNN-5.1-blue.svg)](https://developer.nvidia.com/cuda-downloads)

## Setup the machine

Before you start, ask yourself if you've backup the machine.

1. Download Ubuntu Server from the website.
2. Burn a bootable CD or flash disk by following the instructions.
3. Configure BIOS settings for booting order .
4. Make sure you switch off the UEFI secure boot or enable driver compatibility so that 3rd party drivers can be installed properly.
5. Do not change the machine name as it's our internal alias of the machine.
6. Follow the instructions and setup default username and password.
7. Remove all existing contents in the machine. 
8. Install OpenSSH server if you are asked during the installation. Otherwise, install it after installation.
8. Install the system by following the rest of the instructions and restart the machine.

In principle, the SSH connection should work now.

## After Installation

1. Update the system

```
$ sudo apt-get update
$ sudo apt-get upgrade
```

Reboot machine after upgrade.

2. Install build tools

```
$ sudo apt-get install build-essential binutils
```

Reboot the machine after installation.

3. Install Utilities

    + CMake:

    ```
    $ sudo apt-get install cmake
    ```
    + (Optional) SSH

    ```
    $ sudo apt install openssh-server
    ```

    + Install latest Git

    ```
    $ sudo apt-add-repository ppa:git-core/ppa
    $ sudo apt-get update
    $ sudo apt-get install git
    ```

    + Install Java 8

    ```
    $ sudo add-apt-repository ppa:webupd8team/java
    $ sudo apt-get update
    $ sudo apt-get install oracle-java8-installer
    ```
    + Docker Support

    Follow the guide [here](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository)

    + Small utilities

    ```
    $ sudo apt-get install unzip
    ```

Reboot the machine after installation.

## Install CUDA

1. Install NVIDIA Graphics Driver

```
$ sudo add-apt-repository ppa:graphics-drivers/ppa
$ sudo apt-get update
$ sudo apt-get nvidia-375
$ sudo apt-get nvidia-modprobe  # for nvidia-docker
```

Reboot machine after installation.

_Note: There are number of reasons that the driver installation doesn't works, you need to debug it case-by-case._

_Note: You can install the driver from the file that is available at the official website. However play with caution._


2. Install CUDA

```
$ sudo sh cuda_8.0.61_375.26_linux.run 
$ sudo sh cuda_8.0.61.2_linux.run
```

3. Test CUDA Installation

```
$ cd $HOME/NVIDIA_CUDA-8.0_Samples/0_Simple/matrixMul
$ make
$ ./matrixMul
```

4. Install cuDNN

```
$ tar -zxvf cudnn-8.0-linux-x64-v5.1.tgz
$ cd cuda
$ sudo cp include/* /usr/local/cuda-8.0/include/
$ sudo cp lib64/* /usr/local/cuda-8.0/lib64/
```

## Add User

There are multiple ways of adding users, here is the easiest one I found:

```
$ sudo adduser username
$ sudo adduser username sudo
```

# Contacts

Yuhuang Hu  
Email: yuhuang.hu@ini.uzh.ch
