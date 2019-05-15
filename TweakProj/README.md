## Usage

```bash
$ brew install ldid

$ export THEOS=~/theos
$ export PATH=$THEOS/bin:$PATH

$ git clone --recursive https://github.com/theos/theos.git $THEOS

$ cd ~/Desktop
$ nic.pl
```

## Edit Makefile
or add to `$PATH`

```bash
export THEOS_DEVICE_IP=127.0.0.1
export THEOS_DEVICE_PORT=10010
```


## Install
```bash
$ make
$ make package
$ make install
```