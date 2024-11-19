#! /bin/bash

`mkdir -p /root/containers`

CONTAINER=/root/containers

`docker container ls --format "table {{.Names}}" | tail -n +2 > $CONTAINER/containers_running.txt`

`chmod 755 $CONTAINER/containers_running.txt`

for line in $(cat $CONTAINER/containers_running.txt);do

        docker export -o $CONTAINER/backup-`date +%Y-%m-%d`_$line.tar $line

        if [ $? = 0 ]; then

                echo "backup $line was created successfuly"

        else
                echo "backup failed"

        fi

done
