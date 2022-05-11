# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

VERSION_LIBCOMMUNI="c613600e6a52e6d3166247a05205cf1c755d4868"
VERSION_QBREAKPAD="a4626c12e9ae6f02fc1ca7a4e399bd8307424103"
VERSION_QTKEYCHAIN="de954627363b0b4bff9a2616f1a409b7e14d5df9"
VERSION_RAPIDJSON="d87b698d0fcc10a5f632ecbc80a9cb2a8fa094a5"
VERSION_SERIALIZE="7d37cbfd5ac3bfbe046118e1cec3d32ba4696469"
VERSION_SETTINGS="7cf8431d644332107a51a46c1e3de70e64692f0c"
VERSION_SIGNALS="baf5bb04bd13b090e405e0447c89a811f7e23ddc"
VERSION_WEBSOCKETPP="1b11fd301531e6df35a6107c1e8665b1e77a2d8e"
VERSION_WINTOAST="ce441336ef057576dfb377be754bc5357a04ff85"
VERSION_SANITIZERS="99e159ec9bc8dd362b08d18436bd40ff0648417b"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Chatterino/chatterino2.git"
else
	SRC_URI="
		https://github.com/Chatterino/chatterino2/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Chatterino/libcommuni/archive/${VERSION_LIBCOMMUNI}.tar.gz -> libcommuni-${VERSION_LIBCOMMUNI}.tar.gz
		https://github.com/jiakuan/qBreakpad/archive/${VERSION_QBREAKPAD}.tar.gz -> qBreakpad-${VERSION_QBREAKPAD}.tar.gz
		https://github.com/Chatterino/qtkeychain/archive/${VERSION_QTKEYCHAIN}.tar.gz -> qtkeychain-${VERSION_QTKEYCHAIN}.tar.gz
		https://github.com/Tencent/rapidjson/archive/${VERSION_RAPIDJSON}.tar.gz -> rapidjson-${VERSION_RAPIDJSON}.tar.gz
		https://github.com/pajlada/serialize/archive/${VERSION_SERIALIZE}.tar.gz -> serialize-${VERSION_SERIALIZE}.tar.gz
		https://github.com/pajlada/settings/archive/${VERSION_SETTINGS}.tar.gz -> settings-${VERSION_SETTINGS}.tar.gz
		https://github.com/pajlada/signals/archive/${VERSION_SIGNALS}.tar.gz -> signals-${VERSION_SIGNALS}.tar.gz
		https://github.com/zaphoyd/websocketpp/archive/${VERSION_WEBSOCKETPP}.tar.gz -> websocketpp-${VERSION_WEBSOCKETPP}.tar.gz
		https://github.com/mohabouje/WinToast/archive/${VERSION_WINTOAST}.tar.gz -> WinToast-${VERSION_WINTOAST}.tar.gz
		https://github.com/arsenm/sanitizers-cmake/archive/${VERSION_SANITIZERS}.tar.gz -> sanitizers-cmake-${VERSION_SANITIZERS}.tar.gz
	"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Chat client for twitch.tv"
HOMEPAGE="https://chatterino.com/"

LICENSE="MIT"
SLOT="0"

DEPEND="
	>=dev-qt/qtmultimedia-5.12
	>=dev-qt/qtcore-5.12
	dev-libs/boost
	dev-libs/openssl
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-qt/qtsvg-5.12
	dev-util/cmake
"

if ! [[ ${PV} == 9999 ]]; then
	S="${WORKDIR}/chatterino2-${PV}"
fi

src_prepare() {
	if ! [[ ${PV} == 9999 ]]; then
		local module
		for module in libcommuni qBreakpad qtkeychain rapidjson serialize settings signals websocketpp WinToast; do
			rm -rv lib/"${module}"
			ln -sv "${WORKDIR}"/"${module}"-* lib/"${module}"
		done
		rm -rv cmake/sanitizers-cmake
		ln -sv "${WORKDIR}"/sanitizers-cmake-* cmake/sanitizers-cmake
	fi
	cmake_src_prepare
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
