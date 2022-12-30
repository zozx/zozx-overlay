# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop

DESCRIPTION="An Open-Source Toolkit for Steam"
HOMEPAGE="https://steampp.net"
SRC_URI="
	https://github.com/BeyondDimension/SteamTools/raw/develop/resources/AppIcon/Logo_64.png -> ${PN}.png
	https://github.com/BeyondDimension/SteamTools/releases/download/${PV}/Steam++_linux_x64_v${PV}.tar.zst"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="sys-libs/libcap"
BDEPEND="app-arch/zstd"

RESTRICT="mirror strip"

S="${WORKDIR}"

QA_PRESTRIPPED="
	/opt/${PN}/libHarfBuzzSharp.so
	/opt/${PN}/libSkiaSharp.so
	/opt/${PN}/Steam++"

src_unpack(){
	mkdir -p "${S}/${PN}" || die
	cd "${S}/${PN}" || die
	unpacker "${DISTDIR}/Steam++_linux_x64_v${PV}.tar.zst"
}

src_install(){
	newicon -s 64 "${DISTDIR}/${PN}.png" "${PN%-bin}.png"
	domenu "${FILESDIR}/${PN%-bin}.desktop"
	insinto "/opt"
	doins -r "${S}/${PN}"
	dosym -r "/opt/${PN}/Steam++" "/usr/bin/${PN%-bin}"
	for file in Steam++ libHarfBuzzSharp.so libSkiaSharp.so libe_sqlite3.so
	do
		fperms 0755 "/opt/${PN}/${file}"
	done
}
