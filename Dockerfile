# Creates the docker container for the workshop in Cambridge
# Run the container with the following command:
#   docker run -p 8888:8888 -it --rm miykael/workshop_pybrain
# And then open the URL http://127.0.0.1:8888/?token=pybrain

FROM neurodebian:stretch-non-free

USER root

ARG DEBIAN_FRONTEND="noninteractive"

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    ND_ENTRYPOINT="/neurodocker/startup.sh"
RUN export ND_ENTRYPOINT="/neurodocker/startup.sh" \
    && apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           apt-utils \
           bzip2 \
           ca-certificates \
           curl \
           locales \
           unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG="en_US.UTF-8" \
    && chmod 777 /opt && chmod a+s /opt \
    && mkdir -p /neurodocker \
    && if [ ! -f "$ND_ENTRYPOINT" ]; then \
         echo '#!/usr/bin/env bash' >> "$ND_ENTRYPOINT" \
    &&   echo 'set -e' >> "$ND_ENTRYPOINT" \
    &&   echo 'export USER="${USER:=`whoami`}"' >> "$ND_ENTRYPOINT" \
    &&   echo 'if [ -n "$1" ]; then "$@"; else /usr/bin/env bash; fi' >> "$ND_ENTRYPOINT"; \
    fi \
    && chmod -R 777 /neurodocker && chmod a+s /neurodocker

ENTRYPOINT ["/neurodocker/startup.sh"]

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           convert3d \
           ants \
           fsl \
           fsl-harvard-oxford-atlases \
           fsl-harvard-oxford-cortical-lateralized-atlas \
           gcc \
           g++ \
           graphviz \
           tree \
           git-annex-standalone \
           vim \
           emacs-nox \
           nano \
           less \
           ncdu \
           tig \
           git-annex-remote-rclone \
           octave \
           netbase \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i '$isource /etc/fsl/fsl.sh' $ND_ENTRYPOINT

ENV FORCE_SPMMCR="1" \
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu:/opt/matlabmcr-2010a/v713/runtime/glnxa64:/opt/matlabmcr-2010a/v713/bin/glnxa64:/opt/matlabmcr-2010a/v713/sys/os/glnxa64:/opt/matlabmcr-2010a/v713/extern/bin/glnxa64" \
    MATLABCMD="/opt/matlabmcr-2010a/v713/toolbox/matlab"
RUN export TMPDIR="$(mktemp -d)" \
    && apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           bc \
           libncurses5 \
           libxext6 \
           libxmu6 \
           libxpm-dev \
           libxt6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Downloading MATLAB Compiler Runtime ..." \
    && curl -sSL --retry 5 -o /tmp/toinstall.deb http://mirrors.kernel.org/debian/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb \
    && dpkg -i /tmp/toinstall.deb \
    && rm /tmp/toinstall.deb \
    && apt-get install -f \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL --retry 5 -o "$TMPDIR/MCRInstaller.bin" https://dl.dropbox.com/s/zz6me0c3v4yq5fd/MCR_R2010a_glnxa64_installer.bin \
    && chmod +x "$TMPDIR/MCRInstaller.bin" \
    && "$TMPDIR/MCRInstaller.bin" -silent -P installLocation="/opt/matlabmcr-2010a" \
    && rm -rf "$TMPDIR" \
    && unset TMPDIR \
    && echo "Downloading standalone SPM ..." \
    && curl -fsSL --retry 5 -o /tmp/spm12.zip https://www.fil.ion.ucl.ac.uk/spm/download/restricted/utopia/previous/spm12_r7219_R2010a.zip \
    && unzip -q /tmp/spm12.zip -d /tmp \
    && mkdir -p /opt/spm12-r7219 \
    && mv /tmp/spm12/* /opt/spm12-r7219/ \
    && chmod -R 777 /opt/spm12-r7219 \
    && rm -rf /tmp/spm* \
    && /opt/spm12-r7219/run_spm12.sh /opt/matlabmcr-2010a/v713 quit \
    && sed -i '$iexport SPMMCRCMD=\"/opt/spm12-r7219/run_spm12.sh /opt/matlabmcr-2010a/v713 script\"' $ND_ENTRYPOINT

RUN test "$(getent passwd neuro)" || useradd --no-user-group --create-home --shell /bin/bash neuro

USER neuro

WORKDIR /home/neuro

ENV CONDA_DIR="/opt/miniconda-latest" \
    PATH="/opt/miniconda-latest/bin:$PATH"
RUN export PATH="/opt/miniconda-latest/bin:$PATH" \
    && echo "Downloading Miniconda installer ..." \
    && conda_installer="/tmp/miniconda.sh" \
    && curl -fsSL --retry 5 -o "$conda_installer" https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash "$conda_installer" -b -p /opt/miniconda-latest \
    && rm -f "$conda_installer" \
    && conda update -yq -nbase conda \
    && conda config --system --prepend channels conda-forge \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && sync && conda clean --all && sync \
    && conda create -y -q --name neuro \
    && conda install -y -q --name neuro \
           "python=3.7" \
           "pytest" \
           "jupyter" \
           "jupyterlab" \
           "jupyter_contrib_nbextensions" \
           "traits" \
           "pandas" \
           "matplotlib" \
           "scikit-image" \
           "seaborn" \
           "nbformat" \
           "nb_conda" \
           "numpy=1.18" \
           "scikit-learn==0.20" \
           "bokeh" \
           "plotly" \
           "dipy" \
           "nbconvert=5" \
           "scipy=1.4.1" \
    && sync && conda clean --all && sync \
    && bash -c "source activate neuro \
    && pip install --no-cache-dir  \
             "https://github.com/nipy/nipype/tarball/master" \
             "datalad[full]" \
             "nipy" \
             "duecredit" \
             "nbval" \
             "niflow-nipype1-workflows" \
             "atlasreader" \
             "fury" \
             "joblib" \
             "nitime" \
             "nibabel" \
             "git+https://github.com/nilearn/nilearn" \
             "pingouin==0.2.4" \
             "nose" \
             "pybids==0.10.2" \
             "tensorflow==2.3" \
             "keras" \
             "vtk" \
    && jupyter nbextension enable exercise2/main && jupyter nbextension enable spellchecker/main" \
    && rm -rf ~/.cache/pip/* \
    && rm -rf /opt/conda/pkgs/* \
    && sync \
    && sed -i '$isource activate neuro' $ND_ENTRYPOINT

ENV LD_LIBRARY_PATH="/opt/miniconda-latest/envs/neuro:"

USER root

RUN printf "[user]\n\tname = miykael\n\temail = michaelnotter@hotmail.com\n" > ~/.gitconfig \
    && mkdir /data && chmod 777 /data && chmod a+rw /data \
    && mkdir /output && chmod 777 /output && chmod a+rw /output

RUN curl -J -L -o /data/ds000114_data.zip https://www.dropbox.com/sh/h29g7td8l97q2qn/AACrWLT5OxAN9y694O3PpQkJa?dl=1 \
    && mkdir /data/ds000114 \
    && unzip /data/ds000114_data.zip -d /data/ds000114/ -x / \
    && rm /data/ds000114_data.zip \
    && chown -R neuro /data/ds000114

RUN curl -J -L -o /data/adhd_data.zip https://www.dropbox.com/sh/eifmbxdr5ayoca3/AADaRT2sjmy3RJiN01w6AMxda?dl=1 \
    && mkdir /data/adhd \
    && unzip /data/adhd_data.zip -d /data/adhd/ -x / \
    && rm /data/adhd_data.zip \
    && chown -R neuro /data/adhd

RUN curl -J -L -o /data/ds000228_data.zip https://www.dropbox.com/sh/a2uyyln3jgsxueq/AABOaUv5iDeHyFGosaFJeqW8a?dl=1 \
    && mkdir /data/ds000228 \
    && unzip /data/ds000228_data.zip -d /data/ds000228/ -x / \
    && rm /data/ds000228_data.zip \
    && chown -R neuro /data/ds000228

COPY workshop /home/neuro/workshop

RUN mkdir -p ~/.jupyter && echo c.NotebookApp.ip = \"0.0.0.0\" > ~/.jupyter/jupyter_notebook_config.py \
    && chown -R neuro /home/neuro/workshop \
    && chmod -R 777 /home/neuro/workshop

WORKDIR /home/neuro/workshop

USER neuro

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--NotebookApp.token=pybrain"]
