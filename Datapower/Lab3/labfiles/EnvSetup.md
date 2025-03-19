# sudo su -
# setenforce 0
# cd /home/ibmuser/datapower/labs/lab2/completed
# Yum update crun
# docker run -it \
  -v $PWD/config:/drouter/config \
  -v $PWD/local:/drouter/local \
  -e DATAPOWER_ACCEPT_LICENSE=true \
  -e DATAPOWER_INTERACTIVE=true \
  -p 9090:9090 \
 -p 8000:8000 \
  --name idg \
  --cpus="2" --memory="4g" \
  icr.io/cpopen/datapower/datapower-limited:10.6.0.0
