
FROM alpine as build
WORKDIR /
RUN <<EOF
apk add gcc musl-dev make git
git clone https://github.com/EtchedPixels/EmulatorKit.git
cd EmulatorKit
make rc2014 makedisk
EOF

FROM alpine as rom
ARG ROMWBW_VER=3.4.0
WORKDIR /
RUN <<EOF
apk add wget unzip
wget https://github.com/wwarthen/RomWBW/releases/download/v${ROMWBW_VER}/RomWBW-v${ROMWBW_VER}-Package.zip
mkdir RomWBW
cd RomWBW
unzip ../RomWBW-v${ROMWBW_VER}-Package.zip
EOF

FROM alpine
COPY --from=build /EmulatorKit/rc2014 /EmulatorKit/makedisk /usr/bin/
COPY --from=rom /RomWBW/Binary/RCZ80_std.rom /rom/
COPY --from=rom /RomWBW/Binary/hd1k_combo.img /disk/
COPY start /start

ENTRYPOINT [ "/start" ]
