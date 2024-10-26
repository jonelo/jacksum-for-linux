![GitHub downloads](https://img.shields.io/github/downloads/jonelo/jacksum-fbi-linux/total?color=green)

# Jacksum File Browser Integration on GNU/Linux

The installer script installs [Jacksum](https://github.com/jonelo/jacksum) and [HashGarten](https://github.com/jonelo/HashGarten) which allow accessing Jacksum's primary features from the GNU/Linux file browser/file manager's script menu.

## System Requirements

- A GNU/Linux or Unix operating system

- A graphical desktop user interface

- bash v3 or later, or zsh

- At least one of the supported file browsers below

- A Java Runtime Environment (JRE) or Java Developement Kit (JDK) with graphical libraries, version 11 or later. Note: a headless OpenJDK is not suitable to run the HashGarten GUI. 

- jacksum-3.7.0.jar, HashGarten-0.18.0.jar and flatlaf-3.5.2.jar (all jars are part of the installation tarball)

### Supported File Browsers

The installation script has been tested successfully for many file browsers on many systems. If the API has not changed, the script should work with later [minor or patch versions](https://semver.org) as well. See also the head of the installer script for details.

If your preferred file manager is not listed below, chances are high that your file manager supports at least **drag & drop**, so you could use drag & drop to transfer file/directory-paths from your file manager to the HashGarten GUI where you can process data further, e. g. calculate hashes from file/directory-paths.

| File Browser                                                      | Tested Versions | API                  | Comment                                                                                                                             |
|-------------------------------------------------------------------|-----------------|----------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| [Caja](https://github.com/mate-desktop/caja)                      | 1.12.0 - 1.26.0 | Caja                 | It is the default file manager for the [MATE](https://mate-desktop.org/) desktop environment. It is a fork of Nautilus version 2.32. |
| [Dolphin](https://apps.kde.org/de/dolphin/)                       | 2.2 - 24.08.1   | KDE                  | Default file manager on [KDE](https://kde.org/)-powered distributions.                                                              |
| [elementary files](https://github.com/elementary/files)           | 6.2.1 - 6.5.2   | elementary contracts | "elementary files" is the file manager used by the [elementary OS](https://elementary.io).                                          |
| [GNOME Files (Nautilus)](https://gitlab.gnome.org/GNOME/nautilus) | 2.6.1 - 46.0    | GNOME                | Default file manager for [GNOME](https://www.gnome.org/)-powered distributions like Fedora, Ubuntu or Zorin OS.                     |
| [Konqueror](https://apps.kde.org/de/konqueror/)                   | 3.4.1 - 4.4.2   | KDE                  | Konqueror was the file manager for [KDE](https://kde.org/) before it was replaced by Dolphin starting with KDE 4.                   |
| [Krusader](https://krusader.org/)                                 | 2.7.2           | KDE                  | Krusader is a file manager for [KDE](https://kde.org/).                                                                             |
| [muCommander](https://www.mucommander.com/)                       | 1.3.0           | muCommander          | muCommander is a cross platform file manager written in Java.                                                                       | 
| [Nemo](https://github.com/linuxmint/nemo)                         | 1.8.4 - 6.0.2   | Nemo                 | Nemo is Linux Mint's default file manager in [Cinnamon](https://github.com/linuxmint/Cinnamon) desktop edition. It is a fork of Nautilus 3.4. |
| [PCManFM](https://sourceforge.net/projects/pcmanfm)               | 1.3.2           | PCManFM              | PCManFM is a file manager for GTK.                                                                                                  |
| [PCManFM-Qt](https://github.com/lxqt/pcmanfm-qt)                  | 0.17            | PCManFM              | PCManFM is a Qt port of PCManFM                                                                                                     |
| [ROX-Filer](https://github.com/rox-desktop/rox-filer)             | 2.5 - 2.24.33   | ROX                  | ROX-Filer is the file manager for the desktop environment "[ROX Desktop](https://rox.sourceforge.net/desktop/)".                    |
| [SpaceFM](https://github.com/IgnorantGuru/spacefm)                | 1.0.6           | SpaceFM              | SpaceFM is a file manager on Linux.                                                                                                 |
| [Thunar](https://gitlab.xfce.org/xfce/thunar)                     | 1.0.1 - 1.6.10  | Thunar               | It is the default choice for [Xfce](https://xfce.org/)-based distributions.                                                         |
| [Xfe](https://sourceforge.net/projects/xfe/)                      | 1.37 - 1.43.2   | Xfe                  | X File Explorer [(Xfe)](http://roland65.free.fr/xfe/) is a file manager on Linux.                                                   |
| [zzzFM](https://gitlab.com/antix-contribs/zzzfm/)                 | 1.0.7           | zzzFM                | A file manager for the [antiX Linux](https://antixlinux.com/).                                                                      |


## Get started

### Download the latest installation script

Go to https://github.com/jonelo/jacksum-fbi-linux/releases and download the .tar.bz2 file.

### Extract the installation script

On most GNU/Linux derivates, and on macOS you can enter
```
$ tar xfvj jacksum*.tar.bz2 ; cd jacksum-file-browser-integration/
```

On most Unix derivates, such as Sun/Oracle Solaris you can enter
```
$ bunzip2 < jacksum*.tar.bz2 | tar xfv - ; cd jacksum-file-browser-integration/
```

### Start the installation script

The installation script is an interactive text user interface that allows you to install Jacksum and HashGarten in your file manager. It also allows uninstalling it again safely and completely. You can run the script as often as you want. If a file manager is not detected on your system, it is marked as DISABLED.

<a href="https://asciinema.org/a/651074" target="_blank"><img src="https://asciinema.org/a/651074.svg" /></a>

## FAQs

### Where can I file bugs, feature requests, and support requests?

Please go to https://github.com/jonelo/jacksum-fbi-linux/issues


### I have installed Krusader, but the installer marked it as DISABLED

On systems without KDE, you need to install both the krusader and the kf5-config package in order to make it work.


### The installer marked all entries as DISABLED

Most likely, you are running a non-supported file manager. If you think it should be supported, please file a feature request.
Please note that the file browser must support sending highlighted files or directories or selected files or directories to a 3rd party application such as a script.


### How do I get the latest Java?

#### Debian based Linux (e.g. Ubuntu)

```
$ sudo apt install openjdk-21-jre
```

You just need to enter `/usr/bin/java` (or hit Enter) if the `jacksum-file-browser-integration.sh` asks you for the java command:
```
$ ./jacksum-file-browser-integration.sh
...
Type the absolute path to "java"
and press "Enter" to continue [/usr/bin/java]: 
```

#### Other Linux

You could use the `update_jdk` script from the [bashberries](https://github.com/jonelo/bashberries) project in order to get a suitable JDK. The following example downloads Temurin 21 (that is the JDK 21 from adoptium), and installs it to `/opt/java/jdk_latest`:
```
$ sudo ./update_jdk -s "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.2%2B13/OpenJDK21U-jdk_x64_linux_hotspot_21.0.2_13.tar.gz" -t jdk /opt/java
```
You just need to enter `/opt/java/jdk_latest/bin/java` if the `jacksum-file-browser-integration.sh` asks you for the java command:

```
$ ./jacksum-file-browser-integration.sh
...
Type the absolute path to "java"
and press "Enter" to continue [/usr/bin/java]: /opt/java/jdk_latest/bin/java
```


## Further hints

For more information about Jacksum see also https://jacksum.net or https://github.com/jonelo/jacksum

For more information about HashGarten see also https://jacksum.net or https://github.com/jonelo/HashGarten

There are also File Browser Integration scripts available for both Microsoft Windows, see also https://github.com/jonelo/jacksum-for-windows, and macOS, see also https://github.com/jonelo/jacksum-for-macos


## Show your support

Please ⭐️ this repository if this project helped you!
