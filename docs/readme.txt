Description
-----------
Jacksum File Browser Integration
for GNU/Linux and Unix Operating Systems v2.9.0 (Oct 27, 2024)
Copyright (C) 2006-2024 Dipl.-Inf. (FH) Johann N. Loefflmann

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
any later version.

The Jacksum File Browser Integration script installs Jacksum's primary 
function (compute checksums, CRCs, and hashes) at your favorite file
browser on GNU/Linux and Unix operating systems.

In order to get all the features Jacksum can offer, run Jacksum
on the command line.


Requirements
------------
1) A GNU/Linux or Unix operating system with a graphical user interface
   (non-headless)

2) A file browser: Caja, Dolphin, elementary Files, GNOME Nautilus (Files),
   Konqueror, Krusader, muCommander, Nemo, PCManFM, PCManFM-Qt, ROX-Filer,
   SpaceFM, Thunar, Xfe, and zzzFM are supported

3) A complete Java Runtime Environment (JRE) or Java Developement Kit (JDK)
   with graphical libraries.

   Note: a headless OpenJDK is not suitable to run the HashGarten GUI.
   You can get a suitable Java Runtime from many places:

   https://adoptium.net
   https://openjdk.java.net
   https://www.azul.com/downloads/?package=jdk
   https://bell-sw.com/pages/downloads/
   https://www.microsoft.com/openjdk/
   https://aws.amazon.com/de/corretto/
   https://sapmachine.io
   https://github.com/alibaba/dragonwell8
   https://www.oracle.com/java

4) jacksum-3.7.0.jar, and HashGarten-0.18.0.jar, and flatlaf-3.5.2.jar


Extract the script
------------------
bunzip2 < jacksum*.tar.bz2 | tar xfv -
cd jacksum-for-linux/


Start the script
----------------
./jacksum-for-linux.sh

You can run the script as often as you want.


Tested Environments
-------------------
The script has been tested successfully on many systems. See the head of the
script for details.

The script should also work on many other Linux/Unix-platforms.


Bugs, Feature Requests, Support Requests
----------------------------------------
Go to https://github.com/jonelo/jacksum-fbi-linux/issues
