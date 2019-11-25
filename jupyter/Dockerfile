FROM barretthugh/py38

COPY jupyter/requirement.txt /requirement.txt
COPY jupyter/jupyter_notebook_config.py /root/.jupyter/
# for mirrors in China
# COPY jupyter/source.list /etc/apt/sources.list
# COPY jupyter/pip.conf /root/.pip/pip.conf

RUN apt-get update \
  && pip install -r /requirement.txt \
  && pip install Tushare \
  && pip install prompt_toolkit \
  && jupyter nbextension enable --py widgetsnbextension \
  && jupyter serverextension enable --py jupyterlab \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs \
  && npm --unsafe-perm i -g ijavascript \
  && ijsinstall --install=global \
  && npm i d3 crossfilter2 dc jquery melt highcharts \
  && rm -rf /var/cache/*

WORKDIR "/"

EXPOSE 8888
CMD ["jupyter", "lab", "--allow-root"]
