# GCC support can be specified at major, minor, or micro version
# (e.g. 8, 8.2 or 8.2.0).
# See https://hub.docker.com/r/library/gcc/ for all supported GCC
# tags from Docker Hub.
# See https://docs.docker.com/samples/library/gcc/ for more on how to use this image
# FROM gcc:10.3.0-buster
FROM debian:bullseye-slim

RUN apt update && apt upgrade -y \
 && apt install -y sudo elpa-magit apt-utils vim \
 && apt install -y sudo git-all python3 python3-pip cmake gcc-arm-none-eabi libnewlib-arm-none-eabi \
 && apt autoclean

RUN mkdir /pico
WORKDIR /pico

RUN cd /pico && git clone -b master --recurse-submodules https://github.com/raspberrypi/pico-sdk.git
RUN cd /pico/pico-sdk && git submodule update --init
RUN cd /pico/pico-sdk && git checkout 1.1.2
RUN cd /pico/pico-sdk && git submodule update --recursive
RUN cd /pico && git clone -b master https://github.com/raspberrypi/pico-examples.git

ENV PICO_SDK_PATH="/pico/pico-sdk"

RUN cd /pico/pico-examples && cmake .
RUN cd /pico/pico-examples && make -j 8

COPY projects /pico/projects

RUN cd /pico/projects/hello_usb && cmake . && make -j 8
RUN cd /pico/projects/waveshare_lcd_a && cmake . && make -j 8
RUN cd /pico/projects/waveshare_lcd_b && cmake . && make -j 8
RUN cd /pico/projects/waveshare_lcd_c && cmake . && make -j 8
RUN cd /pico/projects/waveshare_lcd_d && cmake . && make -j 8

EXPOSE 443

CMD ["/bin/bash"]

LABEL Name=versuchepicoc Version=0.0.1
