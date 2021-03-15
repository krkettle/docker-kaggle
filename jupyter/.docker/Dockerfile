FROM python:3.8

RUN apt-get update && \
    apt-get -y install gosu

COPY requirements.txt /opt
COPY docker-entrypoint.sh /usr/local/bin

RUN pip3 install -r /opt/requirements.txt && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

CMD [ "jupyter", "notebook", "--ip=0.0.0.0", "--NotebookApp.token=''", "--allow-root" ]
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]