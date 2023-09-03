#!/usr/bin/env bash
# 
#  Jacksum File Browser Integration for Unix and GNU/Linux Operating Systems
#  Copyright (c) 2006-2023 Dipl.-Inf. (FH) Johann N. Loefflmann
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#  * credit: this shell script is based on the bash script called 
#    Mount ISO 0.9.1 for KDE, which is released under the terms of the GNU GPL.
#    See also https://www.linux-apps.com/p/998451
#
#  * This script requires jacksum-3.4.0.jar and HashGarten-0.10.0.jar
#    which are part of the Jacksum file browser integration package for Linux since 2.0.0
#    See also https://jacksum.net
#
#  * Version 2.2.0 of the script has been successfully tested on the following systems,
#    and it should work on older platforms as well:
#
#    Caja 1.26.0 on Ubuntu Linux 22.04
#    Caja 1.26.0 on Ubuntu Linux 22.04.1
#
#    Files (known as Gnome Nautiulus) 42.6 on Ubuntu Linux 22.04.3
#    Files (known as Gnome Nautiulus) 42.2 on Ubuntu Linux 22.04.1
#    Files (known as Gnome Nautiulus) 42.1.1 on Ubuntu Linux 22.04
#    Files (known as Gnome Nautiulus) 3.26.4 on Ubuntu Linux 18.04
#
#    Dolphin 21.12.3 (KDE Framework 5.92) on Kubuntu 22.04
#
#    Nemo 5.2.4 on Ubuntu Linux 22.04.1
#    Nemo 5.2.4 on Ubuntu Linux 22.04
#
#    ROX Filer 2.11 on Ubuntu Linux 22.04
#    ROX Filer 2.24.33 on Ubuntu Linux 22.04.1
#
#    Xfe 1.43.2 on Ubuntu Linux 22.04.1
#    Xfe 1.43 on Ubuntu Linux 22.04
#
#
#  * Version 1.x of the script has been successfully tested on the following systems,
#    and it should work on similar platforms was well:
#
#    Caja 1.12.0 on Linux Mint 17.3 Mate
#
#    Dolphin 19.12.3 (KDE Framework 5.68.0) on Kubuntu 20.04.1
#    Dolphin 2.2 (KDE 4.14.8) on CentOS Linux 7.2
#
#    Gnome Nautilus 3.10.1 on Ubuntu Linux 14.04.4
#    Gnome Nautilus 3.4.2  on Ubuntu Linux 12.04
#    Gnome Nautilus 2.32.0 on Ubuntu Linux 10.10
#    Gnome Nautilus 2.30.1 on Ubuntu Linux 10.04
#    Gnome Nautilus 2.14.1 on Ubuntu Linux 6.06
#    Gnome Nautilus 2.12.1 on Ubuntu Linux 5.10
#    Gnome Nautilus 2.12.0 on OpenSUSE Linux 10
#    Gnome Nautilus 2.6.1  on Solaris 10/x86
#
#    KDE Konqueror 4.4.2 on Kubuntu Linux 10.04
#    KDE Konqueror 3.5.2 on PC-BSD 1.1
#    KDE Konqueror 3.4.2 on OpenSUSE Linux 10
#    KDE Konqueror 3.4.2 on Kanotix 4
#    KDE Konqueror 3.4.1 on Knoppix 4.0.2 Linux/x86
#
#    Nemo 2.8.6 on Linux Mint 17.3 Cinnamon
#    Nemo 1.8.4 on Ubuntu Linux 14.04.4
#
#    ROX Filer 2.6.1 on Puppy Linux 4.3.1
#    ROX Filer 2.5   on Ubuntu Linux 10.04
#
#    Thunar 1.6.10 on Manjaro 15.12
#    Thunar 1.2.3 on Ubuntu Linux 12.04
#    Thunar 1.0.1 on Ubuntu Linux 10.04
#
#    Xfe 1.41 on Ubuntu Linux 12.04
#    Xfe 1.37 on Ubuntu Linux 14.04
#
#    Note that some older systems that aren't listed above could cause problems
#    on read-only-filesystems (e.g. on life CDs), crashes of kate, or non-supported
#    servicemenus for KDE

VERSION="2.2.0"
NAME="jacksum"
JACKSUM_VERSION="3.7.0"
HASHGARTEN_VERSION="0.14.0"
PROGNAME="Jacksum File Browser Integration"
JACKSUM_JAR="`pwd`/jacksum-${JACKSUM_VERSION}.jar"
HASHGARTEN_JAR="`pwd`/HashGarten-${HASHGARTEN_VERSION}.jar"
ALGOS_DIRECT_SUGGESTION="cksum crc32 ed2k haval_256_5 md5 rmd160 sha1 sha256 sha3-256 sumbsd sumsysv whirlpool"
ALGORITHMS=""
COMMANDS="cmd_calc;1)_Calc_hash_values cmd_check;2)_Check_data_integrity cmd_cust;3)_Customized_output cmd_edit;4)_Edit_script cmd_help;5)_Help"

KDE_PROGNAME="Jacksum at Dolphin/Konqueror/Krusader"
GNOME_PROGNAME="Jacksum at Gnome Nautilus/Files"
ROX_PROGNAME="Jacksum at ROX-Filer"
THUNAR_PROGNAME="Jacksum at Thunar"
XFE_PROGNAME="Jacksum at Xfe"
NEMO_PROGNAME="Jacksum at Nemo"
CAJA_PROGNAME="Jacksum at Caja"


# -------------------------------------------------------------------------
print_line() {
# Prints a particular number of dashes.
#
# $1 number of dashes in the line
# -------------------------------------------------------------------------
    printf -- '-%.0s' {1..80}; printf '\n'
}


# -------------------------------------------------------------------------
print_header() {
# -------------------------------------------------------------------------
  printf "                - $PROGNAME v$VERSION -\n"
  printf "                            https://jacksum.net\n\n"
}


# -------------------------------------------------------------------------
print_menu() {
# -------------------------------------------------------------------------
  printf "Menu:\n"
  printf "  1 - Install   %s for %s %s\n" "$KDE_PROGNAME"    "$USERS" "$KDE_DISABLED"
  printf "  2 - Uninstall %s for %s %s\n" "$KDE_PROGNAME"    "$USERS" "$KDE_DISABLED"
  printf "  3 - Install   %s for %s %s\n" "$GNOME_PROGNAME"  "$USERS" "$GNOME_DISABLED"
  printf "  4 - Uninstall %s for %s %s\n" "$GNOME_PROGNAME"  "$USERS" "$GNOME_DISABLED"
  printf "  5 - Install   %s for %s %s\n" "$ROX_PROGNAME"    "$USERS" "$ROX_DISABLED"
  printf "  6 - Uninstall %s for %s %s\n" "$ROX_PROGNAME"    "$USERS" "$ROX_DISABLED"
  printf "  7 - Install   %s for %s %s\n" "$THUNAR_PROGNAME" "$USERS" "$THUNAR_DISABLED"
  printf "  8 - Uninstall %s for %s %s\n" "$THUNAR_PROGNAME" "$USERS" "$THUNAR_DISABLED"
  printf "  9 - Install   %s for %s %s\n" "$XFE_PROGNAME"    "$USERS" "$XFE_DISABLED"
  printf " 10 - Uninstall %s for %s %s\n" "$XFE_PROGNAME"    "$USERS" "$XFE_DISABLED"
  printf " 11 - Install   %s for %s %s\n" "$NEMO_PROGNAME"   "$USERS" "$NEMO_DISABLED"
  printf " 12 - Uninstall %s for %s %s\n" "$NEMO_PROGNAME"   "$USERS" "$NEMO_DISABLED"
  printf " 13 - Install   %s for %s %s\n" "$CAJA_PROGNAME"   "$USERS" "$CAJA_DISABLED"
  printf " 14 - Uninstall %s for %s %s\n" "$CAJA_PROGNAME"   "$USERS" "$CAJA_DISABLED"
  printf "\n"
  printf "  q - Quit the installer\n"
  print_line 80
}


# -------------------------------------------------------------------------
check_env() {
# -------------------------------------------------------------------------
# parameters:
# - $1 = Description
# - $2 = Default location
# - $3 = Fallback
# -------------------------------------------------------------------------
  if ( test -d "$2" ) then
    DIR="$2"
  elif ( test -d "$3" ) then
    DIR="$3"
  else
    echo
    while ( test ! -d "$DIR" )
    do
      echo "Couldn't find $1!"
      printf "Type the absolute path here or press \"Ctrl+C\" to abort: "
      read DIR
    done
  fi
  DIR="`dirname "$DIR"`/`basename "$DIR"`"
}


# -------------------------------------------------------------------------
check_bin() {
# parameters:
# - $1 = Binary name
# - $2 = Default location
# -------------------------------------------------------------------------
  BIN=""
  WHICH="`which "$1" 2> /dev/null`"
  if ( test -f "$2" ) then
    BIN="$2"
    echo "  [$1]: $BIN"
  elif ( test -f "$WHICH" ) then
    BIN="$WHICH"
    echo "  [$1]: $BIN"
  else
    echo "  [$1]: >> not found <<"
  fi
}


# -------------------------------------------------------------------------
check_file() {
# parameters:
# - $1 = file name
# - $2 = Default location
# -------------------------------------------------------------------------
  BIN=""
  if ( test -f "$2" ) then
    BIN="$2"
    echo "  [$1]: $BIN"
  else
    echo "  [$1]: >> not found <<"
  fi
}


# -------------------------------------------------------------------------
find_bin() {
# parameters:
# - $1 = Description for the binary
# - $2 = Default location
# -------------------------------------------------------------------------
  printf "\n"
  BIN=""
  if ( test ! -z "$2" ) then
    printf "Type the absolute path to \"%s\"\n" "$1"
    printf "and press \"Enter\" to continue [%s]: " "$2"
    read BIN
    test -z "$BIN" && BIN="$2"
  fi
  while ( test ! -f "$BIN" )
  do
    printf "Couldn't find \"%s\"!\n" "$1"
    printf "Type the absolute path here or \"Ctrl+C\" to abort: "
    read BIN
  done
}


# -------------------------------------------------------------------------
version_value() {
# normalizes the version and returns a comparable version as a number
# parameters:
# $1 version, e.g. 12.34.567
# -------------------------------------------------------------------------
  printf "%03d%03d%03d" $(echo "$1" | tr '.' '\n' | head -n 3)
}


# -------------------------------------------------------------------------
set_env() {
# parameters:
# $1 kde, gnome, xfe, rox, thunar, nemo, caja
# -------------------------------------------------------------------------
  case $1 in
    kde)
      KDE=""

      if [ "$KDE" = "" ]; then
        type kf5-config &> /dev/null
        if [ $? -eq 0 ]; then
          # KDE Framework 5.x
          KDE=5
          KDE_DISABLED=""
          if [ $(id | cut -c5) -ne 0 ]; then
            # non-root user
            LOCAL=""
            check_env "KDE config folder" "$LOCAL" "$HOME/.local"
            USERS="user "$(whoami)
          else
            SYSTEM=""
            check_env "KDE install prefix" "$SYSTEM" "/usr"
            USERS="all users"
          fi
          PREFIX="$DIR"
          KDEPOSTFIX="/share/kservices5/ServiceMenus/"
        fi
      fi

      if [ "$KDE" = "" ]; then
        kde4-config > /dev/null 2>&1
        if [ $? -eq 0 ]; then
          # KDE 4.x
          KDE=4
          KDE_DISABLED=""
          if [ $(id | cut -c5) -ne 0 ]; then
            # non-root user
            LOCAL="`kde4-config --localprefix 2>/dev/null`"
            check_env "KDE config folder" "$LOCAL" "$HOME/.kde"
            USERS="user "`whoami`
          else
            SYSTEM="`kde4-config --prefix 2>/dev/null`"
            check_env "KDE install prefix" "$SYSTEM" "/opt/kde4"
            USERS="all users"
          fi
          PREFIX="$DIR"
          KDEPOSTFIX="/share/kde4/services/ServiceMenus/"
        fi
      fi

      if [ "$KDE" = "" ]; then
        kde-config > /dev/null 2>&1
        if [ $? -eq 0 ]; then
          # KDE 3.x
          KDE=3
          KDE_DISABLED=""
          if [ $(id | cut -c5) -ne 0 ]; then
            # non-root user
            LOCAL="`kde-config --localprefix 2>/dev/null`"
            check_env "KDE config folder" "$LOCAL" "$HOME/.kde"
            USERS="user "`whoami`
          else
            SYSTEM="`kde-config --prefix 2>/dev/null`"
            check_env "KDE install prefix" "$SYSTEM" "/opt/kde3"
            USERS="all users"
          fi
          PREFIX="$DIR"
          KDEPOSTFIX="/share/apps/konqueror/servicemenus/"
        fi
      fi

      if [ "$KDE" = "" ]; then
        # no KDE
        KDE=0
        KDE_DISABLED="(DISABLED)"
        USERS="user "`whoami`
      fi
      ;;
   gnome)
      nautilus --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        GNOME=0
        GNOME_DISABLED="(DISABLED)"
      else
        GNOME=1
        GNOME_DISABLED=""
        if ( test `nautilus --version | cut -c16` -ge 2 ) then

          if ( test -e "$HOME/.local/share/nautilus/scripts" ) then
              # In Ubuntu 14.04 and later, Nautilus config folder is
              PREFIX="$HOME/.local/share/nautilus"
              FB_SCRIPTFOLDER=scripts
          else
              # Starting with Nautilus 2.x, the Nautilus config folder is
              PREFIX="$HOME/.gnome2"
              FB_SCRIPTFOLDER=nautilus-scripts
          fi
        else
          # Starting with Nautilus 1.0.5, the Nautilus config folder is
          PREFIX="$HOME/.gnome"
          FB_SCRIPTFOLDER=nautilus-scripts
        fi
      fi
      ;;
   nemo)
      nemo --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        NEMO=0
        NEMO_DISABLED="(DISABLED)"
      else
        NEMO=1
        NEMO_DISABLED=""
        NEMOVER=$(nemo --version | cut -f2 -d' ')
        if [ $(version_value $NEMOVER) -ge $(version_value 2.6.7) ]; then
            # starting with Nemo 2.6.7 Nemo's config folder is
            PREFIX="$HOME/.local/share/nemo"
            FB_SCRIPTFOLDER=scripts
        else
            # before that, Nemo's config folder was
            PREFIX="$HOME/.gnome2"
            FB_SCRIPTFOLDER=nemo-scripts
        fi
      fi
      ;;
    xfe)
      xfe --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        XFE=0
        XFE_DISABLED="(DISABLED)"
      else
        XFEVER=$(xfe --version | cut -f3 -d' ')
        # script folder is supported starting with Xfe 1.35
        if [ $(version_value $XFEVER) -ge $(version_value 1.35) ]; then
            XFE=1
            XFE_DISABLED=""
            PREFIX="$HOME/.config/xfe"
            FB_SCRIPTFOLDER=scripts
        else
            XFE=0
            XFE_DISABLED="(DISABLED)"
        fi
      fi
      ;;
   caja)
      caja --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        CAJA=0
        CAJA_DISABLED="(DISABLED)"
      else
        CAJA=1
        CAJA_DISABLED=""
        PREFIX="$HOME/.config/caja"
        FB_SCRIPTFOLDER=scripts
      fi
      ;;
    rox)
      rox --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        ROX=0
        ROX_DISABLED="(DISABLED)"
      else
        ROX=1
        ROX_DISABLED=""
        PREFIX="$HOME/.config/rox.sourceforge.net"
      fi
      ;;
    thunar)
      thunar --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        THUNAR=0
        THUNAR_DISABLED="(DISABLED)"
      else
        THUNAR=1
        THUNAR_DISABLED=""
        PREFIX="$HOME/.config/Thunar"
      fi
      ;;
  esac
}


# -------------------------------------------------------------------------
uninstall() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# -------------------------------------------------------------------------
  uninstall_silent $1
  printf "\nUninstallation finished. Press any key to continue ... "
  read DUMMY
}


# -------------------------------------------------------------------------
uninstall_silent() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# -------------------------------------------------------------------------
  case $1 in
      kde) uninstall_kde
           ;;
    gnome) uninstall_gnome
           ;;
      rox) uninstall_rox
           ;;
   thunar) uninstall_thunar
           ;;
      xfe) uninstall_xfe
           ;;
     nemo) uninstall_nemo
           ;;
     caja) uninstall_caja
           ;;
  esac
}


# -------------------------------------------------------------------------
uninstall_kde() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"
  DSK="$PREFIX$KDEPOSTFIX$NAME.desktop"

  printf "\n  Removing %s.sh:                " "$NAME"
  if ( test -d "$SH" )
  then
    rm -r "$SH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
  else
    echo "[ NOT INSTALLED ]"
  fi
  printf "  Removing $NAME.desktop:           "
  if ( test -f "$DSK" )
  then
    rm "$DSK" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
  else
    echo "[ NOT INSTALLED ]"
  fi
}


# -------------------------------------------------------------------------
uninstall_gnome() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"
  SCRIPTS="$PREFIX/$FB_SCRIPTFOLDER/$NAME/"

  printf "\n  Removing %s.sh:                " "$NAME"
  if ( test -d "$SH" )
  then
    rm -r "$SH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
  else
    echo "[ NOT INSTALLED ]"
  fi
  printf "  Removing $NAME scripts:           "
  if ( test -d "$SCRIPTS" )
  then
    rm -r "$SCRIPTS" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
  else
    echo "[ NOT INSTALLED ]"
  fi
}


# -------------------------------------------------------------------------
uninstall_xfe() {
# -------------------------------------------------------------------------
  uninstall_gnome
}


# -------------------------------------------------------------------------
uninstall_nemo() {
# -------------------------------------------------------------------------
  uninstall_gnome
}


# -------------------------------------------------------------------------
uninstall_caja() {
# -------------------------------------------------------------------------
  uninstall_gnome
}


# -------------------------------------------------------------------------
uninstall_rox() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"
  SCRIPTS="$PREFIX/SendTo/$NAME/"

  printf "\n  Removing %s.sh:                " "$NAME"
  if ( test -d "$SH" )
  then
    rm -r "$SH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
  else
    echo "[ NOT INSTALLED ]"
  fi
  printf "  Removing $NAME scripts:           "
  if ( test -d "$SCRIPTS" )
  then
    # removing the symlink
    rm "$SCRIPTS/../../OpenWith/$NAME"
    # removing all scripts
    rm -r "$SCRIPTS" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
  else
    echo "[ NOT INSTALLED ]"
  fi
}


# -------------------------------------------------------------------------
uninstall_thunar() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"

  printf "\n  Removing %s.sh:                " "$NAME"
  if ( test -d "$SH" )
  then
    rm -r "$SH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
  else
    echo "[ NOT INSTALLED ]"
  fi
  printf "  Removing $NAME entries:           "
  # restore the backup
  THUNARXML="$PREFIX/uca.xml"
  THUNARXMLBACKUP="$PREFIX/uca.before-jacksum.xml"
  if (test ! -f "$THUNARXMLBACKUP" )
  then
    echo "[ NOT INSTALLED ]"
  else
    cp "$THUNARXMLBACKUP" "$THUNARXML"
    rm "$THUNARXMLBACKUP"
    echo "[  OK  ]"
  fi
}


# -------------------------------------------------------------------------
install_menu() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# -------------------------------------------------------------------------
  case $1 in
      kde) install_menu_kde
           ;;
    gnome) install_menu_gnome
           ;;
      rox) install_menu_rox
           ;;
   thunar) install_menu_thunar
           ;;
      xfe) install_menu_xfe
           ;;
     nemo) install_menu_nemo
           ;;
     caja) install_menu_caja
           ;;
  esac
}


# -------------------------------------------------------------------------
install_menu_kde() {
# -------------------------------------------------------------------------
  printf "  Creating a folder for servicemenus: "

  if ( test ! -d "$PREFIX$KDEPOSTFIX" )
  then
    mkdir -p "$PREFIX$KDEPOSTFIX" 2>/dev/null
    test -d "$PREFIX$KDEPOSTFIX" &&
    echo "[  OK  ]" || { echo "[FAILED]" ; exit 1; }
  else
    echo "[  OK  ]"
  fi

  DESKFILE="$PREFIX$KDEPOSTFIX$NAME.desktop"
  printf "  Installing %s.desktop:         " $NAME

  # gather all action codes
  for i in $COMMANDS
  do
    CMD=`echo $i | awk -F";" '{print $1 }'`
    ACTIONS="$ACTIONS;$CMD"
  done
  for i in $ALGORITHMS
  do
    ACTIONS="$ACTIONS;$i"
  done
  ACTIONS=`echo "$ACTIONS" | sed -e "s/^;//"`

  echo "[Desktop Entry]" > $DESKFILE
  if (test $KDE -ge 4) then
    echo "Type=Service" >> $DESKFILE
    echo "ServiceTypes=KonqPopupMenu/Plugin" >> $DESKFILE
    echo "MimeType=inode/directory;application/octet-stream" >> $DESKFILE
  else
    echo "ServiceTypes=all/all" >> $DESKFILE
  fi

  echo "Actions=$ACTIONS;" >> $DESKFILE
  echo "Encoding=UTF-8" >> $DESKFILE
  echo "X-KDE-Submenu=Jacksum" >> $DESKFILE
  echo >> $DESKFILE

  for i in $COMMANDS
  do
    CMD=`echo $i | awk -F";" '{print $1 }'`
    TXT=`echo $i | awk -F";" '{print $2 }' | sed -e "s/_/ /g"`
    echo "[Desktop Action $CMD]" >> $DESKFILE
    echo "Icon=binary" >> $DESKFILE
    echo "Name=$TXT" >> $DESKFILE
    echo "Exec=$JACKSUMSH $CMD %U" >> $DESKFILE
    echo >> $DESKFILE
  done

  for i in $ALGORITHMS
  do
    echo "[Desktop Action $i]" >> $DESKFILE
    echo "Icon=binary" >> $DESKFILE
    echo "Name=$i" >> $DESKFILE
    echo "Exec=$JACKSUMSH $i %U" >> $DESKFILE
    echo >> $DESKFILE
  done

  test -f "$DESKFILE" &&
  echo "[  OK  ]" || { echo "[FAILED]" ; exit 1; }
}


# -------------------------------------------------------------------------
install_menu_gnome_shared() {
# function for Nautilus, Xfe and Nemo
# -------------------------------------------------------------------------
  printf "  Creating a folder for all scripts:  "
  if ( test ! -d "$SCRIPTFOLDER" )
  then
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null
    test -d "$SCRIPTFOLDER" &&
    echo "[  OK  ]" || { echo "[FAILED]" ; exit 1; }
  else
    echo "[  OK  ]"
  fi

  printf "  Installing scripts:                 "

  for i in $COMMANDS
  do
    CMD=`echo $i | awk -F";" '{print $1 }'`
    TXT=`echo $i | awk -F";" '{print $2 }' | sed -e "s/_/ /g"`
    echo "#!/bin/sh" > "$SCRIPTFOLDER/$TXT"
    echo "exec $JACKSUMSH $CMD \"\$@\"" >> "$SCRIPTFOLDER/$TXT"
    chmod +x "$SCRIPTFOLDER/$TXT"
  done

  for i in $ALGORITHMS
  do
    echo "#!/bin/sh" > "$SCRIPTFOLDER/$i"
    echo "exec $JACKSUMSH $i \"\$@\"" >> "$SCRIPTFOLDER/$i"
    chmod +x "$SCRIPTFOLDER/$i"
  done

  echo "[  OK  ]"
}


# -------------------------------------------------------------------------
install_menu_gnome() {
# -------------------------------------------------------------------------
  SCRIPTFOLDER="$PREFIX/$FB_SCRIPTFOLDER/$NAME/"
  install_menu_gnome_shared
}


# -------------------------------------------------------------------------
install_menu_xfe() {
# -------------------------------------------------------------------------
  SCRIPTFOLDER="$PREFIX/$FB_SCRIPTFOLDER/$NAME/"
  install_menu_gnome_shared
}


# -------------------------------------------------------------------------
install_menu_nemo() {
# -------------------------------------------------------------------------
  SCRIPTFOLDER="$PREFIX/$FB_SCRIPTFOLDER/$NAME/"
  install_menu_gnome_shared
}


# -------------------------------------------------------------------------
install_menu_caja() {
# -------------------------------------------------------------------------
  SCRIPTFOLDER="$PREFIX/$FB_SCRIPTFOLDER/$NAME/"
  install_menu_gnome_shared
}


# -------------------------------------------------------------------------
install_menu_rox() {
# -------------------------------------------------------------------------
  # on Ubuntu 10.04 (ROX-Filer 2.5), the folder is called SendTo
  SCRIPTFOLDER="$PREFIX/SendTo/$NAME"
  printf "  Creating a folder for all scripts:  "
  if ( test ! -d "$SCRIPTFOLDER" )
  then
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null
    test -d "$SCRIPTFOLDER" &&
    echo "[  OK  ]" || { echo "[FAILED]" ; exit 1; }
  else
    echo "[  OK  ]"
  fi
  # on Puppy Linux 4.3.1 (ROX-Filer 2.6.1), the folder is called OpenWith
  OPENWITHFOLDER="$PREFIX/OpenWith"
  if ( test ! -d "$OPENWITHFOLDER" )
  then
    mkdir -p "$OPENWITHFOLDER" 2>/dev/null
  fi
  # simply make a symlink in order to be cross compatible
  ln -s $SCRIPTFOLDER "$OPENWITHFOLDER/$NAME"

  printf "  Installing scripts:                 "

  for i in $COMMANDS
  do
    CMD=`echo $i | awk -F";" '{print $1 }'`
    TXT=`echo $i | awk -F";" '{print $2 }' | sed -e "s/_/ /g"`
    echo "#!/bin/sh" > "$SCRIPTFOLDER/$TXT"
    echo "exec $JACKSUMSH $CMD \$@" >> "$SCRIPTFOLDER/$TXT"
    chmod +x "$SCRIPTFOLDER/$TXT"
  done

  for i in $ALGORITHMS
  do
    echo "#!/bin/sh" > "$SCRIPTFOLDER/$i"
    echo "exec $JACKSUMSH $i \$@" >> "$SCRIPTFOLDER/$i"
    chmod +x "$SCRIPTFOLDER/$i"
  done

  echo "[  OK  ]"
}


# -------------------------------------------------------------------------
install_menu_thunar() {
# -------------------------------------------------------------------------
  THUNARXML="$PREFIX/uca.xml"
  THUNARXMLBACKUP="$PREFIX/uca.before-jacksum.xml"
  printf "  Backing up uca.xml:                 "
  if (test ! -f "$THUNARXML" )
  then
    echo "[ NOT FOUND ]"
    # let's put a default file here
    echo '<?xml encoding="UTF-8" version="1.0"?><actions></actions>' > $THUNARXML
    cp "$THUNARXML" "$THUNARXMLBACKUP"
  else
    cp "$THUNARXML" "$THUNARXMLBACKUP"
    echo "[  OK  ]"
  fi

  printf "  Installing entries:                 "

  MYTEMP=/tmp/jacksum.$$.temp
  # the actions block without the closing action tag
  grep actions $THUNARXML | sed 's/<\/actions>//' > $MYTEMP

  for i in $COMMANDS
  do
    CMD=`echo $i | awk -F";" '{print $1 }'`
    TXT=`echo $i | awk -F";" '{print $2 }' | sed -e "s/_/ /g"`

    echo '<action>' >> $MYTEMP
    echo "<name>Jacksum - $TXT</name>" >> $MYTEMP
    echo "<command>$JACKSUMSH $CMD %F</command>" >> $MYTEMP
    echo "<description>$TXT</description>" >> $MYTEMP
    echo '<patterns>*</patterns>' >> $MYTEMP
    echo '<directories/><audio-files/><image-files/><other-files/><text-files/><video-files/>' >> $MYTEMP
    echo '</action>' >> $MYTEMP
  done

  for i in $ALGORITHMS
  do
    echo '<action>' >> $MYTEMP
    echo "<name>Jacksum - $i</name>" >> $MYTEMP
    echo "<command>$JACKSUMSH $i %F</command>" >> $MYTEMP
    echo "<description>Calculate digital fingerprints by $i</description>" >> $MYTEMP
    echo '<patterns>*</patterns>' >> $MYTEMP
    echo '<directories/><audio-files/><image-files/><other-files/><text-files/><video-files/>' >> $MYTEMP
    echo '</action>' >> $MYTEMP
  done

  echo '</actions>' >> $MYTEMP
  grep "xml encoding" $THUNARXMLBACKUP | grep version > $THUNARXML
  cat $MYTEMP | tr -d '\n' >> $THUNARXML
  echo "" >> $THUNARXML

  echo "[  OK  ]"
}


# -------------------------------------------------------------------------
install_script() {
# parameters:
# kde, gnome, rox, thunar, xfe, caja or nemo
# -------------------------------------------------------------------------
  case $1 in
      kde|gnome|rox|thunar|xfe|nemo|caja) install_script_generic
           ;;
      *) printf "file browser $1 is not supported. Exit.\n"
         exit 1
           ;;
  esac
}


# -------------------------------------------------------------------------
install_script_sh() {
# -------------------------------------------------------------------------

  echo '#!/bin/bash
#
# Jacksum File Browser Integration Script, https://jacksum.net
# Copyright (c) 2006-2023 Johann N. Loefflmann, https://johann.loefflmann.net
# Code has been released under the conditions of the GPLv3+.
#

viewer() {' > "$JACKSUMSH"

    if [ "${VIEWER##*/}" = "zenity" ]; then
        echo '    cat "$1" | "'"${VIEWER}"'" --text-info --width 800 --height 600 --title "Jacksum: $1" --no-wrap --font="Monospace" "$1"' >> "$JACKSUMSH"
    else
        echo '    "'"${EDIT}"'" "$1"' >> "$JACKSUMSH"
    fi
echo '}

FILE_LIST="/tmp/jacksum-'"${JACKSUM_VERSION}"'-filelist.txt"
OUTPUT="/tmp/jacksum-'"${JACKSUM_VERSION}"'-output.txt"
ERROR_LOG="/tmp/jacksum-'"${JACKSUM_VERSION}"'-error.txt"
CHECK_FILE="/tmp/jacksum-'"${JACKSUM_VERSION}"'-check.txt"
JAVA="'"${JAVA}"'"
JACKSUM_JAR="'"${JACKSUM_JAR}"'"
HASHGARTEN_JAR="'"${HASHGARTEN_JAR}"'"

cat /dev/null > $FILE_LIST
VIRGIN=1
for i in "$@"
do
    # ignore the 1st arg
    if [ "$VIRGIN" -eq 1 ]; then
        VIRGIN=0
    else
        # make sure that we get always absolute paths for both directories and files
        if [ -d "$i" ]; then
            ABSOLUTE="$(cd "$i" && pwd)"
        else
            ABSOLUTE="$(cd "$(dirname "$i")" && pwd)/$(basename "$i")"
        fi
        printf "%s\n" "${ABSOLUTE}" >> "${FILE_LIST}"
    fi
done
cd "$HOME"
ALGO=$1
shift
case $ALGO in

  "cmd_calc")
  "${JAVA}" -jar "${HASHGARTEN_JAR}" --header -O relative -U ${ERROR_LOG} --file-list-format list --file-list ${FILE_LIST} --path-relative-to-entry 1 --verbose default,summary
  rm relative > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
      # Generate an output that contains both stdout and stderr in a file for the viewer
      # CHECK_FILE contains the output file name that the user has been specified at the GUI
  
      CHECK_FILE=$(grep gui.output $HOME/.HashGarten.properties)
      # We need to strip the key called gui.output= and undo any escapes done by Java''s properties API
      CHECK_FILE=${CHECK_FILE#*=}
 
      cat ${CHECK_FILE} ${ERROR_LOG} > ${OUTPUT}
      viewer "${OUTPUT}"
  fi
  ;;


  "cmd_check")
  if [ ! -f relative ]; then
      touch relative
  fi
  "${JAVA}" -jar "${HASHGARTEN_JAR}" --header -c relative -O ${OUTPUT} -U ${OUTPUT} --file-list-format list --file-list ${FILE_LIST} --path-relative-to-entry 1 --verbose default,summary
  rm relative > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    viewer "${OUTPUT}"
  fi
  ;;


  "cmd_cust")
  cat /dev/null > "${OUTPUT}"
  ALGOS="md5+sha1+ripemd160+tiger+\
sha256+sha512/256+sha3-256+shake128+sm3+streebog256+kupyna-256+lsh-256-256+blake3+k12+keccak256+\
sha512+sha3-512+shake256+streebog512+kupyna-512+lsh-512-512+blake2b-512+keccak512+m14+skein-512-512+whirlpool"
  TEMPLATE='\''File info:
    name:                      #FILENAME{name}
    path:                      #FILENAME{path}
    size:                      #FILESIZE bytes

legacy message digests (avoid if possible):
    MD5 (128 bit):             #HASH{md5}
    SHA1 (160 bit):            #HASH{sha1}
    RIPEMD-160 (160 bit):      #HASH{ripemd160}
    TIGER (192 bit):           #HASH{tiger}

256 bit message digests (hex):
    SHA-256 (USA):             #HASH{sha256}
    SHA-512/256 (USA):         #HASH{sha512/256}
    SHA3-256 (USA):            #HASH{sha3-256}
    SHAKE128 (USA):            #HASH{shake128}
    SM3 (China):               #HASH{sm3}
    STREEBOG 256 (Russia):     #HASH{streebog256}
    Kupyna256 (Ukraine):       #HASH{kupyna-256}
    LSH-256-256 (South Korea): #HASH{lsh-256-256}
    BLAKE3:                    #HASH{blake3}
    KangarooTwelve:            #HASH{k12}
    KECCAK256:                 #HASH{keccak256}

512 bit message digests (base64, no padding):
    SHA-512 (USA):             #HASH{sha512,base64-nopadding}
    SHA3-512 (USA):            #HASH{sha3-512,base64-nopadding}
    SHAKE256 (USA):            #HASH{shake256,base64-nopadding}
    STREEBOG 512 (Russia):     #HASH{streebog512,base64-nopadding}
    KUPYNA-512 (Ukraine):      #HASH{kupyna-512,base64-nopadding}
    LSH-512-512 (South Korea): #HASH{lsh-512-512,base64-nopadding}
    BLAKE2b-512:               #HASH{blake2b-512,base64-nopadding}
    KECCAK512:                 #HASH{keccak512,base64-nopadding}
    MarsupilamiFourteen:       #HASH{m14,base64-nopadding}
    SKEIN-512-512:             #HASH{skein-512-512,base64-nopadding}
    WHIRLPOOL:                 #HASH{whirlpool,base64-nopadding}

'\''

  "${JAVA}" -jar "${JACKSUM_JAR}" -a "${ALGOS}" -E hex --format "${TEMPLATE}" \
  --file-list "${FILE_LIST}" --file-list-format list \
  -O "${OUTPUT}" -U "${OUTPUT}"

  viewer "${OUTPUT}"
  ;;

  "cmd_edit")
  "'"${EDIT}"'" "'"${JACKSUMSH}"'"
  exit
  ;;

  "cmd_help")
  "${JAVA}" -jar "${JACKSUM_JAR}" --help > "${OUTPUT}"
  viewer "${OUTPUT}"
  ;;

  *)
  "${JAVA}" -jar "${JACKSUM_JAR}" -a $ALGO --header \
  --file-list "${FILE_LIST}" --file-list-format list --path-relative-to-entry 1 \
  -O "${OUTPUT}" -U "${OUTPUT}"
  viewer "${OUTPUT}"
  ;;

esac

' >> "${JACKSUMSH}"
}


# -------------------------------------------------------------------------
install_script_generic() {
# -------------------------------------------------------------------------
  JACKSUM_VER=$("$JAVA" -jar "$JACKSUM_JAR" -v)
  printf "  Found %s:                [  OK  ]\n" "$JACKSUM_VER"

  printf "  Installing %s.sh:              " "$NAME"
  if ( test -d "$PREFIX/share/apps/$NAME/" )
  then
    rm -r "$PREFIX/share/apps/$NAME"
  fi

  JACKSUMSH="$PREFIX/share/apps/$NAME/$NAME.sh"
  mkdir -p "$PREFIX/share/apps/$NAME" 2>/dev/null

  test -d "$PREFIX/share/apps/$NAME" &&
  install_script_sh &&
  chmod +x "$JACKSUMSH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
}


# -------------------------------------------------------------------------
function find_app() {
# -------------------------------------------------------------------------
  if [[ "$#" == "0" ]]; then
    printf >&2 "FATAL: at least one parameter is required in find_app(). Exit.\n"
    exit 1
  fi
  while (( "$#" )); do
    if type -P "$1" >/dev/null; then
      APP="$(type -P "$1")"
      break
    fi
    shift
  done
}


# -------------------------------------------------------------------------
print_params() {
# -------------------------------------------------------------------------
  printf "\nCurrent parameters:\n"
  check_bin "java" "$JAVA"
  JAVA="$BIN"

  check_file "jacksum-${JACKSUM_VERSION}.jar" "$JACKSUM_JAR"
  JACKSUM_JAR="$BIN"

  check_file "HashGarten-${HASHGARTEN_VERSION}.jar" "$HASHGARTEN_JAR"
  HASHGARTEN_JAR="$BIN"

  check_bin "Viewer" "$VIEWER"
  VIEWER="$BIN"

  check_bin "Editor" "$EDIT"
  EDIT="$BIN"

  printf "  [direct accessible algorithms]: %s\n\n" "$ALGORITHMS"
}


# -------------------------------------------------------------------------
enter_java() {
# -------------------------------------------------------------------------
  JAVA_FOUND=0
  while [ $JAVA_FOUND -eq 0 ]
  do
    find_bin "java" "$JAVA"
    JAVA="$BIN"

    JAVA_VERSION="$("$JAVA" -fullversion 2>&1)"
    JAVA_VERSION="${JAVA_VERSION#*\"}"
    JAVA_VERSION="${JAVA_VERSION%\"*}"
    JAVA_VERSION="${JAVA_VERSION%%_*}"
    JAVA_VERSION="${JAVA_VERSION%%+*}"

    if [ $(version_value "$JAVA_VERSION") -lt $(version_value 11.0.0) ]; then
       printf "Java version %s must be at least 11\n" "$JAVA_VERSION"
    else
       JAVA_FOUND=1
    fi
  done
}

# -------------------------------------------------------------------------
modify_params() {
# -------------------------------------------------------------------------
  printf "\nA complete JDK is required. If you use a headless JDK, you cannot use HashGarten which is a GUI for Jacksum.\n"
  printf "You could go to https://adoptium.net for example to obtain a full JDK.\n"

  enter_java

  printf "\n\nThe jar files Jacksum, HashGarten, and FlatLaf have to be stored in the same folder. The script won't copy those files anywhere, but during runtime it expects those binaries to be there at the specified location after the installation.\n"
  find_bin "jacksum-${JACKSUM_VERSION}.jar" "$JACKSUM_JAR"
  JACKSUM_JAR="$BIN"
  
  find_bin "HashGarten-${HASHGARTEN_VERSION}.jar" "$HASHGARTEN_JAR"
  HASHGARTEN_JAR="$BIN"

  printf "\n\nTo view text output, you need to specify a viewer or an editor.\n"
  find_bin "viewer" "$VIEWER"
  VIEWER="$BIN"

  printf "\n\nTo use the \"Edit the script\" feature, you need to specify an editor.\n"
  find_bin "editor" "$EDIT"
  EDIT="$BIN"
  
  select_algorithms
}


# -------------------------------------------------------------------------
print_info_kde() {
# -------------------------------------------------------------------------
  if (test $KDE -gt 1) then
    echo "Info:"
    echo "  This installer can install $KDE_PROGNAME."
    # if not root
    if ( test `id | cut -c5` -ne 0 ) then
      echo "  If you want to install $KDE_PROGNAME"
      echo "  for all users, run the script as root."
    else
      echo "  If you want to install $KDE_PROGNAME"
      echo "  only for one user, run the script as a normal user. If you have a Live CD,"
      echo "  you must run the script as normal user, because CDs are read only."
    fi
    print_line 80
  fi
}


# -------------------------------------------------------------------------
select_algorithms() {
# ------------------------------------------------------------------------- 
  printf "\n\n"
  local YESNO=""
  while ( test "$YESNO" != "y" ) && ( test "$YESNO" != "n" ) ; do
    printf "Do you want to access some algorithms directly without the HashGarten GUI?\nType n to disable direct access to algorithms, type p or any other key to use the previous selection [n]: "
    read YESNO
    test -z "$YESNO" && YESNO="n"
    case "$YESNO" in
      "y")
         if [ -z "$ALGOS_SUPPORTED" ]; then
             ALGOS_SUPPORTED="$("$JAVA" -jar "$JACKSUM_JAR" -a all -l | xargs)"
         fi
         if [ "$ALGORITHMS" = "" ]; then
             ALGORITHMS="$ALGOS_DIRECT_SUGGESTION"
         fi
         printf "\nJacksum %s supports the following algorithms:\n%s\n\n" "$JACKSUM_VERSION" "$ALGOS_SUPPORTED"
         printf "Feel free to modify the selection again [%s]: " "$ALGORITHMS"
         read ALGOS
         test -z "$ALGOS" && ALGOS="$ALGORITHMS"
         ALGORITHMS="$ALGOS"
         ;;
      "n")
         ALGORITHMS=""
         ;;
        *)
         ;;
    esac
  done
}


# ------------------------------------------------------------------------- 
install_interactive() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# ------------------------------------------------------------------------- 
  local YESNO=""
  while [ "$YESNO" != "y" ]; do
    print_params
    printf "Do you want to use the parameters above? [y]: "
    read YESNO
    test -z "$YESNO" && YESNO="y"

    case "$YESNO" in
      "y")
          printf "\n"
          uninstall_silent $1
          install_script $1
          install_menu $1
          ;;
      "n")
          modify_params
          ;;
        *)
          ;;
     esac
  done

  echo
  echo "Installation finished."
  install_done $1
}


# ------------------------------------------------------------------------- 
restart_fb() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# $2 Name of the file browser
# ------------------------------------------------------------------------- 
  local YESNO=""
  printf "Do you want to restart $2 so that changes can become active? [y]: "
  read YESNO
  test -z "$YESNO" && YESNO="y"
  case "$YESNO" in
    "y") # redirecting standard error into standard output
         # in order to avoid ugly warnings from Nautilus
         $1 --quit > /dev/null 2>&1 &
         # avoid a potential race condition (sf# 3099869)
         # (sleep does not cause harm to others)
         printf "Please wait ... "
         sleep 5
         # some older Nautilus restart Nautilus after a quit
         # we ignore that fact and start Nautilus in any case
         $1 > /dev/null 2>&1 &
         ;;
      *)
         ;;
  esac
}


# ------------------------------------------------------------------------- 
install_done() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# ------------------------------------------------------------------------- 
  case $1 in 
    gnome)
          restart_fb nautilus "Gnome Nautilus"
          ;;
     nemo)
          restart_fb nemo "Nemo"
          ;;
     caja)
          restart_fb caja "Caja"
          ;;
      kde)  
          echo "Please restart KDE Konqueror in order to make the change active."
          ;;
      rox)
          # no restart required for ROX-Filer :)
          ;;
   thunar)
          echo "Please restart Thunar in order to make the change active."
          ;;
      xfe)
          # no restart required for Xfe :)
          ;;
  esac
  printf "Press any key to continue ... "
  read DUMMY
}


# ------------------------------------------------------------------------- 
install_generic() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# ------------------------------------------------------------------------- 
  set_env $1
  print_params $1
  modify_params
  install_interactive $1
  EDIT=""
}


# ------------------------------------------------------------------------- 
uninstall_generic() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# ------------------------------------------------------------------------- 
  set_env $1
  uninstall $1
}


# -------------------------------------------------------------------------
init_editor() {
# -------------------------------------------------------------------------
  find_app gedit kate defaulttexteditor xfwrite pluma
  EDIT="$APP"
}


# -------------------------------------------------------------------------
init_viewer() {
# -------------------------------------------------------------------------
  find_app zenity gedit kate defaulttexteditor xfwrite pluma
  VIEWER="$APP"
}


# -------------------------------------------------------------------------
# MAIN
# -------------------------------------------------------------------------
set_env kde
set_env gnome
set_env rox
set_env thunar
set_env xfe
set_env nemo
set_env caja
init_editor
init_viewer

while :
do
  clear
  print_header
  print_info_kde
  print_menu
  printf "Select option 1-14 or q to quit: "
  read OPTION
  case "$OPTION" in
    1) # in $KDE we have the major version
      if (test $KDE -gt 1) then
        install_generic kde
      fi
      ;;
    2) # in $KDE we have the major version
      if (test $KDE -gt 1) then
        uninstall_generic kde
      fi
      ;;
    3)
      if (test $GNOME -eq 1) then
        install_generic gnome
      fi
      ;;
    4)
      if (test $GNOME -eq 1) then
        uninstall_generic gnome
      fi
      ;;
    5)
      if (test $ROX -eq 1) then
        install_generic rox
      fi
      ;;
    6)
      if (test $ROX -eq 1) then
        uninstall_generic rox
      fi
      ;;
    7)
      if (test $THUNAR -eq 1) then
        install_generic thunar
      fi
      ;;
    8)
      if (test $THUNAR -eq 1) then
        uninstall_generic thunar
      fi
      ;;
    9)
      if (test $XFE -eq 1) then
        install_generic xfe
      fi
      ;;
   10)
      if (test $XFE -eq 1) then
        uninstall_generic xfe
      fi
      ;;
   11)
      if (test $NEMO -eq 1) then
        install_generic nemo
      fi
      ;;
   12)
      if (test $NEMO -eq 1) then
        uninstall_generic nemo
      fi
      ;; 
   13)
      if (test $CAJA -eq 1) then
        install_generic caja
      fi
      ;;
   14)
      if (test $CAJA -eq 1) then
        uninstall_generic caja
      fi
      ;; 
    0 | q)    
      echo
      exit 0
      ;;
    *)
      echo
      ;;
  esac
done
