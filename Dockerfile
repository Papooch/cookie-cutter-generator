FROM ubuntu:22.04

###################
# 📥 Install Libs #
###################
RUN apt-get update
RUN apt-get install -y wget

# Libs needed for OpenSCAD
RUN apt-get install -y libfuse2 libopengl0 libglx0 libgl1 libegl1-mesa

# Xvfb needed to simulate GUI
# - for Inkscape
# - to export PNG preview from OpenSCAD
RUN apt-get install -y xvfb

####################
# 📥 Install Tools #
####################
# Register inkscape repositories and install
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:inkscape.dev/stable
RUN apt-get update
RUN apt-get install -y inkscape

# Download OpenSCAD AppImage
RUN wget -O ./openscad-nightly --progress=bar:force https://files.openscad.org/snapshots/OpenSCAD-2023.10.15.ai16550-x86_64.AppImage
RUN ln ./openscad-nightly /usr/bin/openscad-nightly
# Alias the AppImage, so it can be ivoked from CLI as 'openscad-nightly'
RUN chmod a+x /usr/bin/openscad-nightly

###############
# Set workdir #
###############
WORKDIR /app

################
# 🖥️ Setup GUI #
################
# Script to launch Xvfb together with the generate script
# source https://forum.openscad.org/Headless-OpenSCAD-td5187.html
RUN echo '#!/bin/sh\nXvfb :5 -screen 0 800x600x24 -nolisten tcp & ./generate.sh $1 $2' > ./run_with_gui.sh
RUN chmod +x ./run_with_gui.sh
ENV DISPLAY :5
ENTRYPOINT [ "./run_with_gui.sh" ]

#############################
# 📂 Copy application files #
#############################
COPY ./generate-fill.sh ./
COPY ./generate-model.sh ./
COPY ./generate.sh ./
COPY ./generator.scad ./
# Make them executable
RUN chmod +x ./generate-model.sh
RUN chmod +x ./generate-fill.sh
RUN chmod +x ./generate.sh