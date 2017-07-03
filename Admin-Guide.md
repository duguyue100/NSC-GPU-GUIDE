# Admin Guide

This guide is intended for helping current and future machine administrators.

__To future admin: DO NOT RECORD SECURITY INFO HERE.__

[![Ubuntu Version](https://img.shields.io/badge/Ubuntu%20Server-16.04-yellowgreen.svg)](https://launchpad.net/ubuntu/+mirror/releases.ubuntu.csg.uzh.ch-releases)

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

## Install CUDA

1. Install NVIDIA Graphics Driver

```
```

[TODO] Comment on UEFI secure booting
