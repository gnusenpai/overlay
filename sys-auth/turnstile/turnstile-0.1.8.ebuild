# Copyright 2024 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Independent session/login tracker"
HOMEPAGE="https://github.com/chimera-linux/turnstile"
SRC_URI="https://github.com/chimera-linux/turnstile/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+dinit elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="sys-libs/pam"
RDEPEND="
	${DEPEND}
	dinit? ( sys-process/dinit )
"

src_prepare() {
	if ! use dinit; then
		PATCHES+=( "${FILESDIR}/dummy-ready.patch" )
	fi

	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature dinit)
		-Dstatedir=turnstiled
	)

	if use elogind || use systemd; then
		emesonargs+=( -Dmanage_rundir=false )
	else
		emesonargs+=( -Dmanage_rundir=true )
	fi

	meson_src_configure
}

src_install() {
	meson_src_install

	newinitd "${FILESDIR}/turnstiled.initd" turnstiled

	if use dinit; then
		rm -rv "${D}/etc/dinit.d"
	fi
}

pkg_postinst() {
	elog "Enable the turnstiled service and add"
	elog "-session	optional	pam_turnstile.so"
	elog "to the end of /etc/pam.d/login."
}
