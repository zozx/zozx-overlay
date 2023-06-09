# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg unpacker

DESCRIPTION="Bilibili desktop client"
HOMEPAGE="https://github.com/msojocs/${PN%-bin}-linux"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}-4/io.github.msojocs.${PN%-bin}_${PV}-4_amd64.deb"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"
QA_PRESTRIPPED="*"

S="${WORKDIR}"

src_prepare(){
	rm -r "${S}/usr/share/doc" || die
	default
}

src_install(){
	insinto "/opt/apps"
	doins -r "${S}/opt/apps/io.github.msojocs.${PN%-bin}"
	domenu "${S}/usr/share/applications/io.github.msojocs.${PN%-bin}.desktop"
	insinto "/usr/share/icons/hicolor/scalable/apps"
	doins "${S}/usr/share/icons/hicolor/scalable/apps/io.github.msojocs.${PN%-bin}.svg"
	fperms 0755 "/opt/apps/io.github.msojocs.${PN%-bin}/files/bin/bin/${PN%-bin}"
	fperms 0755 "/opt/apps/io.github.msojocs.${PN%-bin}/files/bin/electron/electron"
}
