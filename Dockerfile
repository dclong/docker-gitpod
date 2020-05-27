FROM dclong/jupyterhub-ds

RUN echo "$(date)" > /scripts/sys/version

RUN xinstall spark -ic -v 2.4.5 && xinstall pyspark -ic

RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

USER gitpod
RUN xinstall ipython -c \
    && xinstall svim -ic && nvim --headless +"call dein#install()" +qall \
    && xinstall pt -ic

RUN pip3 install -U --no-cache-dir \
    git+https://github.com/getpelican/pelican \
    pelican-render-math pelican-jupyter beautifulsoup4 typogrify

COPY scripts/ /scripts/
USER root
