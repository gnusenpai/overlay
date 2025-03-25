# Copyright 2024 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python bindings to the NVIDIA Management Library"
HOMEPAGE="https://pypi.org/project/nvidia-ml-py/"
SRC_URI="https://files.pythonhosted.org/packages/source/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="x11-drivers/nvidia-drivers"
DEPEND="${RDEPEND}"
