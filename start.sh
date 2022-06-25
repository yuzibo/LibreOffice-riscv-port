#########################################################################
# File Name: start.sh
# Created Time: Fri 24 Jun 2022 09:32:24 PM
#
#   -_-!  if modify the file in docker image, be carefully with lost it
#       :) when you exit it
#
#
##########################################################################
#!/bin/bash

LO_VER="7.3.4.2"
LO_NAME="libreoffice"
LO_DIR="$LO_NAME-$LO_VER"
LO_TAR="$LO_DIR.tar"
LO_TAR_XZ="$LO_DIR.tar.xz"

PATCH_DIR="../patch"

#echo $LO_DIR
#echo $LO_TAR
#echo $LO_TAR_XZ

function unpack_tarball(){
    if [ -d $LO_DIR ]; then
        echo "It seems the $LO_DIR exists"
    else
        echo "test"
        if [ -f $LO_TAR_XZ ]; then
            $(xz -d $LO_TAR_XZ && tar xf $LO_TAR)
        else
            $(wget http://download.documentfoundation.org/libreoffice/src/7.3.4/libreoffice-7.3.4.2.tar.xz)
            echo "The tarball has been downloaded, please execute this scripts again!"
        fi

    fi
}

function apply_patch(){
    $(cp -rf $PATCH_DIR/* $LO_TAR)
}

function download_externalmodule(){
# disable default
# wget -r --level=1 -nd -P <lo_root>/external/tarballs https://go.suokunlong.cn:88/dl/libreoffice/external_tarballs/
}

unpack_tarball

apply_patch
