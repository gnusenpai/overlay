# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A library that can be used to easily add the RIST protocol to your application."
HOMEPAGE="https://code.videolan.org/rist/librist/"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://code.videolan.org/rist/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://code.videolan.org/rist/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="BSD-2"
SLOT="0"

DEPEND="
	dev-libs/cJSON
	net-libs/mbedtls
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmocka
	app-arch/lz4
"
