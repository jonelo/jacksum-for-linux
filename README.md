![GitHub downloads](https://img.shields.io/github/downloads/jonelo/jacksum-fbi-linux/total?color=green)

# Jacksum File Browser Integration on GNU/Linux

The installer script installs [Jacksum](https://github.com/jonelo/jacksum) and [HashGarten](https://github.com/jonelo/HashGarten) which allows accessing Jacksum's primary features at the GNU/Linux File Browser's script menu.

## System Requirements

- A GNU/Linux or Unix operating system

- A graphical desktop user interface

- bash 3 or later

- At least one of the supported file browsers below

- A complete Java Runtime Environment (JRE) or Java Developement Kit (JDK) with graphical libraries, version 11 or later. Note: a headless OpenJDK is not suitable to run the HashGarten GUI. 

- jacksum-3.7.0.jar, HashGarten-0.14.0.jar and flatlaf-2.3.jar (all are part of the installation tarball)

### Supported File Browsers

The install script has been tested successfully on many systems. See also the head of the installer script for details.

| File Browser         | Tested Versions | API                  | Comment                                                                                                     |
|----------------------|-----------------|----------------------|-------------------------------------------------------------------------------------------------------------|
| Caja                 | 1.12.0 - 1.26.0 | Caja                 | Caja is the stardard file manager of the desktop environment MATE. It is a fork of Nautilus version 2.32.   |
| Dolphin              | 2.2 - 21.12.3   | KDE                  | Dolphin is the file manager of KDE.                                                                         |
| Elementary Files     | 6.2.1           | Elementary Contracts | Elementary Files is the file manager at Elementary OS.                                                      |
| Konqueror            | 3.4.1 - 4.4.2   | KDE                  | Konqueror was the file manager for KDE before it was replaced by Dolphin starting with KDE 4.               |
| Krusader             |                 | KDE                  | Krusader is a file manager for KDE.                                                                         |
| Nemo                 | 1.8.4 - 5.2.4   | Nemo                 | Nemo is the file manager of the desktop environment Cinnamon. It is a fork of Nautilus 3.4.                 |
| Nautilus resp. Files | 2.6.1 - 24.6    | GNOME                | GNOME Files, formerly and internally known as Nautilus, is the official file manager for the GNOME desktop. |
| ROX-Filer            | 2.5 - 2.24.33   | ROX                  | ROX-Filer is the file manager for the desktop environment "ROX Desktop".                                    |
| Thunar               | 1.0.1 - 1.6.10  | Thunar               | Thunar is a file manager for Linux.                                                                         |
| Xfe                  | 1.37  -1.43.2   | Xfe                  | Xfe is a file manager for Linux.                                                                            |


## Get started

### Download the latest install script

Go to https://github.com/jonelo/jacksum-fbi-linux/releases and download the .tar.bz2 file.

### Extract the install script

```
$ bunzip2 < jacksum*.tar.bz2 | tar xfv - ; cd jacksum-file-browser-integration/
```

### Start the install script

The script is an interactive text user interface and allows to install Jacksum and HashGarten at your file manager. It also allows to uninstall it again savely. You can run the script as often as you want.
If a file manager is not detected on your system, it is marked as DISABLED.

```
$ ./jacksum-file-browser-integration.sh
                - Jacksum File Browser Integration v2.2.0 -
                            https://jacksum.net

Menu:
  1 - Install   Jacksum at Dolphin/Konqueror/Krusader for user johann
  2 - Uninstall Jacksum at Dolphin/Konqueror/Krusader for user johann
  3 - Install   Jacksum at Gnome Nautilus/Files for user johann (DISABLED)
  4 - Uninstall Jacksum at Gnome Nautilus/Files for user johann (DISABLED)
  5 - Install   Jacksum at ROX-Filer for user johann (DISABLED)
  6 - Uninstall Jacksum at ROX-Filer for user johann (DISABLED)
  7 - Install   Jacksum at Thunar for user johann (DISABLED)
  8 - Uninstall Jacksum at Thunar for user johann (DISABLED)
  9 - Install   Jacksum at Xfe for user johann (DISABLED)
 10 - Uninstall Jacksum at Xfe for user johann (DISABLED)
 11 - Install   Jacksum at Nemo for user johann (DISABLED)
 12 - Uninstall Jacksum at Nemo for user johann (DISABLED)
 13 - Install   Jacksum at Caja for user johann (DISABLED)
 14 - Uninstall Jacksum at Caja for user johann (DISABLED)
 15 - Install   Jacksum at Elementary Files for user johann (DISABLED)
 16 - Uninstall Jacksum at Elementary Files for user johann (DISABLED)

  q - Quit the installer
--------------------------------------------------------------------------------
Select option 1-16 or q to quit: 

```

## FAQs

## How do I get the latest Java?

### Debian based Linux (e.g. Ubuntu)

```
$ sudo apt install openjdk-17-jre
```

You just need to enter `/usr/bin/java` (or hit Enter) if the `jacksum-file-browser-integration.sh` asks you for the java command:
```
$ ./jacksum-file-browser-integration.sh
...
Type the absolute path to "java"
and press "Enter" to continue [/usr/bin/java]: 
```

### Other Linux

You could use the `update_jdk` script from the [bashberries](https://github.com/jonelo/bashberries) project in order to get a suitable JDK. The following example downloads Temurin 17 (that is the JDK 17 from adoptium), and installs it to `/opt/java/jdk_latest`:
```
$ sudo ./update_jdk -s "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.6%2B10/OpenJDK17U-jdk_x64_linux_hotspot_17.0.6_10.tar.gz" -t jdk /opt/java
```
You just need to enter `/opt/java/jdk_latest/bin/java` if the `jacksum-file-browser-integration.sh` asks you for the java command:

```
$ ./jacksum-file-browser-integration.sh
...
Type the absolute path to "java"
and press "Enter" to continue [/usr/bin/java]: /opt/java/jdk_latest/bin/java
```


## Bugs, Feature Requests, Support Requests

Go to https://github.com/jonelo/jacksum-fbi-linux/issues

## Further hints

For more information about Jacksum see also https://jacksum.net or https://github.com/jonelo/jacksum

For more information about HashGarten see also https://jacksum.net or https://github.com/jonelo/HashGarten

There are also File Browser Integration scripts available for both Microsoft Windows, see also https://github.com/jonelo/jacksum-fbi-windows, and macOS, see also https://github.com/jonelo/jacksum-fbi-macos
