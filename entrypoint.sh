#!/bin/bash

if [ ! -z "$PGP_KEY" ] ; then
    echo "$PGP_KEY" | gpg --import
fi

for private_key in $(find /secrets -type f -name '*.gpg') ; do
    if [ -f "$private_key.passpharase" ] ; then
        cat "$private_key" | gpg --import --passphrase-file "$private_key.passpharase"
    else
        cat "$private_key" | gpg --import
    fi
done

exec "$@"
