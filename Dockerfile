FROM python:3.4

MAINTAINER Marcin Matląg <marcin.matlag@gmail.com>

ENV MAILMAN_HOME /data
ARG user=mailman
ARG group=mailman
ARG uid=999
ARG gid=999

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${MAILMAN_HOME}" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

#ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update;  apt-get -y install tcpdump


COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt

COPY run.sh /
RUN chown ${user}:${group} run.sh
RUN chmod 750 /run.sh

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY mailman_supervisord.conf /etc/supervisor/conf.d/ 
COPY postfix_supervisord.conf /etc/supervisor/conf.d/

COPY mailman_proxy.sh /usr/local/bin
RUN chmod +rx /usr/local/bin/mailman_proxy.sh

COPY generate_mailman_conf.py /usr/local/bin
RUN chmod +x /usr/local/bin/generate_mailman_conf.py

#COPY postfix_proxy.sh /usr/local/bin
#RUN chmod +x /usr/local/bin/postfix_proxy.sh

WORKDIR ${MAILMAN_HOME}

USER ${user}

VOLUME "$MAILMAN_HOME"

EXPOSE 8024
EXPOSE 8001

USER root

#CMD /usr/bin/supervisord 
CMD /run.sh

