# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

# Needed for meson submodules
MY_COMMIT="4074560e3642a53ace07b31baaf3f04c060dcd0b"

# MATE uses an odd/even numbering system for release and dev build
MINOR=$(($(ver_cut 2) % 2))
if [[ ${MINOR} -eq 0 ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"
fi

DESCRIPTION="Calculator for MATE"
HOMEPAGE="https://github.com/mate-desktop/mate-calc"

SRC_URI="
	https://github.com/mate-desktop/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/mate-desktop/mate-submodules/archive/$"{MY_COMMIT}".tar.gz -> mate-submodules-${MY_COMMIT}.tar.gz
"

S="${WORKDIR}/${PN}-${PV}"
LICENSE="CC-BY-SA-3.0 GPL-2+"
SLOT="0"

COMMON_DEPEND="
	>=app-accessibility/at-spi2-core-2.46.0
	>=dev-libs/glib-2.50:2
	dev-libs/libxml2:2=
	dev-libs/mpc:=
	>=dev-libs/mpfr-4.0.2:=
	>=x11-libs/gtk+-3.22:3
	x11-libs/pango
"

RDEPEND="${COMMON_DEPEND}
	virtual/libintl
"

BDEPEND="${COMMON_DEPEND}
	app-text/yelp-tools
	dev-libs/libxml2
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
"

src_prepare() {
	default
	# Mate pulls submodules directly from git, this  moves the earlier pulled
	# sources to a tagged commit so we are able to track changes easier.
	mv $"{WORKDIR}"/mate-submodules-$"{MY_COMMIT}" $"{S}"/subprojects/mate-submodules
}
