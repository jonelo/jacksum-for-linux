Beschreibung
------------
Jacksum File Browser Integration 2.2.0
fuer GNU/Linux und Unix Betriebssysteme v2.2.0 (03.09.2023)
Copyright (C) 2006-2023 Dipl.-Inf. (FH) Johann N. Loefflmann

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
any later version.

Das Jacksum File Browser Integration Script installiert die primaere Funktion
von Jacksum (Berechnen von Pruefsummen, CRCs und Hashes) in Ihren bevorzugten
Dateibrowser unter GNU/Linux und Unix Betriebssystemen.

Caja, Dolphin, Konqueror, Krusader, Nemo, Nautilus, ROX-Filer, Thunar und Xfe
werden unterstuetzt.

Um alle Funktionen von Jacksum benutzen zu können, lassen Sie Jacksum auf
der Kommandozeile laufen.


Voraussetzungen
---------------
1) Ein GNU/Linux oder Unix Betriebssystem mit grafischer Oberflaeche.
   Ein headless-System ist nicht ausreichend.

2) Einen Dateimanager: Caja, Dolphin, Konqueror, Krusader,
   Nemo, Gnome Nautilus (Files), ROX-Filer, Thunar und Xfe werden unterstuetzt.

3) Eine komplette Java Laufzeitumgebung mit grafischen Bibliotheken. 
   Ein headless-OpenJDK ist nicht ausreichend.

   Beziehen Sie ein passende Java Laufzeitumgebung (JRE oder JDK)
   aus dem Internet:

   https://adoptium.net
   https://openjdk.java.net
   https://www.azul.com/downloads/?package=jdk
   https://bell-sw.com/pages/downloads/
   https://www.microsoft.com/openjdk/
   https://aws.amazon.com/de/corretto/
   https://sapmachine.io
   https://github.com/alibaba/dragonwell8
   https://www.oracle.com/java

4) jacksum-3.7.0.jar, and HashGarten-0.14.0.jar, und flatlaf-3.2.jar


Entpacken des Scripts
---------------------
bunzip2 < jacksum*integration*.tar.bz2 | tar xfv -
cd jacksum-file-browser-integration/


Starten des Scripts
-------------------
./jacksum-file-browser-integration.sh

Sie können das Script so oft aufrufen wie sie wollen.


Getestete Umgebungen
--------------------
Das Script wurde erfolgreich under vielen Systemen getestet. Details 
entnehmen Sie bitte dem Kommentarkopf aus dem Script.

Das Script sollte auch unter anderen GNU/Linux und Unix-Plattformen
funktionieren.


Fehler, Wuensche, Supportanfragen
---------------------------------
Besuchen Sie https://github.com/jonelo/jacksum-fbi-linux/issues

