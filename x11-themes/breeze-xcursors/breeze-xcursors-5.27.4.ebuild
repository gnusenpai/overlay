# Copyright 2023 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SLOT="5"
PVCUT=$(ver_cut 1-2)
SRC_URI="https://download.kde.org/stable/plasma/${PV}/breeze-${PV}.tar.xz -> ${P}.tar.xz"
S="$WORKDIR/breeze-$PV"

DESCRIPTION="Breeze SVG icon theme (cursors only)"

LICENSE="LGPL-3" # OR GPL-2? conflicting information
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86"
RESTRICT="mirror"

src_install() {
	insinto /usr/share/icons
	doins -r cursors/Breeze/Breeze
	doins -r cursors/Breeze_Snow/Breeze_Snow
}
