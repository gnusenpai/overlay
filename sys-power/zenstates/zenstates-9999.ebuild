# Copyright 1999-2021 Jannis234
# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit git-r3 python-r1 linux-info

DESCRIPTION="Dynamically edit AMD Ryzen processor P-States (Zen 3 fork)"
HOMEPAGE="https://github.com/irusanov/ZenStates-Linux"
EGIT_REPO_URI="https://github.com/irusanov/ZenStates-Linux.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

CONFIG_CHECK="X86_MSR"

PATCHES=("${FILESDIR}/nogui.patch")

src_install() {
	do_install() {
		python_newscript zenstates.py zenstates
		python_domodule cpuid.py
	}
	python_foreach_impl do_install
	dodoc README.md
}
