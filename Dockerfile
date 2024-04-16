FROM alpine as emulator
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
ADD https://github.com/wwarthen/RomWBW/releases/download/v${ROMWBW_VER}/RomWBW-v${ROMWBW_VER}-Package.zip /romwbw.zip
RUN <<EOF
apk add unzip
unzip romwbw.zip Binary/hd1k_* Binary/*.rom -d romwbw
EOF

FROM alpine
COPY --from=emulator /EmulatorKit/rc2014 /EmulatorKit/makedisk /usr/bin/
COPY --from=rom /romwbw/Binary/RCZ80_std.rom /rom/
COPY --from=rom /romwbw/Binary/hd1k_prefix.dat \
                /romwbw/Binary/hd1k_zsdos.img \
                /romwbw/Binary/hd1k_tpascal.img \
                /romwbw/Binary/hd1k_games.img \
                /romwbw/Binary/hd1k_aztecc.img \
                /disk/

ENTRYPOINT [ "/start" ]
