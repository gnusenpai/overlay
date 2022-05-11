# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson xdg-utils

DESCRIPTION="A GTK patchbay for pipewire"
HOMEPAGE="https://gitlab.freedesktop.org/pipewire/helvum"
EGIT_REPO_URI="https://gitlab.freedesktop.org/pipewire/helvum.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
RESTRICT="network-sandbox"

DEPEND="
	>=dev-libs/glib-2.66
	>=gui-libs/gtk-4.4
	>=media-video/pipewire-0.3
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=sys-devel/clang-3.7
	>=dev-util/meson-0.59.0
	virtual/rust
"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
