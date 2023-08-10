# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pritunl OpenVPN client"
HOMEPAGE="https://client.pritunl.com/"
SRC_URI="https://github.com/pritunl/pritunl-client-electron/releases/download/${PV}/${PN}_${PV}-0ubuntu1.kinetic_amd64.deb"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/dpkg"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

inherit unpacker systemd desktop

src_prepare() {
	default
}

src_unpack() {
	unpack_deb "${A}" || die "unable to unpack ${A}"
	echo "OnlyShowIn=GNOME;KDE" >> usr/share/applications/pritunl-client-electron.desktop
}

src_install(){
	insinto /
	doins -r usr etc var
	fperms +x /usr/bin/{pritunl-client,pritunl-client-service}
	fperms +x /usr/lib/pritunl_client_electron/Pritunl
	dosym /usr/lib/pritunl_client_electron/Pritunl /usr/bin/pritunl-client-electron
	doicon usr/share/icons/hicolor/scalable/apps/pritunl_client_electron.svg
	domenu usr/share/applications/pritunl-client-electron.desktop
	systemd_dounit etc/systemd/system/pritunl-client.service
}
