# Maintainer: iyamnabeen <iym.nabeen@gmail.com>

pkgname=metis-wallpapers
pkgver=1.0
pkgrel=2
pkgdesc="Branding wallpapers for metis-os"
url="https://github.com/metis-os/metis-wallpapers"
arch=('any')
license=('GPL3')
makedepends=()
depends=()
conflicts=()
groups=(metis-wallpapers)
provides=("${pkgname}")
options=(!strip !emptydirs)

prepare() {
    cp -af ../files/. ${srcdir}
}

package() {
	local _bgdir=${pkgdir}/usr/share/backgrounds/metis
	mkdir -p "$_bgdir"
	cp -r ${srcdir}/* "$_bgdir"
}
