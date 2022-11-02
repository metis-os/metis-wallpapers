#!/usr/bin/env bash

## Copyright (C) 2020-2022 Metis Linux <info@metislinux.org>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

## Dirs
PKG1=(`ls -d */ | cut -f1 -d'/' | sed -n '1{p;q}'`)
PKG2=(`ls -d */ | cut -f1 -d'/' | sed -n '2{p;q}'`)

## Script Termination
exit_on_signal_SIGINT () {
    { printf "\n\n%s\n" "Script interrupted." 2>&1; echo; }
    exit 0
}

exit_on_signal_SIGTERM () {
    { printf "\n\n%s\n" "Script terminated." 2>&1; echo; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

# Build packages
build_pkgs () {
     local PKGDIR=("$HOME"/metis-repo/x86_64)
        echo -e "\nBuilding Packages - \n"
	cd "$PKG1" && makepkg -s 
        mv *.tar.zst "$PKGDIR" && rm -rf src pkg  
        cd ../"$PKG2" && makepkg -s
        mv *.tar.zst "$PKGDIR" && rm -rf src pkg  
        echo -e "\nPackages Built & moved successfully - \n"
        echo -e "\nDo not forget to add packages in repo. - \n"
    }

# Execute
build_pkgs
