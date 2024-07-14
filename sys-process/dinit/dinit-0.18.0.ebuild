# Copyright 2024 amano.kenji
# Copyright 2024 gnusenpai

EAPI=8

inherit meson

DESCRIPTION="service manager and init system"
HOMEPAGE=("https://davmac.org/projects/dinit/"
	"https://github.com/davmac314/dinit")
SRC_URI="https://github.com/davmac314/${PN}/releases/download/v${PV}/${P}.tar.xz"
RESTRICT="mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=(NEWS README.md TODO doc/COMPARISON doc/DESIGN doc/SECURITY doc/getting_started.md
	doc/linux/DINIT-AS-INIT.md)

src_configure() {
	local emesonargs=(
		-Dbuild-shutdown=disabled
	)

	meson_src_configure
}
