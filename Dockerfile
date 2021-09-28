FROM ubuntu:18.04

RUN apt-get update; apt-get install -y build-essential cmake vim
RUN apt-get install -y python3-pip
RUN pip3 install wllvm

WORKDIR /root

RUN apt-get install -y sudo wget software-properties-common
# RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -; \
# sudo apt-add-repository "deb http://apt.llvm.org/bionic/llvm-toolchain-bionic-11 main"; \
# sudo apt-get update; \
# sudo apt-get install -y llvm-11 llvm-11-dev clang-11 llvm-11-tools

RUN sudo apt-get install -y ninja-build pkg-config make autoconf automake libtool \
libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev patchelf wget
RUN sudo apt-get install -y git

RUN wget https://ftp.gnu.org/gnu/binutils/binutils-2.35.tar.gz
RUN tar xzvf binutils-2.35.tar.gz; \
cd binutils-2.35; ./configure; make -j8; make install;
RUN rm /usr/bin/objcopy; ln -s /usr/local/bin/objcopy /usr/bin/objcopy

RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1.tar.gz
RUN sudo apt-get install -y libssl-dev
RUN tar xzvf cmake-3.21.1.tar.gz; \
cd cmake-3.21.1; ./bootstrap; make -j8; make install

RUN sudo apt-get install -y gdb
RUN wget -q -O ~/.gdbinit-gef.py https://github.com/hugsy/gef/raw/master/gef.py
RUN echo source /root/.gdbinit-gef.py >> ~/.gdbinit

RUN wget https://spice-space.org/download/releases/spice-protocol-0.12.10.tar.bz2
RUN tar xvf spice-protocol-0.12.10.tar.bz2
RUN cd spice-protocol-0.12.10/ && ./configure && make -j8 && make install && cd
RUN wget http://downloads.us.xiph.org/releases/celt/celt-0.5.1.3.tar.gz
RUN tar zxvf celt-0.5.1.3.tar.gz
RUN cd celt-0.5.1.3/ && ./configure && make -j8 && make install && cd
RUN apt-get install -y libjpeg-dev libsasl2-dev
RUN wget https://spice-space.org/download/releases/spice-server/spice-0.12.7.tar.bz2
RUN tar xvf spice-0.12.7.tar.bz2
RUN cd spice-0.12.7/ && ./configure --prefix=/usr --sysconfdir=/etc \
--localstatedir=/var --libdir=/usr/lib && make -j8 && make install && cd
RUN sudo apt-get install -y llvm-10 llvm-10-dev clang-10 llvm-10-tools
RUN apt-get install -y libncurses5-dev libncursesw5-dev
RUN apt-get install -y libgtk-3-dev
RUN apt-get install -y libsdl2-dev
RUN apt-get install -y libvncserver-dev
RUN apt-get install -y screen
RUN apt-get install -y parallel
RUN pip3 install picire
RUN apt-get install -y htop cpulimit
