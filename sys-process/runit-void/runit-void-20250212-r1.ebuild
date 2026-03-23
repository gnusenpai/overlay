# Copyright 2026 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Void Linux runit scripts"
HOMEPAGE="https://github.com/void-linux/void-runit"
SRC_URI="https://github.com/void-linux/void-runit/archive/refs/tags/${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/void-runit-${PV}"
IUSE="+services"

DEPEND="
	sys-process/runit[-scripts]
	!sys-apps/openrc[sysv-utils]
	!sys-apps/systemd[sysv-utils]
	!sys-apps/s6-linux-init[sysv-utils]
	!sys-apps/sysvinit
"
RDEPEND="
	app-alternatives/awk
	sys-process/procps
	sys-apps/util-linux[tty-helpers]
	services? ( sys-process/void-services )
"

src_prepare() {
	default

	# Void changes runit's default SVDIR
	sed \
		-e "s|env - PATH=\$PATH|env - PATH=\$PATH SVDIR=/var/service|" \
		-i 2 || die

	# Modern udev prints an error if told to exit when not running
	sed \
		-e "s|]|] \&\& [ ! -L /var/service/udevd ]|" \
		-i shutdown.d/60-udev.sh || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install

	ln -s runit-init "${D}/usr/sbin/init"

	mkdir "${D}/var"
	ln -s /run/runit/runsvdir/current "${D}/var/service"

	# runit-void assumes /dev/fd, /dev/std{in,out,err} exist
	# OpenRC doesn't, so:
	cp "${FILESDIR}/01-stdio.sh" "${D}/etc/runit/core-services/"

	# Void changes runit's default SVDIR
	newenvd - 21runit <<- EOF
		#/etc/env.d/20runit
		SVDIR="/var/service/"
	EOF

	# Suppress missing sysctl.conf message
	cat <<- EOF > "${D}/etc/sysctl.conf"
		# See sysctl.conf(5)
	EOF
}
