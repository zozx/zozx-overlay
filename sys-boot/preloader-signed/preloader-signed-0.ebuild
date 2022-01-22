# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A Preloader which is signed for Secure Boot."
HOMEPAGE="https://blog.hansenpartnership.com/linux-foundation-secure-boot-system-released"
SRC_URI="
	https://blog.hansenpartnership.com/wp-uploads/2013/PreLoader.efi
	https://blog.hansenpartnership.com/wp-uploads/2013/HashTool.efi"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

S="${WORKDIR}"

src_configure() {
	mkdir -p preloader-signed
	cp ${DISTDIR}/{PreLoader,HashTool}.efi preloader-signed
}

src_install() {
	insinto /usr/share
	doins -r preloader-signed
}
