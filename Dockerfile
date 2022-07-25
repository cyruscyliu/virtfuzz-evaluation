FROM videzzo:latest

RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1.tar.gz
RUN sudo apt-get install -y libssl-dev
RUN tar xzvf cmake-3.21.1.tar.gz; \
cd cmake-3.21.1; ./bootstrap; make -j8; make install

RUN git clone https://gitlab.freedesktop.org/spice/spice-protocol.git --depth=1
RUN cd spice-protocol && meson --buildtype=release build-default && ninja -C build-default && \
ninja -C build-default dist && ninja -C build-default install && cd
RUN wget http://downloads.us.xiph.org/releases/celt/celt-0.5.1.3.tar.gz
RUN tar zxvf celt-0.5.1.3.tar.gz
RUN cd celt-0.5.1.3/ && ./configure && make -j8 && make install && cd
RUN python3 -m pip install six pyparsing
RUN git clone https://gitlab.freedesktop.org/spice/spice.git --depth=1
RUN cd spice && ./autogen.sh && ./configure --prefix=/usr --sysconfdir=/etc \
--localstatedir=/var --libdir=/usr/lib && make && make install && cd

RUN python3 -m pip install numpy pandas matplotlib

RUN python3 -m pip install jinja2 msgpack
RUN apt-get install -y gcc-8 g++-8 libc6-dev-i386 libisoburn-dev libdevmapper-dev
