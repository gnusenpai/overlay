# Copyright 2024 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python bindings to the NVIDIA Management Library"
HOMEPAGE="https://pypi.org/project/nvidia-ml-py/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="x11-drivers/nvidia-drivers"
DEPEND="${RDEPEND}"

src_prepare() {
	rm -v "${S}/example.py" || die
	distutils-r1_src_prepare
}
