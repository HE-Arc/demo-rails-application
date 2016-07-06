#!/bin/sh

username=ruby
statfile=/usr/src/app/docker-compose.yml

# wait forever kill.
at_term() {
    echo 'Bye bye.'
    exit 0
}

trap at_term TERM

#
# Fix the local user to match the external files.
#
uid=`stat -c %u "${statfile}"`
user_id=`id -u $username`
# Bash only
if [ "${user_uid}" != "${uid}" ]; then
    # Change user's uid globally.
    sed -i "s/\(${username}:x:\)${user_id}/\\1${uid}/" /etc/passwd
    find / -not \( -path /proc -prune \) -user ${user_id} -exec chown -h ${uid} {} \;
fi

gid=`stat -c %g "${statfile}"`
group_id=`id -g $username`
if [ "${group_id}" != "${gid}" ]; then
    # Change user's gid globally.
    sed -i "s/\(${username}:x:${uid}:\)${group_id}/\\1${gid}/" /etc/passwd

    # Add user to the existing group (or create it).
    groupname=`getent group ${gid} | cut -d: -f1`
    if [ "${groupname}" == "" ]; then
        groupname=usergroup
        addgroup -g ${gid} ${groupname}
    fi
    adduser $username ${groupname}

    find / -not \( -path /proc -prune \) -group ${group_id} -exec chgrp -h ${gid} {} \;
fi

# Do nothing.
while true; do
    sleep 10 && wait $!
done
