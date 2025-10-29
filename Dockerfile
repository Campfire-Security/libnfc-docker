FROM debian:bookworm-slim

#Installing dependencies
RUN apt-get update
RUN apt-get install -y zip git make autoconf doxygen libcurl4-openssl-dev libtool pkg-config libusb-dev libpcsclite-dev bzip2 build-essential

WORKDIR /usr/src/
#Clone libnfc repo
RUN git clone https://github.com/nfc-tools/libnfc.git

#Making release
WORKDIR /usr/src/libnfc
RUN ./make_release.sh
RUN ./configure --prefix=/usr --sysconfdir=/etc
RUN make
RUN make install

# Install mfoc first (which will create the default blacklist config)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mfoc

# Override/append our custom blacklist configuration
RUN bash -c 'echo "blacklist pn533_usb" >> /etc/modprobe.d/blacklist-libnfc.conf' && \
    bash -c 'echo "blacklist pn533" >> /etc/modprobe.d/blacklist-libnfc.conf' && \
    bash -c 'echo "blacklist nfc" >> /etc/modprobe.d/blacklist-libnfc.conf'

WORKDIR /root/dumps
