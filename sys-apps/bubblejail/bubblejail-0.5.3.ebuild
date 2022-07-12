# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit meson python-single-r1 xdg

DESCRIPTION="Bubblewrap based sandboxing for desktop applications"
HOMEPAGE="https://github.com/igo95862/bubblejail"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/igo95862/bubblejail.git"
else
	SRC_URI="https://github.com/igo95862/bubblejail/releases/download/${PV}/${P}.tar.gz"
	S="${WORKDIR}"
	KEYWORDS="~amd64"
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
		dev-python/tomli[${PYTHON_USEDEP}]
		dev-python/tomli-w[${PYTHON_USEDEP}]
		dev-python/PyQt5[${PYTHON_USEDEP},widgets]
		sys-libs/libseccomp[${PYTHON_USEDEP}]
	')
"

src_prepare() {
	python_fix_shebang .
	default
}

src_configure() {
	local emesonargs=(
		-Duse_python_site_packages_dir=true
	)
	meson_src_configure
}
