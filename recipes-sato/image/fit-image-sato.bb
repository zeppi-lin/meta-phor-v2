DESCRIPTION = "Custom core-image-sato image"

require recipes-sato/images/core-image-sato.bb

IMAGE_INSTALL += "ciao"
#IMAGE_INSTALL += "ciao mono mono-helloworld"

FEATURE_PACKAGES_debug-utils = "packagegroup-debug-utils"

IMAGE_FEATURES += "ssh-server-openssh tools-debug"
#IMAGE_FEATURES += "ssh-server-openssh tools-debug eclipse-debug debug-utils"

LICENSE = "MIT"
