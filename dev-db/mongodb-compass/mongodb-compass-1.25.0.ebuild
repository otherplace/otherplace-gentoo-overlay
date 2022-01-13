# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

MY_PV=${PV/_beta/~beta.}
MY_PN=${PN}
DESCRIPTION="The MongoDB GUI"
HOMEPAGE="https://www.mongodb.com/products/compass"

SRC_URI="https://downloads.mongodb.com/compass/${PN}_${PV}_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_unpack(){
	unpack "${A}"
	unpack ./data.tar.xz
	rm *.tar.gz debian-binary
}

src_install(){
	insinto /opt/${MY_PN}
	doins -r usr/share/* || die
	doins -r usr/lib/${MY_PN} || die
	dosym "/opt/${MY_PN}/${MY_PN}/MongoDB Compass" /usr/bin/${MY_PN}
	fperms +x "/opt/${MY_PN}/${MY_PN}/MongoDB Compass"


	newicon usr/share/pixmaps/${MY_PN}.png ${MY_PN}.png
	domenu usr/share/applications/${MY_PN}.desktop
}

