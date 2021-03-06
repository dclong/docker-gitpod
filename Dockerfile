# NAME: dclong/gitpod
FROM dclong/jupyterhub-ds
# GIT: https://github.com/dclong/docker-jupyterhub-ds.git

RUN xinstall spark -ic --loc /opt && pip3 install -U --no-cache-dir pyspark findspark
RUN pip3 install -U --no-cache-dir \
    pelican pelican-render-math pelican-jupyter \
    beautifulsoup4 typogrify

RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

USER gitpod
WORKDIR /home/gitpod/
RUN xinstall ipython -c \
    && xinstall svim -ic && nvim --headless +"call dein#install()" +qall \
    && xinstall pt -ic

COPY scripts/ /scripts/
#COPY settings/settings.json .gitpod-code/User/settings.json
USER root
