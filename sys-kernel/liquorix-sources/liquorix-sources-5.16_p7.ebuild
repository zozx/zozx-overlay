# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -lqx patch set already includes main updates
K_GENPATCHES_VER="1"

# -lqx already sets EXTRAVERSION to kernel Makefile
K_NOSETEXTRAVERSION="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

# We want the very basic patches from gentoo-sources, experimental patch is
# already included in liquorix-sources
K_WANT_GENPATCHES="base	extras"

# To use CJKTTY, Please enable this USE
IUSE="+cjk"

DEPEND="
	app-arch/cpio
	sys-devel/bc
	dev-libs/elfutils
	dev-util/pahole"

inherit kernel-2
detect_version

DESCRIPTION="Liquorix kernel is best one for desktop, multimedia and gaming workloads"
HOMEPAGE="https://liquorix.net/"

SRC_URI="
	${KERNEL_BASE_URI}/linux-5.16.tar.xz
	${GENPATCHES_URI}
	https://github.com/zen-kernel/zen-kernel/releases/download/v5.16.9-lqx1/v5.16.9-lqx1.patch.xz
	https://github.com/zhmars/cjktty-patches/raw/master/v5.x/cjktty-5.16.patch"

KEYWORDS="~amd64"

S="${WORKDIR}/linux-${PVR}-liquorix"

K_EXTRAEINFO="For more info on liquorix-kernel and details on how to report problems, see: ${HOMEPAGE}."

UNIPATCH_LIST="${DISTDIR}/v5.16.9-lqx1.patch.xz"

PATCHES="${DISTDIR}/cjktty-5.16.patch"

src_prepare() {
	# Default enable CJKTTY
	if use cjk; then
		eapply "${DISTDIR}/cjktty-5.16.patch" || die
	fi

	kernel-2_src_prepare
}

pkg_setup() {
	ewarn ""
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the ${HOMEPAGE} directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn ""

	kernel-2_pkg_setup
}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use Liquorix-Kernel with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
