# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A PreLoader which is signed for Secure Boot."
HOMEPAGE="https://blog.hansenpartnership.com/linux-foundation-secure-boot-system-released"
SRC_URI="
	https://blog.hansenpartnership.com/wp-uploads/2013/PreLoader.efi
	https://blog.hansenpartnership.com/wp-uploads/2013/HashTool.efi"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	INSDIR="/usr/share/preloader-signed"
	dodir "${INSDIR}"
	insinto "${INSDIR}"
	doins "${DISTDIR}"/{PreLoader,HashTool}.efi
	fperms 0755 "${INSDIR}"/{PreLoader,HashTool}.efi
}
