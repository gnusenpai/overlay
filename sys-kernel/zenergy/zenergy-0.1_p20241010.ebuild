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
	EGIT_COMMIT="7c4e83d5e2f887f4c31edaf92e5f94e9448e9764"
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
