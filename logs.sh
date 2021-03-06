
PWD=$(printf '%q\n' "${PWD##*/}")
PWD=${PWD//[^a-zA-Z\d\-\_:]/}

if [ $1 ] ; then
    COMMAND=$1
fi

if [ $2 ] ; then
    USER=$2
fi


CONTAINERS=($(docker ps | awk '{print $NF}' | grep $PWD))

if [ ! ${CONTAINERS[@]} ] ; then
  echo "No running containers for $PWD"
  exit 1
fi


echo ""
echo "Select the container to print logs"
echo ""

select CONTAINER in "${CONTAINERS[@]}"
do
    break
done

if [ ! $CONTAINER ] ; then
 echo "No container selected"
 exit 1
fi

docker logs $CONTAINER
