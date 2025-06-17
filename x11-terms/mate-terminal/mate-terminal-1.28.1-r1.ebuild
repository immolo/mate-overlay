# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

# Needed for meson submodules
MY_COMMIT="4074560e3642a53ace07b31baaf3f04c060dcd0b"

# MATE uses an odd/even numbering system for release and dev builds
MINOR=$(($(ver_cut 2) % 2))
if [[ ${MINOR} -eq 0 ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"
fi

	SRC_URI="
		https://github.com/mate-desktop/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/mate-desktop/mate-submodules/archive/$"{MY_COMMIT}".tar.gz -> mate-submodules-${MY_COMMIT}.tar.gz
	"

S="${WORKDIR}/${PN}-${PV}"

DESCRIPTION="The MATE Terminal"
HOMEPAGE="https://github.com/mate-desktop/mate-terminal"
LICENSE="FDL-1.1+ GPL-2 GPL-3+ LGPL-3+"
SLOT="0"

COMMON_DEPEND="
	>=app-accessibility/at-spi2-core-2.46.0
	>=dev-libs/glib-2.50:2
	>=gnome-base/dconf-0.13.4
	x11-libs/gdk-pixbuf:2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/pango
	>=x11-libs/gtk+-3.22:3[X]
	>=x11-libs/vte-0.48:2.91
"

RDEPEND="${COMMON_DEPEND}
	>=mate-base/mate-desktop-$(ver_cut 1-2)
	virtual/libintl
"

BDEPEND="${COMMON_DEPEND}
	app-text/rarian
	app-text/yelp-tools
	dev-util/glib-utils
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default
	# Mate pulls submodules directly from git, this  moves the earlier pulled
	# sources to a tagged commit so we are able to track changes easier.
	mv $"{WORKDIR}"/mate-submodules-$"{MY_COMMIT}" $"{S}"/subprojects/mate-submodules
}
