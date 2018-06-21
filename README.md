# petalinux-docker

Copy petalinux-v2018.1-final-installer.run file to this folder. Then run

`docker build --build-arg PETA_VERSION=2018.1 --build-arg PETA_RUN_FILE=petalinux-v2018.1-final-installer.run -t petalinux:2018.1 .`
