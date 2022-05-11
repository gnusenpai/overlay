# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/sparanoid/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/sparanoid/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Monitor and download live streams from YouTube "
HOMEPAGE="https://github.com/sparanoid/live-dl"

LICENSE="AGPL-3"
SLOT="0"

DEPEND="
	net-misc/aria2
	app-shells/bash
	media-gfx/exiv2
	app-misc/yq
	net-misc/streamlink
	net-misc/yt-dlp
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/global-config.patch"
)

src_compile() {
	true
}

src_install() {
	dobin live-dl

	insinto /etc/live-dl
	newins config.example.yml config.yml
}
