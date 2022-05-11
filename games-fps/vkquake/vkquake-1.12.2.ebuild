# Copyright 2022 Gentoo Authors
# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Novum/vkQuake.git"
else
	SRC_URI="https://github.com/Novum/vkQuake/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/vkQuake-${PV}"
fi

DESCRIPTION="Vulkan Quake port based on QuakeSpasm"
HOMEPAGE="https://github.com/Novum/vkQuake"

LICENSE="GPL-2"
SLOT="0"
IUSE="flac mp3 opus +vorbis"

DEPEND="
	flac? ( media-libs/flac )
	mp3? ( media-libs/libmad )
	opus? ( media-libs/opus )
	vorbis? ( media-libs/libvorbis )
	>=media-libs/libsdl2-2.0.6[vulkan]
"
RDEPEND="${DEPEND}"

src_compile() {
	emake -C Quake \
		STRIP="/bin/true" \
		DO_USERDIRS=1 \
		USE_CODEC_FLAC=$(usex flac 1 0) \
		USE_CODEC_MP3=$(usex mp3 1 0) \
		USE_CODEC_OPUS=$(usex opus 1 0) \
		USE_CODEC_VORBIS=$(usex vorbis 1 0)

	emake -C Misc/vq_pak
}

src_install() {
	dobin Quake/vkquake

	insinto /usr/share/games/vkquake
	doins Misc/vq_pak/vkquake.pak
}
