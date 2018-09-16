#!/bin/sh


for dir in cache logs prefs; \
	do mkdir -p ${LMS_VOL}/$dir; \
	done
chown -R squeezeboxserver:nogroup ${LMS_VOL}


exec squeezeboxserver --user squeezeboxserver --group squeezeboxserver \
        --prefsdir ${LMS_VOL}/prefs \
        --logdir ${LMS_VOL}/logs \
        --cachedir ${LMS_VOL}/cache "$@"
