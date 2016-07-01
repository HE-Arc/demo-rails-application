#!/bin/bash

username=ruby
filename=${CWD}/.BOOT
statfile=/usr/src/app/docker-compose.yml

# Wait forever.
at_term() {
    echo 'Bye bye.'
    exit 0
}

trap at_term TERM

while true; do
    if [ ! -f $filename ]; then
        touch $filename

        #
        # Fix the local user to match the external files.
        #
        uid=`python -c "import os; print(os.stat('${statfile}').st_uid)"`
        user_id=`id -u $username`
        # Bash only
        if [ "${user_uid}" != "${uid}" ]; then
            # Change user's uid globally.
            sed -i "s/\(${username}:x:\)${user_id}/\\1${uid}/" /etc/passwd
            find / -not \( -path /proc -prune \) -user ${user_id} -exec chown -h ${uid} {} \;
        fi

        gid=`python -c "import os; print(os.stat('${statfile}').st_gid)"`
        group_id=`id -g $username`
        if [ "${group_id}" != "${gid}" ]; then
            # Change user's gid globally.
            sed -i "s/\(${username}:x:${uid}:\)${group_id}/\\1${gid}/" /etc/passwd

            # Add user to the existing group (or create it).
            group_name=`getent group ${gid} | cut -d: -f1`
            if [ "{$group_name}" == "" ]; then
                group_name=usergroup
                addgroup -g ${gid} ${group_name}
            fi
            adduser $username -G ${group_name}

            find / -not \( -path /proc -prune \) -group ${group_id} -exec chgrp -h ${gid} {} \;
        fi

        echo "Booted up! To rerun, rm $filename"
    fi

    sleep 10 && wait $!
done
