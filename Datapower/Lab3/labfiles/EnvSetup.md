# sudo su -
# setenforce 0
# cd /home/ibmuser/datapower/labs/lab2/completed

# Update crun
yum update crun

# RUN DOCKER

docker run -it \ 
  <br>-v $PWD/config:/drouter/config \\
  <br>-v $PWD/local:/drouter/local \\
  <br>-e DATAPOWER_ACCEPT_LICENSE=true \\
  <br>-e DATAPOWER_INTERACTIVE=true \\
  <br>-p 9090:9090 \\
  <br>-p 8000:8000 \\
  <br>--name idg \\
  <br>--cpus="2" --memory="4g" \\
  <br>icr.io/cpopen/datapower/datapower-limited:10.6.0.0
<br>
# Activate web-mgmt UI
<br>
<br>login : admin/admin
<br>idg# conf
<br>idg(config)#web-mgmt
<br>idg(config web-mgmt)# admin-state enabled
<br>idg(config web-mgmt)# exit
<br>idg(config)# write mem
<br>idg(config)# show web-mgmt
<br>[CTRL][p][q]
<br>
