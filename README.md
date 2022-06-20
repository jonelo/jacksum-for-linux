# Jacksum File Browser Integration on GNU/Linux

The installer script can install Jacksum's primary features to the GNU/Linux File Browser's Script Menu.

## Requirements

- A GNU/Linux or Unix operating system with a graphical user interface (non-headless)

- A file browser: Caja, Dolphin, Konqueror, Krusader, Nemo, Nautilus resp. Files, ROX-Filer, Thunar and Xfe are supported

- bash

- A complete Java Runtime Environment (JRE) or Java Developement Kit (JDK) with graphical libraries. Note: a headless OpenJDK is not suitable to run the HashGarten GUI.

- jacksum-3.4.0.jar, HashGarten-0.10.0.jar, and flatlaf-2.3.jar which are all part of the tarball (see releases)

## Download the latest install script

Go to https://github.com/jonelo/jacksum-fbi-linux/releases and download the .tar.bz2 file.

## Extract the install script

```
bunzip2 < jacksum*.tar.bz2 | tar xfv -
cd jacksum-file-browser-integration/
```

## Start the install script

```
./jacksum-file-browser-integration.sh
```

You can run the script as often as you want.

## Tested Environments

The script has been tested successfully on many systems. See the head of the installer script for details.

## Bugs, Feature Requests, Support Requests

Go to https://github.com/jonelo/jacksum-fbi-linux/issues

## Further hints

For more information about Jacksum see also https://jacksum.net or https://github.com/jonelo/jacksum

For more information about HashGarten see also https://jacksum.net or https://github.com/jonelo/HashGarten

There are also File Browser Integration scripts available for both Microsoft Windows, see also https://github.com/jonelo/jacksum-fbi-windows, and macOS, see also https://github.com/jonelo/jacksum-fbi-macos
