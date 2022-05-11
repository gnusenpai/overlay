# Copyright 2021 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Python bindings to zopfli"
HOMEPAGE="https://github.com/fonttools/${PN}"
SRC_URI="https://github.com/fonttools/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="app-arch/zopfli"
DEPEND="${RDEPEND}"
BDEPEND="${RDEPEND}"

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV/_p/.post}"
	export USE_SYSTEM_ZOPFLI=1
}
