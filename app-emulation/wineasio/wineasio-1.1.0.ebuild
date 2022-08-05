# Copyright 2022 gnusenpai
# Copyright 2022 hering
# Distributed under the terms of the GNU General Public License v2

# WARNING: I don't know how to use multilib properly so this ebuild might be janky!

EAPI=8

inherit multilib-minimal

DESCRIPTION="ASIO to JACK driver for WINE"
HOMEPAGE="https://github.com/wineasio/wineasio"
SRC_URI="https://github.com/wineasio/wineasio/releases/download/v${PV}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	virtual/wine[${MULTILIB_USEDEP}]
	virtual/jack[${MULTILIB_USEDEP}]
"
RDEPEND="${DEPEND}"

pkg_setup() {
	export WINETARGET=`eselect --brief --colour=no wine show | awk '{$1=$1;print}'`
	[[ $WINETARGET == "(unset)" ]] && die "please set wine version (eselect wine)"
}

multilib_src_compile() {
	cd "${S}"
	case ${ABI} in
		x86) emake 32;;
		amd64) emake 64;;
	esac
}

multilib_src_install() {
	case ${ABI} in
		x86)
			cd "${S}/build32"
			ARCH=i386
			;;
		amd64)
			cd "${S}/build64"
			ARCH=x86_64
			;;
	esac
	exeinto /usr/$(get_libdir)/${WINETARGET}/wine/${ARCH}-unix
	doexe *.so
	insinto /usr/$(get_libdir)/${WINETARGET}/wine/${ARCH}-windows
	doins *.dll
}

pkg_postinst() {
	echo
	elog "Finally the dll must be registered in the wineprefix."
	elog "For both 32 and 64 bit wine do:"
	elog "$ regsvr32 wineasio.dll"
	elog
	elog "On a 64 bit system with wine supporting both 32 and 64 applications, regsrv32"
	elog "will register the 32 bit driver in a 64 bit prefix, use the following command"
	elog "to register the 64 bit driver in a 64 bit wineprefix:"
	elog "$ wine64 regsvr32 wineasio.dll"
	echo
}
