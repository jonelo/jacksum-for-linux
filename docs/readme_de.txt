Beschreibung
------------
Jacksum File Browser Integration 2.9.0
für GNU/Linux und Unix Betriebssysteme (27.10.2024)
Copyright (C) 2006-2024 Dipl.-Inf. (FH) Johann N. Löfflmann

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
any later version.

Das Jacksum File Browser Integration Script installiert die primäre Funktion
von Jacksum (Berechnen von Prüfsummen, CRCs und Hashes) in Ihren bevorzugten
Dateibrowser unter GNU/Linux und Unix Betriebssystemen.

Um alle Funktionen von Jacksum benutzen zu können, lassen Sie Jacksum auf
der Kommandozeile laufen.


Voraussetzungen
---------------
1) Ein GNU/Linux oder Unix Betriebssystem mit grafischer Oberfläche.
   Ein headless-System ist nicht ausreichend.

2) Einen Dateimanager: Caja, Dolphin, elementary Files, GNOME Nautilus (Files),
   Konqueror, Krusader, muCommander, Nemo, PCManFM, PCManFM-Qt, ROX-Filer,
   SpaceFM, Thunar, Xfe und zzzFM werden unterstützt.

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

4) jacksum-3.7.0.jar, HashGarten-0.18.0.jar und flatlaf-3.5.2.jar


Entpacken des Scripts
---------------------
bunzip2 < jacksum*.tar.bz2 | tar xfv -
cd jacksum-for-linux/


Starten des Scripts
-------------------
./jacksum-for-linux.sh

Sie können das Script so oft aufrufen wie sie wollen.


Getestete Umgebungen
--------------------
Das Script wurde erfolgreich mit vielen Systemen getestet. Details
entnehmen Sie bitte dem Kommentarkopf aus dem Script.

Das Script sollte auch unter anderen GNU/Linux und Unix-Plattformen
funktionieren.


Fehler, Wünsche, Supportanfragen
--------------------------------
Besuchen Sie https://github.com/jonelo/jacksum-for-linux/issues
