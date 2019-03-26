DESCRIPTION = "Ciao application"
SECTION = "ciao"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/zeppi-lin/ciao.git;protocol=https"

PV = "1.0+git${SRCPV}"

# get ciao repo revision:
#   git ls-remote https://github.com/zeppi-lin/ciao.git master
SRCREV = "100dc934586f08e81075f6086aea23e17fd1ecb1"

S = "${WORKDIR}/git"

do_compile () {
  oe_runmake
}

do_install () {
  install -d ${D}${bindir}
  install -m 0755 ciao ${D}${bindir}
}
