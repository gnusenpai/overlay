# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3 distutils-r1 optfeature

DESCRIPTION="Tool that generates color schemes from images"
HOMEPAGE="https://github.com/dylanaraps/pywal"
EGIT_REPO_URI="https://github.com/dylanaraps/${PN}.git"

if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT="236aa48e741ff8d65c4c3826db2813bf2ee6f352"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="media-gfx/imagemagick[jpeg]"

pkg_postinst() {
	optfeature "setting wallpaper support" \
		media-gfx/feh \
		x11-misc/hsetroot \
		x11-misc/nitrogen
}
