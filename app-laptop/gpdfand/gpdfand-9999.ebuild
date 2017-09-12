# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info systemd

DESCRIPTION="Fan control daemon for GPD Pocket"
HOMEPAGE="https://github.com/efluffy/gpdfand"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="dev-perl/Log-Dispatch
         dev-perl/Proc-Daemon
		 dev-perl/Proc-PID-File
		 dev-perl/TimeDate"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/efluffy/${PN}.git"
else
	SRC_URI="https://github.com/efluffy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi


src_install() {
	systemd_dounit ${PN}.service
	insinto "$(systemd_get_systemunitdir)-sleep"
	insopts -m755
	doins ${PN}
	insinto /usr/local/bin
	insopts -m755
	newins ${PN}.pl ${PN}

	systemd_enable_service multi-user.target ${PN}.service
}
