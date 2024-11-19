#! /bin/bash

`mkdir -p /root/images`
`mkdir -p /root/containers`

IMAGE=/root/images
CONTAINER=/root/containers

`docker container ls --format "table {{.Names}}" | tail -n +2 > $CONTAINER/containers_running.txt`

`chmod 755 /root/containers/containers_running.txt`

for line in $(cat /root/containers/containers_running.txt);do

        docker commit $line $line:backup_`date +%Y-%m-%d`
        docker save $line:backup_`date +%Y-%m-%d` -o $IMAGE/$line_`date +%Y-%m-%d_%H:%M:%S`.tar
#	docker image prune

        if [ $? = 0 ]; then

                echo "backup $line was created successfuly"

        else
                echo "backup failed"

        fi
done

docker image prune -f

