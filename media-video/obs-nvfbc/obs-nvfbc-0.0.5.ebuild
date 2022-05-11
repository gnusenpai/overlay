# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="OBS Studio source plugin using NVIDIA's FBC API for Linux"
HOMEPAGE="https://gitlab.com/fzwoch/obs-nvfbc"
SRC_URI="https://gitlab.com/fzwoch/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-video/obs-studio
	x11-libs/libX11
	x11-drivers/nvidia-drivers
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}-v${PV}"

pkg_postinst() {
	echo
	elog "In order to use NvFBC on GeForce GPUs,"
	elog "you need to patch your driver with:"
	elog "https://github.com/keylase/nvidia-patch"
	echo
}
