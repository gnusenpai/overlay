# Copyright 2024 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

DESCRIPTION="Python library to control Linux kernel namespaces"
HOMEPAGE="https://github.com/igo95862/python-lxns"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/igo95862/python-lxns.git"
else
	SRC_URI="https://github.com/igo95862/python-lxns/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MPL-2.0"
SLOT="0"

distutils_enable_tests unittest
