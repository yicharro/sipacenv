FROM python:3.8-buster

ENV PYTHONUNBUFFERED 1

RUN apt-get -y update && apt-get install -y libzbar-dev \
python3-dev \
libsasl2-dev \
python-dev \
libldap2-dev \
libssl-dev \
python3-ldap3 \
gunicorn \
libfontconfig \
wkhtmltopdf \
gettext && \
apt-get autoremove && \
apt-get clean

RUN pip3 install --upgrade pip

RUN mkdir /app
COPY requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

RUN echo "deb http://debian.uci.cu/debian stable main contrib non-free" > /etc/apt/sources.list

RUN mkdir -p /root/.pip/
RUN /bin/bash -c 'echo "[global]" > ~/.pip/pip.conf'
RUN /bin/bash -c 'echo "timeout = 120" >> ~/.pip/pip.conf'
RUN /bin/bash -c 'echo "index = http://nexus.prod.uci.cu/repository/pypi-all/pypi" >> ~/.pip/pip.conf'
RUN /bin/bash -c 'echo "index-url = http://nexus.prod.uci.cu/repository/pypi-all/simple" >> ~/.pip/pip.conf'
RUN /bin/bash -c 'echo "[install]" >> ~/.pip/pip.conf'
RUN /bin/bash -c 'echo "trusted-host = nexus.prod.uci.cu" >> ~/.pip/pip.conf'

RUN adduser --disabled-password --gecos '' sipacuser

WORKDIR /app
