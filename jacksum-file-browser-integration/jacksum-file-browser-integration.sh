#!/bin/bash
# 
#  Jacksum File Browser Integration for Unix and GNU/Linux Operating Systems
#  Copyright (c) 2006-2020 Dipl.-Inf. (FH) Johann N. Loefflmann
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
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
#  * This shell script is based on the bash script called 
#    Mount ISO 0.9.1 for KDE, which is released under the terms of the GNU GPL.
#    See also http://www.kde-apps.org/content/download.php?content=11577&id=1
#
#  * This script requires jacksum.jar from Jacksum 1.7.0 or later
#    which is part of the jacksum file browser integration package since 1.1.0
#    See also http://jacksum.net
#
#  * This script has been successfully tested on the following systems,
#    and it should work on similar platforms as well:
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

VERSION="1.4.0"
NAME="jacksum"
PROGNAME="Jacksum File Browser Integration"
KDEPROGNAME="Jacksum at Dolphin/Konqueror/Krusader"
GNOMEROGNAME="Jacksum at Gnome Nautilus"
ROXPROGNAME="Jacksum at ROX-Filer"
THUNARPROGNAME="Jacksum at Thunar"
XFEPROGNAME="Jacksum at Xfe"
NEMOPROGNAME="Jacksum at Nemo"
CAJAPROGNAME="Jacksum at Caja"
JACKSUMJAR="`pwd`/jacksum.jar"
ALGOALL="adler32 cksum crc8 crc16 crc24 crc32 crc32_bzip2 crc32_mpeg2 crc64 ed2k elf fcs16 gost has160 haval_128_3 haval_128_4 haval_128_5 haval_160_3 haval_160_4 haval_160_5 haval_192_3 haval_192_4 haval_192_5 haval_224_3 haval_224_4 haval_224_5 haval_256_3 haval_256_4 haval_256_5 md2 md4 md5 ripemd128 ripemd160 ripemd256 ripemd320 sha0 sha1 sha224 sha256 sha384 sha512 sum8 sum16 sum24 sum32 sumbsd sumsysv tiger tiger128 tiger160 tiger2 tree:tiger tree:tiger2 whirlpool0 whirlpool1 whirlpool2 xor8"
ALGOMIN="cksum crc32 ed2k haval_256_5 md5 rmd160 sha1 sumbsd sumsysv whirlpool"
ALGORITHMS="$ALGOMIN"
COMMANDS="cmd_calc;1)_Calc_integrity_for_directory cmd_check;2)_Check_integrity_for_directory cmd_all;3)_All_algorithms cmd_edit;4)_Edit_script"

# -------------------------------------------------------------------------
print_line() {
# $0 number of dashes in the line
# -------------------------------------------------------------------------
    printf -- '-%.0s' {1..80}; printf '\n'
}

# -------------------------------------------------------------------------
print_header() {
# -------------------------------------------------------------------------
  echo "                - $PROGNAME v$VERSION -"
  echo "                           http://www.jacksum.net"
  echo
}

# -------------------------------------------------------------------------
print_menu() {
# -------------------------------------------------------------------------
  echo "Menu:"
  echo "  1 - Install   $KDEPROGNAME for $USERS $KDEDISABLED"
  echo "  2 - Uninstall $KDEPROGNAME for $USERS $KDEDISABLED"
  echo "  3 - Install   $GNOMEROGNAME for $USERS $GNOMEDISABLED"
  echo "  4 - Uninstall $GNOMEROGNAME for $USERS $GNOMEDISABLED"
  echo "  5 - Install   $ROXPROGNAME for $USERS $ROXDISABLED"
  echo "  6 - Uninstall $ROXPROGNAME for $USERS $ROXDISABLED"
  echo "  7 - Install   $THUNARPROGNAME for $USERS $THUNARDISABLED"
  echo "  8 - Uninstall $THUNARPROGNAME for $USERS $THUNARDISABLED"
  echo "  9 - Install   $XFEPROGNAME for $USERS $XFEDISABLED"
  echo " 10 - Uninstall $XFEPROGNAME for $USERS $XFEDISABLED"
  echo " 11 - Install   $NEMOPROGNAME for $USERS $NEMODISABLED"
  echo " 12 - Uninstall $NEMOPROGNAME for $USERS $NEMODISABLED"
  echo " 13 - Install   $CAJAPROGNAME for $USERS $CAJADISABLED"
  echo " 14 - Uninstall $CAJAPROGNAME for $USERS $CAJADISABLED"
  echo "  0 - Quit the installer"
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
      printf "Type the full path here or press \"Ctrl+C\" to abort: "
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
# - $1 = Binary name
# - $2 = Default location
# -------------------------------------------------------------------------
  echo
  BIN=""
  if ( test ! -z "$2" ) then
    echo "Type the full path to \"$1\""
    printf "or press \"Enter\" to continue [%s]: " "$2"
    read BIN
    test -z "$BIN" && BIN="$2"
  fi
  while ( test ! -f "$BIN" )
  do
    echo "Couldn't find \"$1\"!"
    printf "Type the full path here or \"Ctrl+C\" to abort: "
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
          KDEDISABLED=""
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
          KDEDISABLED=""
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
          KDEDISABLED=""
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
        KDEDISABLED="(DISABLED)"
        USERS="user "`whoami`
      fi
      ;;
   gnome)
      nautilus --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        GNOME=0
        GNOMEDISABLED="(DISABLED)"
      else
        GNOME=1
        GNOMEDISABLED=""
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
        NEMODISABLED="(DISABLED)"
      else
        NEMO=1
        NEMODISABLED=""
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
        XFEDISABLED="(DISABLED)"
      else
        XFEVER=$(xfe --version | cut -f3 -d' ')
        # script folder is supported starting with Xfe 1.35
        if [ $(version_value $XFEVER) -ge $(version_value 1.35) ]; then
            XFE=1
            XFEDISABLED=""
            PREFIX="$HOME/.config/xfe"
            FB_SCRIPTFOLDER=scripts
        else
            XFE=0
            XFEDISABLED="(DISABLED)"
        fi
      fi
      ;;
   caja)
      caja --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        CAJA=0
        CAJADISABLED="(DISABLED)"
      else
        CAJA=1
        CAJADISABLED=""
        PREFIX="$HOME/.config/caja"
        FB_SCRIPTFOLDER=scripts
      fi
      ;;
    rox)
      rox --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        ROX=0
        ROXDISABLED="(DISABLED)"
      else
        ROX=1
        ROXDISABLED=""
        PREFIX="$HOME/.config/rox.sourceforge.net"
      fi
      ;;
    thunar)
      thunar --version >/dev/null 2>&1
      if ( test $? -ne 0 ) then
        THUNAR=0
        THUNARDISABLED="(DISABLED)"
      else
        THUNAR=1
        THUNARDISABLED=""
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
      kde) install_script_kde
           ;;
    gnome) install_script_gnome
           ;;
      rox) install_script_rox
           ;;
   thunar) install_script_thunar
           ;;
      xfe) install_script_xfe
           ;;
     nemo) install_script_nemo
           ;;
     caja) install_script_caja
           ;;
  esac
}

# -------------------------------------------------------------------------
install_script_share() {
# -------------------------------------------------------------------------
  JACKSUMVER=$("$JAVA" -jar "$JACKSUMJAR" -v)
  echo "  Found $JACKSUMVER:                [  OK  ]"

  printf "  Installing %s.sh:              " "$NAME"
  if ( test -d "$PREFIX/share/apps/$NAME/" )
  then
    rm -r "$PREFIX/share/apps/$NAME"
  fi

  JACKSUMSH="$PREFIX/share/apps/$NAME/$NAME.sh"
  mkdir -p "$PREFIX/share/apps/$NAME" 2>/dev/null
}


# -------------------------------------------------------------------------
install_script_xfe() {
# -------------------------------------------------------------------------
    install_script_gnome
}

# -------------------------------------------------------------------------
install_script_nemo() {
# -------------------------------------------------------------------------
    install_script_gnome
}

# -------------------------------------------------------------------------
install_script_caja() {
# -------------------------------------------------------------------------
    install_script_gnome
}

# -------------------------------------------------------------------------
install_script_gnome() {
# -------------------------------------------------------------------------
  install_script_share
  test -d "$PREFIX/share/apps/$NAME" &&
  echo '#!/bin/sh
#
# Gnome Nautilus, Caja, Nemo, Xfe Integration Script for Jacksum
# Copyright (c) 2006-2016 Johann N. Loefflmann, released under the GPLv2+
#
FILENAMES=
VIRGIN=1
for arg
do
    # ignore the 1st arg
    if [ "$VIRGIN" -eq 1 ]; then
        VIRGIN=0
    else
        FILENAMES=$FILENAMES"\""$arg"\" "
    fi
done

FILE=/tmp/jacksum.$$.txt
ALGO=$1
shift
case $ALGO in
  "cmd_all")
  eval "'$JAVA' -jar '\'''$JACKSUMJAR''\'' -a all -F \"#ALGONAME{i} (#FILENAME) = #CHECKSUM{i}\" -O $FILE -U $FILE $FILENAMES"
  '$EDIT' $FILE
  ;;
  "cmd_edit")
  '$EDIT' "'$JACKSUMSH'"
  exit
  ;;
  "cmd_calc")
  eval "'$JAVA' -jar '\'''$JACKSUMJAR''\'' -a sha1+crc32 -m -r -f -p -O /tmp/jacksum.txt -U $FILE -w $FILENAMES"
  echo >> $FILE
  echo "Done. Go to another directory and select 2) Check integrity of directory from the Scripts menu." >> $FILE
  '$EDIT' $FILE
  ;;
  "cmd_check")
  eval "'$JAVA' -jar '\'''$JACKSUMJAR''\'' -O $FILE -U $FILE -c /tmp/jacksum.txt -w $FILENAMES"
  '$EDIT' $FILE
  ;;
  *)
  eval "'$JAVA' -jar '\'''$JACKSUMJAR''\'' -a $ALGO -O $FILE -U $FILE $FILENAMES"
  echo >> $FILE
  echo "# -- " >> $FILE
  echo "# created with '$JACKSUMVER', algorithm=$ALGO" >> $FILE
  '$EDIT' $FILE
  ;;
esac
ALGO=
FILENAMES=
#rm $FILE
FILE=
' > "$JACKSUMSH" &&
  chmod +x "$JACKSUMSH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
}

# -------------------------------------------------------------------------
install_script_rox() {
# -------------------------------------------------------------------------
  install_script_share
  test -d "$PREFIX/share/apps/$NAME" &&
  echo '#!/bin/sh
#
# ROX-Filer Integration Script for Jacksum
# Copyright (c) 2010-2016 Johann N. Loefflmann, released under the GPLv2+
#
FILE=/tmp/jacksum.$$.txt
ALGO=$1
shift
case $ALGO in
  "cmd_all")
  '$JAVA' -jar "'$JACKSUMJAR'" -a all -F "#ALGONAME{i} (#FILENAME) = #CHECKSUM{i}" -O $FILE -U $FILE "$@"
  '$EDIT' $FILE
  ;;
  "cmd_edit")
  '$EDIT' "'$JACKSUMSH'"
  exit
  ;;
  "cmd_calc")
  '$JAVA' -jar "'$JACKSUMJAR'" -a sha1+crc32 -m -r -f -p -O /tmp/jacksum.txt -U $FILE -w "$@"
  echo >> $FILE
  echo "Done. Go to another directory and select 2) Check integrity of directory from the Action menu." >> $FILE
  '$EDIT' $FILE
  ;;
  "cmd_check")
  '$JAVA' -jar "'$JACKSUMJAR'" -O $FILE -U $FILE -c /tmp/jacksum.txt -w "$@"
  '$EDIT' $FILE
  ;;
  *)
  '$JAVA' -jar "'$JACKSUMJAR'" -a $ALGO -O $FILE -U $FILE "$@"
  echo >> $FILE
  echo "# -- " >> $FILE
  echo "# created with '$JACKSUMVER', algorithm=$ALGO" >> $FILE
  '$EDIT' $FILE
  ;;
esac
ALGO=
#rm $FILE
FILE=
' > "$JACKSUMSH" &&
  chmod +x "$JACKSUMSH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
}


# -------------------------------------------------------------------------
install_script_thunar() {
# -------------------------------------------------------------------------
  install_script_share
  test -d "$PREFIX/share/apps/$NAME" &&
  echo '#!/bin/sh
#
# Thunar Integration Script for Jacksum
# Copyright (c) 2010-2016 Johann N. Loefflmann, released under the GPLv2+
#
FILE=/tmp/jacksum.$$.txt
ALGO=$1
shift
case $ALGO in
  "cmd_all")
  '$JAVA' -jar "'$JACKSUMJAR'" -a all -F "#ALGONAME{i} (#FILENAME) = #CHECKSUM{i}" -O $FILE -U $FILE "$@"
  '$EDIT' $FILE
  ;;
  "cmd_edit")
  '$EDIT' "'$JACKSUMSH'"
  exit
  ;;
  "cmd_calc")
  '$JAVA' -jar "'$JACKSUMJAR'" -a sha1+crc32 -m -r -f -p -O /tmp/jacksum.txt -U $FILE -w "$@"
  echo >> $FILE
  echo "Done. Go to another directory and select 2) Check integrity of directory from the Action menu." >> $FILE
  '$EDIT' $FILE
  ;;
  "cmd_check")
  '$JAVA' -jar "'$JACKSUMJAR'" -O $FILE -U $FILE -c /tmp/jacksum.txt -w "$@"
  '$EDIT' $FILE
  ;;
  *)
  '$JAVA' -jar "'$JACKSUMJAR'" -a $ALGO -O $FILE -U $FILE "$@"
  echo >> $FILE
  echo "# -- " >> $FILE
  echo "# created with '$JACKSUMVER', algorithm=$ALGO" >> $FILE
  '$EDIT' $FILE
  ;;
esac
ALGO=
#rm $FILE
FILE=
' > "$JACKSUMSH" &&
  chmod +x "$JACKSUMSH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
}


# -------------------------------------------------------------------------
install_script_kde() {
# -------------------------------------------------------------------------
  install_script_share
  test -d "$PREFIX/share/apps/$NAME" &&
  echo '#!/bin/sh
#
# KDE Konqueror Integration Script for Jacksum
# Copyright (c) 2006-2016 Johann N. Loefflmann, released under the GPLv2+
#
FILE=/tmp/jacksum.$$.txt
ALGO=$1
shift
case $ALGO in
  "cmd_all")
  '$JAVA' -jar "'$JACKSUMJAR'" -a all -F "#ALGONAME{i} (#FILENAME) = #CHECKSUM{i}" -O $FILE -U $FILE "$@"
  '$EDIT' $FILE
  ;;
  "cmd_edit")
  '$EDIT' "'$JACKSUMSH'"
  exit
  ;;
  "cmd_calc")
  '$JAVA' -jar "'$JACKSUMJAR'" -a sha1+crc32 -m -r -f -p -O /tmp/jacksum.txt -U $FILE -w "$@"
  echo >> $FILE
  echo "Done. Go to another directory and select 2) Check integrity of directory from the Action menu." >> $FILE
  '$EDIT' $FILE
  ;;
  "cmd_check")
  '$JAVA' -jar "'$JACKSUMJAR'" -O $FILE -U $FILE -c /tmp/jacksum.txt -w "$@"
  '$EDIT' $FILE
  ;;
  *)
  '$JAVA' -jar "'$JACKSUMJAR'" -a $ALGO -O $FILE -U $FILE "$@"
  echo >> $FILE
  echo "# -- " >> $FILE
  echo "# created with '$JACKSUMVER', algorithm=$ALGO" >> $FILE
  '$EDIT' $FILE
  ;;
esac
ALGO=
#rm $FILE
FILE=
' > "$JACKSUMSH" &&
  chmod +x "$JACKSUMSH" && echo "[  OK  ]" || { echo "[FAILED]"; exit 1; }
}

# -------------------------------------------------------------------------
print_params() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# -------------------------------------------------------------------------
  echo
  echo "Parameters:"
  check_bin "java" "$JAVA"
  JAVA="$BIN"
  check_file "jacksum.jar" "$JACKSUMJAR"
  JACKSUMJAR="$BIN"
  case $1 in
      kde) check_bin "kate" "$EDIT"
           EDIT="$BIN"
           ;;
    gnome) check_bin "gedit" "$EDIT"
           EDIT="$BIN"
           ;;
      rox) check_bin "defaulttexteditor" "$EDIT"
           EDIT="$BIN"
           ;;
   thunar) check_bin "xfwrite" "$EDIT"
           EDIT="$BIN"
           ;;
      xfe) check_bin "xfwrite" "$EDIT"
           EDIT="$BIN"
           ;;
     nemo) check_bin "gedit" "$EDIT"
           EDIT="$BIN"
           ;;
     caja) check_bin "pluma" "$EDIT"
           EDIT="$BIN"
           ;;
  esac
  echo "  [algorithms]: $ALGORITHMS"
  echo
}

# -------------------------------------------------------------------------
change_params() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja or nemo
# -------------------------------------------------------------------------
  find_bin "java" "$JAVA"
  JAVA="$BIN"
  find_bin "jacksum.jar" "$JACKSUMJAR"
  JACKSUMJAR="$BIN"
  case $1 in
      kde) find_bin "kate" "$EDIT"
           EDIT="$BIN"
           ;;
    gnome) find_bin "gedit" "$EDIT"
           EDIT="$BIN"
           ;;
      rox) find_bin "defaulttexteditor" "$EDIT"
           EDIT="$BIN"
           ;;
   thunar) find_bin "xfwrite" "$EDIT"
           EDIT="$BIN"
           ;;
      xfe) find_bin "xfwrite" "$EDIT"
           EDIT="$BIN"
           ;;
     nemo) find_bin "gedit" "$EDIT"
           EDIT="$BIN"
           ;;
     caja) find_bin "pluma" "$EDIT"
           EDIT="$BIN"
           ;;    
  esac
  echo
  algorithm_selection
  printf "You can modify the selection again [%s]: " "$ALGORITHMS"
  read ALGOS
  test -z "$ALGOS" && ALGOS="$ALGORITHMS"
  ALGORITHMS="$ALGOS"
}

# -------------------------------------------------------------------------
print_info_kde() {
# -------------------------------------------------------------------------
  if (test $KDE -gt 1) then
    echo "Info:"
    echo "  This installer can install $KDEPROGNAME."
    # if not root
    if ( test `id | cut -c5` -ne 0 ) then
      echo "  If you want to install $KDEPROGNAME"
      echo "  for all users, run the script as root."
    else
      echo "  If you want to install $KDEPROGNAME"
      echo "  only for one user, run the script as a normal user. If you have a Live CD,"
      echo "  you must run the script as normal user, because CDs are read only."
    fi
    print_line 80
  fi
}

# -------------------------------------------------------------------------
algorithm_selection() {
# ------------------------------------------------------------------------- 
  YESNO=""
  while ( test "$YESNO" != "y" ) && ( test "$YESNO" != "n" ) ; do
    printf "Do you want to use all algorithms? Type n to use previous selection [y]: "
    read YESNO
    test -z "$YESNO" && YESNO="y"
    case "$YESNO" in
      "y")
         ALGORITHMS="$ALGOALL"
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
  YESNO=""
  while [ "$YESNO" != "y" ]; do
    print_params $1
    printf "Do you want use the parameters above? [y]: "
    read YESNO
    test -z "$YESNO" && YESNO="y"

    case "$YESNO" in
      "y")
          echo
          uninstall_silent $1
          install_script $1
          install_menu $1
          ;;
      "n")
          change_params $1
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
          echo "Restart KDE Konqueror in order to make the change active."
          ;;
      rox)
          # no restart required for ROX-Filer :)
          ;;
   thunar)
          echo "Restart Thunar in order to make the change active."
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
  change_params $1
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
# MAIN
# -------------------------------------------------------------------------
set_env kde
set_env gnome
set_env rox
set_env thunar
set_env xfe
set_env nemo
set_env caja

while :
do
  clear
  print_header
  print_info_kde
  print_menu
  printf "Select option 1-10 or 0 to quit: "
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
    0)
      echo
      exit 0
      ;;
    *)
      echo
      ;;
  esac
done

