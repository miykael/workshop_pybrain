# Creates the docker container for the workshop in Cambridge
# Run the container with the following command:
#   docker run -p 8888:8888 -it --rm miykael/workshop_pybrain
# And then open the URL http://127.0.0.1:8888/?token=pybrain

FROM miykael/nipype_tutorial:2020

ARG DEBIAN_FRONTEND=noninteractive

USER root

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

RUN conda install -y -q --name neuro numpy=1.18 \
                                     scikit-learn==0.20 \
                                     bokeh \
                                     plotly \
                                     dipy \
                                     nbconvert=5 \
    && sync && conda clean -tipsy && sync \
    && bash -c "source activate neuro \
    && pip install --no-cache-dir atlasreader \
                                   fury \
                                   joblib \
                                   nitime \
                                   nibabel \
                                   git+https://github.com/nilearn/nilearn \
                                   pingouin==0.2.4 \
                                   matplotlib \
                                   nose \
                                   pybids==0.10.2 \
                                   scipy \
                                   tensorflow==2.2 \
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
             && datalad get -J 4 /data/ds000114/sub-0[123]/ses-test/anat/sub-0[123]_ses-test_T1w.nii.gz \
                                 /data/ds000114/sub-0[123]/ses-test/func/*fingerfootlips* \
                                 /data/ds000114/derivatives/freesurfer/sub-01 \
                                 /data/ds000114/derivatives/fmriprep/sub-01/ses-test/func/*fingerfootlips* \
                                 /data/ds000114/derivatives/fmriprep/sub-02/ses-test/func/*fingerfootlips* \
                                 /data/ds000114/derivatives/fmriprep/sub-03/ses-test/func/*fingerfootlips*'

RUN bash -c 'mv /data/ds000114/derivatives/fmriprep/sub-01/ses-test/func/sub-01_ses-test_task-fingerfootlips_bold_space-mni152nlin2009casym_preproc.nii.gz /data/ds000114/derivatives/fmriprep/sub-01/ses-test/func/sub-01_ses-test_task-fingerfootlips_space-MNI152nlin2009casym_desc-preproc_bold.nii.gz'

RUN bash -c 'mv /data/ds000114/derivatives/fmriprep/sub-02/ses-test/func/sub-02_ses-test_task-fingerfootlips_bold_space-mni152nlin2009casym_preproc.nii.gz /data/ds000114/derivatives/fmriprep/sub-02/ses-test/func/sub-02_ses-test_task-fingerfootlips_space-MNI152nlin2009casym_desc-preproc_bold.nii.gz'

RUN bash -c 'mv /data/ds000114/derivatives/fmriprep/sub-03/ses-test/func/sub-03_ses-test_task-fingerfootlips_bold_space-mni152nlin2009casym_preproc.nii.gz /data/ds000114/derivatives/fmriprep/sub-03/ses-test/func/sub-03_ses-test_task-fingerfootlips_space-MNI152nlin2009casym_desc-preproc_bold.nii.gz'

RUN cp /data/ds000114/task-fingerfootlips_events.tsv /data/ds000114/sub-01/ses-test/func/sub-01_ses-test_task-fingerfootlips_events.tsv

RUN cp /data/ds000114/task-fingerfootlips_events.tsv /data/ds000114/sub-02/ses-test/func/sub-02_ses-test_task-fingerfootlips_events.tsv

RUN cp /data/ds000114/task-fingerfootlips_events.tsv /data/ds000114/sub-03/ses-test/func/sub-03_ses-test_task-fingerfootlips_events.tsv

RUN bash -c 'rm -r /data/ds000114/*/ses-retest/*'

RUN bash -c 'rm -r /data/ds000114/derivatives/fmriprep/*/ses-retest/*'

RUN bash -c 'mv /data/ds000114/derivatives/fmriprep/sub-01/ses-test/func/sub-01_ses-test_task-fingerfootlips_bold_confounds.tsv /data/ds000114/derivatives/fmriprep/sub-01/ses-test/func/sub-01_ses-test_task-fingerfootlips_bold_desc-confounds_timeseries.tsv'

RUN bash -c 'mv /data/ds000114/derivatives/fmriprep/sub-02/ses-test/func/sub-02_ses-test_task-fingerfootlips_bold_confounds.tsv /data/ds000114/derivatives/fmriprep/sub-02/ses-test/func/sub-02_ses-test_task-fingerfootlips_bold_desc-confounds_timeseries.tsv'

RUN bash -c 'mv /data/ds000114/derivatives/fmriprep/sub-03/ses-test/func/sub-03_ses-test_task-fingerfootlips_bold_confounds.tsv /data/ds000114/derivatives/fmriprep/sub-03/ses-test/func/sub-03_ses-test_task-fingerfootlips_bold_desc-confounds_timeseries.tsv'

#------------------------------------------------
# Copy workshop notebooks into image and clean up
#------------------------------------------------

USER root

RUN curl -J -L -o /data/adhd_data.zip https://www.dropbox.com/sh/wl0auzjfnp2jia3/AAChCae4sCHzB8GJ02VHGOYQa?dl=1 \
    && mkdir /data/adhd \
    && unzip /data/adhd_data.zip -d /data/adhd/ -x / \
    && rm /data/adhd_data.zip

RUN chown -R neuro /data/adhd

RUN curl -J -L -o /data/ds000228_data.zip https://www.dropbox.com/sh/p25mxdxvh6queom/AACgoYuzr8Til-fim0wcwHwEa?dl=1 \
    && mkdir /data/ds000228 \
    && unzip /data/ds000228_data.zip -d /data/ds000228/ -x / \
    && rm /data/ds000228_data.zip

RUN chown -R neuro /data/ds000228

COPY ["program.ipynb", "/home/neuro/workshop/program.ipynb"]

RUN chown -R neuro /home/neuro

COPY ["notebooks", "/home/neuro/workshop/notebooks"]

COPY ["slides", "/home/neuro/workshop/slides"]

COPY ["test_notebooks.py", "/home/neuro/workshop/test_notebooks.py"]

RUN chown -R neuro /home/neuro/workshop

RUN rm -rf /opt/conda/pkgs/*

USER neuro

WORKDIR /home/neuro

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--NotebookApp.token=pybrain"]
