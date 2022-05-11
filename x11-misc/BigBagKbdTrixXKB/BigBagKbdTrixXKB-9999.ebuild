# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/DreymaR/${PN}.git"

DESCRIPTION="DreymaR's Big Bag of Keyboard Tricks for *nix with XKB"
HOMEPAGE="https://dreymar.colemak.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="
	x11-apps/setxkbmap
	x11-misc/xkeyboard-config
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i "s/^X11DIR=.*/X11DIR=\/usr\/share\/${PN}/" setxkb.sh || die
	sed -i 's/ -v \${VerboseLvl}//' setxkb.sh || die
	sed -i 's/^setxkbmap \$MySetXKB/setxkbmap \$MySetXKB -print | xkbcomp -I"\$XKBdir" - "\$DISPLAY"/' setxkb.sh || die
}

src_install() {
	dodir "/usr/share/${PN}"
	cp -r xkb-data_xmod/xkb "${D}/usr/share/${PN}/"
	dobin setxkb.sh
}
