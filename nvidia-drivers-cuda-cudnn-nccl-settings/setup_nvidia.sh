sudo apt-get remove --purge nvidia*
sudo apt-get autoremove
sudo apt-get install -f

sudo add-apt-repository ppa:graphics-drivers/ppa

sudo sed -i "s/ppa\.launchpad\.net/lanuchpad.moruy.cn/g" /etc/apt/sources.list.d/*.list
sudo apt-get update

ubuntu-drivers devices

# sudo ubuntu-drivers autoinstall only 410 for good

reboot


