# Copyright 2024 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod-r1

DESCRIPTION="AMD energy driver but with some jiffies added so non-root users can read it safely"
HOMEPAGE="https://github.com/BoukeHaarsma23/zenergy"
EGIT_REPO_URI="https://github.com/BoukeHaarsma23/zenergy.git"

if [[ "${PV}" == "9999" ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="d65592b3c9d171ba70e6017e0827191214d81937"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

CONFIG_CHECK="HWMON"

src_compile() {
	local modlist=(
		zenergy=misc:::modules
	)
	linux-mod-r1_src_compile
}
