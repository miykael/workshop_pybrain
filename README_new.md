# Workshop Marburg - 2019

[![GitHub issues](https://img.shields.io/github/issues/peerherholz/workshop_marburg.svg)](https://github.com/peerherholz/workshop_marburg/issues/)
[![GitHub pull-requests](https://img.shields.io/github/issues-pr/peerherholz/workshop_marburg.svg)](https://github.com/peerherholz/workshop_marburg/pulls/)
[![GitHub contributors](https://img.shields.io/github/contributors/peerherholz/workshop_marburg.svg)](https://GitHub.com/peerherholz/workshop_marburg/graphs/contributors/)
[![GitHub Commits](https://github-basic-badges.herokuapp.com/commits/peerherholz/workshop_marburg.svg)](https://github.com/peerherholz/workshop_marburg/commits/master)
[![GitHub size](https://github-size-badge.herokuapp.com/peerherholz/workshop_marburg.svg)](https://github.com/peerherholz/workshop_marburg/archive/master.zip)
[![GitHub HitCount](http://hits.dwyl.io/peerherholz/workshop_marburg.svg)](http://hits.dwyl.io/peerherholz/workshop_marburg)
[![Docker Hub](https://img.shields.io/docker/pulls/peerherholz/workshop_marburg.svg?maxAge=2592000)](https://hub.docker.com/r/peerherholz/workshop_marburg/)
[<img src="https://img.shields.io/badge/Supported%20by-%20CONP%2FPCNO-red?link=https://conp.ca/">](https://conp.ca/)

This repository contains everything for the workshop in Marburg 2019. There are three ways that you can interact with its content:

## 1. Docker (recommended)

If you want to have the full experience, use the docker container `peerherholz/workshop_marburg`. It provides the computational environment to run the notebooks on any system with all necessary dependencies installed. To install [Docker](https://www.docker.com/) on your system, follow one of those links:

 - [Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntu/) or [Debian](https://docs.docker.com/engine/installation/linux/docker-ce/debian/)
 - [Windows 7/8/9/10](https://docs.docker.com/toolbox/toolbox_install_windows/) or [Windows 10Pro](https://docs.docker.com/docker-for-windows/install/)
 - [OS X (from El Capitan 10.11 on)](https://docs.docker.com/docker-for-mac/install/) or [OS X (before El Capitan 10.11)](https://docs.docker.com/toolbox/toolbox_install_mac/).

Once Docker is installed, open up the docker terminal and test if it works with the command: `docker run hello-world`

**Note:** Linux users might need to use ``sudo`` to run ``docker`` commands or follow the [post-installation steps](https://docs.docker.com/engine/installation/linux/linux-postinstall/).

Once docker is running on your system you can continue with downloading the docker image for this workshop. For this use the command:

`docker pull peerherholz/workshop_marburg`

Once the download finished, proceed with the following steps:

1. Run the following command in a terminal: ```docker run -it --rm -p 8888:8888 peerherholz/workshop_marburg```
1. Copy paste the link that looks like ```http://20f109eba8e4:8888/?token=0312c1ef3b61d7a44ff5346d3d150c23249a548850e13868``` into your webbrowser.
1. Replace the hash number ```20f109eba8e4``` after `http://` with `localhost` or your local IP (probably `192.168.99.100`) if you're on windows.
1. Once Jupyter Notebook is open, click on the `program.ipynb` notebook, and you're good to go.

And if you want to have **access to the output data created within the docker container**, add the command  `-v /path/to/your/output_folder:/output` before `peerherholz/workshop_marburg`, where `/path/to/your/output_folder` should be a free folder on your system, such as `/User/neuro/Desktop/output`.

## Some useful Docker Commands

    Show running containers
    $ docker ps

    Show all installed Docker images
    $ docker images

    Show all (also stopped) containers
    $ docker ps -a

    Remove a container
    $ docker rm $CONTAINER_ID

    Remove a docker image
    $ docker rmi -f $IMAGE_ID

    Start a stopped container & attach to it
    $ docker start -ia $CONTAINER_ID

**Note**: when you stop a container (Ctrl-C), and then re-execute above "docker run" command, you will end up with a second container. If you want to access your previous container (e.g. with downloaded data), you must reconnect to it (see "docker start -ia" command below).



## 2. Conda (if you want to install everything on your system yourself)

If you don't care about some of the software dependencies, or have them already installed on your system, you can use conda to create the necessary python environment to run the notebooks:

1. If you haven't yet, get conda on your system: https://conda.io/miniconda.html
2. Download the `environment.yml` file from [here].(https://github.com/peerherholz/workshop_marburg/blob/master/environment.yml)
3. Open up a conda terminal (or any other terminal), and create a new conda environment with the following command: `conda env create --name workshop --file /path/to/file/environment.yml`
4. Download the notebooks in this repository ([here](https://github.com/peerherholz/workshop_marburg/archive/master.zip)), save them in the desired location, i.e. (`Desktop/workshop`).
5. Download the three datasets [adhd](https://www.dropbox.com/sh/wl0auzjfnp2jia3/AAChCae4sCHzB8GJ02VHGOYQa?dl=1), [ds000114](https://www.dropbox.com/sh/s0m8iz8fer3j5el/AACMamy4DyTMHMBud1IVgEDka?dl=1) and [ds000228](https://drive.google.com/file/d/1TWMVjjsBzWJvOx_uq-YVbJU4Yw0Ob0Wh/view?usp=sharing) and put them into the workshop folder, i.e. (`Desktop/workshop`).
6. Open up a (docker) terminal, activate the conda environment with `source activate workshop` (for mac and linux) or with `activate workshop` (for windows), go into the folder where you saved the just downloaded notebooks (i.e. `Desktop/workshop`) and run the following command from the folder that contains the `program.ipynb` notebook: `jupyter notebook`

**Note**: This only provides you the notebooks from the workshop that are not already in the `nipype_tutorial`. Those notebooks you can download here: https://github.com/peerherholz/workshop_marburg


## 3. Jupyter NBViewer

All the notebooks (but not the slides) can be looked at via [Jupyter nbviewer](https://nbviewer.jupyter.org/github/PeerHerholz/workshop_marburg/blob/master/program.ipynb). Like this you can see everything but cannot really interact with the scripts or run the code.

## Support 
This work was supported in part by funding provided by [Brain Canada](https://braincanada.ca/), in partnership with [Health Canada](https://www.canada.ca/en/health-canada.html), for the [Canadian Open Neuroscience Platform initiative](https://conp.ca/).


[<img src="https://conp.ca/wp-content/uploads/elementor/thumbs/logo-2-o5e91uhlc138896v1b03o2dg8nwvxyv3pssdrkjv5a.png">](https://conp.ca/)
