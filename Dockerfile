FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


RUN apt update

RUN apt install -y libexpat1-dev \
    libssl-dev \
    #libgnome2-canvas-perl \
    libcairo2-dev \
    libpango1.0-dev \
    libgtk2.0-dev	\
    libgnomecanvas2-dev \
    libcanberra-gtk-module

RUN apt-get install -y wget curl gnupg software-properties-common 

#  GDAL:
#  we build our own gdal for the source code version, 
#  but for the binary version the apt-get version seems to work.
#  next two commands from http://www.sarasafavi.com/installing-gdalogr-on-ubuntu.html
RUN add-apt-repository ppa:ubuntugis/ppa && apt-get update -y
RUN apt-get install -y gdal-bin
RUN apt-get install -y libkml-dev libfreexl-dev libogdi-dev
RUN apt-get install -y libgdal-dev sqlite3

# Download and install the binary biodiverse
RUN cd /opt && \
    wget https://github.com/shawnlaffan/biodiverse/releases/download/r4.3/biodiverse_4.3_ubuntu.tar && \
    tar -xvf biodiverse*.tar && \
    rm biodiverse*.tar && \
    mv biodiverse* biodiverse

ENTRYPOINT exec /opt/biodiverse/BiodiverseGUI_4.3_linux "$@"