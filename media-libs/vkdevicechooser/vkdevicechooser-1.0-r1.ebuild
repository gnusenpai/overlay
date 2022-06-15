# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Vulkan layer to force a specific device to be used"
HOMEPAGE="https://github.com/aejsmith/vkdevicechooser"
SRC_URI="https://github.com/aejsmith/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/vulkan-headers
	media-libs/vulkan-layers
"

src_prepare() {
	default
	sed -i 's/1.2.131/1.3.211/' vkdevicechooser.json
}
