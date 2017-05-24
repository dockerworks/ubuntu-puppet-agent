FROM 		ubuntu:16.04
MAINTAINER 	technopeneural@yahoo.com

ENV 		PUPPET_AGENT_VERSION="1.8.3" \
		UBUNTU_CODENAME="xenial"

RUN 		apt-get update && \
		apt-get install --no-install-recommends -y wget ca-certificates lsb-release && \
		wget https://apt.puppetlabs.com/puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
		dpkg -i puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
		rm puppetlabs-release-pc1-"$UBUNTU_CODENAME".deb && \
		apt-get update && \
		apt-get install --no-install-recommends -y puppet-agent && \
		apt-get remove --purge -y lsb-release wget && \
		apt-get autoremove -y && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

ENV 		PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

ENTRYPOINT 	["/opt/puppetlabs/bin/puppet"]
CMD 		["agent", "--verbose", "--no-daemonize", "--summarize" ]
#CMD 		["agent", "--verbose", "--onetime", "--no-daemonize", "--summarize" ]

COPY 		Dockerfile /
