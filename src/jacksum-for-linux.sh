#!/usr/bin/env bash
#
#  Jacksum File Browser Integration for Unix and GNU/Linux Operating Systems
#  Copyright (c) 2006-2026 Dipl.-Inf. (FH) Johann N. Loefflmann
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
#
#  * credit: this shell script is based on the bash script called
#    Mount ISO 0.9.1 for KDE, which is released under the terms of the GNU GPL.
#    See also https://web.archive.org/web/20170706050025/https://www.linux-apps.com/p/998451/
#
#  * This script requires jacksum-4.0.0.jar and HashGarten-0.19.0.jar,
#    which are part of the Jacksum file browser integration package for Linux
#    since 2.0.0.
#    See also https://jacksum.net
#
#  * Version 2.x of the script has been successfully tested on the following
#    systems, and it should work on older platforms as well:
#
#    broot 1.55.0 on Ubuntu Linux 26.04
#
#    Caja 1.26.4 on Ubuntu Linux 26.04
#    Caja 1.26.0 on Ubuntu Linux 22.04
#    Caja 1.26.0 on Ubuntu Linux 22.04.1
#
#    Dolphin 24.08.1 (KDE Framework 6.6.0) on Kubuntu 24.10
#    Dolphin 24.02.1 on KDE Neon 6.0, Release 22.04
#    Dolphin 21.12.3 (KDE Framework 5.92) on Kubuntu 22.04
#
#    elementary Files 6.5.2 on elementary OS 7.1
#    elementary Files 6.2.1 on elementary OS 7
#
#    GNOME Files (known as Gnome Nautilus) 50.2.2 on Ubuntu Linux 26.04
#    GNOME Files (known as Gnome Nautilus) 46.0 on Ubuntu Linux 24.04
#    GNOME Files (known as Gnome Nautilus) 42.6 on Ubuntu Linux 22.04.3
#    GNOME Files (known as Gnome Nautilus) 42.2 on Ubuntu Linux 22.04.1
#    GNOME Files (known as Gnome Nautilus) 42.1.1 on Ubuntu Linux 22.04
#    GNOME Files (known as Gnome Nautilus) 3.26.4 on Ubuntu Linux 18.04
#
#    Midnight Commander 4.8.33 on Ubuntu Linux 26.04
#
#    muCommander 1.3.0 on Ubuntu 22.04.4 LTS
#
#    Nemo 6.4.5 on Ubuntu Linux 26.04
#    Nemo 6.0.2 on Linux Mint 21.3
#    Nemo 5.2.4 on Ubuntu Linux 22.04.1
#    Nemo 5.2.4 on Ubuntu Linux 22.04
#
#    nnn 5.1 on Ubuntu Linux 26.04
#
#    PCManFM 1.4.0 on Ubuntu 26.04
#    PCManFM 1.3.2 on Ubuntu 22.04.4
#    PCManFM-Qt 0.17 on Ubuntu 22.04.4
# 
#    Ranger 1.9.4 on Ubuntu Linux 26.04
#
#    ROX Filer 2.24.33 on Ubuntu Linux 22.04.1
#    ROX Filer 2.11 on Ubuntu Linux 22.04
#
#    SpaceFM 1.0.6 on Ubuntu Linux 22.04.3
#    SpaceFM 1.0.6 on elementary OS 7
#
#    Thunar 4.20.7 on Ubuntu Linux 26.04
#    Thunar 4.18.4 on MX-Linux 23
#
#    vifm 0.14.3 on Ubuntu Linux 26.04
#
#    Xfe 1.43.2 on Ubuntu Linux 22.04.1
#    Xfe 1.43 on Ubuntu Linux 22.04
#
#    Yazi 26.9.1 on Ubuntu Linux 26.04
#
#    zzzFM 1.0.7 on antiX Linux 23
#
#
#  * Version 1.x of the script has been successfully tested on the following systems,
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
#    on read-only filesystems (e.g. live CDs), crashes of Kate, or unsupported
#    servicemenus for KDE.

VERSION="2.11.0"
NAME="jacksum"
JACKSUM_VERSION="4.0.0"
HASHGARTEN_VERSION="0.19.0"
PROGNAME="Jacksum/HashGarten File Browser Integration"
JACKSUM_JAR="$(pwd)/jacksum-${JACKSUM_VERSION}.jar"
HASHGARTEN_JAR="$(pwd)/HashGarten-${HASHGARTEN_VERSION}.jar"
ALGOS_DIRECT_SUGGESTION="sha256 sha3-256 sha1 md5 cksum crc32 ed2k sumbsd sumsysv"
ALGORITHMS=""
COMMANDS="cmd_calc;1)_Calc_Hash_Values cmd_check;2)_Check_Data_Integrity cmd_cust;3)_Customized_Output cmd_edit;4)_Edit_Script"
# How many of the $ALGORITHMS get an entry of their own where every entry
# costs a key: mc, ranger and Yazi have a menu hotkey or a key binding per
# entry, and an open ended list of algorithms would either run out of keys or
# bury the entries of the user. Everywhere else all of them get one - broot
# and nnn included, whose verbs and plugins cost no key at all.
MAX_DIRECT_ALGOS=5

# What the installation puts into a config file of a file browser that does
# not have one yet (see backup_file). The uninstallation compares the backup
# against it: if they are the same, the file exists only because we created
# it, and it is removed rather than restored (see restore_backup).
SEED_UCA_XML=$'<?xml version="1.0" encoding="UTF-8"?><actions></actions>\n'
SEED_COMMANDS_XML=$'<?xml version="1.0" encoding="UTF-8"?><commands></commands>\n'

# the user who runs the script; only KDE can install for all users, see set_env
ME="$(whoami)"

# 1 while an uninstallation is only reported, 0 while it is actually carried
# out. See confirm_uninstall(), which uses a dry run to show the user what an
# uninstallation would delete and modify before it asks for confirmation.
DRYRUN=0
# the number of changes that the dry run has found
PLAN_COUNT=0

# Every supported file browser: the key it has in the menu, its internal
# name, and the programs it stands for. The order of the keys is the order of
# the menu. Together with an install_menu_* and an uninstall_* function this
# is all it takes to add one.
BROWSER_KEYS="a b c d e g m n o p r s t u v x y z"
declare -A BROWSER_ID=(
  [a]=ranger [b]=broot [c]=caja [d]=kde [e]=elementary [g]=gnome [m]=mc
  [n]=nnn [o]=nemo [p]=pcmanfm [r]=rox [s]=spacefm [t]=thunar
  [u]=mucommander [v]=vifm [x]=xfe [y]=yazi [z]=zzzfm
)
declare -A BROWSER_PROGNAME=(
  [broot]="broot"
  [caja]="Caja"
  [elementary]="Elementary Files"
  [gnome]="GNOME Files (Nautilus)"
  [kde]="Dolphin, Konqueror, Krusader"
  [mc]="Midnight Commander"
  [mucommander]="muCommander"
  [nemo]="Nemo"
  [nnn]="nnn"
  [pcmanfm]="PCManFM, PCManFM-Qt"
  [ranger]="ranger"
  [rox]="ROX-Filer"
  [spacefm]="SpaceFM"
  [thunar]="Thunar"
  [vifm]="vifm"
  [xfe]="Xfe"
  [yazi]="Yazi"
  [zzzfm]="zzzFM"
)
# Whose install_menu_*/uninstall_* function does the work: several file
# browsers share one, because they want the very same thing (the Nautilus
# family its scripts folder, SpaceFM and zzzFM their handlers).
declare -A BROWSER_IMPL=(
  [broot]=broot [caja]=gnome [elementary]=elementary [gnome]=gnome [kde]=kde
  [mc]=mc [mucommander]=mucommander [nemo]=gnome [nnn]=nnn [pcmanfm]=pcmanfm
  [ranger]=ranger [rox]=rox [spacefm]=xxxfm [thunar]=thunar
  [vifm]=vifm [xfe]=gnome [yazi]=yazi [zzzfm]=xxxfm
)

# Filled in by set_env() and refresh_menu_item(), read by print_menu(): "the
# file browser is not on this machine", whom an installation would be for,
# and "1" if something of ours is installed for it already (which decides
# whether the menu offers install or reinstall, uninstall or nothing at all).
declare -A BROWSER_UNAVAILABLE BROWSER_USERS BROWSER_INSTALLED

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
# Prints one file-manager menu line, unless it is UNAVAILABLE and unavailable
# entries are currently hidden.
#
print_menu_item() {
#
# parameters:
# $1 = menu key
# $2 = file browser
# -------------------------------------------------------------------------
  local KEY="$1"
  local ID="$2"
  local UNAVAILABLE="${BROWSER_UNAVAILABLE[$ID]}"
  local VERB

  if [ -n "$UNAVAILABLE" ] && [ -n "$HIDE_UNAVAILABLE" ]; then
    return
  fi

  # The word says what the key does, and by that it says what is there: an
  # entry that cannot be installed at all, and one that has nothing to
  # uninstall, get dashes rather than an action that would do nothing.
  if [ -n "$UNAVAILABLE" ]; then
    VERB="-------"
  elif [ "$ACTION" = "install" ]; then
    if [ -n "${BROWSER_INSTALLED[$ID]}" ]; then
      VERB="reinstall"
    else
      VERB="install"
    fi
  elif [ -n "${BROWSER_INSTALLED[$ID]}" ]; then
    VERB="uninstall"
  else
    VERB="-------"
  fi

  printf "  %s - %-9s  in %s for %s%s\n" "$KEY" "$VERB" "${BROWSER_PROGNAME[$ID]}" \
    "${BROWSER_USERS[$ID]}" "${UNAVAILABLE:+ $UNAVAILABLE}"
}

# -------------------------------------------------------------------------
# Prints the install/uninstall menu.
#
print_menu() {
# -------------------------------------------------------------------------
  local KEY

  printf "Menu:\n"
  for KEY in $BROWSER_KEYS; do
    print_menu_item "$KEY" "${BROWSER_ID[$KEY]}"
  done
  printf "\n"
  if [ -z "$HIDE_UNAVAILABLE" ]; then
    printf "  h - Hide the UNAVAILABLE entries\n"
  else
    printf "  h - Unhide the UNAVAILABLE entries\n"
  fi
  printf "  i - Toggle install/uninstall menu\n"
  printf "  q - Quit the installer\n"
  print_dashes
}

# -------------------------------------------------------------------------
# Returns 0 if the glob that the caller passed in (unquoted, so that the shell
# expands it here) matched at least one existing file, otherwise 1. An unmatched
# glob stays unexpanded in bash, hence the -e test rather than a count of "$#".
# A symlink whose target is gone is an entry that is still there and that still
# has to be removed, so -L counts as well - -e alone would not see it.
#
glob_exists() {
#
# parameters:
# $@ = the expanded glob, e.g.  glob_exists "$DIR"/foo*
# -------------------------------------------------------------------------
  local f
  for f in "$@"; do
    { [ -e "$f" ] || [ -L "$f" ]; } && return 0
  done
  return 1
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
    # a value left over from an earlier call must not be reused silently
    DIR=""
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
# Looks for a program and reports where it was found, or that it was not.
# The four functions here all take the variable that the result goes into as
# their first parameter, rather than leaving it in one of their own.
#
check_bin() {
#
# parameters:
# $1 = the variable that takes the result
# $2 = binary name
# $3 = default location
# -------------------------------------------------------------------------
  local FOUND=""
  local WHICH
  WHICH="$(command -v "$2" 2>/dev/null)"
  if [ -f "$3" ]; then
    FOUND="$3"
  elif [ -f "$WHICH" ]; then
    FOUND="$WHICH"
  fi

  if [ -n "$FOUND" ]; then
    printf "  [%s]: %s\n" "$2" "$FOUND"
  else
    printf "  [%s]: >> not found <<\n" "$2"
  fi
  printf -v "$1" "%s" "$FOUND"
}

# -------------------------------------------------------------------------
# The same for a file that is expected at one certain place, e.g. a jar.
#
check_file() {
#
# parameters:
# $1 = the variable that takes the result
# $2 = file name
# $3 = default location
# -------------------------------------------------------------------------
  local FOUND=""
  if [ -f "$3" ]; then
    FOUND="$3"
    printf "  [%s]: %s\n" "$2" "$FOUND"
  else
    printf "  [%s]: >> not found <<\n" "$2"
  fi
  printf -v "$1" "%s" "$FOUND"
}

# -------------------------------------------------------------------------
# Asks the user for a file, and keeps asking until it names one that is
# really there.
#
find_bin() {
#
# parameters:
# $1 = the variable that takes the result
# $2 = description for the binary
# $3 = default location
# -------------------------------------------------------------------------
  local FOUND=""

  printf "\n"
  if [ -n "$3" ]; then
    printf "Type the absolute path to \"%s\"\n" "$2"
    printf "and press \"Enter\" to continue [%s]: " "$3"
    read -r FOUND
    test -z "$FOUND" && FOUND="$3"
  fi
  while [ ! -f "$FOUND" ]; do
    printf "Couldn't find \"%s\"!\n" "$2"
    printf "Type the absolute path here or press \"Ctrl+C\" to abort: "
    read -r FOUND
  done
  printf -v "$1" "%s" "$FOUND"
}

# -------------------------------------------------------------------------
# Returns 0 if the java binary that was passed in belongs to a headless
# JRE/JDK, one that cannot open a window, so that HashGarten cannot be used
# with it.
#
# A headless build ships the java.desktop module like every other one, and
# the java.awt.headless property is not set either way (the JVM decides that
# lazily), so neither of the two says anything. What such a build does not
# ship is the native X11 binding of AWT, libawt_xawt.so - that is the file
# that tells them apart (Debian's openjdk-*-jre-headless, Red Hat's
# java-*-openjdk-headless).
#
# Returns 1 for a full JRE/JDK, and also whenever the question cannot be
# answered - a warning that turns out to be made up would be worse than none.
#
is_headless_java() {
#
# parameters:
# $1 the java binary
# -------------------------------------------------------------------------
  local JAVA_HOME_DIR
  # the JVM itself knows where it lives, which readlink would not survive if
  # the binary that was entered is a wrapper script rather than a symlink
  JAVA_HOME_DIR="$("$1" -XshowSettings:properties -version 2>&1 | sed -n 's/^ *java\.home = //p')"
  if [ ! -d "$JAVA_HOME_DIR" ]; then
    return 1
  fi

  # not a layout we know (a Mac has libawt.dylib, and so on), so say nothing
  # rather than read "headless" into the absence of a file that would never
  # be there in the first place
  if ! glob_exists "$JAVA_HOME_DIR"/lib/libawt.so "$JAVA_HOME_DIR"/lib/*/libawt.so; then
    return 1
  fi

  # lib/ is where Java 9 and later keep it, lib/<arch>/ is the older layout
  if glob_exists "$JAVA_HOME_DIR"/lib/libawt_xawt.so "$JAVA_HOME_DIR"/lib/*/libawt_xawt.so; then
    return 1
  fi
  return 0
}

# -------------------------------------------------------------------------
# Normalizes the version and returns a comparable version as a number.
#
version_value() {
#
# parameters:
# $1 version, e.g. 12.34.567
# -------------------------------------------------------------------------
  # leading zeros are stripped, otherwise printf would read a component such as
  # the 08 of 4.08.1 as an octal number and bail out with "invalid octal number"
  # shellcheck disable=SC2046
  # shellcheck disable=SC2183
  printf "%03d%03d%03d" $(printf "%s\n" "$1" | tr '.' '\n' | head -n 3 | sed -e 's/^0*\([0-9]\)/\1/')
}

# -------------------------------------------------------------------------
set_env() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  # Every file browser but KDE installs into the home of the user who runs
  # the script - none of the others has a system wide location that it would
  # read a menu of ours from - so this holds for all of them, and only the
  # KDE branch below overwrites it when the script is run as root.
  USERS="user $ME"

  # a file browser is taken to be missing until its own arm below has found
  # it, so that only the arm that succeeds has anything to say
  BROWSER_UNAVAILABLE[$1]="(UNAVAILABLE)"

  case $1 in
  kde)
    # Every generation of KDE keeps its servicemenus somewhere else, and each
    # one is recognized by a program that only it brings along. The table is
    # walked from the newest generation to the oldest, one row each:
    #
    #   version;program;ask it?;config folder;install prefix;servicemenu folder
    #
    # KDE 6 and 5 are only looked for, KDE 4 and 3 are run: their kde*-config
    # prints the folders they use, so it is asked, and one that cannot even be
    # run is not a KDE we could install into. The two newer ones have no such
    # program, so they leave the folder to the default in the row.
    KDE=0
    for ROW in \
      "6;kded6;;$HOME/.local;/usr;/share/kio/servicemenus/" \
      "5;kf5-config;;$HOME/.local;/usr;/share/kservices5/ServiceMenus/" \
      "4;kde4-config;ask;$HOME/.kde;/opt/kde4;/share/kde4/services/ServiceMenus/" \
      "3;kde-config;ask;$HOME/.kde;/opt/kde3;/share/apps/konqueror/servicemenus/"; do
      IFS=";" read -r KDEVER KDEPROBE KDEASK KDELOCAL KDESYSTEM KDEMENUS <<<"$ROW"

      if [ -n "$KDEASK" ]; then
        "$KDEPROBE" >/dev/null 2>&1 || continue
      else
        type "$KDEPROBE" >/dev/null 2>&1 || continue
      fi

      KDE="$KDEVER"
      BROWSER_UNAVAILABLE[$1]=""
      # $EUID rather than "id -u": Solaris' /usr/bin/id does not know -u
      # (only /usr/xpg4/bin/id does), while bash brings $EUID everywhere
      if [ "$EUID" -ne 0 ]; then
        # non-root user
        LOCAL=""
        test -n "$KDEASK" && LOCAL="$("$KDEPROBE" --localprefix 2>/dev/null)"
        check_env "KDE config folder" "$LOCAL" "$KDELOCAL"
        USERS="user $ME"
      else
        SYSTEM=""
        test -n "$KDEASK" && SYSTEM="$("$KDEPROBE" --prefix 2>/dev/null)"
        check_env "KDE install prefix" "$SYSTEM" "$KDESYSTEM"
        USERS="all users"
      fi
      PREFIX="$DIR"
      KDEPOSTFIX="$KDEMENUS"
      break
    done
    ;;

  gnome)
    if nautilus --version >/dev/null 2>&1; then
      BROWSER_UNAVAILABLE[$1]=""
      # "GNOME nautilus " is 15 characters, so the version starts at column 16
      NAUTILUSVER=$(nautilus --version 2>/dev/null | cut -c16-)
      # The folder has to be derived from the version, not from the folder that
      # happens to exist already (as Nemo does it below): on a fresh account
      # none of them exists yet, and dropping the scripts into the pre 14.04
      # location would install them where a current Nautilus never looks.
      case $NAUTILUSVER in
      [0-9]*)
        if [ "$(version_value "$NAUTILUSVER")" -ge "$(version_value 3.0.0)" ]; then
          # In Ubuntu 14.04 and later, Nautilus config folder is
          PREFIX="$HOME/.local/share/nautilus"
          FB_SCRIPTFOLDER=scripts
        elif [ "$(version_value "$NAUTILUSVER")" -ge "$(version_value 2.0.0)" ]; then
          # Starting with Nautilus 2.x, the Nautilus config folder is
          PREFIX="$HOME/.gnome2"
          FB_SCRIPTFOLDER=nautilus-scripts
        else
          # Starting with Nautilus 1.0.5, the Nautilus config folder is
          PREFIX="$HOME/.gnome"
          FB_SCRIPTFOLDER=nautilus-scripts
        fi
        ;;
      *)
        # unexpected --version output, fall back to whatever is there already
        if [ -e "$HOME/.local/share/nautilus/scripts" ]; then
          PREFIX="$HOME/.local/share/nautilus"
          FB_SCRIPTFOLDER=scripts
        else
          PREFIX="$HOME/.gnome2"
          FB_SCRIPTFOLDER=nautilus-scripts
        fi
        ;;
      esac
    fi
    ;;

  nemo)
    if nemo --version >/dev/null 2>&1; then
      BROWSER_UNAVAILABLE[$1]=""
      NEMOVER=$(nemo --version 2>/dev/null | cut -f2 -d' ')
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
    if xfe --version >/dev/null 2>&1; then
      XFEVER=$(xfe --version 2>/dev/null | cut -f3 -d' ')
      # script folder is supported starting with Xfe 1.35
      if [ "$(version_value "$XFEVER")" -ge "$(version_value 1.35)" ]; then
        BROWSER_UNAVAILABLE[$1]=""
        PREFIX="$HOME/.config/xfe"
        FB_SCRIPTFOLDER=scripts
      fi
    fi
    ;;

  caja)
    if caja --version >/dev/null 2>&1; then
      BROWSER_UNAVAILABLE[$1]=""
      PREFIX="$HOME/.config/caja"
      FB_SCRIPTFOLDER=scripts
    fi
    ;;

  rox)
    if rox --version >/dev/null 2>&1; then
      BROWSER_UNAVAILABLE[$1]=""
      PREFIX="$HOME/.config/rox.sourceforge.net"
    fi
    ;;

  thunar)
    if thunar --version >/dev/null 2>&1; then
      BROWSER_UNAVAILABLE[$1]=""
      PREFIX="$HOME/.config/Thunar"
    fi
    ;;

  elementary)
    if io.elementary.files --version >/dev/null 2>&1; then
      BROWSER_UNAVAILABLE[$1]=""
      PREFIX="$HOME/.local/share/contractor"
    fi
    ;;

  spacefm)
    if spacefm --version >/dev/null 2>&1; then
      BROWSER_UNAVAILABLE[$1]=""
      PREFIX="$HOME/.config/spacefm"
    fi
    ;;

  zzzfm)
    if zzzfm --version >/dev/null 2>&1; then
      BROWSER_UNAVAILABLE[$1]=""
      PREFIX="$HOME/.config/zzzfm"
    fi
    ;;
    
  mucommander)
    if [ -f "/opt/mucommander/bin/muCommander" ]; then
      BROWSER_UNAVAILABLE[$1]=""
      PREFIX="$HOME/.mucommander"
    fi
    ;;

  broot)
    if type broot &>/dev/null; then
      BROWSER_UNAVAILABLE[$1]=""
      # broot's config folder, honoring BROOT_CONFIG_DIR and XDG_CONFIG_HOME
      # like broot itself does (see Conf::dir())
      PREFIX="${BROOT_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/broot}"
      # broot reads conf.hjson, and only if that one is missing conf.toml
      # (see Conf::default_location()). The extension is remembered rather
      # than the whole path, because it is also the syntax that
      # install_menu_broot has to write, and uninstall_broot has to arrive at
      # the very same file.
      if [ ! -f "$PREFIX/conf.hjson" ] && [ -f "$PREFIX/conf.toml" ]; then
        BROOT_CONF_EXT="toml"
      else
        BROOT_CONF_EXT="hjson"
      fi
    fi
    ;;

  mc)
    if type mc &>/dev/null; then
      BROWSER_UNAVAILABLE[$1]=""
      # mc's config folder; MC_PROFILE_ROOT replaces HOME and switches the XDG
      # lookup off entirely, that's what mc itself does (see mc(1))
      if [ -n "$MC_PROFILE_ROOT" ]; then
        PREFIX="$MC_PROFILE_ROOT/.config/mc"
      else
        PREFIX="${XDG_CONFIG_HOME:-$HOME/.config}/mc"
      fi
    fi
    ;;

  nnn)
    if type nnn &>/dev/null; then
      BROWSER_UNAVAILABLE[$1]=""
      # nnn's config folder, honoring XDG_CONFIG_HOME like nnn itself does
      PREFIX="${XDG_CONFIG_HOME:-$HOME/.config}/nnn"
      FB_SCRIPTFOLDER=plugins
    fi
    ;;

  pcmanfm)
    if [ -f "$(command -v pcmanfm 2>/dev/null)" ] || [ -f "$(command -v pcmanfm-qt 2>/dev/null)" ]; then
      BROWSER_UNAVAILABLE[$1]=""
      PREFIX="$HOME/.local/share/file-manager"
    fi
    ;;

  ranger)
    if type ranger &>/dev/null; then
      BROWSER_UNAVAILABLE[$1]=""
      # ranger's config folder, honoring XDG_CONFIG_HOME like ranger itself does
      PREFIX="${XDG_CONFIG_HOME:-$HOME/.config}/ranger"
    fi
    ;;

  vifm)
    if type vifm &>/dev/null; then
      BROWSER_UNAVAILABLE[$1]=""
      # vifm's config folder: $VIFM first, then ~/.vifm, then XDG - the very
      # order vifm itself looks in (see vifm(1), "Startup")
      if [ -n "$VIFM" ]; then
        PREFIX="$VIFM"
      elif [ -d "$HOME/.vifm" ]; then
        PREFIX="$HOME/.vifm"
      else
        PREFIX="${XDG_CONFIG_HOME:-$HOME/.config}/vifm"
      fi
      # $MYVIFMRC wins over $VIFM/vifmrc and may well point somewhere else
      # entirely. The whole path is remembered rather than the folder, because
      # install_menu_vifm and uninstall_vifm have to arrive at the very same
      # file (cf. $BROOT_CONF_EXT).
      VIFMRC="${MYVIFMRC:-$PREFIX/vifmrc}"
    fi
    ;;

  yazi)
    if type yazi &>/dev/null; then
      BROWSER_UNAVAILABLE[$1]=""
      # Yazi's own override var takes precedence, then XDG, like Yazi itself does
      PREFIX="${YAZI_CONFIG_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/yazi}"
    fi
    ;;

  esac
}

# -------------------------------------------------------------------------
# Prints the file browser that a menu key stands for, nothing at all if the
# key is none of ours. The keys are compared one by one on purpose: "*" and
# "@" are subscripts of their own for an array, so a key that somebody typed
# must not be used as one.
#
browser_for_key() {
#
# parameters:
# $1 = the key that was typed
# -------------------------------------------------------------------------
  local KEY
  for KEY in $BROWSER_KEYS; do
    if [ "$KEY" = "$1" ]; then
      printf '%s' "${BROWSER_ID[$KEY]}"
      return
    fi
  done
}

# -------------------------------------------------------------------------
# Probes one file browser and remembers what its menu line has to show: whom
# an installation would be for, and whether it is installed already. Called
# for every file browser on startup and again for the one that an
# installation or an uninstallation has just changed, so that the menu is up
# to date without the installer having to be restarted.
#
refresh_menu_item() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  set_env "$1"

  # A file browser that is not there has no $PREFIX of its own - set_env
  # leaves the one of the file browser before it standing - so there is
  # nothing to probe, and the line shows (UNAVAILABLE) anyway.
  if [ -n "${BROWSER_UNAVAILABLE[$1]}" ] || ! is_installed "$1"; then
    BROWSER_INSTALLED[$1]=""
  else
    BROWSER_INSTALLED[$1]="1"
  fi
  BROWSER_USERS[$1]="$USERS"
}

# -------------------------------------------------------------------------
# Runs the action of the menu on one file browser, unless its menu line shows
# dashes rather than an action - there is nothing that key could do then, see
# print_menu_item().
#
menu_action() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  # the file browser is not there at all
  if [ -n "${BROWSER_UNAVAILABLE[$1]}" ]; then
    return
  fi
  # nothing of ours to remove
  if [ "$ACTION" = "uninstall" ] && [ -z "${BROWSER_INSTALLED[$1]}" ]; then
    return
  fi
  "${ACTION}_generic" "$1"
}

# -------------------------------------------------------------------------
uninstall() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  uninstall_silent "$1"
  printf "\nUninstallation finished. Please press the \"Enter\" key to continue ... "
  read -r
}

# -------------------------------------------------------------------------
uninstall_silent() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  "uninstall_${BROWSER_IMPL[$1]}" "$1"
}

# -------------------------------------------------------------------------
# Returns 0 if something of ours is installed for the file browser.
#
# It does not look for anything itself: it lets the uninstallation report in
# a dry run what it would remove, and if that is nothing, nothing is
# installed. So the menu cannot say anything else than what an uninstallation
# would really find a moment later - a leftover of a half removed
# installation counts as installed, because that is what would be removed.
#
# $PREFIX has to be set for that file browser already, see set_env().
#
is_installed() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  local COUNT

  DRYRUN=1
  PLAN_COUNT=0
  uninstall_silent "$1" >/dev/null
  COUNT="$PLAN_COUNT"
  DRYRUN=0

  [ "$COUNT" -gt 0 ]
}

# -------------------------------------------------------------------------
# Prints one line of the report that an uninstallation shows before it asks
# for confirmation, and counts it, so that confirm_uninstall() can tell
# whether anything of ours is installed at all.
#
plan_item() {
#
# parameters:
# $1 what would happen to it, e.g. "delete" or "modify"
# $2 the path
# $3 optional remark
# -------------------------------------------------------------------------
  PLAN_COUNT=$((PLAN_COUNT + 1))
  printf "  %-7s %s\n" "$1" "$2"
  if [ -n "$3" ]; then
    printf "          (%s)\n" "$3"
  fi
}

# -------------------------------------------------------------------------
# Removes every one of the paths that is there, and reports the result. In a
# dry run ($DRYRUN=1) nothing is touched, the paths are only reported.
#
# Returns 0 if at least one of them was there (and has been removed),
# otherwise 1, so that a caller can make further steps depend on it.
#
remove_items() {
#
# parameters:
# $1 label for the progress line, e.g. "jacksum scripts"
# $2 remark for the report, may be empty
# $@ the paths, globs expanded by the caller as in glob_exists()
# -------------------------------------------------------------------------
  local LABEL="$1"
  local REMARK="$2"
  shift 2

  if ! glob_exists "$@"; then
    status_begin "Removing $LABEL"
    status_note "NOT INSTALLED"
    return 1
  fi

  if [ "$DRYRUN" -eq 1 ]; then
    local ITEM
    for ITEM in "$@"; do
      { [ -e "$ITEM" ] || [ -L "$ITEM" ]; } || continue
      if [ -n "$REMARK" ]; then
        plan_item "delete" "$ITEM" "$REMARK"
      elif [ -L "$ITEM" ]; then
        plan_item "delete" "$ITEM" "symbolic link"
      elif [ -d "$ITEM" ]; then
        plan_item "delete" "$ITEM" "folder with all of its contents"
      else
        plan_item "delete" "$ITEM"
      fi
    done
    return 0
  fi

  status_begin "Removing $LABEL"
  # -f, because a glob that matched nothing is still in "$@" as the pattern
  if rm -rf "$@"; then
    status_ok
  else
    status_failed
  fi
  return 0
}

# -------------------------------------------------------------------------
# Restores a config file that the installation has modified from the backup
# that it has taken back then, and removes the backup. In a dry run
# ($DRYRUN=1) nothing is touched, both files are only reported.
#
# Returns 0 if the backup was there (so that the file has been restored),
# otherwise 1.
#
restore_backup() {
#
# parameters:
# $1 label for the progress line, e.g. "jacksum entries"
# $2 the config file to restore
# $3 the backup to restore it from
# $4 what the installation seeds a config file with that does not exist yet
#    (see backup_file). If that is all the backup holds, the file browser had
#    no config file of its own before the installation, so restoring it would
#    leave a file behind that only exists because we created it - it is
#    removed instead, together with the folder if nothing else is left in it.
#    A config file that holds no more than the default is worth nothing to
#    the file browser: none of them can tell it from one that is not there.
# -------------------------------------------------------------------------
  local LABEL="$1"
  local FILE="$2"
  local BACKUP="$3"
  local SEED="$4"

  if [ ! -f "$BACKUP" ]; then
    status_begin "Removing $LABEL"
    status_note "NOT INSTALLED"
    return 1
  fi

  # both sides go through a command substitution, which strips the trailing
  # newlines of either, so that a seed that ends with one still compares
  # equal to the file that was written from it
  if [ "$(cat "$BACKUP")" = "$(printf "%s" "$SEED")" ]; then
    if [ "$DRYRUN" -eq 1 ]; then
      plan_item "delete" "$FILE" "it holds nothing but what the installation put into it, the file browser had none of its own"
      plan_item "delete" "$BACKUP"
      return 0
    fi
    status_begin "Removing $LABEL"
    rm -f "$FILE" "$BACKUP"
    rmdir "$(dirname "$FILE")" 2>/dev/null
    status_ok
    return 0
  fi

  if [ "$DRYRUN" -eq 1 ]; then
    plan_item "modify" "$FILE" "restored from $(basename "$BACKUP")"
    plan_item "delete" "$BACKUP"
    return 0
  fi

  status_begin "Removing $LABEL"
  cp "$BACKUP" "$FILE"
  rm "$BACKUP"
  status_ok
  return 0
}

# -------------------------------------------------------------------------
# Reports what the caller is about to create or modify, and tells it whether
# it still has to do it: the return value is 0 in a dry run ($DRYRUN=1), so
# that a write site only needs one line in front of it -
#
#   plan_pending "create" "$FILE" && continue
#
# and everything that writes the file stays untouched below it.
#
plan_pending() {
#
# parameters:
# $1 "create" or "modify"
# $2 the path
# $3 optional remark
# -------------------------------------------------------------------------
  if [ "$DRYRUN" -eq 0 ]; then
    return 1
  fi
  plan_item "$1" "$2" "$3"
  return 0
}

# -------------------------------------------------------------------------
# Prints a progress line of the installation, unless this is a dry run,
# where the plan_item lines of the report are all that is wanted.
#
progress() {
#
# parameters:
# $1 the text, backslash escapes such as \n are interpreted
# -------------------------------------------------------------------------
  if [ "$DRYRUN" -eq 0 ]; then
    printf '%b' "$1"
  fi
}

# -------------------------------------------------------------------------
# The three parts of a progress line of the installation: the text on the
# left, padded so that the result behind it always begins in the same column,
# and the result itself. All of them go through progress(), so a dry run,
# which wants nothing but the plan_item lines of its report, stays silent.
#
status_begin() {
#
# parameters:
# $1 what is being done, e.g. "Installing entries"
# -------------------------------------------------------------------------
  progress "$(printf '  %-36s' "$1:")"
}

# -------------------------------------------------------------------------
status_ok() {
# -------------------------------------------------------------------------
  progress "[  OK  ]\n"
}

# -------------------------------------------------------------------------
# Closes the progress line with a result of its own, e.g. "NOT INSTALLED".
#
status_note() {
#
# parameters:
# $1 the word between the brackets
# -------------------------------------------------------------------------
  progress "[ $1 ]\n"
}

# -------------------------------------------------------------------------
# Closes the progress line and gives up: whatever was to be done here could
# not be done, and an installation that goes on from there would leave the
# file browser in a half changed state.
#
status_failed() {
# -------------------------------------------------------------------------
  progress "[FAILED]\n"
  exit 1
}

# -------------------------------------------------------------------------
# Makes a file that has just been written executable and closes the progress
# line. A file that is not there means that writing it has failed.
#
finish_file() {
#
# parameters:
# $1 the file
# -------------------------------------------------------------------------
  if [ -f "$1" ]; then
    chmod +x "$1"
    status_ok
  else
    status_failed
  fi
}

# -------------------------------------------------------------------------
# Builds the remark for a config file that does not get one file per menu
# entry but one entry appended per command and per algorithm, and returns it
# in $ENTRIES_TEXT, e.g. "9 key bindings are added (4 commands + the first 5
# of 12 algorithms)".
#
count_entries() {
#
# parameters:
# $1 what one entry is called here, e.g. "key bindings"
# $2 how many algorithms get one at most, 0 if there is no limit
# -------------------------------------------------------------------------
  local WHAT="$1"
  local MAX="$2"
  local CMDS_N
  local ALGOS_N

  # the word splitting of the two blank separated lists is what counts them;
  # the positional parameters are yardstick only, both arguments are read
  # into locals above
  # shellcheck disable=SC2086
  set -- $COMMANDS
  CMDS_N=$#
  # shellcheck disable=SC2086
  set -- $ALGORITHMS
  ALGOS_N=$#

  if [ "$MAX" -gt 0 ] && [ "$ALGOS_N" -gt "$MAX" ]; then
    ENTRIES_TEXT="$((CMDS_N + MAX)) $WHAT are added ($CMDS_N commands + the first $MAX of $ALGOS_N algorithms)"
  elif [ "$ALGOS_N" -gt 0 ]; then
    ENTRIES_TEXT="$((CMDS_N + ALGOS_N)) $WHAT are added ($CMDS_N commands + $ALGOS_N algorithms)"
  else
    ENTRIES_TEXT="$CMDS_N $WHAT are added, one per command"
  fi
}

# -------------------------------------------------------------------------
# Prints one line per menu entry that a file browser is to get, first one for
# every command and then one for every algorithm:
#
#   KIND<tab>COMMAND<tab>TEXT
#
# KIND is "command" or "algorithm", and the two are not interchangeable: a
# command carries the blanks of its label as underscores and gets them back
# here, while an algorithm keeps every underscore of its name (haval_256_5);
# and ranger and Yazi put the commands on letters but the algorithms on
# numbers, while broot builds a verb name out of either.
#
# To be read with a process substitution rather than with a pipe - the loop
# has to run in the shell of the caller, several of them collect something in
# it that is still needed afterwards (e.g. $MC_ENTRIES):
#
#   while IFS=$'\t' read -r KIND CMD TXT; do ... done < <(menu_entries)
#
menu_entries() {
#
# parameters:
# $1 how many algorithms at most, empty or 0 for all of them
# -------------------------------------------------------------------------
  local MAX="${1:-0}"
  local ENTRY TXT
  local N=0

  # the word splitting of the two blank separated lists is what walks them
  # shellcheck disable=SC2086
  for ENTRY in $COMMANDS; do
    TXT="${ENTRY#*;}"
    printf 'command\t%s\t%s\n' "${ENTRY%;*}" "${TXT//_/ }"
  done

  # shellcheck disable=SC2086
  for ENTRY in $ALGORITHMS; do
    N=$((N + 1))
    if [ "$MAX" -gt 0 ] && [ "$N" -gt "$MAX" ]; then
      break
    fi
    printf 'algorithm\t%s\t%s\n' "$ENTRY" "$ENTRY"
  done
}

# -------------------------------------------------------------------------
# The letter that ranger and Yazi put a command on, empty for a command that
# has none - such a command is skipped rather than silently overwriting the
# binding of the command before it.
#
command_key() {
#
# parameters:
# $1 the command
# -------------------------------------------------------------------------
  case "$1" in
  cmd_calc) printf 'h' ;;
  cmd_check) printf 'c' ;;
  cmd_cust) printf 'o' ;;
  cmd_edit) printf 'e' ;;
  esac
}

# -------------------------------------------------------------------------
# Names the algorithms that did not get an entry of their own because there
# were more of them than $MAX_DIRECT_ALGOS. Prints nothing if none were left
# out. The whole, uncut list is walked on purpose: the entries beyond the
# limit are exactly what this is about.
#
print_skipped_algorithms() {
#
# parameters:
# $1 what an algorithm beyond the limit does not get, e.g. "a menu entry"
# -------------------------------------------------------------------------
  local ALGO
  local N=0
  # shellcheck disable=SC2086
  for ALGO in $ALGORITHMS; do
    N=$((N + 1))
    if [ "$N" -gt "$MAX_DIRECT_ALGOS" ]; then
      printf '    (skipped "%s" and beyond - only the first %d selected algorithms get %s)\n' \
        "$ALGO" "$MAX_DIRECT_ALGOS" "$1"
      return
    fi
  done
}

# -------------------------------------------------------------------------
# Tells the user which key binding the algorithms have got, b1, b2 and so on,
# and which ones did not get one (see $MAX_DIRECT_ALGOS).
#
print_algo_keybindings() {
#
# parameters:
# $1 what an algorithm beyond the limit does not get, e.g. "a key binding"
# -------------------------------------------------------------------------
  local ALGO
  local N=0
  # shellcheck disable=SC2086
  for ALGO in $ALGORITHMS; do
    N=$((N + 1))
    if [ "$N" -eq 1 ]; then
      printf "  Direct algorithm key bindings:\n"
    fi
    if [ "$N" -gt "$MAX_DIRECT_ALGOS" ]; then
      break
    fi
    printf "    b%d - %s\n" "$N" "$ALGO"
  done
  print_skipped_algorithms "$1"
}

# -------------------------------------------------------------------------
# Creates a folder that the installation needs, and reports the result. In a
# dry run ($DRYRUN=1) nothing is created, and only a folder that is not there
# yet is reported - creating one that exists already changes nothing.
#
create_folder() {
#
# parameters:
# $1 what the folder is for, e.g. "all scripts"
# $2 the folder
# -------------------------------------------------------------------------
  local LABEL="$1"
  local DIR="$2"

  if [ "$DRYRUN" -eq 1 ]; then
    if [ ! -d "$DIR" ]; then
      plan_item "create" "$DIR" "folder"
    fi
    return 0
  fi

  status_begin "Creating a folder for $LABEL"
  if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR" 2>/dev/null
    if [ ! -d "$DIR" ]; then
      status_failed
    fi
  fi
  status_ok
}

# -------------------------------------------------------------------------
# Copies a config file that the installation is about to change to its
# backup, so that the uninstallation can put it back (see restore_backup).
# A config file that does not exist yet is created first, which is what the
# [ NOT FOUND ] in the progress line means. In a dry run ($DRYRUN=1) nothing
# is copied, both files are only reported.
#
backup_file() {
#
# parameters:
# $1 label for the progress line, e.g. "rc.conf"
# $2 the config file
# $3 the backup to write
# $4 optional content for a config file that does not exist yet
# -------------------------------------------------------------------------
  local LABEL="$1"
  local FILE="$2"
  local BACKUP="$3"
  local SEED="$4"

  if [ "$DRYRUN" -eq 1 ]; then
    if [ ! -f "$FILE" ]; then
      plan_item "create" "$FILE" "it does not exist yet"
    fi
    plan_item "create" "$BACKUP" "backup of $(basename "$FILE"), taken before it is changed"
    return 0
  fi

  status_begin "Backing up $LABEL"
  if [ ! -f "$FILE" ]; then
    status_note "NOT FOUND"
    mkdir -p "$(dirname "$FILE")" 2>/dev/null
    printf "%s" "$SEED" >"$FILE"
    cp "$FILE" "$BACKUP"
  else
    cp "$FILE" "$BACKUP"
    status_ok
  fi
}

# -------------------------------------------------------------------------
# Removes the generated wrapper folder $PREFIX/share/apps/jacksum and reports
# the result. The now empty parents are taken along too (but only if they are
# in fact empty - "share" may well be shared with something else), so that an
# uninstallation leaves nothing of us behind.
#
remove_jacksum_sh() {
# -------------------------------------------------------------------------
  local SH="$PREFIX/share/apps/$NAME"

  if [ "$DRYRUN" -eq 0 ]; then
    printf "\n"
  fi
  if remove_items "$NAME.sh" \
    "folder with all of its contents, its empty parents are removed too" \
    "$SH"; then
    if [ "$DRYRUN" -eq 0 ]; then
      rmdir "$PREFIX/share/apps" "$PREFIX/share" 2>/dev/null
    fi
  fi
}

# -------------------------------------------------------------------------
uninstall_kde() {
# -------------------------------------------------------------------------
  remove_jacksum_sh
  remove_items "$NAME.desktop" "" "$PREFIX$KDEPOSTFIX$NAME.desktop"
}


# -------------------------------------------------------------------------
uninstall_pcmanfm() {
# -------------------------------------------------------------------------
  DESKTOP_FILES="$PREFIX/actions"

  remove_jacksum_sh
  # the actions folder is shared with the user's own custom actions, so only
  # remove the ones we have generated (see install_menu_pcmanfm_sub)
  remove_items "$NAME*.desktop" "" "$DESKTOP_FILES/${NAME}_"*.desktop
}


# -------------------------------------------------------------------------
uninstall_gnome() {
# -------------------------------------------------------------------------
  SCRIPTS="$PREFIX/$FB_SCRIPTFOLDER/$NAME"

  remove_jacksum_sh
  remove_items "$NAME scripts" "" "$SCRIPTS"
}

# -------------------------------------------------------------------------
uninstall_nnn() {
# -------------------------------------------------------------------------
  SCRIPTS="$PREFIX/$FB_SCRIPTFOLDER"

  remove_jacksum_sh
  # plugins live flat in the shared nnn plugins folder (see install_menu_nnn),
  # so only remove the ones with our "Jacksum  " prefix, not the whole folder
  remove_items "$NAME plugins" "" "$SCRIPTS"/Jacksum\ \ *
}

# -------------------------------------------------------------------------
uninstall_rox() {
# -------------------------------------------------------------------------
  SCRIPTS="$PREFIX/SendTo/$NAME"

  remove_jacksum_sh
  # the scripts and the symlink that points at their folder from the OpenWith
  # folder (see install_menu_rox)
  remove_items "$NAME scripts" "" "$SCRIPTS" "$PREFIX/OpenWith/$NAME"
}

# -------------------------------------------------------------------------
uninstall_thunar() {
# -------------------------------------------------------------------------
  THUNARXML="$PREFIX/uca.xml"
  THUNARXMLBACKUP="$PREFIX/uca.before-jacksum.xml"

  remove_jacksum_sh
  restore_backup "$NAME entries" "$THUNARXML" "$THUNARXMLBACKUP" "$SEED_UCA_XML"
}

# -------------------------------------------------------------------------
uninstall_mc() {
# -------------------------------------------------------------------------
  MCMENU="$PREFIX/menu"
  MCMENUBACKUP="$PREFIX/menu.before-jacksum"

  remove_jacksum_sh
  # A user menu that mc did not have before is a copy of the system wide one
  # that mc falls back to anyway, so restore_backup drops it rather than
  # leaving that copy behind. Determining that copy starts a process, which
  # is not worth it if there is no backup to compare it with in the first
  # place (is_installed() probes every file browser on startup).
  MC_SEED=""
  if [ -f "$MCMENUBACKUP" ]; then
    mc_seed
  fi
  restore_backup "$NAME entries" "$MCMENU" "$MCMENUBACKUP" "$MC_SEED"
}

# -------------------------------------------------------------------------
uninstall_broot() {
# -------------------------------------------------------------------------
  BROOTCONF="$PREFIX/conf.$BROOT_CONF_EXT"
  BROOTCONFBACKUP="$PREFIX/conf.before-jacksum.$BROOT_CONF_EXT"

  remove_jacksum_sh
  # broot does write a config of its own, but only when it is started for the
  # first time; the one the installation creates when there is none yet is
  # empty, so the empty seed drops it again rather than leaving it behind
  restore_backup "$NAME entries" "$BROOTCONF" "$BROOTCONFBACKUP" ""
}

# -------------------------------------------------------------------------
uninstall_ranger() {
# -------------------------------------------------------------------------
  RANGERRC="$PREFIX/rc.conf"
  RANGERRCBACKUP="$PREFIX/rc.before-jacksum.conf"

  remove_jacksum_sh
  # ranger writes no rc.conf of its own, so the one the installation creates
  # when there is none is empty
  restore_backup "$NAME entries" "$RANGERRC" "$RANGERRCBACKUP" ""
}

# -------------------------------------------------------------------------
uninstall_vifm() {
# -------------------------------------------------------------------------
  VIFMRCBACKUP="$VIFMRC.before-jacksum"

  remove_jacksum_sh
  # A vifmrc that vifm did not have yet is a copy of the sample configuration
  # that vifm itself would have created on its very first start (see
  # install_menu_vifm), so restore_backup drops it rather than leaving that
  # copy behind - vifm creates the folder and the file again, sample and all,
  # the next time it is started. Looking the sample up starts a process, which
  # is not worth it if there is no backup to compare it with in the first
  # place (is_installed() probes every file browser on startup).
  VIFM_SEED=""
  if [ -f "$VIFMRCBACKUP" ]; then
    vifm_seed
  fi
  restore_backup "$NAME entries" "$VIFMRC" "$VIFMRCBACKUP" "$VIFM_SEED"
}

# -------------------------------------------------------------------------
uninstall_yazi() {
# -------------------------------------------------------------------------
  YAZIKEYMAP="$PREFIX/keymap.toml"
  YAZIKEYMAPBACKUP="$PREFIX/keymap.before-jacksum.toml"

  remove_jacksum_sh
  restore_backup "$NAME entries" "$YAZIKEYMAP" "$YAZIKEYMAPBACKUP" ""
}

# -------------------------------------------------------------------------
uninstall_mucommander() {
# -------------------------------------------------------------------------
  XML="$PREFIX/commands.xml"
  XMLBACKUP="$PREFIX/commands.before-jacksum.xml"

  remove_jacksum_sh
  restore_backup "$NAME entries" "$XML" "$XMLBACKUP" "$SEED_COMMANDS_XML"
}

# -------------------------------------------------------------------------
uninstall_elementary() {
# -------------------------------------------------------------------------
  SCRIPTS="$PREFIX"

  remove_jacksum_sh
  # the contractor folder is shared with the contracts of other applications,
  # so only remove our own ones (see install_menu_elementary)
  remove_items "$NAME scripts" "" "${SCRIPTS}"/"$NAME".*.contract
}

# -------------------------------------------------------------------------
# Rebuilds the "open_hand-s=..." line of a SpaceFM/zzzFM session file without
# any of our own hand_f_jacksum* entries, keeping every foreign handler and
# their order untouched.
#
# This has to be done word by word. A pattern substitution such as
# ${HANDLERS//hand_f_jacksum[^ ]*/} looks like it would do the same, but in a
# glob "*" is not a quantifier for the preceding bracket expression - it matches
# any string, blanks included - so it would silently swallow every handler that
# is registered behind ours.
#
strip_jacksum_handlers() {
#
# parameters:
# $1 the whole "open_hand-s=..." line
# $2 optional: remove exactly this one handler instead of all of ours, so that
#    the install loop can re-register one handler at a time without dropping
#    the ones it has added before
# -------------------------------------------------------------------------
  local REST="${1#*=}"
  local ONLY="$2"
  local OUT=""
  local HANDLER
  # word splitting is wanted here, the handlers are blank separated
  for HANDLER in $REST; do
    if [ -n "$ONLY" ]; then
      if [ "$HANDLER" = "$ONLY" ]; then
        continue
      fi
    else
      case "$HANDLER" in
      hand_f_jacksum*) continue ;;
      esac
    fi
    OUT="$OUT $HANDLER"
  done
  printf "open_hand-s=%s" "${OUT# }"
}

# -------------------------------------------------------------------------
clean_xxxfm_session_file() {
#
# parameters:
# $1 session file of SpaceFM or zzzFM
# -------------------------------------------------------------------------
  local SESSION_FILE="$1"
  local HANDLER_PREFIX="hand_f_jacksum"

  # get the registered handlers
  local HANDLERS
  HANDLERS=$(grep ^open_hand-s "${SESSION_FILE}") # e.g. open_hand-s=hand_f_3aa02120 hand_f_28b4b240

  # clean the handlers property
  HANDLERS="$(strip_jacksum_handlers "$HANDLERS")"

  # update the session file
  local TEMP_FILE
  TEMP_FILE="$(mktemp)"
  grep -v ^"${HANDLER_PREFIX}" "${SESSION_FILE}" | grep -v ^open_hand-s >"$TEMP_FILE"
  printf "%s\n" "$HANDLERS" >>"$TEMP_FILE"
  cat "${TEMP_FILE}" >"${SESSION_FILE}"
  rm "${TEMP_FILE}"
}

# -------------------------------------------------------------------------
uninstall_xxxfm() {
# -------------------------------------------------------------------------
  SCRIPTS="$PREFIX/scripts"

  remove_jacksum_sh
  if remove_items "$NAME scripts" "" "${SCRIPTS}"/hand_f_jacksum* &&
    [ -f "${PREFIX}/session" ]; then
    if [ "$DRYRUN" -eq 1 ]; then
      plan_item "modify" "${PREFIX}/session" "the jacksum file handlers are unregistered there"
    else
      clean_xxxfm_session_file "${PREFIX}/session"
    fi
  fi
  # The copy of the session file that the installation took (see
  # install_menu_xxxfm) is not restored, it is dropped: the handlers are
  # unregistered above one by one, which keeps everything else in the session
  # - the windows, the bookmarks, every other setting - as it is now, while
  # putting the copy back would revert all of that to the day of the
  # installation. It is only there in case the surgery goes wrong.
  remove_items "$NAME session backup" "" "${PREFIX}/session.backup"
}

# -------------------------------------------------------------------------
install_menu() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  "install_menu_${BROWSER_IMPL[$1]}" "$1"
}

# -------------------------------------------------------------------------
install_menu_kde() {
# -------------------------------------------------------------------------
  # $KDEPOSTFIX carries a trailing slash, which would look odd in the report
  create_folder "servicemenus" "$PREFIX${KDEPOSTFIX%/}"

  DESKFILE="$PREFIX$KDEPOSTFIX$NAME.desktop"
  # one single file, with one action in it per command and per algorithm
  count_entries "menu actions" 0
  plan_pending "create" "$DESKFILE" "$ENTRIES_TEXT" && return 0

  status_begin "Installing $NAME.desktop"

  # gather all action codes (reset first, the installer menu can be run
  # more than once per session)
  ACTIONS=""
  while IFS=$'\t' read -r _KIND CMD TXT; do
    ACTIONS="$ACTIONS;$CMD"
  done < <(menu_entries)
  ACTIONS="${ACTIONS#;}"

  printf "[Desktop Entry]\n" >"$DESKFILE"
  if [ "$KDE" -ge 4 ]; then {
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

  while IFS=$'\t' read -r _KIND CMD TXT; do
    {
      printf "[Desktop Action %s]\n" "$CMD"
      printf "Icon=binary\n"
      printf "Name=%s\n" "$TXT"
      printf "Exec=%s %s %s\n" "$JACKSUMSH" "$CMD" "%U"
      printf "\n"
    } >>"$DESKFILE"
  done < <(menu_entries)

  finish_file "$DESKFILE"
}

# -------------------------------------------------------------------------
# Writes the .desktop file of one menu entry.
#
install_menu_pcmanfm_sub() {
#
# parameters:
# $1 = command or algorithm
# $2 = text
# -------------------------------------------------------------------------
  local CMD="$1"
  local TXT="$2"
  local DESKFILE="${PREFIX}/actions/${NAME}_${CMD}.desktop"

  plan_pending "create" "$DESKFILE" && return 0

  {
    printf "[Desktop Entry]\n"
    printf "Type=Action\n"
    printf "Name=%s\n" "$TXT"
    printf "Profiles=%s_%s\n" "$NAME" "$CMD"
    printf "\n"
    printf "[X-Action-Profile %s_%s]\n" "$NAME" "$CMD"
    printf "Exec=%s %s %s\n" "$JACKSUMSH" "$CMD" "%F"
    printf "\n"
  } >"$DESKFILE"
  # one progress line covers the whole set of them, see install_menu_pcmanfm,
  # so only a failure has something to say here
  if [ ! -f "$DESKFILE" ]; then
    status_failed
  fi
  chmod +x "$DESKFILE"
}

# -------------------------------------------------------------------------
install_menu_pcmanfm() {
# -------------------------------------------------------------------------
  create_folder "servicemenus" "$PREFIX/actions"

  status_begin "Installing actions"

  while IFS=$'\t' read -r _KIND CMD TXT; do
    install_menu_pcmanfm_sub "$CMD" "$TXT"
  done < <(menu_entries)

  status_ok
}

# -------------------------------------------------------------------------
# Writes one little script per menu entry into $SCRIPTFOLDER, named after the
# entry, which is what the file browser shows in its menu. Used by Nautilus,
# Xfe, Nemo, Caja and ROX-Filer.
#
install_entry_scripts() {
# -------------------------------------------------------------------------
  local _KIND CMD TXT SCRIPT

  status_begin "Installing scripts"

  while IFS=$'\t' read -r _KIND CMD TXT; do
    SCRIPT="$SCRIPTFOLDER/$TXT"
    plan_pending "create" "$SCRIPT" && continue
    printf "#!/bin/sh\n" >"$SCRIPT"
    printf 'exec %s %s "$@"\n' "$JACKSUMSH" "$CMD" >>"$SCRIPT"
    chmod +x "$SCRIPT"
  done < <(menu_entries)

  status_ok
}

# -------------------------------------------------------------------------
# Function for Nautilus, Xfe and Nemo.
#
install_menu_gnome_shared() {
# -------------------------------------------------------------------------
  create_folder "all scripts" "$SCRIPTFOLDER"
  install_entry_scripts
}

# -------------------------------------------------------------------------
install_menu_gnome() {
# -------------------------------------------------------------------------
  SCRIPTFOLDER="$PREFIX/$FB_SCRIPTFOLDER/$NAME"
  install_menu_gnome_shared
}

# -------------------------------------------------------------------------
# Writes one nnn plugin script that forwards the current selection (or the
# hovered file, if nothing is explicitly selected) to jacksum.sh. Unlike the
# Nautilus-family scripts, nnn does not pass selected files as "$@" - plugins
# get $1=hovered file, $2=working dir, and must read nnn's own NUL-separated
# ".selection" file for a multi-file selection.
#
# The plugin picker (';' then Enter) only runs entries that sit directly in
# nnn's plugins folder; an entry inside a subfolder is just opened with the
# default file opener/editor instead of executed. So, unlike the other
# browsers' dedicated "jacksum" scripts folder, plugins must be written flat
# into $SCRIPTFOLDER, with a "Jacksum  " prefix (two spaces to visually
# separate it from the entry name) to keep them identifiable and to not
# collide with the user's other, unrelated nnn plugins.
#
install_menu_nnn_plugin() {
#
# parameters:
# $1 = command or algorithm
# $2 = text
# -------------------------------------------------------------------------
  local CMD="$1"
  local TXT="$2"
  local PLUGIN="$SCRIPTFOLDER/Jacksum  $TXT"
  plan_pending "create" "$PLUGIN" && return 0
  {
    printf '#!/usr/bin/env bash\n'
    printf 'JACKSUMSH="%s"\n' "$JACKSUMSH"
    printf 'CMD="%s"\n' "$CMD"
    cat <<'EOF'
# $1 = hovered file, $2 = working directory (nnn plugin convention)
# NNN_SEL is nnn's own override for the selection file, see nnn(1)
SEL="${NNN_SEL:-${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection}"
FILES=()
if [ -s "$SEL" ]; then
  # "|| [ -n "$f" ]" also picks up the last entry when the selection file
  # has no trailing NUL after it (read would otherwise fail and drop it)
  while IFS= read -r -d '' f || [ -n "$f" ]; do
    FILES+=("$f")
  done < "$SEL"
else
  FILES=("$2/$1")
fi
# detached, everything we start is a GUI and nnn would otherwise stay blocked
# until its window is closed again
("$JACKSUMSH" "$CMD" "${FILES[@]}" >/dev/null 2>&1 &)
EOF
  } >"$PLUGIN"
  chmod +x "$PLUGIN"
}

# -------------------------------------------------------------------------
install_menu_nnn() {
# -------------------------------------------------------------------------
  SCRIPTFOLDER="$PREFIX/$FB_SCRIPTFOLDER"
  create_folder "all plugins" "$SCRIPTFOLDER"

  status_begin "Installing plugins"
  while IFS=$'\t' read -r _KIND CMD TXT; do
    install_menu_nnn_plugin "$CMD" "$TXT"
  done < <(menu_entries)
  status_ok
}

# -------------------------------------------------------------------------
# Looks for the system wide mc.menu and returns its path in $MC_SYSTEM_MENU.
# "mc --datadir" prints the folder of the system wide config files and, in
# parentheses, the one of the system wide data files; depending on the
# distribution the file is in either of the two.
#
find_mc_system_menu() {
# -------------------------------------------------------------------------
  local DIR
  MC_SYSTEM_MENU=""
  # the word splitting of the "mc --datadir" output is intended here
  for DIR in $(mc --datadir 2>/dev/null | tr -d '()') /etc/mc /usr/share/mc /usr/local/share/mc; do
    # mc prints its folders with a trailing slash, we don't want a double one
    if [ -f "${DIR%/}/mc.menu" ]; then
      MC_SYSTEM_MENU="${DIR%/}/mc.menu"
      return 0
    fi
  done
  return 1
}

# -------------------------------------------------------------------------
# Returns in $MC_SEED what a user menu that mc does not have yet is filled
# with by the installation: the system wide menu that mc falls back to as
# long as there is no user menu, so that the user does not lose the entries
# they know, or a minimal menu if there is no system wide one either.
#
mc_seed() {
# -------------------------------------------------------------------------
  if find_mc_system_menu; then
    MC_SEED="$(cat "$MC_SYSTEM_MENU")"
  else
    MC_SEED="shell_patterns=0"
  fi
}

# -------------------------------------------------------------------------
# Determines the hotkey of the next mc user menu entry and returns it in
# $HOTKEY. The first character of an entry line in an mc menu file is that
# entry's hotkey, and mc jumps to the first entry that carries the character
# that was typed - an entry with a character that is taken already would
# never be reached. So the characters that are in use are collected in
# $MC_HOTKEYS_USED (install_menu_mc initializes it from the menu file) and
# they are skipped here.
#
# The pool deliberately has none of the characters that mc's own mc.menu
# uses. At most 4 + 5 = 9 of them are needed, so running out is a merely
# theoretical case; "." is used then, which is no hotkey at all, but the
# entry is still in the menu and can be reached with the arrow keys, which
# beats shadowing an entry of the user.
#
mc_next_hotkey() {
#
# in/out: $MC_HOTKEYS_USED, the characters that are taken already
# -------------------------------------------------------------------------
  local POOL="jklefgipqsuvwJKLEFGIMNOPQSTVWX9"
  local I C
  for ((I = 0; I < ${#POOL}; I++)); do
    C="${POOL:I:1}"
    case "$MC_HOTKEYS_USED" in
    *"$C"*) ;;
    *)
      MC_HOTKEYS_USED="$MC_HOTKEYS_USED$C"
      HOTKEY="$C"
      return
      ;;
    esac
  done
  HOTKEY="."
}

# -------------------------------------------------------------------------
# Appends one entry to the mc user menu: the hotkey and the title start in
# column 1, and the command below it is indented - that is what makes mc
# treat the line as a command rather than as the next entry.
#
# mc replaces %s with the tagged files, or with the file under the cursor if
# nothing is tagged, and it shell quotes what it inserts (see the macro
# documentation on top of mc's own mc.menu), so %s can be handed over to
# jacksum.sh as it is. Everything we start is a GUI and mc runs a menu
# command synchronously, hence the subshell in the background - the panels
# would stay frozen until the window is closed again otherwise.
#
install_menu_mc_entry() {
#
# parameters:
# $1 = command or algorithm
# $2 = text
#
# in/out: $MC_HOTKEYS_USED, $MC_ENTRIES
# -------------------------------------------------------------------------
  mc_next_hotkey
  printf '%s       Jacksum - %s\n' "$HOTKEY" "$2"
  printf '        ("%s" %s %%s >/dev/null 2>&1 &)\n' "$JACKSUMSH" "$1"
  MC_ENTRIES="$MC_ENTRIES    $HOTKEY - $2"$'\n'
}

# -------------------------------------------------------------------------
# mc's user menu, the one that F2 opens, is a plain text file that mc reads
# again every time the menu is opened, so no restart is required. mc uses the
# user's own menu only if it exists and the system wide one otherwise, which
# is why a menu that we have to create is seeded with a copy of the system
# wide one: a file with nothing but our own entries in it would silently take
# all of mc's default actions away from the user.
#
# Unlike ranger and Yazi this is a real menu, so all four fixed $COMMANDS get
# an entry; of $ALGORITHMS (open-ended, user-selectable) only the first 5 do,
# so that a long list of directly selected algorithms cannot bury the user's
# own entries - the rest remain reachable via HashGarten's own GUI as usual.
#
install_menu_mc() {
# -------------------------------------------------------------------------
  MCMENU="$PREFIX/menu"
  MCMENUBACKUP="$PREFIX/menu.before-jacksum"
  # This one cannot use backup_file: a user menu that we have to create is
  # not seeded with a fixed text but with a byte for byte copy of the system
  # wide menu, which mc falls back to as long as there is no user menu - the
  # user would lose the entries they know otherwise.
  if [ "$DRYRUN" -eq 1 ]; then
    if [ ! -f "$MCMENU" ]; then
      if find_mc_system_menu; then
        plan_item "create" "$MCMENU" "a copy of $MC_SYSTEM_MENU, the menu that mc uses as long as there is no user menu"
      else
        plan_item "create" "$MCMENU" "it does not exist yet"
      fi
    fi
    plan_item "create" "$MCMENUBACKUP" "backup of menu, taken before it is changed"
  else
    status_begin "Backing up the user menu"
    if [ ! -f "$MCMENU" ]; then
      status_note "NOT FOUND"
      mkdir -p "$PREFIX" 2>/dev/null
      # this is what mc_seed() describes for the uninstallation, keep the two
      # in step - the uninstallation recognizes a menu that is only ours by
      # comparing the backup against it
      if find_mc_system_menu; then
        cp "$MC_SYSTEM_MENU" "$MCMENU"
      else
        printf 'shell_patterns=0\n' >"$MCMENU"
      fi
      cp "$MCMENU" "$MCMENUBACKUP"
    else
      cp "$MCMENU" "$MCMENUBACKUP"
      status_ok
    fi
    # mc ignores a user menu that everybody could write to, see mc(1)
    chmod go-w "$MCMENU"
  fi

  count_entries "menu entries" "$MAX_DIRECT_ALGOS"
  plan_pending "modify" "$MCMENU" "$ENTRIES_TEXT" && return 0

  status_begin "Installing entries"
  # the characters that are in use as a hotkey already; the shell_patterns
  # line is a setting rather than an entry, and lines that start with #, +
  # or = are comments and conditions, so none of those carries a hotkey
  MC_HOTKEYS_USED="$(sed -n '/^shell_patterns=/d; s/^\([^[:space:]#+=]\).*/\1/p' "$MCMENU" | tr -d '\n')"
  MC_ENTRIES=""
  {
    printf '\n# Jacksum/HashGarten (added by jacksum-for-linux.sh)\n'
    while IFS=$'\t' read -r _KIND CMD TXT; do
      install_menu_mc_entry "$CMD" "$TXT"
    done < <(menu_entries "$MAX_DIRECT_ALGOS")
  } >>"$MCMENU"
  status_ok

  # see mc(1), FILES: a "local user-defined menu" wins over the user menu
  MCLOCALMENU="${MC_PROFILE_ROOT:-$HOME}/.local/share/mc.menu"
  if [ -f "$MCLOCALMENU" ]; then
    printf "  Note: mc uses %s\n" "$MCLOCALMENU"
    printf "        instead of the user menu, so the entries below stay invisible as\n"
    printf "        long as that file exists.\n"
  fi

  printf "  User menu entries (press F2 in mc):\n"
  printf "%s" "$MC_ENTRIES"
  print_skipped_algorithms "a menu entry"
}

# -------------------------------------------------------------------------
install_menu_rox() {
# -------------------------------------------------------------------------
# on Ubuntu 10.04 (ROX-Filer 2.5), the folder is called SendTo
  SCRIPTFOLDER="$PREFIX/SendTo/$NAME"
  create_folder "all scripts" "$SCRIPTFOLDER"

  # on Puppy Linux 4.3.1 (ROX-Filer 2.6.1), the folder is called OpenWith
  OPENWITHFOLDER="$PREFIX/OpenWith"
  create_folder "OpenWith" "$OPENWITHFOLDER"
  # simply make a symlink in order to be cross-compatible
  if ! plan_pending "create" "$OPENWITHFOLDER/$NAME" "symbolic link to $SCRIPTFOLDER"; then
    ln -sfn "$SCRIPTFOLDER" "$OPENWITHFOLDER/$NAME"
  fi

  install_entry_scripts
}

# -------------------------------------------------------------------------
install_menu_thunar() {
# -------------------------------------------------------------------------
  THUNARXML="$PREFIX/uca.xml"
  THUNARXMLBACKUP="$PREFIX/uca.before-jacksum.xml"
  backup_file "uca.xml" "$THUNARXML" "$THUNARXMLBACKUP" "$SEED_UCA_XML"

  count_entries "actions" 0
  plan_pending "modify" "$THUNARXML" "$ENTRIES_TEXT" && return 0

  status_begin "Installing entries"

  MYTEMP="$(mktemp)"
  # xml without the closing </actions> tag
  sed 's/<\/actions>//' "$THUNARXML" >"$MYTEMP"

  while IFS=$'\t' read -r _KIND CMD TXT; do
    {
      printf '<action>\n'
      printf '<name>Jacksum - %s</name>\n' "$TXT"
      printf '<command>%s %s %s</command>\n' "$JACKSUMSH" "$CMD" "%F"
      printf '<description>%s</description>\n' "$TXT"
      printf '<patterns>*</patterns>\n'
      printf '<directories/><audio-files/><image-files/><other-files/><text-files/><video-files/>\n'
      printf '</action>\n'
    } >>"$MYTEMP"
  done < <(menu_entries)

  printf '</actions>\n' >>"$MYTEMP"
  cp "$MYTEMP" "$THUNARXML"
  rm "$MYTEMP"
  status_ok
}

# -------------------------------------------------------------------------
# broot has neither a menu nor a browsable plugin folder, and a key of the
# ranger kind is out of the question too: what is typed in broot goes into
# its search input. Its own extension point are verbs - named commands that
# are called with ":" and their name, are completed while they are typed and
# are listed on the help screen ("?"). A verb costs no key, so unlike mc,
# ranger and Yazi broot deliberately gets one for every single selected
# algorithm, nnn style.
#
# The verbs are appended to broot's config file - conf.hjson, or conf.toml if
# that is the one broot itself would read (see set_env) - which is backed
# up/restored the way Thunar's uca.xml is. {file:space-separated} is what
# hands jacksum.sh more than one file: broot runs an external command once
# per file of its staging area (ctrl-g), and that flag turns it into a single
# run with all of them; without anything staged it is simply the selection.
# The flag arrived in broot 1.56.0 and an older broot silently ignores it, so
# the verbs work there too - one run per staged file instead of one for all
# of them, which is what the note at the end of this function is about.
#
install_menu_broot() {
# -------------------------------------------------------------------------
  BROOTCONF="$PREFIX/conf.$BROOT_CONF_EXT"
  BROOTCONFBACKUP="$PREFIX/conf.before-jacksum.$BROOT_CONF_EXT"

  # Repeated [[verbs]] tables are regular TOML, so a conf.toml is always
  # appended to. In hjson a second "verbs" key would be a duplicate one
  # instead, and broot's own conf.hjson has none (it keeps its verbs in the
  # imported verbs.hjson), so an hjson config that does bring one is added to
  # rather than appended to - as long as its array opens on a line of its
  # own. Where it does not, this stops before anything has been touched:
  # guessing where that array ends would put the config of the user at risk.
  BROOT_INSERT=""
  if [ "$BROOT_CONF_EXT" = "hjson" ] && [ -f "$BROOTCONF" ] &&
    grep -q '^[[:space:]]*verbs[[:space:]]*:' "$BROOTCONF"; then
    if grep -q '^[[:space:]]*verbs[[:space:]]*:[[:space:]]*\[[[:space:]]*$' "$BROOTCONF"; then
      BROOT_INSERT=1
    else
      printf >&2 "\nFATAL: %s holds a \"verbs\" key that this\n" "$BROOTCONF"
      printf >&2 "       script cannot add to. Move your verbs to verbs.hjson, which\n"
      printf >&2 "       broot's own conf.hjson imports, and try again. Exit.\n"
      exit 1
    fi
  fi

  backup_file "conf.$BROOT_CONF_EXT" "$BROOTCONF" "$BROOTCONFBACKUP" ""

  # broot waits for an external command while everything we start is a GUI,
  # so it gets a helper of its own next to jacksum.sh that starts it detached
  BROOTRUN="$(dirname "$JACKSUMSH")/broot-run.sh"
  if plan_pending "create" "$BROOTRUN" "helper that starts $NAME.sh detached"; then
    count_entries "verbs" 0
    plan_item "modify" "$BROOTCONF" "$ENTRIES_TEXT"
    return 0
  fi
  {
    printf '#!/usr/bin/env bash\n'
    printf 'JACKSUMSH="%s"\n' "$JACKSUMSH"
    cat <<'EOF'
CMD="$1"; shift
# detached, everything we start is a GUI and broot would otherwise stay
# blocked until its window is closed again
("$JACKSUMSH" "$CMD" "$@" >/dev/null 2>&1 &)
EOF
  } >"$BROOTRUN"
  chmod +x "$BROOTRUN"

  status_begin "Installing verbs"

  MYTEMP="$(mktemp)"
  BROOT_VERBS=""
  while IFS=$'\t' read -r KIND CMD TXT; do
    if [ "$KIND" = "command" ]; then
      VERB="${CMD#cmd_}"
    else
      VERB="$CMD"
    fi
    # broot reads a verb name as one word, and every character in it that is
    # neither alphanumeric nor "_" nor "-" would start the arguments of the
    # verb instead - so sha512/256 becomes jacksum_sha512_256, while sha3-256
    # and haval_256_5 stay what they are. Only the name is touched: the
    # description and what is handed to jacksum.sh keep the algorithm as it is.
    VERB="${NAME}_${VERB//[!A-Za-z0-9_-]/_}"
    if [ "$BROOT_CONF_EXT" = "toml" ]; then
      printf '\n[[verbs]]\n'
      printf 'invocation = "%s"\n' "$VERB"
      printf 'description = "Jacksum - %s"\n' "$TXT"
      printf 'external = [ "%s", "%s", "{file:space-separated}" ]\n' "$BROOTRUN" "$CMD"
      # a verb that leaves broot cannot be used on the staging area, and
      # switching the terminal away is pointless for a GUI we start detached
      printf 'leave_broot = false\n'
      printf 'switch_terminal = false\n'
    else
      printf '    {\n'
      printf '        invocation: %s\n' "$VERB"
      printf '        description: "Jacksum - %s"\n' "$TXT"
      printf '        external: [ "%s", "%s", "{file:space-separated}" ]\n' "$BROOTRUN" "$CMD"
      printf '        leave_broot: false\n'
      printf '        switch_terminal: false\n'
      printf '    }\n'
    fi
    BROOT_VERBS="$BROOT_VERBS    :$VERB - $TXT"$'\n'
  done < <(menu_entries) >"$MYTEMP"

  if [ -n "$BROOT_INSERT" ]; then
    MYTEMP2="$(mktemp)"
    awk -v entries="$MYTEMP" '
      { print }
      !added && /^[[:space:]]*verbs[[:space:]]*:[[:space:]]*\[[[:space:]]*$/ {
        print "    # Jacksum/HashGarten (added by jacksum-for-linux.sh)"
        while ((getline line < entries) > 0) { print line }
        added = 1
      }' "$BROOTCONF" >"$MYTEMP2"
    cp "$MYTEMP2" "$BROOTCONF"
    rm "$MYTEMP2"
  else
    {
      printf '\n# Jacksum/HashGarten (added by jacksum-for-linux.sh)\n'
      if [ "$BROOT_CONF_EXT" = "hjson" ]; then
        printf 'verbs: [\n'
        cat "$MYTEMP"
        printf ']\n'
      else
        cat "$MYTEMP"
      fi
    } >>"$BROOTCONF"
  fi
  rm "$MYTEMP"
  status_ok

  # "broot 1.55.0" - the version decides whether the whole staging area
  # reaches jacksum.sh in one run, see {file:space-separated} above
  BROOT_VER="$(broot --version 2>/dev/null | cut -f2 -d' ')"
  BROOT_MAJOR="${BROOT_VER%%.*}"
  BROOT_MINOR="${BROOT_VER#*.}"
  BROOT_MINOR="${BROOT_MINOR%%.*}"
  case "$BROOT_MAJOR.$BROOT_MINOR" in
  *[!0-9.]* | "." | *..*) ;; # nothing to compare, so nothing to say
  *)
    if [ "$BROOT_MAJOR" -eq 1 ] && [ "$BROOT_MINOR" -lt 56 ]; then
      printf "  Note: broot %s runs a verb once per file of the staging area;\n" "$BROOT_VER"
      printf "        1.56.0 and newer hand all of them over in a single run.\n"
    fi
    ;;
  esac

  printf "  Verbs (type \":\" and the name in broot, \"?\" lists them all):\n"
  printf "%s" "$BROOT_VERBS"
}

# -------------------------------------------------------------------------
# Looks for the sample vifmrc and returns its path in $VIFM_SAMPLE. vifm
# takes it from the data folder that belongs to its own binary (see
# get_installed_data_dir()), so that one is asked first and the usual system
# wide places afterwards.
#
find_vifm_sample_vifmrc() {
# -------------------------------------------------------------------------
  local DIR
  VIFM_SAMPLE=""
  for DIR in "$(dirname "$(command -v vifm)" 2>/dev/null)/../share/vifm" \
    /usr/share/vifm /usr/local/share/vifm /etc/vifm; do
    if [ -f "$DIR/vifmrc" ]; then
      VIFM_SAMPLE="$DIR/vifmrc"
      return 0
    fi
  done
  return 1
}

# -------------------------------------------------------------------------
# Returns in $VIFM_SEED what a vifmrc that vifm does not have yet is filled
# with by the installation: the sample configuration that vifm copies there
# itself - but only on its very first start, and only as long as the config
# folder does not exist yet (see setup_dirs()/copy_rc_file()), so a vifmrc
# that we create would take the sample away from the user for good. An empty
# seed if there is no sample anywhere.
#
vifm_seed() {
# -------------------------------------------------------------------------
  if find_vifm_sample_vifmrc; then
    VIFM_SEED="$(cat "$VIFM_SAMPLE")"
  else
    VIFM_SEED=""
  fi
}

# -------------------------------------------------------------------------
# Builds the name of the vifm command for one menu entry and prints it.
#
# vifm takes letters and digits in a command name and nothing else (see
# vifm(1), :command), so the "_" that a broot verb carries is out of the
# question here. On top of that vifm refuses a name whose part in front of a
# digit matches a command that ends there or goes on with a letter, which
# "ed2k" ("jacksumed" + "it") and pairs like "tiger"/"tiger2" or "md5"/"mdc2"
# would run into. "X" solves both at once: it separates the name of the
# program from the entry, it stands in for every character that vifm does not
# take, and it goes in front of every group of digits.
#
#   cmd_calc -> jacksumXcalc      sha3-256    -> jacksumXshaX3X256
#   ed2k     -> jacksumXedX2k     haval_256_5 -> jacksumXhavalX256X5
#
# Only the name is built this way: what is handed to jacksum.sh and what the
# summary shows keep the algorithm exactly as it is.
#
vifm_command_name() {
#
# parameters:
# $1 the command without its "cmd_", or the algorithm
# -------------------------------------------------------------------------
  local IN="$1"
  local OUT=""
  local PREV=""
  local C I

  for ((I = 0; I < ${#IN}; I++)); do
    C="${IN:I:1}"
    case "$C" in
    [!A-Za-z0-9]) C="X" ;;
    esac
    case "$C" in
    [0-9])
      # an X in front of the group of digits, unless there is one already. A
      # group that starts the name gets one too: "jacksumX2..." and
      # "jacksumXcalc" would be ambiguous to vifm otherwise.
      case "$PREV" in
      "" | [!0-9X]) OUT="${OUT}X" ;;
      esac
      ;;
    esac
    OUT="$OUT$C"
    PREV="$C"
  done

  printf '%sX%s' "$NAME" "$OUT"
}

# -------------------------------------------------------------------------
# vifm has neither a context menu nor a browsable plugin folder, and its
# normal mode keys are the ones a vi user expects them to be, so a key
# binding of the ranger kind is no place for this either. Its own extension
# point are user commands: they are called with ":" and their name, are
# completed while they are typed, and ":command jacksum" lists all of ours as
# a menu. A command costs no key, so unlike mc, ranger and Yazi vifm
# deliberately gets one for every single selected algorithm, broot style.
#
# The commands are appended to the vifmrc that vifm reads (see set_env),
# which is backed up/restored the way Thunar's uca.xml is. What deliberately
# does not happen here is a ":filetype" entry per command: those would show
# up in vifm's file menu, but they would also take the Enter key away from
# every file that has no association of its own yet.
#
install_menu_vifm() {
# -------------------------------------------------------------------------
  VIFMRCBACKUP="$VIFMRC.before-jacksum"

  # This one cannot use backup_file: a vifmrc that we have to create is not
  # seeded with a fixed text but with a byte for byte copy of the sample
  # configuration, which vifm would only ever write itself while it does not
  # have a config folder yet (see vifm_seed).
  if [ "$DRYRUN" -eq 1 ]; then
    if [ ! -f "$VIFMRC" ]; then
      if find_vifm_sample_vifmrc; then
        plan_item "create" "$VIFMRC" "a copy of $VIFM_SAMPLE, the sample configuration that vifm creates on its first start"
      else
        plan_item "create" "$VIFMRC" "it does not exist yet"
      fi
    fi
    plan_item "create" "$VIFMRCBACKUP" "backup of $(basename "$VIFMRC"), taken before it is changed"
  else
    status_begin "Backing up $(basename "$VIFMRC")"
    if [ ! -f "$VIFMRC" ]; then
      status_note "NOT FOUND"
      mkdir -p "$(dirname "$VIFMRC")" 2>/dev/null
      # this is what vifm_seed() describes for the uninstallation, keep the
      # two in step - the uninstallation recognizes a vifmrc that is only
      # ours by comparing the backup against it
      if find_vifm_sample_vifmrc; then
        cp "$VIFM_SAMPLE" "$VIFMRC"
      else
        : >"$VIFMRC"
      fi
      cp "$VIFMRC" "$VIFMRCBACKUP"
    else
      cp "$VIFMRC" "$VIFMRCBACKUP"
      status_ok
    fi
  fi

  count_entries "user commands" 0
  plan_pending "modify" "$VIFMRC" "$ENTRIES_TEXT" && return 0

  status_begin "Installing commands"
  VIFM_COMMANDS=""
  {
    # a comment in a vifmrc starts with '"', not with '#'
    printf '\n" Jacksum/HashGarten (added by jacksum-for-linux.sh)\n'
    while IFS=$'\t' read -r KIND CMD TXT; do
      if [ "$KIND" = "command" ]; then
        VIFMCMD="$(vifm_command_name "${CMD#cmd_}")"
      else
        VIFMCMD="$(vifm_command_name "$CMD")"
      fi
      # "command!" rather than "command": a reinstallation, or a name that
      # the user has given away already, is overwritten rather than making
      # vifm complain about it on every start.
      # %f = the selected files, or the file under the cursor if nothing is
      # selected, shell quoted by vifm itself (the counterpart of ranger's
      # %p). %i and the trailing "&" run it in the background, without an
      # error dialog and without the terminal - everything we start is a GUI
      # and vifm would stay blocked until its window is closed again
      # otherwise; what it has to say is still in vifm's ":jobs" menu.
      printf 'command! %s "%s" %s %%f %%i &\n' "$VIFMCMD" "$JACKSUMSH" "$CMD"
      VIFM_COMMANDS="$VIFM_COMMANDS    :$VIFMCMD - $TXT"$'\n'
    done < <(menu_entries)
  } >>"$VIFMRC"
  status_ok

  printf "  Commands (type \":\" and the name in vifm, \":command %s\" lists them all):\n" "$NAME"
  printf "%s" "$VIFM_COMMANDS"
}

# -------------------------------------------------------------------------
# ranger has no browsable plugin/menu folder like nnn; its only extension
# point for this is key bindings in its own rc.conf (backed up/restored the
# same way Thunar's uca.xml is). The four fixed $COMMANDS get key bindings
# b[h|c|o|e]; of $ALGORITHMS (open-ended, user-selectable) only the first 5
# also get one (b1..b5), since an unbounded list doesn't scale to individual
# key bindings - the rest remain reachable via HashGarten's own GUI as usual.
#
install_menu_ranger() {
# -------------------------------------------------------------------------
  RANGERRC="$PREFIX/rc.conf"
  RANGERRCBACKUP="$PREFIX/rc.before-jacksum.conf"
  backup_file "rc.conf" "$RANGERRC" "$RANGERRCBACKUP" ""

  count_entries "key bindings" "$MAX_DIRECT_ALGOS"
  plan_pending "modify" "$RANGERRC" "$ENTRIES_TEXT" && return 0

  status_begin "Installing key bindings"
  {
    printf '\n# Jacksum/HashGarten (added by jacksum-for-linux.sh)\n'
    N=0
    while IFS=$'\t' read -r KIND CMD _TXT; do
      if [ "$KIND" = "command" ]; then
        KEY="$(command_key "$CMD")"
        # a command we have no key for is skipped rather than silently
        # overwriting the binding of the entry before it
        if [ -z "$KEY" ]; then
          continue
        fi
      else
        # the algorithms are numbered, b1 to b$MAX_DIRECT_ALGOS
        N=$((N + 1))
        KEY="$N"
      fi
      # -f = fork: everything we start here is a GUI, without it ranger would
      # stay blocked until the window is closed again (see ranger(1), FLAGS)
      # %p = selection: marked files if any, else the highlighted file (ranger's own convention)
      printf 'map b%s shell -f %s %s %%p\n' "$KEY" "$JACKSUMSH" "$CMD"
    done < <(menu_entries "$MAX_DIRECT_ALGOS")
  } >>"$RANGERRC"
  status_ok

  print_algo_keybindings "a ranger key binding"
}

# -------------------------------------------------------------------------
# Yazi's %h (hovered) and %s (selected) are independent placeholders with no
# built-in "selection, else hovered" fallback (unlike ranger's %p) - so a
# small resolver picks %s if any files were selected, else falls back to %h,
# before forwarding to jacksum.sh. Only the four fixed $COMMANDS get key
# bindings, plus the first 5 selected $ALGORITHMS (b1..b5) - see ranger.
#
install_menu_yazi() {
# -------------------------------------------------------------------------
  YAZIKEYMAP="$PREFIX/keymap.toml"
  YAZIKEYMAPBACKUP="$PREFIX/keymap.before-jacksum.toml"
  backup_file "keymap.toml" "$YAZIKEYMAP" "$YAZIKEYMAPBACKUP" ""

  # yazi hands a plugin the hovered file and the selection separately, so it
  # needs a second wrapper next to jacksum.sh that sorts that out
  YAZIRUN="$(dirname "$JACKSUMSH")/yazi-run.sh"
  if plan_pending "create" "$YAZIRUN" "helper that passes yazi's selection on to $NAME.sh"; then
    count_entries "key bindings" "$MAX_DIRECT_ALGOS"
    plan_item "modify" "$YAZIKEYMAP" "$ENTRIES_TEXT"
    return 0
  fi
  {
    printf '#!/usr/bin/env bash\n'
    printf 'JACKSUMSH="%s"\n' "$JACKSUMSH"
    cat <<'EOF'
CMD="$1"; shift
HOVERED="$1"; shift
if [ "$#" -gt 0 ]; then
  exec "$JACKSUMSH" "$CMD" "$@"
elif [ -n "$HOVERED" ]; then
  exec "$JACKSUMSH" "$CMD" "$HOVERED"
else
  exec "$JACKSUMSH" "$CMD"
fi
EOF
  } >"$YAZIRUN"
  chmod +x "$YAZIRUN"

  status_begin "Installing key bindings"
  {
    printf '\n# Jacksum/HashGarten (added by jacksum-for-linux.sh)\n'
    N=0
    while IFS=$'\t' read -r KIND CMD TXT; do
      if [ "$KIND" = "command" ]; then
        KEY="$(command_key "$CMD")"
        # a command we have no key for is skipped rather than silently
        # overwriting the binding of the entry before it
        if [ -z "$KEY" ]; then
          continue
        fi
      else
        # the algorithms are numbered, b1 to b$MAX_DIRECT_ALGOS
        N=$((N + 1))
        KEY="$N"
      fi
      printf '\n[[mgr.prepend_keymap]]\n'
      printf 'on = [ "b", "%s" ]\n' "$KEY"
      # %h is single-quoted so an empty hovered file still arrives as one (empty) arg
      printf "run = \"shell -- %s %s '%%h' %%s\"\n" "$YAZIRUN" "$CMD"
      printf 'desc = "Jacksum - %s"\n' "$TXT"
    done < <(menu_entries "$MAX_DIRECT_ALGOS")
  } >>"$YAZIKEYMAP"
  status_ok

  print_algo_keybindings "a key binding"
}

# -------------------------------------------------------------------------
install_menu_elementary() {
# -------------------------------------------------------------------------
  SCRIPTFOLDER="$PREFIX"
  create_folder "all scripts" "$SCRIPTFOLDER"

  status_begin "Installing scripts"

  while IFS=$'\t' read -r _KIND CMD TXT; do
    OUTPUTFILE="${SCRIPTFOLDER}/jacksum.${CMD}.contract"
    plan_pending "create" "$OUTPUTFILE" && continue
    printf "[Contractor Entry]\n" >"$OUTPUTFILE"
    {
      printf "Name=%s\n" "${TXT}"
      printf "Description=%s\n" "${TXT}"
      printf "MimeType=!inode/blockdevice;inode/chardevice;inode/fifo;inode/socket;\n"
      printf "Exec=%s %s %s\n" "${JACKSUMSH}" "${CMD}" "%F"
    } >>"$OUTPUTFILE"
    chmod +x "$OUTPUTFILE"
  done < <(menu_entries)

  status_ok
}

# -------------------------------------------------------------------------
install_menu_mucommander() {
# -------------------------------------------------------------------------
  XML="$PREFIX/commands.xml"
  XMLBACKUP="$PREFIX/commands.before-jacksum.xml"
  backup_file "commands.xml" "$XML" "$XMLBACKUP" "$SEED_COMMANDS_XML"

  count_entries "entries" 0
  plan_pending "modify" "$XML" "$ENTRIES_TEXT" && return 0

  status_begin "Installing entries"

  MYTEMP="$(mktemp)"
  # xml without the closing </commands> tag
  sed 's/<\/commands>//' "$XML" >"$MYTEMP"

  while IFS=$'\t' read -r _KIND CMD TXT; do
    {
      # $f is the placeholder for muCommander, therefore it must not be evaluated
      # shellcheck disable=SC2016
      printf '<command alias="Jacksum - %s" value="%s %s %s" />\n' "$TXT" "${JACKSUMSH}" "${CMD}" '$f'
    } >>"$MYTEMP"
  done < <(menu_entries)

  printf '</commands>\n' >>"$MYTEMP"
  cp "$MYTEMP" "$XML"
  rm "$MYTEMP"
  status_ok
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

  # drop this very handler only (avoids a duplicate entry when it is already
  # registered), then append it again below
  HANDLERS="$(strip_jacksum_handlers "$HANDLERS" "$HANDLER")" # e.g. open_hand-s=hand_f_3aa02120

  # update the session file
  local TEMP_FILE
  TEMP_FILE="$(mktemp)"
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

  # None of this belongs into a dry run: it asks the user to close the file
  # browser, it starts and signals it, and it gives up if the session file is
  # still not there - all of that is part of the installation itself, which
  # the user has not confirmed yet while the report is being written.
  if [ "$DRYRUN" -eq 0 ]; then
    # if the session file does not exist, the user needs to run the file manager once.
    if [ ! -f "$SESSION_FILE" ]; then
      printf "  Note: In the next step I will try to open %s so that the required session file gets generated.\n" "$BROWSER"
      printf "        Please press the \"Enter\" key when you are ready: "
      read -r
      $BROWSER >/dev/null 2>&1 &
    fi

    printf "  Note: Please close all %s instances manually.\n" "$BROWSER"
    printf "        Please press the \"Enter\" key when you are ready: "
    read -r
    # if the user didn't read the instruction it could still work if a session file is there already.
    pkill -HUP "$BROWSER"

    if [ ! -f "$SESSION_FILE" ]; then
      printf "  Error: %s session file not found.\n" "$BROWSER"
      printf "         Please follow the instructions.\n"
      exit 1
    fi
  elif [ ! -f "$SESSION_FILE" ]; then
    # a plain note, not a change, so it is deliberately not a plan_item
    printf "  Note: %s has no session file yet. The installation will ask you to\n" "$BROWSER"
    printf "        start and close %s once so that it gets written.\n" "$BROWSER"
  fi

  # backup the "session" file, as a fallback for the user if the handler
  # surgery below goes wrong - the uninstallation removes it again, it does
  # not restore it (see uninstall_xxxfm)
  if ! plan_pending "create" "${SESSION_FILE}.backup" "backup of session, taken before it is changed"; then
    cp "${SESSION_FILE}" "${SESSION_FILE}.backup"
  fi

  # the handlers are registered in the session file one by one below, but
  # that is one single change to it as far as the report is concerned
  count_entries "file handlers" 0
  plan_pending "modify" "$SESSION_FILE" "$ENTRIES_TEXT"

  create_folder "all scripts" "${PREFIX}/scripts"

  # The actual scripts in .sh format
  status_begin "Installing scripts"

  while IFS=$'\t' read -r _KIND CMD TXT; do
    HANDLER="hand_f_jacksum_${CMD}"
    SCRIPTFOLDER="${PREFIX}/scripts/${HANDLER}"
    # probably a bug in SpaceFM. It works only if the file handler is called
    # "hand-file-mount.sh", not "hand-jacksum.${CMD}.sh"
    OUTPUTFILE="${SCRIPTFOLDER}/hand-file-mount.sh"
    plan_pending "create" "$OUTPUTFILE" && continue
    mkdir -p "$SCRIPTFOLDER" 2>/dev/null

    printf "%s\n" '#!/bin/bash' >"$OUTPUTFILE"
    printf "%s %s %s\n" "${JACKSUMSH}" "${CMD}" "%F" >>"$OUTPUTFILE"
    chmod +x "$OUTPUTFILE"

    update_xxxfm_session_file "$SESSION_FILE" "$HANDLER" "$TXT"
  done < <(menu_entries)

  status_ok
}

# -------------------------------------------------------------------------
install_script_sh() {
# -------------------------------------------------------------------------

  # header
  cat << 'EOF'
#!/bin/bash
#
# Jacksum File Browser Integration Script, https://jacksum.net
# Copyright (c) 2006-2026 Johann N. Loefflmann, https://johann.loefflmann.net
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
    printf '    "%s" "$1"\n' "${VIEWER}"
  fi
  printf '}\n\n'

  # The result files stay behind on purpose (some editors need them to be still
  # there when they open them), so they cannot get random names. They do get a
  # private folder per user though: with fixed names directly in a shared /tmp a
  # second user could neither overwrite them nor avoid reading the first user's
  # results, and anybody could pre-create one of those names as a symlink.
  cat <<'EOF'
JACKSUM_TMPDIR="${TMPDIR:-/tmp}/jacksum-$(id -u)"
mkdir -p "$JACKSUM_TMPDIR" 2>/dev/null
if [ -L "$JACKSUM_TMPDIR" ] || [ ! -d "$JACKSUM_TMPDIR" ] || [ ! -O "$JACKSUM_TMPDIR" ]; then
  # not ours (or not a folder at all), so don't touch it
  JACKSUM_TMPDIR="$(mktemp -d)"
fi
chmod 700 "$JACKSUM_TMPDIR"
EOF
  # $JACKSUM_TMPDIR must be evaluated when the generated script runs, not now
  # shellcheck disable=SC2016
  {
    printf 'FILE_LIST="$JACKSUM_TMPDIR/jacksum-%s-filelist.txt"\n' "${JACKSUM_VERSION}"
    printf 'OUTPUT="$JACKSUM_TMPDIR/jacksum-%s-output.txt"\n' "${JACKSUM_VERSION}"
    printf 'ERROR_LOG="$JACKSUM_TMPDIR/jacksum-%s-error.txt"\n' "${JACKSUM_VERSION}"
    printf 'CHECK_FILE="$JACKSUM_TMPDIR/jacksum-%s-check.txt"\n' "${JACKSUM_VERSION}"
  }
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
    "${JAVA}" -jar "${HASHGARTEN_JAR}" --header -O relative -U "${ERROR_LOG}" --file-list-format list --file-list "${FILE_LIST}" --path-relative-to-entry 1 --verbose default,summary
    ;;

  "cmd_check")
    "${JAVA}" -jar "${HASHGARTEN_JAR}" --header -c relative -O "${OUTPUT}" -U "${OUTPUT}" --file-list-format list --file-list "${FILE_LIST}" --path-relative-to-entry 1 --verbose default,summary
    ;;

  "cmd_cust")
    ALGOS="md5+sha1+ripemd160+\
sha256+sha512/256+sha3-256+shake128+ascon-hash+sm3+streebog256+kupyna-256+lsh-256-256+blake3+k12+keccak256+\
sha512+sha3-512+shake256+kupyna-512+lsh-512-512+blake2b-512+keccak512+m14+skein-512-512+whirlpool"
  TEMPLATE='File info:
    name:                      #FILENAME{name}
    path:                      #FILENAME{path}
    size:                      #FILESIZE bytes

256 bit message digests (hex):
    SHA3-256 (USA):            #HASH{sha3-256}
    SHA-256 (USA):             #HASH{sha256}
    SHA-512/256 (USA):         #HASH{sha512/256}
    SHAKE128 (USA):            #HASH{shake128}
    BLAKE3:                    #HASH{blake3}
    KangarooTwelve:            #HASH{k12}
    KECCAK256:                 #HASH{keccak256}
    Kupyna256 (Ukraine):       #HASH{kupyna-256}
    LSH-256-256 (South Korea): #HASH{lsh-256-256}
    SM3 (China):               #HASH{sm3}
    STREEBOG 256 (Russia):     #HASH{streebog256}

512 bit message digests (base64, no padding):
    SHA3-512 (USA):            #HASH{sha3-512,base64-nopadding}
    SHA-512 (USA):             #HASH{sha512,base64-nopadding}
    SHAKE256 (USA):            #HASH{shake256,base64-nopadding}
    BLAKE2b-512:               #HASH{blake2b-512,base64-nopadding}
    KECCAK512:                 #HASH{keccak512,base64-nopadding}
    KUPYNA-512 (Ukraine):      #HASH{kupyna-512,base64-nopadding}
    LSH-512-512 (South Korea): #HASH{lsh-512-512,base64-nopadding}
    MarsupilamiFourteen:       #HASH{m14,base64-nopadding}
    SKEIN-512-512:             #HASH{skein-512-512,base64-nopadding}
    WHIRLPOOL:                 #HASH{whirlpool,base64-nopadding}

Legacy message digests (avoid if possible):
    MD5 (128 bit):             #HASH{md5}
    RIPEMD-160 (160 bit):      #HASH{ripemd160}
    SHA1 (160 bit):            #HASH{sha1}

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
  # in a dry run this is all that is needed from here, the menu functions
  # below refer to the wrapper by this path
  JACKSUMSH="$PREFIX/share/apps/$NAME/$NAME.sh"
  # the folder is wiped rather than overwritten, but that deletion is not
  # worth a line of its own in the report: the uninstallation that runs
  # first (see confirm_install) reports it already
  plan_pending "create" "$JACKSUMSH" && return 0

  JACKSUM_VER=$("$JAVA" -jar "$JACKSUM_JAR" -v)
  status_begin "Found $JACKSUM_VER"
  status_ok

  status_begin "Installing $NAME.sh"
  if [ -d "$PREFIX/share/apps/$NAME/" ]; then
    rm -r "$PREFIX/share/apps/$NAME"
  fi

  mkdir -p "$PREFIX/share/apps/$NAME" 2>/dev/null

  if [ -d "$PREFIX/share/apps/$NAME" ] && install_script_sh && chmod +x "$JACKSUMSH"; then
    status_ok
  else
    status_failed
  fi
}

# -------------------------------------------------------------------------
# Takes the first of the programs that is installed, and nothing if none of
# them is.
#
find_app() {
#
# parameters:
# $1 = the variable that takes the result
# $@ = the programs, in the order in which they are preferred
# -------------------------------------------------------------------------
  local VAR="$1"
  shift
  if [ "$#" -eq 0 ]; then
    printf >&2 "FATAL: at least one program is required in find_app(). Exit.\n"
    exit 1
  fi

  local FOUND=""
  while [ "$#" -gt 0 ]; do
    if type -P "$1" >/dev/null; then
      FOUND="$(type -P "$1")"
      break
    fi
    shift
  done
  printf -v "$VAR" "%s" "$FOUND"
}

# -------------------------------------------------------------------------
print_params() {
# -------------------------------------------------------------------------
  printf "\nCurrent parameters:\n"
  check_bin JAVA "java" "$JAVA"
  check_file JACKSUM_JAR "jacksum-${JACKSUM_VERSION}.jar" "$JACKSUM_JAR"
  check_file HASHGARTEN_JAR "HashGarten-${HASHGARTEN_VERSION}.jar" "$HASHGARTEN_JAR"
  check_bin VIEWER "Viewer" "$VIEWER"
  check_bin EDIT "Editor" "$EDIT"

  if [ -z "$ALGORITHMS" ]; then
    printf "  [directly accessible algorithms]: %s\n\n" "n/a"
  else
    printf "  [directly accessible algorithms]: %s\n\n" "$ALGORITHMS"
  fi
}

# -------------------------------------------------------------------------
enter_java() {
# -------------------------------------------------------------------------
  JAVA_FOUND=0
  while [ $JAVA_FOUND -eq 0 ]; do
    find_bin JAVA "java" "$JAVA"

    JAVA_VERSION="$("$JAVA" -fullversion 2>&1)"
    JAVA_VERSION="${JAVA_VERSION#*\"}"
    JAVA_VERSION="${JAVA_VERSION%\"*}"
    JAVA_VERSION="${JAVA_VERSION%%_*}"
    JAVA_VERSION="${JAVA_VERSION%%+*}"

    if [ "$(version_value "$JAVA_VERSION")" -lt "$(version_value 11.0.0)" ]; then
      printf "Java version %s must be at least 11\n" "$JAVA_VERSION"
    else
      JAVA_FOUND=1
      if is_headless_java "$JAVA"; then
        printf "\nWarning: %s\n" "$JAVA"
        printf "         is a headless JRE/JDK, it cannot open a window. HashGarten, the GUI\n"
        printf "         for Jacksum, cannot be used with it, so the menu entries \"Calc Hash\n"
        printf "         Values\" and \"Check Data Integrity\" would fail. \"Customized Output\",\n"
        printf "         \"Edit Script\" and the entries for the algorithms don't need\n"
        printf "         HashGarten and would work.\n"
      fi
    fi
  done
}

# -------------------------------------------------------------------------
modify_params() {
# -------------------------------------------------------------------------
  printf "\nA JDK or JRE is required. If you use a headless JDK/JRE, you cannot use HashGarten, which is a GUI for Jacksum.\n"
  printf "You could, for example, go to https://adoptium.net to obtain a full JDK/JRE.\n"

  enter_java

  printf "\n\nThe jar files Jacksum, HashGarten, and FlatLaf have to be stored in the same folder. The script won't copy those files anywhere, but at runtime it expects to find them at the specified location once installation is complete.\n"
  find_bin JACKSUM_JAR "jacksum-${JACKSUM_VERSION}.jar" "$JACKSUM_JAR"
  find_bin HASHGARTEN_JAR "HashGarten-${HASHGARTEN_VERSION}.jar" "$HASHGARTEN_JAR"

  printf "\n\nTo view text output, you need to specify a viewer or an editor.\n"
  find_bin VIEWER "viewer" "$VIEWER"

  printf "\n\nTo use the \"Edit Script\" feature, you need to specify an editor.\n"
  find_bin EDIT "editor" "$EDIT"

  select_algorithms
}

# -------------------------------------------------------------------------
print_info_kde() {
# -------------------------------------------------------------------------
  if [ "$KDE" -gt 1 ]; then
    printf "Info:\n"
    # if not root
    if [ "$EUID" -ne 0 ]; then
      printf "  If you want to install Jacksum/HashGarten in %s\n" "${BROWSER_PROGNAME[kde]}"
      printf "  for all users, please run this script as root.\n"
    else
      printf "  If you want to install Jacksum/HashGarten in %s\n" "${BROWSER_PROGNAME[kde]}"
      printf "  only for one user, run the script as a normal user. If you have a Live CD,\n"
      printf "  you must run the script as a normal user, because CD-ROMs are read-only.\n"
    fi
    print_dashes
  fi
}

# -------------------------------------------------------------------------
read_key() {
# reads a single keypress without waiting for Enter, echoes it back
# (since -s suppresses the terminal's own echo), and stores it in $KEY
# -------------------------------------------------------------------------
  IFS= read -rsn1 KEY
  printf "%s\n" "$KEY"
}

# -------------------------------------------------------------------------
select_algorithms() {
# -------------------------------------------------------------------------
  printf "\n\n"
  local YESNO=""
  while [ "$YESNO" != "y" ] && [ "$YESNO" != "n" ]; do
    printf "Do you want to access some algorithms directly without the HashGarten GUI?\nType y to enable direct access to algorithms, type n to disable direct access to algorithms, type p or any other key to use the previous selection [n]: "
    read_key
    YESNO="$KEY"
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
    *)
      # "p" or any other key: keep the previous selection and move on
      YESNO="n"
      ;;
    esac
  done
}

# -------------------------------------------------------------------------
# Shows what an installation would remove, create and modify, and asks
# whether it should really be carried out. Returns 0 only if the user has
# confirmed it.
#
# Like confirm_uninstall(), the report is not written by hand: it is the
# installation itself, running with $DRYRUN=1, so that it cannot tell the
# user anything else than what actually happens a moment later. An
# installation starts by removing whatever is installed already, hence the
# two sections.
#
confirm_install() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  local YESNO=""
  local PROG="${BROWSER_PROGNAME[$1]}"

  DRYRUN=1

  PLAN_COUNT=0
  printf "Uninstalling the previous %s from %s first:\n\n" "$NAME" "$PROG"
  uninstall_silent "$1"
  if [ "$PLAN_COUNT" -eq 0 ]; then
    printf "  nothing, %s is not installed in %s yet\n" "$NAME" "$PROG"
  fi

  PLAN_COUNT=0
  printf "\nInstalling %s into %s:\n\n" "$NAME" "$PROG"
  install_script_generic
  install_menu "$1"
  if [ "$PLAN_COUNT" -eq 0 ]; then
    printf "  nothing - that cannot be right, please report this as a bug.\n"
  fi

  DRYRUN=0

  printf "\nDo you want to start the installation? [y]: "
  read_key
  YESNO="$KEY"
  test -z "$YESNO" && YESNO="y"
  test "$YESNO" = "y"
}

# -------------------------------------------------------------------------
install_interactive() {
#
# parameters:
# $1 kde, gnome, rox, thunar, xfe, caja, nemo, elementary, spacefm or zzzfm
# or broot or mc or mucommander or nnn or ranger or vifm or yazi
# -------------------------------------------------------------------------
  local YESNO=""
  while [ "$YESNO" != "y" ]; do
    print_params
    printf "Do you want to use the parameters above? [y]: "
    read_key
    YESNO="$KEY"
    test -z "$YESNO" && YESNO="y"

    case "$YESNO" in
    "y")
      printf "\n"
      if confirm_install "$1"; then
        printf "\n"
        uninstall_silent "$1"
        install_script_generic
        install_menu "$1"
      else
        # back to the question above, so that the user can change the
        # parameters and have a look at a new report
        YESNO=""
      fi
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
# $1 Name of the executable
# $2 Name of the file browser
# -------------------------------------------------------------------------
  local YESNO=""
  printf "Do you want to restart %s so that changes can become active? [y]: " "$2"
  read_key
  YESNO="$KEY"
  test -z "$YESNO" && YESNO="y"
  case "$YESNO" in
  "y") # redirecting standard error into standard output
    # in order to avoid ugly warnings from Nautilus
    $1 --quit >/dev/null 2>&1 &
    # avoid a potential race condition (sf# 3099869)
    # (sleep does not cause harm to others)
    printf "Please wait ... "
    sleep 5
    # some older versions of Nautilus restart Nautilus after a quit
    # we ignore that fact and start Nautilus in any case
    $1 >/dev/null 2>&1 &
    ;;
  *) ;;

  esac
}

# -------------------------------------------------------------------------
install_done() {
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
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
  kde | thunar | mucommander)
    printf "Please restart %s in order to make the change active.\n" "${BROWSER_PROGNAME[$1]}"
    ;;
  mc)
    # no restart required, mc reads its user menu every time F2 is pressed :)
    printf "Press F2 in Midnight Commander to open the user menu.\n"
    ;;
  broot)
    printf "Please restart broot, then type \":\" and the name of a verb,\n"
    printf "e.g. :jacksum_calc - the \"?\" help screen lists all of them.\n"
    ;;
  vifm)
    printf "Please restart vifm (\":restart\" rereads the vifmrc in a running\n"
    printf "one), then type \":\" and the name of a command, e.g.\n"
    printf ":jacksumXcalc - \":command jacksum\" lists all of them.\n"
    ;;
  ranger | yazi)
    # the name of the program rather than the one from the menu: that is what
    # has to be typed to start it again
    printf "Please restart %s, then use these key bindings:\n" "$1"
    printf "  bh - Calc Hash Values\n"
    printf "  bc - Check Data Integrity\n"
    printf "  bo - Customized Output\n"
    printf "  be - Edit Script\n"
    ;;
  # ROX-Filer, Xfe, elementary, SpaceFM, zzzFM, nnn and PCManFM pick the new
  # entries up by themselves, so there is nothing to say :)
  esac
  printf "Press the \"Enter\" key to continue ... "
  read -r
}

# -------------------------------------------------------------------------
install_generic() {
#
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  set_env "$1"
  # No print_params here, install_interactive prints the parameters anyway.
  # The defaults offered by modify_params come from init_java/init_editor/
  # init_viewer, and they are deliberately kept across runs.
  modify_params
  install_interactive "$1"
  refresh_menu_item "$1"
}

# -------------------------------------------------------------------------
# Shows what an uninstallation would delete and modify, and asks whether it
# should really be carried out. Returns 0 only if the user has confirmed it.
#
# The report is not written by hand, it is the uninstallation itself, running
# with $DRYRUN=1 - that way it cannot tell the user anything else than what
# actually happens a moment later.
#
confirm_uninstall() {
#
# parameters:
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  local YESNO=""
  local PROG="${BROWSER_PROGNAME[$1]}"

  DRYRUN=1
  PLAN_COUNT=0
  printf "\nUninstalling %s from %s would make the following changes:\n\n" "$NAME" "$PROG"
  uninstall_silent "$1"
  DRYRUN=0

  if [ "$PLAN_COUNT" -eq 0 ]; then
    printf "  none - %s is not installed in %s.\n" "$NAME" "$PROG"
    printf "\nPlease press the \"Enter\" key to continue ... "
    read -r
    return 1
  fi

  printf "\nDo you really want to uninstall %s from %s? [y]: " "$NAME" "$PROG"
  read_key
  YESNO="$KEY"
  test -z "$YESNO" && YESNO="y"
  test "$YESNO" = "y"
}

# -------------------------------------------------------------------------
uninstall_generic() {
#
# $1 broot, caja, elementary, gnome, kde, mc, mucommander, nemo, nnn, pcmanfm,
#    ranger, rox, spacefm, thunar, vifm, xfe, yazi or zzzfm
# -------------------------------------------------------------------------
  set_env "$1"
  # the confirmation is deliberately not in uninstall_silent(), which every
  # installation runs to clean up before it installs (see install_interactive)
  if confirm_uninstall "$1"; then
    uninstall "$1"
    refresh_menu_item "$1"
  fi
}

# -------------------------------------------------------------------------
init_java() {
# -------------------------------------------------------------------------
  find_app JAVA java
}

# -------------------------------------------------------------------------
init_editor() {
# -------------------------------------------------------------------------
  find_app EDIT gedit gnome-text-editor kate defaulttexteditor xfwrite pluma io.elementary.code geany xed
}

# -------------------------------------------------------------------------
init_viewer() {
# -------------------------------------------------------------------------
  find_app VIEWER zenity gedit gnome-text-editor kate defaulttexteditor xfwrite pluma io.elementary.code geany xed
}

# -------------------------------------------------------------------------
# MAIN
# -------------------------------------------------------------------------
for KEY in $BROWSER_KEYS; do
  refresh_menu_item "${BROWSER_ID[$KEY]}"
done

init_java
init_editor
init_viewer
ACTION="install"
HIDE_UNAVAILABLE=""

while :; do
  clear
  print_header
  print_info_kde
  print_menu
  printf "Enter option: "
  read_key
  OPTION="$KEY"
  case "$OPTION" in
  i)
    if [ "$ACTION" = "install" ]; then
      ACTION="uninstall"
    else
      ACTION="install"
    fi
    ;;
  h)
    if [ -z "$HIDE_UNAVAILABLE" ]; then
      HIDE_UNAVAILABLE=1
    else
      HIDE_UNAVAILABLE=""
    fi
    ;;
  0 | q)
    printf "\n"
    exit 0
    ;;
  *)
    BROWSER="$(browser_for_key "$OPTION")"
    if [ -n "$BROWSER" ]; then
      menu_action "$BROWSER"
    else
      printf "\n"
    fi
    ;;
  esac
done
