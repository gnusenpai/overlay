# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Hyprland is a dynamic tiling Wayland compositor that doesn't sacrifice on its looks."
HOMEPAGE="https://github.com/vaxerski/Hyprland"
EGIT_REPO_URI="https://github.com/vaxerski/Hyprland"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND="
	x11-libs/libxcb
	x11-base/xcb-proto
	x11-libs/xcb-util
	x11-libs/xcb-util-keysyms
	x11-libs/libXfixes
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-apps/xinput
	x11-libs/libXrender
	x11-libs/pixman
	dev-libs/wayland-protocols
	x11-libs/cairo
	x11-libs/pango
	dev-util/glslang
	dev-libs/libinput
	x11-libs/libxkbcommon
	virtual/opengl
	dev-libs/wayland
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-wm
	sys-auth/seatd
	media-libs/vulkan-loader
	media-libs/vulkan-layers
	x11-base/xwayland
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/vulkan-headers
	dev-libs/wayland-protocols
	x11-base/xorg-proto
"

src_install() {
	meson_src_install
	rm -r "${D}"/usr/include "${D}"/usr/lib64
}
