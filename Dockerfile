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
gettext

RUN apt-get autoremove && apt-get clean

RUN pip install --upgrade pip

RUN mkdir /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

WORKDIR /app
