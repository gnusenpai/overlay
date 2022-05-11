# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for Linux kernel sources"
SLOT="0"
KEYWORDS=""
IUSE="firmware"

RDEPEND="
	firmware? ( sys-kernel/linux-firmware )
"
