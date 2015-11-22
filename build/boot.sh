#!/bin/bash

# Wait forever.
at_term() {
    echo 'Bye bye.'
    exit 0
}

filename=${CWD}/.BOOT

trap at_term TERM
echo $$
while true; do
    if [ ! -f $filename ]; then
        touch $filename

        # Fix the local user to match the external files.
        username=ruby

        stat=`stat /usr/src/app/README.md | grep -Po '(?<=Uid: \\( )[0-9]*\/ [^\\)]*'`
        # Bash only
        user=(${stat//\/ / })
        if [ "$username" != "${user[1]}" ]; then
            olduid=`id -u $username`
            if [ "$olduid" != "${user[0]}" ]; then
                usermod -u ${user[0]} $username
                find / -not \( -path /proc -prune \) -user ${olduid} -exec chown -h ${user[0]} {} \;
            fi
        fi

        stat=`stat /usr/src/app/README.md | grep -Po "(?<=Gid: \(  )[0-9]*\/ [^\)]*"`
        group=(${stat//\/ / })
        if [ "$username" != ${group[1]} ]; then
            oldgid=`id -g $username`
            if [ "$oldgid" != "${group[0]}" ]; then
                if [ "UNKNOWN" == "${group[1]}" ]; then
                    groupmod -g ${group[0]} $username
                else
                    usermod --gid ${group[1]} --groups ${group[1]},$username $username
                fi
                find / -not \( -path /proc -prune \) -group ${oldgid} -exec chgrp -h ${group[0]} {} \;
            fi
        fi

        echo "Booted up! To rerun, rm $filename"
    fi

    sleep 10 && wait $!
done
