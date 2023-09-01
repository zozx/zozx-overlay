# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg unpacker

DESCRIPTION="Bilibili desktop client"
HOMEPAGE="https://github.com/msojocs/${PN%-bin}-linux"
SRC_URI="https://github.com/msojocs/${PN%-bin}-linux/releases/download/v${PV}-1/io.github.msojocs.${PN%-bin}_${PV}-1_amd64.deb"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"

RDEPEND="
	dev-libs/nss
	media-libs/alsa-lib
	x11-libs/gtk+:=
	x11-libs/libxkbcommon
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libxcb
	x11-misc/xdg-utils
	wayland? ( dev-libs/wayland )
	x11-libs/libvdpau
"

RESTRICT="mirror"
QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/io.github.msojocs.bilibili.desktop"

S="${WORKDIR}"

src_install(){
	insinto "/opt/apps"
	doins -r "${S}/opt/apps/io.github.msojocs.${PN%-bin}"
	domenu "${S}/usr/share/applications/io.github.msojocs.${PN%-bin}.desktop"
	doicon -s scalable "${S}/usr/share/icons/hicolor/scalable/apps/io.github.msojocs.${PN%-bin}.svg"
	fperms 0755 "/opt/apps/io.github.msojocs.${PN%-bin}/files/bin/bin/${PN%-bin}"
	fperms 0755 "/opt/apps/io.github.msojocs.${PN%-bin}/files/bin/electron/electron"
}
