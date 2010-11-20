all:
	mkdir -p build
	cp PKGBUILD build
	cd build && makepkg -p PKGBUILD && makepkg --source -p PKGBUILD

clean:
	rm -rf build
