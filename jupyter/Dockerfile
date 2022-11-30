FROM barretthugh/py38

COPY jupyter/requirement.txt /requirement.txt
COPY jupyter/jupyter_notebook_config.py /root/.jupyter/
# for mirrors in China
# COPY jupyter/source.list /etc/apt/sources.list
# COPY jupyter/pip.conf /root/.pip/pip.conf

RUN apt-get update \
  && apt install -yqq libpq-dev \
  && pip install -r /requirement.txt \
  && pip install Tushare \
  && pip uninstall prompt_toolkit -y \
  && pip install prompt-toolkit==2.0.10 \
  && jupyter nbextension enable --py widgetsnbextension \
  && jupyter serverextension enable --py jupyterlab \
  && rm -rf /var/cache/*

WORKDIR "/"

EXPOSE 8888
CMD ["jupyter", "lab", "--allow-root"]
