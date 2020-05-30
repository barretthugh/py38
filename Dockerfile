FROM python:3.8.2-buster

COPY requirement.txt /requirement.txt
# for mirrors in China
# COPY source.list /etc/apt/sources.list
# COPY pip.conf /root/.pip/pip.conf

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Define en_US.
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

ENV TZ=Asia/Shanghai

RUN set -ex \
    && buildDeps=' \
        freetds-dev \
        libkrb5-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        libpq-dev \
    ' \
    && apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends \
        $buildDeps \
        freetds-bin \
        build-essential \
        default-libmysqlclient-dev \
        apt-utils \
        curl \
        libpq5 \
        rsync \
        netcat \
        locales \
        unzip \
        tzdata \
        libnss3-dev \
        iproute2 \
        net-tools \
        iputils-ping \
        git \
    && sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && pip install -U pip setuptools wheel \
    && pip install -r /requirement.txt \
    && curl "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb?src=0&filename=google-chrome-stable_current_amd64.deb" -o /chrome.deb \
    && dpkg -i /chrome.deb || apt-get install -yf \
    && rm /chrome.deb \
    && curl https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_linux64.zip -o /usr/local/bin/chromedriver.zip \
    && unzip /usr/local/bin/chromedriver.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/chromedriver \
    && rm /usr/local/bin/chromedriver.zip \
    && apt-get purge --auto-remove -yqq $buildDeps \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shangshai" > /etc/timezone
