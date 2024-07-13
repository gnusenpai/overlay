# Copyright 2024 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Provides user runtime directory (XDG_RUNTIME_DIR) on Linux systems"
HOMEPAGE="https://jjacky.com/pam_rundir/"
SRC_URI="https://gitea.artixlinux.org/artix/pam_rundir/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="sys-libs/pam"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	default
	sed -i -e 's|$(CC)|$(CC) $(CFLAGS) $(LDFLAGS)|' Makefile || die
}

src_configure() {
	./configure \
		--prefix=/ \
		--securedir="/$(get_libdir)/security" || die
}

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}
