# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="No description provided"
HOMEPAGE="https://github.com/mate-desktop/mate-submodules"
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
COMMON_DEPEND="
>=dev-libs/glib-2.58.1:2
>=x11-libs/gtk+-3.22:3
x11-libs/libICE
x11-libs/libSM"
DEPEND="${COMMON_DEPEND}"
BDEPEND="${COMMON_DEPEND}"
