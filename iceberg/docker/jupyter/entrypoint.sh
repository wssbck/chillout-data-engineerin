#!/bin/sh
# The container runs as the host user's UID, which the image doesn't know about.
# Spark's JVM needs that UID to have a passwd entry, so register it via nss_wrapper.
if ! getent passwd "$(id -u)" >/dev/null 2>&1; then
    printf 'jovyan:x:%s:%s::/tmp:/bin/sh\n' "$(id -u)" "$(id -g)" > /tmp/passwd
    printf 'jovyan:x:%s:\n' "$(id -g)" > /tmp/group
    export NSS_WRAPPER_PASSWD=/tmp/passwd
    export NSS_WRAPPER_GROUP=/tmp/group
    export LD_PRELOAD="$(find /usr/lib -name libnss_wrapper.so | head -n 1)"
fi

exec "$@"
