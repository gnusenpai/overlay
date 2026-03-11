# Copyright 2026 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="runit services from Void Linux's base-system"
HOMEPAGE="https://github.com/void-linux/void-packages"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"

src_install() {
	mkdir -p "${D}/etc/sv"
	(
		cd "${FILESDIR}/sv" || die
		for sv in *; do
			"${FILESDIR}/vsv" "${sv}"
		done
	)

	dobin "${FILESDIR}/vsv"
}
