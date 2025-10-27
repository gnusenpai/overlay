# Copyright 2024 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Mouse acceleration driver and kernel module for Linux"
HOMEPAGE="https://www.maccel.org"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Gnarus-G/maccel.git"
else
	SRC_URI="https://github.com/Gnarus-G/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror network-sandbox"

src_compile() {
	local modlist=(
		maccel=misc::driver:build
	)
	linux-mod-r1_src_compile
	emake build_cli
}

src_install() {
	linux-mod-r1_src_install
	dobin target/release/maccel
}
