# Copyright 1999-2022 Gentoo Authors
# Copyright 2022 gnusenpai
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="real-cugan converter using ncnn and vulkan"
HOMEPAGE="https://github.com/nihui/realcugan-ncnn-vulkan"
SRC_URI="https://github.com/nihui/realcugan-ncnn-vulkan/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/ncnn:=[vulkan]
	media-libs/libwebp:=
	media-libs/vulkan-loader"
DEPEND="
	${RDEPEND}
	dev-util/glslang
	dev-util/vulkan-headers"

src_prepare() {
	CMAKE_USE_DIR=${S}/src
	cmake_src_prepare

	# Update all paths to match installation for models.
	sed "/PATHSTR\|model path/s|models-|${EPREFIX}/usr/share/${PN}/models-|" \
		-i src/main.cpp || die
}

src_configure() {
	local mycmakeargs=(
		-DGLSLANG_TARGET_DIR="${ESYSROOT}"/usr/$(get_libdir)/cmake
		-DUSE_SYSTEM_NCNN=ON
		-DUSE_SYSTEM_WEBP=ON
	)

	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}"/realcugan-ncnn-vulkan

	insinto /usr/share/${PN}
	doins -r models/.

	einstalldocs
}
