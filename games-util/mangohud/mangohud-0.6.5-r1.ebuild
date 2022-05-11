# Copyright 2020 telans
# Copyright 2021 ROKO__
# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 meson multilib-minimal

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring FPS, CPU/GPU load and more."
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

MY_PV=${PV/_p/-}

IMGUI_VER="1.81"

IMGUI_SRC_URI="
	https://github.com/ocornut/imgui/archive/v${IMGUI_VER}.tar.gz -> ${PN}-imgui-${IMGUI_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/imgui_${IMGUI_VER}-1/get_patch -> ${PN}-imgui-${IMGUI_VER}-1-wrap.zip
"

SRC_URI="${IMGUI_SRC_URI}"

if [ ${PV} = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flightlessmango/MangoHud.git"
else
	SRC_URI="${SRC_URI} https://github.com/flightlessmango/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/MangoHud-${MY_PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+dbus debug +X xnvctrl wayland video_cards_nvidia"
REQUIRED_USE="
	|| ( X wayland )
	xnvctrl? ( video_cards_nvidia )"

BDEPEND="dev-python/mako[${PYTHON_USEDEP}]"
DEPEND="
	dev-util/glslang
	>=dev-util/vulkan-headers-1.2
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	media-libs/libglvnd[$MULTILIB_USEDEP]
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
	wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )"
RDEPEND="${DEPEND}"

src_unpack() {
	[[ ${PV} == "9999" ]] && git-r3_src_unpack
	default

	mv "${WORKDIR}/imgui-${IMGUI_VER}" "${S}/subprojects" || die
}

multilib_src_configure() {
	local emesonargs=(
		-Duse_system_vulkan=enabled
		-Dappend_libdir_mangohud=false
		-Dinclude_doc=false
		$(meson_feature video_cards_nvidia with_nvml)
		$(meson_feature xnvctrl with_xnvctrl)
		$(meson_feature X with_x11)
		$(meson_feature wayland with_wayland)
		$(meson_feature dbus with_dbus)
	)
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_install() {
	meson_src_install
}

multilib_src_install_all() {
	dodoc "${S}/bin/MangoHud.conf"
	einstalldocs
}

pkg_postinst() {
	if use video_cards_nvidia && ! use xnvctrl; then
		einfo ""
		einfo "If mangohud can't get the GPU load, or other GPU information,"
		einfo "and you have an older Nvidia device."
		einfo ""
		einfo "Try enabling the 'xnvctrl' useflag."
		einfo ""
	fi

	einfo "A template configuration file has been placed in:"
	einfo "'/usr/share/doc/${P}/MangoHud.conf.bz2'"
	einfo ""
	einfo "Copy this file to '\${HOME}/.config/MangoHud/MangoHud.conf',"
	einfo "in order for it to take affect across all applications launched with 'mangohud' from your user"
}
