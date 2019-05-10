DESCRIPTION = "Custom core-image-sato image"

require recipes-sato/images/core-image-sato.bb

IMAGE_INSTALL += "ciao"
#IMAGE_INSTALL += "ciao vlc"
#IMAGE_INSTALL += "ciao mono mono-helloworld"

FEATURE_PACKAGES_debug-utils = "packagegroup-debug-utils"

IMAGE_FEATURES += "ssh-server-openssh tools-debug"
#IMAGE_FEATURES += "ssh-server-openssh tools-debug eclipse-debug debug-utils"

# add 1gb extra space in units of kb
#IMAGE_ROOTFS_EXTRA_SPACE = "1048576"

LICENSE = "MIT"

# licenses required by vlc and libs it depends on
#LICENSE_FLAGS_WHITELIST += " GPL-2.0 commercial"
