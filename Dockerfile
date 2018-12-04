FROM bitnami/minideb:stretch
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf && \
    echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf
RUN apt-get -y update && apt-get install -y --no-install-recommends build-essential gcc libc-dev wget g++ libffi-dev libxml2 unixodbc-dev default-libmysqlclient-dev libsqlite3-dev libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev wget && rm -rf /var/lib/apt/lists/*
RUN wget https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tar.xz --no-check-certificate
RUN tar xf Python-3.6.7.tar.xz
WORKDIR Python-3.6.7
RUN ./configure --enable-optimizations
RUN make -j 8
RUN make install
WORKDIR /
RUN rm Python-3.6.7.tar.xz
RUN rm -r Python-3.6.7
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache  -r requirements.txt
