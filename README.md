![GitHub downloads](https://img.shields.io/github/downloads/jonelo/jacksum-fbi-linux/total?color=green)

# Jacksum File Browser Integration on GNU/Linux

The installer script can install Jacksum's primary features to the GNU/Linux File Browser's Script Menu.

## Requirements

- A GNU/Linux or Unix operating system with a graphical user interface (non-headless)

- At least one of the following file browsers: Caja, Dolphin, Konqueror, Krusader, Nemo, Nautilus resp. Files, ROX-Filer, Thunar or Xfe

- bash

- A complete Java Runtime Environment (JRE) or Java Developement Kit (JDK) with graphical libraries, version 11 or later. Note: a headless OpenJDK is not suitable to run the HashGarten GUI. 

- jacksum-3.4.0.jar, HashGarten-0.10.0.jar, and flatlaf-2.3.jar which are all part of the tarball (see releases)

## Get the latest Java

### Debian based Linux (e.g. Ubuntu)

```
$ sudo apt install openjdk-17-jre
```

You just need to enter `/usr/bin/java` if the `jacksum-file-browser-integration.sh` asks you for the java command.

### Other Linux

You could use the `update_jdk` script from the [bashberries](https://github.com/jonelo/bashberries) project in order to get a suitable JDK. The following example downloads Temurin 17 (that is the JDK 17 from adoptium), and installs it to `/opt/java/jdk_latest`:
```
$ sudo ./update_jdk -s "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.6%2B10/OpenJDK17U-jdk_x64_linux_hotspot_17.0.6_10.tar.gz" -t jdk /opt/java
```
You just need to enter `/opt/java/jdk_latest/bin/java` if the `jacksum-file-browser-integration.sh` asks you for the java command.

## Download the latest install script

Go to https://github.com/jonelo/jacksum-fbi-linux/releases and download the .tar.bz2 file.

## Extract the install script

```
$ bunzip2 < jacksum*.tar.bz2 | tar xfv - ; cd jacksum-file-browser-integration/
```

## Start the install script

```
$ ./jacksum-file-browser-integration.sh
```

The script is interactive and allows you to install Jacksum and HashGarten at your file manager. It also allows you uninstall it again savely. You can run the script as often as you want.

## Tested Environments

The script has been tested successfully on many systems. See the head of the installer script for details.

## Bugs, Feature Requests, Support Requests

Go to https://github.com/jonelo/jacksum-fbi-linux/issues

## Further hints

For more information about Jacksum see also https://jacksum.net or https://github.com/jonelo/jacksum

For more information about HashGarten see also https://jacksum.net or https://github.com/jonelo/HashGarten

There are also File Browser Integration scripts available for both Microsoft Windows, see also https://github.com/jonelo/jacksum-fbi-windows, and macOS, see also https://github.com/jonelo/jacksum-fbi-macos
