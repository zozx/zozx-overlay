# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="A third party music player for Netease Music"
HOMEPAGE="https://github.com/qier222/YesPlayMusic"
SRC_URI="https://github.com/qier222/YesPlayMusic/releases/download/v${PV}/${PN%-bin}-${PV}.pacman"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

QA_PRESTRIPPED="*"
QA_PREBUILT="*"

RDEPEND="
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	x11-libs/gtk+:3=
	x11-libs/libxkbcommon"

S="${WORKDIR}"

src_unpack() {
	tar xvf "${DISTDIR}/${PN%-bin}-${PV}.pacman" || die
}

src_install() {
	insinto "/opt"
	doins -r "${S}/opt/YesPlayMusic"
	for si in 16 24 32 48 64 128 256 512; do
		doicon -s ${si} usr/share/icons/hicolor/${si}x${si}/apps/${PN%-bin}.png
	done
	domenu "${FILESDIR}/${PN%-bin}.desktop"
	fperms 0755 "/opt/YesPlayMusic/yesplaymusic"
}
