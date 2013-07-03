# snap-monitor

Build light interacting with snap-ci using a Raspberry PI

## requirements

sudo apt-get update && sudo apt-get upgrade

### Lamp command line tool

```sh
sudo apt-get install -y libusb++-dev
wget https://github.com/rtircher/usblamp/tarball/master --no-check-certificate
tar xzf master
cd rtircher-usblamp-c33bae8/
cd src/
make
sudo make install
```

### Ruby tool to parse snap cctray

```sh
sudo apt-get install -y ruby
sudo aptitude install ruby1.9.1-dev
sudo apt-get install -y libxml2 libxml2-dev libxslt1.1 libxslt1-dev
sudo gem install nokogiri
```

### Lamp commands

```sh
usblamp red
usblamp green
usblamp blue
usblamp yellow
usblamp white
usblamp off
```


## The following instructions are intended to setup the init.d script and the boot sequence

### the monitor.rb file should be located in /var/lib/snap-monitor/monitor.rb

``` sh
sudo mv monitor.rb /var/lib/snap-monitor/monitor.rb 
```

### init.d script

``` sh
copy it to /etc/init.d/snap-monitor
```
### make the script executable

``` sh
sudo chmod 755 /etc/init.d/snap-monitor
```

### add it to the boot sequence (debian)

``` sh
sudo update-rc.d snap-monitor defaults
```

### to remove the deamon from the boot sequence

``` sh
sudo update-rc.d -f  snap-monitor remove
```
