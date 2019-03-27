#!/bin/sh
#
# Fit build setup script

FSL_TOOLS_DIR="meta-fsl-bsp-release/imx/tools"
FSL_RELEASE_SETUP_SCRIPT="fsl-setup-release.sh"

CWD=`pwd`

# check for fsl release setup script
if [ ! -f "${CWD}/sources/$FSL_TOOLS_DIR/$FSL_RELEASE_SETUP_SCRIPT" ]; then
  echo "$FSL_RELEASE_SETUP_SCRIPT not found, abort"
  clean_up && return 1
fi


clean_up()
{

    unset CWD BUILD_DIR DISTRO MACHINE
    unset fit_setup_help fit_setup_error fit_setup_flag
    unset usage clean_up
}

usage()
{
    echo "Usage: source fit-setup-build.sh [-b build-dir] [-h]"
    echo "  options:"
    echo "    -b build-dir    set build directory (def: build)"
    echo "    -h              print usage"
}

unset BUILD_DIR

# get command line options
OLD_OPTIND=$OPTIND
while getopts "b:h" fit_setup_flag
do
    case $fit_setup_flag in
        b) BUILD_DIR="$OPTARG";
           ;;
        h) fit_setup_help='true';
           ;;
        \?) fit_setup_error='true';
           ;;
    esac
done
shift $((OPTIND-1))
if [ $# -ne 0 ]; then
    fit_setup_error=true
    echo -e "Invalid command line ending: '$@'"
fi
OPTIND=$OLD_OPTIND

if test $fit_setup_help; then
    usage && clean_up && return 1
elif test $fit_setup_error; then
    clean_up && return 1
fi


DISTRO='speedy'
echo "Using distro: $DISTRO"

MACHINE='fit-v2'
echo "Using machine: $MACHINE"

if [ -z "$BUILD_DIR" ]; then
    BUILD_DIR='build'
fi
echo "Using build directory: $BUILD_DIR"


# run fsl release setup script
DISTRO=$DISTRO MACHINE=$MACHINE BUILD_DIR=$BUILD_DIR source "${CWD}/sources/$FSL_TOOLS_DIR/$FSL_RELEASE_SETUP_SCRIPT"

#echo "fsl return = $?"
if [ $? != 0 ]; then
    echo "Error: $FSL_RELEASE_SETUP_SCRIPT failed"
    clean_up && return 1
fi

#echo "after fsl release script"
#echo "BUILD_DIR=$BUILD_DIR"
#echo "BUILD_DIR_SAVE=$BUILD_DIR_SAVE"
#echo "CWD=$CWD"
#echo "pwd=`pwd`"

# add fit custom layers to bitbake layers config
echo "" >> ./conf/bblayers.conf
echo "# Fit custom layers" >> ./conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-fit-bsp \"" >> ./conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-phor-v2 \"" >> ./conf/bblayers.conf


clean_up
