# Portecle Installer

This is simplified and unified approach to build script for the [Portecle](http://portecle.sourceforge.net/) Installer. To be able to build Installer from scratch you need to run local instance of [Docker](https://www.docker.com/).

## Clone this repo

To clone this repository you just need to execute bolow command in your working directory:

```bash
git clone https://github.com/avosoftware/PortecleInstaller.git
```

## Build docker image

Image that will be generated in this step will contain all the tools that are needed to prepare Portecle Installer.

```bash
cd PortecleInstaller
docker build -t portecle-installer:latest .
```

## Preparing environment

Now you need to download and unpack latest version of Portecle.

```bash
curl -J -L https://sourceforge.net/projects/portecle/files/latest/download -o portecle.zip
unzip portecle.zip
```

At this point you should have unpacked folder with Portecle in the current path, ie:

```bash
Dockerfile    README.md     portecle.zip
LICENSE       portecle-1.11 resources
```

So in this case the new folder is _portecle-1.11_. This tells us that the latest version of portecle is _1.11_, we will need this information in next step.

## Building Installer

Last step is to run below script, but first we need to replace version number in __VESION=1.11__ to what we find out from previous step. The same thing we need
to do with __"$(pwd)"/portecle-1.11__ which should point to the folder with unpacked Portecle.

```bash
docker run --env VERSION=1.11 \
  --mount type=bind,source="$(pwd)"/portecle-1.11,target=/portecle-installer/portecle \
  --mount type=bind,source="$(pwd)"/resources,target=/portecle-installer/resources \
  portecle-installer:latest
```

## Done

After successfully completing all of above steps you should find file with name simmilar to __Portecle-Installer-1.11.exe__ in the unpacked Portecle folder, ie:
```bash
LICENSE.bouncycastle.txt    bcpkix.jar
LICENSE.txt                 bcprov.jar
NEWS.txt                    icons
Portecle-Installer-1.11.exe net.sf.portecle.appdata.xml
Portecle.exe                net.sf.portecle.desktop
README.md                   portecle.jar
```
