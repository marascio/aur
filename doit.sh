#!/usr/bin/env bash

pkgs=(gtest quantlib quantlib-python quickfix)
aurp=$(type -P aurploader)
files=()

build()
{
    mkdir -p build
    cd build

    for i in ${pkgs[@]}; do
        mkdir -p $i
        cd $i
        cp "../../$i/PKGBUILD" .
        makepkg -f
        makepkg -f --source
        cd ..
    done
}

clean()
{
    rm -rf build
}

publish()
{
    if [ ! -x "$aurp" ]; then
        echo "You need aurploader to push packages to AUR"
        exit 1
    fi

    for i in ${pkgs[@]}; do
        p=$(find "build/$i" -name "$i*.src.tar.gz")
        files+=($p)
    done

    $aurp ${files[@]}
}

usage()
{
    cat <<EOF
    Usage: ...
EOF
}

trap 'kill 0; echo;' TERM HUP QUIT INT

case "$1" in
    build)   shift; build "$*" ;;
    clean)   shift; clean "$*" ;;
    publish) shift; publish "$*" ;;
    *)       shift; usage ;;
esac
