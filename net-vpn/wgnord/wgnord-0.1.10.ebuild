# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A NordVPN Wireguard (\"NordLynx\") client in POSIX shell"
HOMEPAGE="https://git.phire.cc/wgnord/"
SRC_URI="https://git.phire.cc/${PN}/snapshot/${P}.tar.gz"

LICENSE=""
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
	cp template.conf countries.txt "${D}/var/lib/${PN}"
	dobin wgnord
}
