# Copyright 2021 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

DESCRIPTION="Generate and change color-schemes on the fly"
HOMEPAGE="https://github.com/dylanaraps/pywal"
SRC_URI="https://github.com/dylanaraps/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="sys-process/procps
	media-gfx/imagemagick"
RDEPEND="${DEPEND}"

distutils_enable_tests setup.py

python_prepare_all() {
	distutils-r1_python_prepare_all
	cp -v "${FILESDIR}"/gnucolor.py "${S}"/pywal/backends/
}
