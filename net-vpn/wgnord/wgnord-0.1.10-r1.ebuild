# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A NordVPN Wireguard (\"NordLynx\") client in POSIX shell"
HOMEPAGE="https://github.com/phirecc/wgnord"
SRC_URI="https://github.com/phirecc/wgnord/archive/refs/tags/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~*"

DEPEND="
	app-misc/jq
	net-misc/curl
	net-vpn/wireguard-tools
"
RDEPEND="${DEPEND}"

src_install() {
	dodir "/var/lib/${PN}"
	chmod 770 "${D}/var/lib/${PN}"
	cp template.conf countries.txt countries_iso31662.txt "${D}/var/lib/${PN}"
	dobin wgnord
}
