<img src="slides/images/Cambridge_logo.png" height=100>

# Workshops Cambridge - 2020

[![GitHub issues](https://img.shields.io/github/issues/miykael/workshop_pybrain.svg)](https://github.com/miykael/workshop_pybrain/issues/)
[![GitHub pull-requests](https://img.shields.io/github/issues-pr/miykael/workshop_pybrain.svg)](https://github.com/miykael/workshop_pybrain/pulls/)
[![GitHub contributors](https://img.shields.io/github/contributors/miykael/workshop_pybrain.svg)](https://GitHub.com/miykael/workshop_pybrain/graphs/contributors/)
[![GitHub Commits](https://github-basic-badges.herokuapp.com/commits/miykael/workshop_pybrain.svg)](https://github.com/miykael/workshop_pybrain/commits/master)
[![GitHub size](https://github-size-badge.herokuapp.com/miykael/workshop_pybrain.svg)](https://github.com/miykael/workshop_pybrain/archive/master.zip)
[![Docker Hub](https://img.shields.io/docker/pulls/miykael/workshop_pybrain.svg?maxAge=2592000)](https://hub.docker.com/r/miykael/workshop_pybrain/)
[![GitHub HitCount](http://hits.dwyl.io/miykael/workshop_pybrain.svg)](http://hits.dwyl.io/miykael/workshop_pybrain)

This repository contains everything you'll need for the [pybrain workshop](https://pybrain-workshop.github.io/) "MRI analysis in Python using Nipype, Nilearn and more" in Cambridge 2020, 9th to 10th of November.

There are three ways how you can profit from this workshop:

1. Via **Docker** (recommened): **Full** workshop experience, **interactive**, with **all software dependencies**.
2. Via **Conda (Python)**: **Almost full** workshop experience, **interactive**, with **only Python based** software dependencies (i.e. no support for FSL, SPM or ANTs)
3. Via **Jupyter NBViewer**: **Only visual exploration** of the workshop content, **no interactive** aspect.


## 1. Docker (recommended): Fully interactive

If you want the full experience, chose this option. This is also the one you should use if you participate in the November 2020 workshop. The only thing you'll need to install for this workshop is [Docker Desktop](https://www.docker.com/products/docker-desktop) (for more detailed instructions, see here [Mac](https://docs.docker.com/docker-for-mac/install/), [Windows](https://docs.docker.com/docker-for-windows/install/) and [Linux](https://hub.docker.com/search?q=&type=edition&offering=community&operating_system=linux)). 

Once Docker Desktop is set up, open a (docker) terminal and run the following command to verify if everything is good to go:

    docker run hello-world

### Download workshop content

Now, the only thing that's still missing is the actual workshop content. Do get this, use again a (docker) terminal and run the following command

    docker pull miykael/workshop_pybrain

Given that the whole workshop content is more than 8GB in size, the download of this container image might take a while.

### Access workshop content via Jupyter Notebooks

Once the container is pulled and on your system, you're all good to go. To access the workshop and open the Jupyter Notebook environment, please follow these steps:

1. Open a (docker) terminal and run the following command: `docker run -p 9999:8888 -it --rm miykael/workshop_pybrain`
2. Open [http://127.0.0.1:9999/?token=pybrain](http://127.0.0.1:9999/?token=pybrain) to access the workshop content. Should that not work, try [http://localhost:9999/?token=pybrain](http://localhost:9999/?token=pybrain).
3. Once Jupyter Notebook is open, click on the notebook `program.ipynb` - et voilà.

### Important notes

#### Don't loose your progress/notes

Everything you do within this docker container will be reset the moment you terminate the `docker run ...` command in step one (or you close this terminal). This means, any output file created within the docker container will be deleted. Similarly, any notes and changes within the notebooks will be lost. To prevent this from happening, either (1) manually download the changed notebooks (i.e. File > Download As > Notebook (.ipynb)) or (2) create a common folder within the container and on your system and allow a direct transition of data by adding the `-v` flag to the `docker run ...` command.

For example, something like `docker run -p 9999:8888 -it --rm -v /path/to/your/output_folder:/output miykael/workshop_pybrain`, where `/path/to/your/output_folder` should be an empty folder on your system, such as `/User/neuro/Desktop/output`.

Here's a more detailed explanation of this full command:

```bash
docker run \                   #  start up a container already built or pulled
    -p 9999:8888  \            #  port used, <local port>:<container port>
    -it  \                     #  run Docker interactively
    --rm  \                    #  remove the container when it exits
    -v /local_folder:/outputs  #  use local files <local path>:<container path>
    miykael/workshop_pybrain   #  use specified user/project:version container
```

#### Memory issues during workshop

It is possible that you might run into some `MemoryError` during the workshop. This has most likely nothing to do with your system, and probably is due to Docker Desktop and it's resource management. By default, Docker Desktop only 2 CPUs and 2 GB of RAM. You can change this default setting by opening Docker Desktop, go to Settings/Preferences > Resources. For a more detailed description see here for [Mac](https://docs.docker.com/docker-for-mac/#resources) and for [Windows](https://docs.docker.com/docker-for-windows/#resources).

#### Docker is messy, clean up space

Docker is a great tool to quickly provide a out-of-the-box running computer environment. However, if you're not carefull, it can quickly create a lot of unwanted files on your machine. To better understand these footprints and to clean out unwanted files after the workshop, please concider the following commands (run from within a (docker) terminal).

```bash
# Show all installed Docker images
docker images

# Remove a docker image
docker rmi -f $IMAGE_ID

# Remove all unused docker objects
docker system prune

# Remove everything (including images you might still need)
docker system prune -a
```

And should you chose to remove the `--rm` string in the `docker run ...` command, you can use the following commands to explore which containers are still open and potentially can be accessed once more (with their changes and additional outputs still present). Our advice is against such an approach as it can clutter your machine even quicker.

```bash
# Show running containers
docker ps

# Show all (also stopped) containers
docker ps -a

# Start a stopped container & attach to it
docker start -ia $CONTAINER_ID

# Remove a container
docker rm $CONTAINER_ID
```

## 2. Conda (Python): Almost fully interactive (Python only)

If you want to do the workshop without installing heavy neuroimaing software packages, such as FSL, SPM12 or ANTs and don't want to install Docker on your system, than you might be interested in this approach. By installing Python on your system (i.e. specifically Conda) and setting up the appropriate environment, you will be able to open all the Jupyter Notebooks and go through the whole content of the course. Except for the notebooks which depend on the heavy neuroimaing software packages, you should be able to run everything locally.

To get things up and running, please follow these steps:

1. Download and install either [miniconda](https://docs.conda.io/en/latest/miniconda.html) or [Anaconda](https://www.anaconda.com/products/individual) with a Python version of at least 3.6
2. Download the [`environment.yml`](https://raw.githubusercontent.com/miykael/workshop_pybrain/master/environment.yml) file (e.g. with right mouse click -> Save As). Make sure that the file ends with `.yml` and not `.txt`.
3. Open up a conda terminal (or any other terminal), and create a new conda environment with the following command: `conda env create -f /path/to/file/environment.yml` - For example ``conda env create -f ~/Downloads/environment.yml`
4. Download the notebooks in this repository via [this link](https://github.com/miykael/workshop_pybrain/archive/master.zip)) and unzip them to your prefered location, e.g. `Desktop/pybrain`.
5. Download the two datasets [adhd](https://www.dropbox.com/sh/wl0auzjfnp2jia3/AAChCae4sCHzB8GJ02VHGOYQa?dl=1) and [ds000114](https://www.dropbox.com/sh/s0m8iz8fer3j5el/AACMamy4DyTMHMBud1IVgEDka?dl=1) and put them into the workshop folder as well, e.g. at `Desktop/pybrain/adhd` and `Desktop/pybrain/ds000114`.
6. Next, open up a conda terminal (or any other terminal), activate the conda environment with `conda activate pybrain` (or on older conda environments with `source activate pybrain` for mac and linux and `activate pybrain` for windows).
7. Finally, via the terminal, move to the folder where you've put all the unzipped content of this workshop, e.g. with the command `cd ~/Desktop/pybrain` and run the command `jupyter notebook` from the folder that contains the `program.ipynb` notebook.

**Note**: This only provides you the notebooks from the workshop that are not already in the `nipype_tutorial`. You can download the notebooks for the Nipype section of this workshop directly from [here](https://github.com/miykael/nipype_tutorial).


## 3. Jupyter NBViewer: Visual inspection only

If you want to go through the content of this workshop without installing anything on your machine, you should chose this approach. To see all the notebooks and slides from this workshop, please use this [Jupyter NBviewer link](https://nbviewer.jupyter.org/github/miykael/workshop_pybrain/blob/master/program.ipynb).

**Note**: For the non-interactive version of the Nipype section of this workshop, please us [this link](https://miykael.github.io/nipype_tutorial/).