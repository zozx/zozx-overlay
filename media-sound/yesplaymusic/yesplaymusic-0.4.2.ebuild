# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils xdg

DESCRIPTION="A third party music player for Netease Music"
HOMEPAGE="https://github.com/qier222/YesPlayMusic"
BASE_URI="https://github.com/qier222/YesPlayMusic/releases/download/v0.4.2"
SRC_URI="${BASE_URI}/${P}.pacman"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

QA_PRESTRIPPED="*"

DEPEND="
	app-arch/gzip
	x11-libs/gtk+:*
	dev-libs/nss"

RDEPEND="
	${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	:
}

src_configure(){
	tar xvf "${DISTDIR}/${P}.pacman"
	rm -r "${S}/usr/share/applications"
}

src_install(){
	insinto "/opt"
	doins -r "${S}/opt/YesPlayMusic"
	insinto "/usr/share"
	doins -r "${S}/usr/share/icons"
	insinto "/usr/share/applications"
	doins "${FILESDIR}/yesplaymusic.desktop"
	fperms 0755 "/opt/YesPlayMusic/yesplaymusic"
}
