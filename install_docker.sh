sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88 | grep '9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88'
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER

# docker run -itd -v /mnt/disks/hdd1-libri/workspace/:/home/zhangzn710_gmail_com/workspace -w /home/zhangzn710_gmail_com/workspace ubuntu:16.04 bash
# useradd -m -s /bin/bash -G sudo -u 1312004298 zhangzn710_gmail_com
# passwd zhangzn710_gmail_com
# apt-get update
# apt-get install sudo
# docker exec -it --user zhangzn710_gmail_com focused_panini bash
