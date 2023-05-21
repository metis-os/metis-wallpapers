#!/bin/bash

## Copyright (C) Pwnwriter // METIS Linux 

## Directories
current_directory="$(pwd)"
directory_name="$(basename "$current_directory")"
last_character="$(basename "$(pwd)")"
package_directories=(`ls -d */ | cut -f1 -d'/'`)
packages_directory="$current_directory/pkgs-$last_character"

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

## Build packages
build_packages () {
    local package

    if [[ ! -d "$packages_directory" ]]; then
        mkdir -p "$packages_directory"
    fi

    echo -e "\nBuilding Packages - \n"
    for package in "${package_directories[@]}"; do
        echo -e "Building ${package}..."
        cd ${package}
        makepkg -sc
        mv *.pkg.tar.zst "$packages_directory"    

        # Verify
        while true; do
            set -- "$packages_directory"/${package}-*
            if [[ -e "$1" ]]; then
                echo -e "\nPackage '${package}' generated successfully.\n"
                break
            else
                echo -e "\nFailed to build '${package}', Exiting...\n"
                exit 1;
            fi
        done
        cd "$current_directory"
    done

    repository_directory='../pkgs/x86_64'
    if [[ -d "$repository_directory" ]]; then
        mv -f "$packages_directory"/*.pkg.tar.zst "$repository_directory" && rm -r "$packages_directory"
        echo -e "Packages moved to Repository.\n[!] Don't forget to update the database.\n"
    fi
}

build_packages

