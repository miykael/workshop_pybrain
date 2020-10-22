# Creates the docker container for the workshop in Cambridge
# Run the container with the following command:
#   docker run -it --rm -p 8888:8888 miykael/workshop_cambridge

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
    && pip install  --no-cache-dir nitime \
                                   nibabel \
                                   nilearn==0.5.0a \
                                   pymvpa2 \
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
                                 /data/ds000114/derivatives/freesurfer/sub-01'

#------------------------------------------------
# Copy workshop notebooks into image and clean up
#------------------------------------------------

USER root

COPY ["notebooks", "/home/neuro/workshop/notebooks"]

COPY ["slides", "/home/neuro/workshop/slides"]

COPY ["program.ipynb", "/home/neuro/workshop/program.ipynb"]

COPY ["test_notebooks.py", "/home/neuro/workshop/test_notebooks.py"]

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
