# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
inherit meson python-single-r1 xdg

DESCRIPTION="Bubblewrap based sandboxing for desktop applications"
HOMEPAGE="https://github.com/igo95862/bubblejail"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/igo95862/bubblejail.git"
else
	SRC_URI="https://github.com/igo95862/bubblejail/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	>=sys-apps/bubblewrap-0.5.0
	sys-apps/xdg-dbus-proxy
	dev-util/desktop-file-utils
	$(python_gen_cond_dep '
		dev-python/pyxdg[${PYTHON_USEDEP}]
		dev-python/tomli-w[${PYTHON_USEDEP}]
		dev-python/PyQt6[${PYTHON_USEDEP},widgets]
		sys-libs/libseccomp[${PYTHON_USEDEP}]
		dev-python/python-lxns[${PYTHON_USEDEP}]
	')
"

src_prepare() {
	python_fix_shebang .
	default
}
