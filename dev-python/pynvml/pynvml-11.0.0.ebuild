# Copyright 2021 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

DESCRIPTION="Python bindings to the NVIDIA Management Library"
HOMEPAGE="https://pypi.org/project/pynvml/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="x11-drivers/nvidia-drivers"
DEPEND="${RDEPEND}"
