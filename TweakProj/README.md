## usage

```bash
$ brew install ldid

$ export THEOS=~/theos
$ export PATH=$THEOS/bin:$PATH

$ git clone --recursive https://github.com/theos/theos.git $THEOS

$ cd ~/Desktop
$ nic.pl
```

## edit Makefile

export THEOS_DEVICE_IP=127.0.0.1
export THEOS_DEVICE_PORT=10010

## install
```bash
$ make
$ make package
$ make install
```