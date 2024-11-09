#! /bin/bash

`docker container ls --format "table {{.Names}}" | tail -n +2 > /root/containers/containers_running.txt`

`chmod 755 /root/containers/containers_running.txt`

for line in $(cat /root/containers/containers_running.txt);do

        docker export -o /root/containers/backup-`date +%Y-%m-%d`_$line.tar $line

        if [ $? = 0 ]; then

                echo "backup $line was created successfuly"

        else
                echo "backup failed"

        fi

done
