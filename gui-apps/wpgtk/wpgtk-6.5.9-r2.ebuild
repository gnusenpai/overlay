# Copyright 2021 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1 desktop xdg

DESCRIPTION="A colorscheme, wallpaper and template manager for *nix"
HOMEPAGE="https://github.com/deviantfero/wpgtk"
SRC_URI="https://github.com/deviantfero/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=">=dev-python/pillow-4.2.1
	>=x11-misc/pywal-3.0.0"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	rm -r "${ED}"/usr/etc || die
}

src_install() {
	distutils-r1_src_install
	domenu wpgtk/misc/wpgtk.desktop
}
