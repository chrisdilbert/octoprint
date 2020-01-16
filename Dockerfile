
FROM python:2.7
EXPOSE 5000
LABEL maintainer "chrisdilbert at  gmail dot com"

ARG tag=master

WORKDIR /opt/octoprint

#Create an octoprint user
RUN useradd -ms /bin/bash octoprint && adduser octoprint dialout
RUN chown octoprint:octoprint /opt/octoprint
USER octoprint
#This fixes issues with the volume command setting wrong permissions
RUN mkdir /home/octoprint/.octoprint

#Install Octoprint
RUN git clone --branch $tag https://github.com/foosel/OctoPrint.git /opt/octoprint \
  && virtualenv venv \
	&& ./venv/bin/python setup.py install

VOLUME /home/octoprint/.octoprint

CMD ["/opt/octoprint/venv/bin/octoprint", "serve"]
