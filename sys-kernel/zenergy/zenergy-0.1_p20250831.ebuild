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
	EGIT_COMMIT="58f2fda7184fbde95033f492f7c54990552ef86f"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

CONFIG_CHECK="HWMON"

src_compile() {
	local modlist=(
		zenergy=misc:::modules
	)
	local modargs=(
		KDIR="${KV_OUT_DIR}"
	)

	linux-mod-r1_src_compile
}
