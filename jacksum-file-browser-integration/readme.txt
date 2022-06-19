Description
-----------
Jacksum File Browser Integration 2.0.0
for GNU/Linux and Unix Operating Systems (June 19, 2022)
Copyright (C) 2006-2022 Dipl.-Inf. (FH) Johann N. Loefflmann

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
any later version.

The Jacksum File Browser Integration script installs Jacksum's primary 
function (compute checksums, CRCs, and hashes) at your favorite file
browser on GNU/Linux and Unix operating systems:

Caja, Dolphin, Konqueror, Krusader, Nemo, Nautilus, ROX-Filer,
Thunar and Xfe

In order to get all the features Jacksum can offer, run Jacksum
on the command line.


Requirements
------------
1) A GNU/Linux or Unix operating system with a graphical user interface
   (non-headless)

2) A file browser: Caja, Dolphin, Konqueror, Krusader, Nemo, Nautilus,
   ROX-Filer, Thunar and Xfe are supported

3) A complete Java Runtime Environment (JRE) or Java Developement Kit (JDK)
   with graphical libraries.

   Note: a headless OpenJDK is not suitable to run the HashGarten GUI.
   You can get a suitable Java Runtime from many places

   https://adoptium.net
   https://openjdk.java.net
   https://www.azul.com/downloads/?package=jdk
   https://bell-sw.com/pages/downloads/
   https://www.microsoft.com/openjdk/
   https://aws.amazon.com/de/corretto/
   https://sapmachine.io
   https://github.com/alibaba/dragonwell8
   https://www.oracle.com/java

4) jacksum-3.4.0.jar, and HashGarten-0.10.0.jar, and flatlaf-2.3.jar
   Go to https://jacksum.net in order to get the latest version.


Extract the script
------------------
bunzip2 < jacksum*.tar.bz2 | tar xfv -
cd jacksum-file-browser-integration/


Start the script
----------------
./jacksum-file-browser-integration.sh

You can run the script as often as you want.


Tested Environments
-------------------
The script has been tested successfully on many systems. See the head of the
script for details.

The script should also work on many other Linux/Unix-platforms.


Bugs, Feature Requests, Support Requests
----------------------------------------
Go to https://github.com/jonelo/jacksum-fbi-linux/issues

