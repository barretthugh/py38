FROM barretthugh/py38

# Airflow
ARG AIRFLOW_VERSION=1.10.6
ARG AIRFLOW_USER_HOME=/usr/local/airflow
ARG AIRFLOW_DEPS=""
ARG PYTHON_DEPS=""
ENV AIRFLOW_HOME=${AIRFLOW_USER_HOME}

COPY jupyter/requirement.txt /requirement.txt
COPY jupyter/jupyter_notebook_config.py /root/.jupyter/
# for mirrors in China
# COPY jupyter/source.list /etc/apt/sources.list
# COPY jupyter/pip.conf /root/.pip/pip.conf

COPY script/entrypoint.sh /entrypoint.sh

RUN apt-get update \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow \
    && pip install apache-airflow[crypto,ssh${AIRFLOW_DEPS:+,}${AIRFLOW_DEPS}]==${AIRFLOW_VERSION} \
    && if [ -n "${PYTHON_DEPS}" ]; then pip install ${PYTHON_DEPS}; fi \
    && pip install -r /requirement.txt \
    && pip install Tushare \
    && chmod +x /entrypoint.sh


COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

RUN chown -R airflow: ${AIRFLOW_HOME}

EXPOSE 8080 5555 8793

USER airflow
WORKDIR ${AIRFLOW_HOME}

ENTRYPOINT ["/entrypoint.sh"]

CMD ["webserver"] # set default arg for entrypoint
