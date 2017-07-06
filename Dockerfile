FROM alpine:latest
EXPOSE 9419 9420 9424
RUN addgroup mfs && adduser -S -D -H -G mfs mfs
RUN apk add --no-cache libgcc libstdc++ fuse
RUN mkdir -p /usr/local/etc/mfs/ && mkdir -p /usr/local/var/lib/mfs && chown mfs:mfs /usr/local/var/lib/mfs && mkdir -p /usr/local/var/lib/mfs/
COPY mfsmaster /usr/local/bin/mfsmaster
COPY mfsmetarestore /usr/local/bin/mfsmetarestore
COPY mfsmaster.cfg /usr/local/etc/mfs/mfsmaster.cfg
COPY mfsexports.cfg /usr/local/etc/mfs/mfsexports.cfg
COPY metadata.mfs.empty /usr/local/metadata.mfs.empty
VOLUME /usr/local/var/lib/mfs
COPY entrypoint.sh ./entrypoint.sh
