# Creates the docker container for the workshop in Cambridge
# Run the container with the following command:
#   docker run -it --rm -p 8888:8888 peerherholz/workshop_marburg

FROM miykael/nipype_tutorial:latest

ARG DEBIAN_FRONTEND=noninteractive

#--------------------------------------
# Update system applications for PyMVPA
#--------------------------------------

USER root

# Install software for PyMVPA
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           swig \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#------------------------------------
# Install HarvardOxford atlas via FSL
#------------------------------------

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           fsl-harvard-oxford-atlases \
           fsl-harvard-oxford-cortical-lateralized-atlas \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#---------------------------------
# Update conda environment 'neuro'
#---------------------------------

USER neuro

RUN conda install -y -q --name neuro bokeh \
                                     holoviews \
                                     plotly \
                                     dipy \
                                     vtk \
    && sync && conda clean -tipsy && sync \
    && bash -c "source activate neuro \
    && pip install  --no-cache-dir atlasreader \
                                   fury \
                                   nitime \
                                   nibabel \
                                   nilearn \
                                   nistats \
                                   pingouin==0.2.4 \
                                   matplotlib==3.0.3 \
                                   nose \
                                   git+https://github.com/bids-standard/pybids.git \
                                   pymvpa2 \
                                   scipy==1.2 \
                                   tensorflow \
                                   keras \
                                   vtk" \
    && rm -rf ~/.cache/pip/* \
    && sync

#-----------------------------------------------
# Download workshop required part of the dataset
#-----------------------------------------------

USER neuro

RUN bash -c 'source activate neuro \
             && cd /data/ds000114 \
             && datalad get -J 4 /data/ds000114/sub-0[234789]/ses-test/anat/sub-0[234789]_ses-test_T1w.nii.gz \
                                 /data/ds000114/sub-0[234789]/ses-test/func/*fingerfootlips* \
                                 /data/ds000114/derivatives/freesurfer/sub-01 \
                                 /data/ds000114/derivatives/fmriprep/sub-01/ses-test/func/*fingerfootlips*'

#------------------------------------------------
# Copy workshop notebooks into image and clean up
#------------------------------------------------

USER root

COPY ["notebooks", "/home/neuro/workshop/notebooks"]

COPY ["slides", "/home/neuro/workshop/slides"]

COPY ["program.ipynb", "/home/neuro/workshop/program.ipynb"]

COPY ["test_notebooks.py", "/home/neuro/workshop/test_notebooks.py"]

RUN curl -J -L -o /data/ds000228.zip https://www.dropbox.com/s/ue1wuoaryvp6iw1/ds000228.zip?dl=0 \
    && mkdir /data/ds000228 \
    && unzip /data/ds000228.zip -d /data/ds000228/ -x / \
    && rm /data/ds000228.zip

RUN chown -R neuro /data/ds000228

RUN curl -J -L -o /data/adhd_data.zip https://www.dropbox.com/sh/wl0auzjfnp2jia3/AAChCae4sCHzB8GJ02VHGOYQa?dl=1 \
    && mkdir /data/adhd \
    && unzip /data/adhd_data.zip -d /data/adhd/ -x / \
    && rm /data/adhd_data.zip

RUN chown -R neuro /data/adhd

RUN chown -R neuro /home/neuro/workshop

RUN rm -rf /opt/conda/pkgs/*

USER neuro

RUN mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \"0.0.0.0\" > ~/.jupyter/jupyter_notebook_config.py

WORKDIR /home/neuro

CMD ["jupyter-notebook"]
