#Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"
else
	SRC_URI="
		https://github.com/mate-desktop/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${PN}.tar.gz
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${PV}"
fi

DESCRIPTION="Mate wayland session"
HOMEPAGE="https://github.com/mate-desktop/mate-wayland-session"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

PATCHES=(
	"${FILESDIR}"/${PN}-config-and-permissions-fix-${PV}.patch
)

DEPEND="
	gui-wm/wayfire
	gui-apps/wcm
	mate-base/mate
	dev-libs/gobject-introspection
	x11-libs/startup-notification
	x11-base/xwayland
	x11-libs/gtk+:3
"
BDEPEND="
	dev-build/meson
"
