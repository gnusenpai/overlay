# Copyright 1999-2021 gentoo-zh
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Arch Linux install tools (pacstrap, genfstab, arch-chroot)"
HOMEPAGE="https://projects.archlinux.org/arch-install-scripts.git/"
SRC_URI="https://github.com/archlinux/arch-install-scripts/archive/refs/tags/v${PV}.tar.gz -> arch-install-scripts-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/pacman"

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
