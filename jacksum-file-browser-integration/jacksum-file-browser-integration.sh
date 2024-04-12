#!/usr/bin/env bash
#
#  Jacksum File Browser Integration for Unix and GNU/Linux Operating Systems
#  Copyright (c) 2006-2024 Dipl.-Inf. (FH) Johann N. Loefflmann
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
#  * This script requires jacksum-3.7.0.jar and HashGarten-0.14.0.jar
#    which are part of the Jacksum file browser integration package for Linux
#    since 2.0.0
#    See also https://jacksum.net
#
#  * Version 2.x of the script has been successfully tested on the following
#    systems, and it should work on older platforms as well:
#
#    Caja 1.26.0 on Ubuntu Linux 22.04
#    Caja 1.26.0 on Ubuntu Linux 22.04.1
#
#    Dolphin 21.12.3 (KDE Framework 5.92) on Kubuntu 22.04
#
#    elementary Files 6.5.2 on elementary OS 7.1
#    elementary Files 6.2.1 on elementary OS 7
#
#    GNOME Files (known as Gnome Nautilus) 42.6 on Ubuntu Linux 22.04.3
#    GNOME Files (known as Gnome Nautilus) 42.2 on Ubuntu Linux 22.04.1
#    GNOME Files (known as Gnome Nautilus) 42.1.1 on Ubuntu Linux 22.04
#    GNOME Files (known as Gnome Nautilus) 3.26.4 on Ubuntu Linux 18.04
#
#    muCommander 1.3.0 on Ubuntu 22.04.4 LTS
#
#    Nemo 6.0.2 on Linux Mint 21.3
#    Nemo 5.2.4 on Ubuntu Linux 22.04.1
#    Nemo 5.2.4 on Ubuntu Linux 22.04
#
#    ROX Filer 2.24.33 on Ubuntu Linux 22.04.1
#    ROX Filer 2.11 on Ubuntu Linux 22.04
#
#    SpaceFM 1.0.6 on Ubuntu Linux 22.04.3
#    SpaceFM 1.0.6 on elementary OS 7
#
#    Thunar 4.18.4 on MX-Linux 23
#
#    Xfe 1.43.2 on Ubuntu Linux 22.04.1
#    Xfe 1.43 on Ubuntu Linux 22.04
#
#    zzzFM 1.0.7 on antiX Linux 23
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

VERSION="2.8.0"
NAME="jacksum"
JACKSUM_VERSION="3.7.0"
HASHGARTEN_VERSION="0.16.0"
PROGNAME="Jacksum/HashGarten File Browser Integration"
JACKSUM_JAR="$(pwd)/jacksum-${JACKSUM_VERSION}.jar"
HASHGARTEN_JAR="$(pwd)/HashGarten-${HASHGARTEN_VERSION}.jar"
ALGOS_DIRECT_SUGGESTION="cksum crc32 ed2k haval_256_5 md5 rmd160 sha1 sha256 sha3-256 sumbsd sumsysv whirlpool"
ALGORITHMS=""
COMMANDS="cmd_calc;1)_Calc_hash_values cmd_check;2)_Check_data_integrity cmd_cust;3)_Customized_output cmd_edit;4)_Edit_script"

KDE_PROGNAME="Dolphin, Konqueror, or Krusader"
GNOME_PROGNAME="GNOME Files (Nautilus)"
ROX_PROGNAME="ROX-Filer"
THUNAR_PROGNAME="Thunar"
XFE_PROGNAME="Xfe"
NEMO_PROGNAME="Nemo"
CAJA_PROGNAME="Caja"
ELEMENTARY_PROGNAME="Elementary Files"
SPACEFM_PROGNAME="SpaceFM"
ZZZFM_PROGNAME="zzzFM"
MUCOMMANDER_PROGNAME="muCommander"

# -------------------------------------------------------------------------
# Prints a line with dashes.
#
print_dashes() {
# -------------------------------------------------------------------------
  printf -- '-%.0s' {1..80}
  printf '\n'
}

# -------------------------------------------------------------------------
# Prints the program header with name, version, and homepage.
#
print_header() {
# -------------------------------------------------------------------------
  printf "          >>> %s v%s <<<\n" "$PROGNAME" "$VERSION"
  printf "                            https://jacksum.net\n\n"
}

# -------------------------------------------------------------------------
# Prints the install/uninstall menu.
#
print_menu() {
#
# parameter:
# $1 "install" or "uninstall"
# -------------------------------------------------------------------------
  printf "Menu:\n"
  printf "  c - %-9s  in %s for %s %s\n" "${ACTION}" "$CAJA_PROGNAME" "$USERS" "$CAJA_DISABLED"
  printf "  d - %-9s  in %s for %s %s\n" "${ACTION}" "$KDE_PROGNAME" "$USERS" "$KDE_DISABLED"
  printf "  e - %-9s  in %s for %s %s\n" "${ACTION}" "$ELEMENTARY_PROGNAME" "$USERS" "$ELEMENTARY_DISABLED"
  printf "  g - %-9s  in %s for %s %s\n" "${ACTION}" "$GNOME_PROGNAME" "$USERS" "$GNOME_DISABLED"
  printf "  m - %-9s  in %s for %s %s\n" "${ACTION}" "$MUCOMMANDER_PROGNAME" "$USERS" "$MUCOMMANDER_DISABLED"
  printf "  n - %-9s  in %s for %s %s\n" "${ACTION}" "$NEMO_PROGNAME" "$USERS" "$NEMO_DISABLED"
  printf "  r - %-9s  in %s for %s %s\n" "${ACTION}" "$ROX_PROGNAME" "$USERS" "$ROX_DISABLED"
  printf "  s - %-9s  in %s for %s %s\n" "${ACTION}" "$SPACEFM_PROGNAME" "$USERS" "$SPACEFM_DISABLED"
  printf "  t - %-9s  in %s for %s %s\n" "${ACTION}" "$THUNAR_PROGNAME" "$USERS" "$THUNAR_DISABLED"
  printf "  x - %-9s  in %s for %s %s\n" "${ACTION}" "$XFE_PROGNAME" "$USERS" "$XFE_DISABLED"
  printf "  z - %-9s  in %s for %s %s\n" "${ACTION}" "$ZZZFM_PROGNAME" "$USERS" "$ZZZFM_DISABLED"
  printf "\n"
  if [ "$ACTION" = "install" ]; then
    printf "  u - Show the uninstall menu\n"
  else
    printf "  i - Show the install menu\n"
  fi
  printf "  q - Quit the installer\n"
  print_dashes
}

# -------------------------------------------------------------------------
check_env() {
#
# parameters:
# $1 = Description
# $2 = Default location
# $3 = Fallback
# -------------------------------------------------------------------------
  if [ -d "$2" ]; then
    DIR="$2"
  elif [ -d "$3" ]; then
    DIR="$3"
  else
    printf "\n"
    while [ ! -d "$DIR" ]; do
      printf "Could not find %s!\n" "$1"
      printf "Type the absolute path here or press \"Ctrl+C\" to abort: "
      read -r DIR
    done
  fi
  DIR="$(dirname "$DIR")/$(basename "$DIR")"
}

# -------------------------------------------------------------------------
check_bin() {
#
# parameters:
# $1 = Binary name
# $2 = Default location
# -------------------------------------------------------------------------
  BIN=""
  WHICH="$(which "$1" 2>/dev/null)"
  if [ -f "$2" ]; then
    BIN="$2"
    printf "  [%s]: %s\n" "$1" "$BIN"
  elif [ -f "$WHICH" ]; then
    BIN="$WHICH"
    printf "  [%s]: %s\n" "$1" "$BIN"
  else
    printf "  [%s]: >> not found <<\n" "$1"
  fi
}

# -------------------------------------------------------------------------
check_file() {
#
# parameters:
# $1 = file name
# $2 = Default location
# -------------------------------------------------------------------------
  BIN=""
  if [ -f "$2" ]; then
    BIN="$2"
    printf "  [%s]: %s\n" "$1" "$BIN"
  else
    printf "  [%s]: >> not found <<\n" "$1"
  fi
}

# -------------------------------------------------------------------------
find_bin() {
#
# parameters:
# $1 = Description for the binary
# $2 = Default location
# -------------------------------------------------------------------------
  printf "\n"
  BIN=""
  if [ -n "$2" ]; then
    printf "Type the absolute path to \"%s\"\n" "$1"
    printf "and press \"Enter\" to continue [%s]: " "$2"
    read -r BIN
    test -z "$BIN" && BIN="$2"
  fi
  while [ ! -f "$BIN" ]; do
    printf "Couldn't find \"%s\"!\n" "$1"
    printf "Type the absolute path here or \"Ctrl+C\" to abort: "
    read -r BIN
  done
}

# -------------------------------------------------------------------------
# Normalizes the version and returns a comparable version as a number.
#
version_value() {
#
# parameters:
# $1 version, e.g. 12.34.567
# -------------------------------------------------------------------------
  # shellcheck disable=SC2046
  # shellcheck disable=SC2183
  printf "%03d%03d%03d" $(printf "%s\n" "$1" | tr '.' '\n' | head -n 3)
}

# -------------------------------------------------------------------------
set_env() {
#
# parameters:
# $1 kde, gnome, xfe, rox, thunar, nemo, caja, elementary, spacefm or zzzfm
# -------------------------------------------------------------------------
  case $1 in
  kde)
    KDE=""
    if [ "$KDE" = "" ]; then
      if type kf5-config &>/dev/null; then
        # KDE Framework 5.x
        KDE=5
        KDE_DISABLED=""
        if [ "$(id | cut -c5)" -ne 0 ]; then
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
      if kde4-config >/dev/null 2>&1; then
        # KDE 4.x
        KDE=4
        KDE_DISABLED=""
        if [ "$(id | cut -c5)" -ne 0 ]; then
          # non-root user
          LOCAL="$(kde4-config --localprefix 2>/dev/null)"
          check_env "KDE config folder" "$LOCAL" "$HOME/.kde"
          USERS="user "$(whoami)
        else
          SYSTEM="$(kde4-config --prefix 2>/dev/null)"
          check_env "KDE install prefix" "$SYSTEM" "/opt/kde4"
          USERS="all users"
        fi
        PREFIX="$DIR"
        KDEPOSTFIX="/share/kde4/services/ServiceMenus/"
      fi
    fi

    if [ "$KDE" = "" ]; then
      if kde-config >/dev/null 2>&1; then
        # KDE 3.x
        KDE=3
        KDE_DISABLED=""
        if [ "$(id | cut -c5)" -ne 0 ]; then
          # non-root user
          LOCAL="$(kde-config --localprefix 2>/dev/null)"
          check_env "KDE config folder" "$LOCAL" "$HOME/.kde"
          USERS="user "$(whoami)
        else
          SYSTEM="$(kde-config --prefix 2>/dev/null)"
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
      USERS="user "$(whoami)
    fi
    ;;

  gnome)
    if ! nautilus --version >/dev/null 2>&1; then
      GNOME=0
      GNOME_DISABLED="(DISABLED)"
    else
      GNOME=1
      GNOME_DISABLED=""
      if [ "$(nautilus --version | cut -c16)" -ge 2 ]; then

        if [ -e "$HOME/.local/share/nautilus/scripts" ]; then
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
    if ! nemo --version >/dev/null 2>&1; then
      NEMO=0
      NEMO_DISABLED="(DISABLED)"
    else
      NEMO=1
      NEMO_DISABLED=""
      NEMOVER=$(nemo --version | cut -f2 -d' ')
      if [ "$(version_value "$NEMOVER")" -ge "$(version_value 2.6.7)" ]; then
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
    if ! xfe --version >/dev/null 2>&1; then
      XFE=0
      XFE_DISABLED="(DISABLED)"
    else
      XFEVER=$(xfe --version | cut -f3 -d' ')
      # script folder is supported starting with Xfe 1.35
      if [ "$(version_value "$XFEVER")" -ge "$(version_value 1.35)" ]; then
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
    if ! caja --version >/dev/null 2>&1; then
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
    if ! rox --version >/dev/null 2>&1; then
      ROX=0
      ROX_DISABLED="(DISABLED)"
    else
      ROX=1
      ROX_DISABLED=""
      PREFIX="$HOME/.config/rox.sourceforge.net"
    fi
    ;;

  thunar)
    if ! thunar --version >/dev/null 2>&1; then
      THUNAR=0
      THUNAR_DISABLED="(DISABLED)"
    else
      THUNAR=1
      THUNAR_DISABLED=""
      PREFIX="$HOME/.config/Thunar"
    fi
    ;;

  elementary)
    if ! io.elementary.files --version >/dev/null 2>&1; then
      ELEMENTARY=0
      ELEMENTARY_DISABLED="(DISABLED)"
    else
      ELEMENTARY=1
      ELEMENTARY_DISABLED=""
      PREFIX="$HOME/.local/share/contractor"
    fi
    ;;

  spacefm)
    if ! spacefm --version >/dev/null 2>&1; then
      SPACEFM=0
      SPACEFM_DISABLED="(DISABLED)"
    else
      SPACEFM=1
      SPACEFM_DISABLED=""
      PREFIX="$HOME/.config/spacefm/"
    fi
    ;;

  zzzfm)
    if ! zzzfm --version >/dev/null 2>&1; then
      ZZZFM=0
      ZZZFM_DISABLED="(DISABLED)"
    else
      ZZZFM=1
      ZZZFM_DISABLED=""
      PREFIX="$HOME/.config/zzzfm/"
    fi
    ;;
    
  mucommander)
   if [ ! -f "/opt/mucommander/bin/muCommander" ]; then
      MUCOMMANDER=0
      MUCOMMANDER_DISABLED="(DISABLED)"
    else
      MUCOMMANDER=1
      MUCOMMANDER_DISABLED=""
      PREFIX="$HOME/.mucommander/"
    fi
    ;;

  esac
}

# -------------------------------------------------------------------------
uninstall() {
#
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo, elementary spacefm, zzzfm
# or mucommander
# -------------------------------------------------------------------------
  uninstall_silent "$1"
  printf "\nUninstallation finished. Please press enter key to continue ... "
  read -r
}

# -------------------------------------------------------------------------
uninstall_silent() {
#
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo, elementary, spacefm, zzzfm
# or mucommander
# -------------------------------------------------------------------------
  case $1 in
  kde)
    uninstall_kde
    ;;
  gnome)
    uninstall_gnome
    ;;
  rox)
    uninstall_rox
    ;;
  thunar)
    uninstall_thunar
    ;;
  xfe)
    uninstall_xfe
    ;;
  nemo)
    uninstall_nemo
    ;;
  caja)
    uninstall_caja
    ;;
  elementary)
    uninstall_elementary
    ;;
  spacefm)
    uninstall_xxxfm
    ;;
  zzzfm)
    uninstall_xxxfm
    ;;
  mucommander)
    uninstall_mucommander
    ;;
  esac
}

# -------------------------------------------------------------------------
uninstall_kde() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"
  DSK="$PREFIX$KDEPOSTFIX$NAME.desktop"

  printf "\n  Removing %s.sh:                " "$NAME"
  if [ -d "$SH" ]; then
    if rm -r "$SH"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
  printf "  Removing %s.desktop:           " "$NAME"
  if [ -f "$DSK" ]; then
    if rm "$DSK"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
}

# -------------------------------------------------------------------------
uninstall_gnome() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"
  SCRIPTS="$PREFIX/$FB_SCRIPTFOLDER/$NAME/"

  printf "\n  Removing %s.sh:                " "$NAME"
  if [ -d "$SH" ]; then
    if rm -r "$SH"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
  printf "  Removing %s scripts:           " "$NAME"
  if [ -d "$SCRIPTS" ]; then
    if rm -r "$SCRIPTS"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
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
  if [ -d "$SH" ]; then
    if rm -r "$SH"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
  printf "  Removing %s scripts:           " "$NAME"
  if [ -d "$SCRIPTS" ]; then
    # removing the symlink
    rm "$SCRIPTS/../../OpenWith/$NAME"
    # removing all scripts
    if rm -r "$SCRIPTS"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
}

# -------------------------------------------------------------------------
uninstall_thunar() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"

  printf "\n  Removing %s.sh:                " "$NAME"
  if [ -d "$SH" ]; then
    if rm -r "$SH"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
  printf "  Removing %s entries:           " "$NAME"
  # restore the backup
  THUNARXML="$PREFIX/uca.xml"
  THUNARXMLBACKUP="$PREFIX/uca.before-jacksum.xml"
  if [ ! -f "$THUNARXMLBACKUP" ]; then
    printf "[ NOT INSTALLED ]\n"
  else
    cp "$THUNARXMLBACKUP" "$THUNARXML"
    rm "$THUNARXMLBACKUP"
    printf "[  OK  ]\n"
  fi
}


# -------------------------------------------------------------------------
uninstall_mucommander() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"

  printf "\n  Removing %s.sh:                " "$NAME"
  if [ -d "$SH" ]; then
    if rm -r "$SH"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
  printf "  Removing %s entries:           " "$NAME"
  # restore the backup
  XML="$PREFIX/commands.xml"
  XMLBACKUP="$PREFIX/commands.before-jacksum.xml"
  if [ ! -f "$XMLBACKUP" ]; then
    printf "[ NOT INSTALLED ]\n"
  else
    cp "$XMLBACKUP" "$XML"
    rm "$XMLBACKUP"
    printf "[  OK  ]\n"
  fi
}

# -------------------------------------------------------------------------
uninstall_elementary() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME/"
  SCRIPTS="$PREFIX"

  printf "\n  Removing %s.sh:                " "$NAME"
  if [ -d "$SH" ]; then
    if rm -r "$SH"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
  printf "  Removing %s scripts:           " "$NAME"
  if [ -f "${SCRIPTS}/jacksum.cmd_calc.contract" ]; then
    if rm "${SCRIPTS}"/jacksum.*.contract; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
}

# -------------------------------------------------------------------------
clean_xxxfm_session_file() {
#
# parameters:
# $1 session file of SpaceFM or zzzFM
# $3 text
# -------------------------------------------------------------------------
  local SESSION_FILE="$1"
  local HANDLER_PREFIX="hand_f_jacksum"

  # get the registered handlers
  local HANDLERS
  HANDLERS=$(grep ^open_hand-s "${SESSION_FILE}") # e.g. open_hand-s=hand_f_3aa02120 hand_f_28b4b240

  # clean the handlers property
  HANDLERS="${HANDLERS//hand_f_jacksum[^ ]*/}" # remove all strings that start with hand_f_jacksum

  # update the session file
  local TEMP_FILE="/tmp/jacksum.$$.session"
  grep -v ^${HANDLER_PREFIX} "${SESSION_FILE}" | grep -v ^open_hand-s >"$TEMP_FILE"
  printf "%s\n" "$HANDLERS" >>"$TEMP_FILE"
  cat "${TEMP_FILE}" >"${SESSION_FILE}"
  rm "${TEMP_FILE}"
}

# -------------------------------------------------------------------------
uninstall_xxxfm() {
# -------------------------------------------------------------------------
  SH="$PREFIX/share/apps/$NAME"
  SCRIPTS="$PREFIX/scripts"

  printf "\n  Removing %s.sh:                " "$NAME"
  if [ -d "$SH" ]; then
    if rm -r "$SH"; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[ NOT INSTALLED ]\n"
  fi
  printf "  Removing %s scripts:           " "$NAME"
  if [ -d "${SCRIPTS}/hand_f_jacksum_cmd_calc" ]; then
    if rm -R "${SCRIPTS}"/hand_f_jacksum*; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
    clean_xxxfm_session_file "${PREFIX}/session"
  else
    printf "[ NOT INSTALLED ]\n"
  fi
}

# -------------------------------------------------------------------------
install_menu() {
#
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo, elementary, spacefm, zzzfm
# or mucommander
# -------------------------------------------------------------------------
  case $1 in
  kde)
    install_menu_kde
    ;;
  gnome)
    install_menu_gnome
    ;;
  rox)
    install_menu_rox
    ;;
  thunar)
    install_menu_thunar
    ;;
  xfe)
    install_menu_xfe
    ;;
  nemo)
    install_menu_nemo
    ;;
  caja)
    install_menu_caja
    ;;
  elementary)
    install_menu_elementary
    ;;
  spacefm)
    install_menu_xxxfm spacefm
    ;;
  zzzfm)
    install_menu_xxxfm xxxfm
    ;;
  mucommander)
    install_menu_mucommander
    ;;
  esac
}

# -------------------------------------------------------------------------
install_menu_kde() {
# -------------------------------------------------------------------------
  printf "  Creating a folder for servicemenus: "

  if [ ! -d "$PREFIX$KDEPOSTFIX" ]; then
    mkdir -p "$PREFIX$KDEPOSTFIX" 2>/dev/null
    if [ -d "$PREFIX$KDEPOSTFIX" ]; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[  OK  ]\n"
  fi

  DESKFILE="$PREFIX$KDEPOSTFIX$NAME.desktop"
  printf "  Installing %s.desktop:         " $NAME

  # gather all action codes
  for i in $COMMANDS; do
    CMD=$(printf "%s\n" "$i" | awk -F";" '{print $1 }')
    ACTIONS="$ACTIONS;$CMD"
  done
  for i in $ALGORITHMS; do
    ACTIONS="$ACTIONS;$i"
  done
  ACTIONS=$(printf "%s\n" "$ACTIONS" | sed -e "s/^;//")

  printf "[Desktop Entry]\n" >"$DESKFILE"
  if [ $KDE -ge 4 ]; then {
      printf "Type=Service\n"
      printf "ServiceTypes=KonqPopupMenu/Plugin\n"
      printf "MimeType=inode/directory;application/octet-stream\n"
    } >>"$DESKFILE"
  else
    printf "ServiceTypes=all/all\n" >>"$DESKFILE"
  fi

  {
    printf "Actions=%s;\n" "$ACTIONS"
    printf "Encoding=UTF-8\n"
    printf "X-KDE-Submenu=Jacksum\n"
    printf "\n"
  } >>"$DESKFILE"

  for i in $COMMANDS; do
    CMD="${i%;*}"; TXT="${i#*;}"; TXT="${TXT//_/ }"
    {
      printf "[Desktop Action %s]\n" "$CMD"
      printf "Icon=binary\n"
      printf "Name=%s\n" "$TXT"
      printf "Exec=%s %s %s\n" "$JACKSUMSH" "$CMD" "%U"
      printf "\n"
    } >>"$DESKFILE"
  done

  for i in $ALGORITHMS; do
    {
      printf "[Desktop Action %s]\n" "$i"
      printf "Icon=binary\n"
      printf "Name=%s\n" "$i"
      printf "Exec=%s %s %s\n" "$JACKSUMSH" "$i" "%U"
      printf "\n"
    } >>"$DESKFILE"
  done

  if [ -f "$DESKFILE" ]; then
    printf "[  OK  ]\n"
  else
    printf "[FAILED]\n"
    exit 1
  fi
}

# -------------------------------------------------------------------------
# Function for Nautilus, Xfe and Nemo.
#
install_menu_gnome_shared() {
# -------------------------------------------------------------------------
  printf "  Creating a folder for all scripts:  "
  if [ ! -d "$SCRIPTFOLDER" ]; then
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null
    if [ -d "$SCRIPTFOLDER" ]; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[  OK  ]\n"
  fi

  printf "  Installing scripts:                 "

  for i in $COMMANDS; do
    CMD="${i%;*}"; TXT="${i#*;}"; TXT="${TXT//_/ }"
    printf "#!/bin/sh\n" >"$SCRIPTFOLDER/$TXT"
    printf 'exec %s %s "$@"\n' "$JACKSUMSH" "$CMD" >>"$SCRIPTFOLDER/$TXT"
    chmod +x "$SCRIPTFOLDER/$TXT"
  done

  for i in $ALGORITHMS; do
    printf "#!/bin/sh\n" >"$SCRIPTFOLDER/$i"
    printf 'exec %s %s "$@"\n' "$JACKSUMSH" "$i" >>"$SCRIPTFOLDER/$i"
    chmod +x "$SCRIPTFOLDER/$i"
  done

  printf "[  OK  ]\n"
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
  if [ ! -d "$SCRIPTFOLDER" ]; then
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null
    if [ -d "$SCRIPTFOLDER" ]; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[  OK  ]\n"
  fi
  # on Puppy Linux 4.3.1 (ROX-Filer 2.6.1), the folder is called OpenWith
  OPENWITHFOLDER="$PREFIX/OpenWith"
  if [ ! -d "$OPENWITHFOLDER" ]; then
    mkdir -p "$OPENWITHFOLDER" 2>/dev/null
  fi
  # simply make a symlink in order to be cross compatible
  ln -s "$SCRIPTFOLDER" "$OPENWITHFOLDER/$NAME"

  printf "  Installing scripts:                 "

  for i in $COMMANDS; do
    CMD="${i%;*}"; TXT="${i#*;}"; TXT="${TXT//_/ }"
    printf "#!/bin/sh\n" >"$SCRIPTFOLDER/$TXT"
    printf 'exec %s %s "$@"\n' "$JACKSUMSH" "$CMD" >>"$SCRIPTFOLDER/$TXT"
    chmod +x "$SCRIPTFOLDER/$TXT"
  done

  for i in $ALGORITHMS; do
    printf "#!/bin/sh\n" >"$SCRIPTFOLDER/$i"
    printf 'exec %s %s "$@"\n' "$JACKSUMSH" "$i" >>"$SCRIPTFOLDER/$i"
    chmod +x "$SCRIPTFOLDER/$i"
  done

  printf "[  OK  ]\n"
}

# -------------------------------------------------------------------------
install_menu_thunar() {
# -------------------------------------------------------------------------
  THUNARXML="$PREFIX/uca.xml"
  THUNARXMLBACKUP="$PREFIX/uca.before-jacksum.xml"
  printf "  Backing up uca.xml:                 "
  if [ ! -f "$THUNARXML" ]; then
    printf "[ NOT FOUND ]\n"
    # Put a default file here
    printf '<?xml encoding="UTF-8" version="1.0"?><actions></actions>\n' >"$THUNARXML"
    cp "$THUNARXML" "$THUNARXMLBACKUP"
  else
    cp "$THUNARXML" "$THUNARXMLBACKUP"
    printf "[  OK  ]\n"
  fi

  printf "  Installing entries:                 "

  MYTEMP=/tmp/jacksum.$$.temp
  # xml without the closing </actions> tag
  sed 's/<\/actions>//' "$THUNARXML" >"$MYTEMP"

  for i in $COMMANDS; do
    CMD="${i%;*}"; TXT="${i#*;}"; TXT="${TXT//_/ }"
    {
      printf '<action>\n'
      printf '<name>Jacksum - %s</name>\n' "$TXT"
      printf '<command>%s %s %s</command>\n' "$JACKSUMSH" "$CMD" "%F"
      printf '<description>%s</description>\n' "$TXT"
      printf '<patterns>*</patterns>\n'
      printf '<directories/><audio-files/><image-files/><other-files/><text-files/><video-files/>\n'
      printf '</action>\n'
    } >>"$MYTEMP"
  done

  for i in $ALGORITHMS; do
    {
      printf '<action>\n'
      printf '<name>Jacksum - %s</name>\n' "$i"
      printf '<command>%s %s %s</command>\n' "$JACKSUMSH" "$i" "%F"
      printf '<description>%s</description>\n' "$i"
      printf '<patterns>*</patterns>\n'
      printf '<directories/><audio-files/><image-files/><other-files/><text-files/><video-files/>\n'
      printf '</action>\n'
    } >>"$MYTEMP"
  done

  printf '</actions>\n' >>"$MYTEMP"
  cp "$MYTEMP" "$THUNARXML"
  rm "$MYTEMP"
  printf "[  OK  ]\n"
}

# -------------------------------------------------------------------------
install_menu_elementary() {
# -------------------------------------------------------------------------
  SCRIPTFOLDER="$PREFIX"
  printf "  Creating a folder for all scripts:  "
  if [ ! -d "$SCRIPTFOLDER" ]; then
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null
    if [ -d "$SCRIPTFOLDER" ]; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[  OK  ]\n"
  fi

  printf "  Installing scripts:                 "

  for i in $COMMANDS; do
    CMD="${i%;*}"; TXT="${i#*;}"; TXT="${TXT//_/ }"
    OUTPUTFILE="${SCRIPTFOLDER}/jacksum.${CMD}.contract"
    printf "[Contractor Entry]\n" >"$OUTPUTFILE"
    {
      printf "Name=%s\n" "${TXT}"
      printf "Description=%s\n" "${TXT}"
      printf "MimeType=!inode/blockdevice;inode/chardevice;inode/fifo;inode/socket;\n"
      printf "Exec=%s %s %s\n" "${JACKSUMSH}" "${CMD}" "%F"
    } >>"$OUTPUTFILE"
    chmod +x "$OUTPUTFILE"
  done

  for i in $ALGORITHMS; do
    OUTPUTFILE="${SCRIPTFOLDER}/jacksum.${i}.contract"
    printf "[Contractor Entry]\n" >"$OUTPUTFILE"
    {
      printf "Name=%s\n" "${i}"
      printf "Description=%s\n" "${i}"
      printf "MimeType=!inode/blockdevice;inode/chardevice;inode/fifo;inode/socket;\n"
      printf "Exec=%s %s %s\n" "${JACKSUMSH}" "${i}" "%F"
    } >>"$OUTPUTFILE"
    chmod +x "$OUTPUTFILE"
  done

  printf "[  OK  ]\n"
}

# -------------------------------------------------------------------------
install_menu_mucommander() {
# -------------------------------------------------------------------------
  XML="$PREFIX/commands.xml"
  XMLBACKUP="$PREFIX/commands.before-jacksum.xml"
  printf "  Backing up commands.xml:            "
  if [ ! -f "$XML" ]; then
    printf "[ NOT FOUND ]\n"
    # Put a default file here
    printf '<?xml version="1.0" encoding="UTF-8"?><commands></commands>\n' >"$XML"
    cp "$XML" "$XMLBACKUP"
  else
    cp "$XML" "$XMLBACKUP"
    printf "[  OK  ]\n"
  fi

  printf "  Installing entries:                 "

  MYTEMP=/tmp/jacksum.$$.temp
  # xml without the closing </commands> tag
  sed 's/<\/commands>//' "$XML" >"$MYTEMP"

  for i in $COMMANDS; do
    CMD="${i%;*}"; TXT="${i#*;}"; TXT="${TXT//_/ }"
    {
      # $f is the placeholder for muCommander, therefore it must not be evaluated
      # shellcheck disable=SC2016
      printf '<command alias="Jacksum - %s" value="%s %s %s" />\n' "$TXT" "${JACKSUMSH}" "${CMD}" '$f'
    } >>"$MYTEMP"
  done

  for i in $ALGORITHMS; do
    {
      # shellcheck disable=SC2016
      printf '<command alias="Jacksum - %s" value="%s %s %s" />\n' "$i" "$JACKSUMSH" "$i" '$f'
    } >>"$MYTEMP"
  done

  printf '</commands>\n' >>"$MYTEMP"
  cp "$MYTEMP" "$XML"
  rm "$MYTEMP"
  printf "[  OK  ]\n"
}



# -------------------------------------------------------------------------
update_xxxfm_session_file() {
#
# parameters:
# $1 session file of SpaceFM or zzzFM
# $2 handler name
# $3 text
# -------------------------------------------------------------------------
  local SESSION_FILE="$1"
  local HANDLER="$2"
  local TXT="$3"

  # get the registered handlers
  local HANDLERS
  HANDLERS=$(grep ^open_hand-s "${SESSION_FILE}") # e.g. open_hand-s=hand_f_3aa02120 hand_f_28b4b240

  # clean the handlers property
  HANDLERS="${HANDLERS//${HANDLER}/}" # e.g. open_hand-s=hand_f_3aa02120
  HANDLERS="${HANDLERS//  /}"         # remove all double blanks

  # update the session file
  local TEMP_FILE="/tmp/jacksum.$$.session"
  grep -v ^"${HANDLER}" "${SESSION_FILE}" | grep -v ^open_hand-s >"$TEMP_FILE"
  {
    printf "%s %s\n" "$HANDLERS" "$HANDLER"
    printf "%s-s=%s\n" "$HANDLER" ""
    printf "%s-x=%s\n" "$HANDLER" "*"
    printf "%s-label=%s\n" "$HANDLER" "${TXT}"
    printf "%s-icon=%s\n" "$HANDLER" ""
    printf "%s-keep=%s\n" "$HANDLER" "1"
  } >>"$TEMP_FILE"
  cat "${TEMP_FILE}" >"${SESSION_FILE}"
  rm "${TEMP_FILE}"
}

# -------------------------------------------------------------------------
install_menu_xxxfm() {
#
# parameters:
# $1 file browser name (spacefm or zzzfm)
# -------------------------------------------------------------------------
  local BROWSER="$1"
  SESSION_FILE="${PREFIX}/session"

  # if session file does not exist, the user need to call spacefm once.
  if [ ! -f "$SESSION_FILE" ]; then
    printf "  Note: In the next step I will try to open %s so the required session file gets generated.\n" "$BROWSER"
    printf "        Please hit enter when you are ready: "
    read -r
    $BROWSER >/dev/null 2>&1 &
  fi

  printf "  Note: Please close all SpaceFM instances manually.\n"
  printf "        Please hit enter when you are ready: "
  read -r
  # if the user didn't read the instruction it could still work if a session file is there already.
  pkill -HUP "$BROWSER"

  if [ ! -f "$SESSION_FILE" ]; then
    printf "  Error: SpaceFM session file not found.\n"
    printf "         Please follow the instructions.\n"
    exit 1
  fi

  # backup the "session" file
  cp "${SESSION_FILE}" "${SESSION_FILE}.backup"

  SCRIPTFOLDER="${PREFIX}/scripts/"
  printf "  Creating a folder for all scripts:  "
  if [ ! -d "$SCRIPTFOLDER" ]; then
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null
    if [ -d "$SCRIPTFOLDER" ]; then
      printf "[  OK  ]\n"
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[  OK  ]\n"
  fi

  # The actual scripts in .sh format
  printf "  Installing scripts:                 "

  for i in $COMMANDS; do
    CMD="${i%;*}"; TXT="${i#*;}"; TXT="${TXT//_/ }"

    HANDLER="hand_f_jacksum_${CMD}"
    SCRIPTFOLDER="${PREFIX}/scripts/${HANDLER}"
    #OUTPUTFILE="${SCRIPTFOLDER}/hand-jacksum.${CMD}.sh"
    # probably a bug in SpaceFM. It works only if the file handler is called "hand-file-mount.sh"
    OUTPUTFILE="${SCRIPTFOLDER}/hand-file-mount.sh"
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null

    printf "%s\n" '#!/bin/bash' >"$OUTPUTFILE"
    printf "%s %s %s\n" "${JACKSUMSH}" "${CMD}" "%F" >>"$OUTPUTFILE"
    chmod +x "$OUTPUTFILE"

    update_xxxfm_session_file "$SESSION_FILE" "$HANDLER" "$TXT"
  done

  for i in $ALGORITHMS; do
    HANDLER="hand_f_jacksum_${i}"
    SCRIPTFOLDER="${PREFIX}/scripts/${HANDLER}"
    # OUTPUTFILE="${SCRIPTFOLDER}/jacksum.${i}.sh"
    # probably a bug in SpaceFM. It works only if the file handler is called "hand-file-mount.sh"
    OUTPUTFILE="${SCRIPTFOLDER}/hand-file-mount.sh"
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null

    printf "%s\n" '#!/bin/bash' >"$OUTPUTFILE"
    printf "%s %s %s\n" "${JACKSUMSH}" "${i}" "%F" >>"$OUTPUTFILE"
    chmod +x "$OUTPUTFILE"

    update_xxxfm_session_file "$SESSION_FILE" "$HANDLER" "$i"
  done

  printf "[  OK  ]\n"
}

# -------------------------------------------------------------------------
install_script() {
# parameters:
# kde, gnome, rox, thunar, xfe, caja, nemo, elementary, spacefm or zzzfm
# -------------------------------------------------------------------------
  case $1 in
  kde | gnome | rox | thunar | xfe | nemo | caja | elementary | spacefm | zzzfm | mucommander)
    install_script_generic
    ;;
  *)
    printf "Error: file browser %s is not supported. Exit.\n" "$1"
    exit 1
    ;;
  esac
}

# -------------------------------------------------------------------------
install_script_sh() {
# -------------------------------------------------------------------------

  # header
  cat << 'EOF'
#!/bin/bash
#
# Jacksum File Browser Integration Script, https://jacksum.net
# Copyright (c) 2006-2024 Johann N. Loefflmann, https://johann.loefflmann.net
# Code has been released under the conditions of the GPLv3+.
#

EOF

  # viewer logic
  printf 'viewer() {\n'
  if [ "${VIEWER##*/}" = "zenity" ]; then
    # shellcheck disable=SC2016
    printf '    cat "$1" | "%s" --text-info --width 800 --height 600 --title "Jacksum: $1" --no-wrap --font="Monospace" "$1"\n' "${VIEWER}"
  else
    # shellcheck disable=SC2016
    printf '    "%s" "$1"\n' "${EDIT}"
  fi
  printf '}\n\n'

  printf 'FILE_LIST="/tmp/jacksum-%s-filelist.txt"\n' "${JACKSUM_VERSION}"
  printf 'OUTPUT="/tmp/jacksum-%s-output.txt"\n' "${JACKSUM_VERSION}"
  printf 'ERROR_LOG="/tmp/jacksum-%s-error.txt"\n' "${JACKSUM_VERSION}"
  printf 'CHECK_FILE="/tmp/jacksum-%s-check.txt"\n' "${JACKSUM_VERSION}"
  printf 'JAVA="%s"\n' "${JAVA}"
  printf 'JACKSUM_JAR="%s"\n' "${JACKSUM_JAR}"
  printf 'HASHGARTEN_JAR="%s"\n' "${HASHGARTEN_JAR}"
  printf 'EDIT="%s"\n' "${EDIT}"
  printf 'SCRIPT="%s"\n' "${JACKSUMSH}"
  printf '\n'

cat <<'EOF'
cat /dev/null > "$FILE_LIST"
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
    ;;

  "cmd_check")
    if [ ! -f relative ]; then
      touch relative
    fi
    "${JAVA}" -jar "${HASHGARTEN_JAR}" --header -c relative -O ${OUTPUT} -U ${OUTPUT} --file-list-format list --file-list ${FILE_LIST} --path-relative-to-entry 1 --verbose default,summary
    ;;

  "cmd_cust")
    ALGOS="md5+sha1+ripemd160+tiger+\
sha256+sha512/256+sha3-256+shake128+ascon-hash+sm3+streebog256+kupyna-256+lsh-256-256+blake3+k12+keccak256+\
sha512+sha3-512+shake256+streebog512+kupyna-512+lsh-512-512+blake2b-512+keccak512+m14+skein-512-512+whirlpool"
  TEMPLATE='File info:
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
    Ascon-Hash (USA):          #HASH{ascon-hash}
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
'

    "${JAVA}" -jar "${JACKSUM_JAR}" -a "${ALGOS}" -E hex --format "${TEMPLATE}" \
    --file-list "${FILE_LIST}" --file-list-format list \
    -O "${OUTPUT}" -U "${OUTPUT}"

    viewer "${OUTPUT}"
    ;;

  "cmd_edit")
    "${EDIT}" "${SCRIPT}"
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
exit 0
EOF
}  >"$JACKSUMSH"

# -------------------------------------------------------------------------
install_script_generic() {
# -------------------------------------------------------------------------
  JACKSUM_VER=$("$JAVA" -jar "$JACKSUM_JAR" -v)
  printf "  Found %s:                [  OK  ]\n" "$JACKSUM_VER"

  printf "  Installing %s.sh:              " "$NAME"
  if [ -d "$PREFIX/share/apps/$NAME/" ]; then
    rm -r "$PREFIX/share/apps/$NAME"
  fi

  JACKSUMSH="$PREFIX/share/apps/$NAME/$NAME.sh"
  mkdir -p "$PREFIX/share/apps/$NAME" 2>/dev/null

  if [ -d "$PREFIX/share/apps/$NAME" ]; then
    if install_script_sh; then
      if chmod +x "$JACKSUMSH"; then
        printf "[  OK  ]\n"
      else
        printf "[FAILED]\n"
        exit 1
      fi
    else
      printf "[FAILED]\n"
      exit 1
    fi
  else
    printf "[FAILED]\n"
    exit 1
  fi
}

# -------------------------------------------------------------------------
function find_app() {
# -------------------------------------------------------------------------
  if [[ "$#" == "0" ]]; then
    printf >&2 "FATAL: at least one parameter is required in find_app(). Exit.\n"
    exit 1
  fi
  while (("$#")); do
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

  if [ -z "$ALGORITHMS" ]; then
    printf "  [direct accessible algorithms]: %s\n\n" "n/a"
  else
    printf "  [direct accessible algorithms]: %s\n\n" "$ALGORITHMS"
  fi
}

# -------------------------------------------------------------------------
enter_java() {
# -------------------------------------------------------------------------
  JAVA_FOUND=0
  while [ $JAVA_FOUND -eq 0 ]; do
    find_bin "java" "$JAVA"
    JAVA="$BIN"

    JAVA_VERSION="$("$JAVA" -fullversion 2>&1)"
    JAVA_VERSION="${JAVA_VERSION#*\"}"
    JAVA_VERSION="${JAVA_VERSION%\"*}"
    JAVA_VERSION="${JAVA_VERSION%%_*}"
    JAVA_VERSION="${JAVA_VERSION%%+*}"

    if [ "$(version_value "$JAVA_VERSION")" -lt "$(version_value 11.0.0)" ]; then
      printf "Java version %s must be at least 11\n" "$JAVA_VERSION"
    else
      JAVA_FOUND=1
    fi
  done
}

# -------------------------------------------------------------------------
modify_params() {
# -------------------------------------------------------------------------
  printf "\nA JDK or JRE is required. If you use a headless JDK/JRE, you cannot use HashGarten which is a GUI for Jacksum.\n"
  printf "You could go to https://adoptium.net for example to obtain a full JDK/JRE.\n"
  printf "On Debian based derivates you could install by 'sudo apt install default-jdk'\n"

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
  if [ $KDE -gt 1 ]; then
    printf "Info:\n"
    # if not root
    if [ "$(id | cut -c5)" -ne 0 ]; then
      printf "  If you want to install Jacksum/HashGarten in %s\n" "$KDE_PROGNAME"
      printf "  for all users, please run this script as root.\n"
    else
      printf "  If you want to install Jacksum/HashGarten %s\n" "$KDE_PROGNAME"
      printf "  only for one user, run the script as a normal user. If you have a Live CD,\n"
      printf "  you must run the script as normal user, because CD-ROMs are read only.\n"
    fi
    print_dashes
  fi
}

# -------------------------------------------------------------------------
select_algorithms() {
# -------------------------------------------------------------------------
  printf "\n\n"
  local YESNO=""
  while [ "$YESNO" != "y" ] && [ "$YESNO" != "n" ]; do
    printf "Do you want to access some algorithms directly without the HashGarten GUI?\nType n to disable direct access to algorithms, type p or any other key to use the previous selection [n]: "
    read -r YESNO
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
      read -r ALGOS
      test -z "$ALGOS" && ALGOS="$ALGORITHMS"
      ALGORITHMS="$ALGOS"
      ;;
    "n")
      ALGORITHMS=""
      ;;
    *) ;;

    esac
  done
}

# -------------------------------------------------------------------------
install_interactive() {
#
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo, elementary, spacefm or zzzfm
# or mucommander
# -------------------------------------------------------------------------
  local YESNO=""
  while [ "$YESNO" != "y" ]; do
    print_params
    printf "Do you want to use the parameters above? [y]: "
    read -r YESNO
    test -z "$YESNO" && YESNO="y"

    case "$YESNO" in
    "y")
      printf "\n"
      uninstall_silent "$1"
      install_script "$1"
      install_menu "$1"
      ;;
    "n")
      modify_params
      ;;
    *) ;;

    esac
  done

  printf "\nInstallation finished.\n"
  install_done "$1"
}

# -------------------------------------------------------------------------
restart_fb() {
#
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo, elementary
# $2 Name of the file browser
# -------------------------------------------------------------------------
  local YESNO=""
  printf "Do you want to restart %s so that changes can become active? [y]: " "$2"
  read -r YESNO
  test -z "$YESNO" && YESNO="y"
  case "$YESNO" in
  "y") # redirecting standard error into standard output
    # in order to avoid ugly warnings from Nautilus
    $1 --quit >/dev/null 2>&1 &
    # avoid a potential race condition (sf# 3099869)
    # (sleep does not cause harm to others)
    printf "Please wait ... "
    sleep 5
    # some older Nautilus restart Nautilus after a quit
    # we ignore that fact and start Nautilus in any case
    $1 >/dev/null 2>&1 &
    ;;
  *) ;;

  esac
}

# -------------------------------------------------------------------------
install_done() {
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo, elementary, mucommander
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
    printf "Please restart KDE Konqueror in order to make the change active.\n"
    ;;
  rox)
    # no restart required for ROX-Filer :)
    ;;
  thunar)
    printf "Please restart Thunar in order to make the change active.\n"
    ;;
  xfe)
    # no restart required for Xfe :)
    ;;
  elementary)
    # restart_fb io.elementary.files "Elementary"
    # no restart required for Elementary :)
    ;;
  spacefm)
    # no restart required for SpaceFM :)
    ;;
  zzzfm)
    # no restart required for zzzFM :)
    ;;
  mucommander)
    printf "Please restart muCommander in order to make the change active.\n"
    ;;
  esac
  printf "Press enter to continue ... "
  read -r
}

# -------------------------------------------------------------------------
install_generic() {
#
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo or elementary, or mucommander
# -------------------------------------------------------------------------
  set_env "$1"
  print_params "$1"
  modify_params
  install_interactive "$1"
  EDIT=""
}

# -------------------------------------------------------------------------
uninstall_generic() {
#
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo or elementary
# -------------------------------------------------------------------------
  set_env "$1"
  uninstall "$1"
}

# -------------------------------------------------------------------------
init_editor() {
# -------------------------------------------------------------------------
  find_app gedit kate defaulttexteditor xfwrite pluma io.elementary.code geany xed pluma
  EDIT="$APP"
}

# -------------------------------------------------------------------------
init_viewer() {
# -------------------------------------------------------------------------
  find_app zenity gedit kate defaulttexteditor xfwrite pluma io.elementary.code geany xed pluma
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
set_env elementary
set_env spacefm
set_env zzzfm
set_env mucommander
init_editor
init_viewer
ACTION="install"
OPTION=0

while :; do
  clear
  print_header
  print_info_kde
  print_menu $ACTION
  printf "Enter option: "
  read -r OPTION
  case "$OPTION" in
  u)
    ACTION="uninstall"
    ;;
  i)
    ACTION="install"
    ;;
  d) # in $KDE we have the major version
    if [ $KDE -gt 1 ]; then
      ${ACTION}_generic kde
    fi
    ;;
  g)
    if [ $GNOME -eq 1 ]; then
      ${ACTION}_generic gnome
    fi
    ;;
  r)
    if [ $ROX -eq 1 ]; then
      ${ACTION}_generic rox
    fi
    ;;
  t)
    if [ $THUNAR -eq 1 ]; then
      ${ACTION}_generic thunar
    fi
    ;;
  x)
    if [ $XFE -eq 1 ]; then
      ${ACTION}_generic xfe
    fi
    ;;
  n)
    if [ $NEMO -eq 1 ]; then
      ${ACTION}_generic nemo
    fi
    ;;
  c)
    if [ $CAJA -eq 1 ]; then
      ${ACTION}_generic caja
    fi
    ;;
  e)
    if [ $ELEMENTARY -eq 1 ]; then
      ${ACTION}_generic elementary
    fi
    ;;
  s)
    if [ $SPACEFM -eq 1 ]; then
      ${ACTION}_generic spacefm
    fi
    ;;
  z)
    if [ $ZZZFM -eq 1 ]; then
      ${ACTION}_generic zzzfm
    fi
    ;;
  m)
    if [ $MUCOMMANDER -eq 1 ]; then
      ${ACTION}_generic mucommander
    fi
    ;;
  
  0 | q)
    printf "\n"
    exit 0
    ;;
  *)
    printf "\n"
    ;;
  esac
done
