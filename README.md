# Node Orb  [![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/node-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/node-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/circleci/node.svg)](https://circleci.com/orbs/registry/orb/circleci/node) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/circleci-public/node-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

An orb for working with Node.js on CircleCI.

## Usage

For full usage guidelines, see the [orb registry listing](http://circleci.com/orbs/registry/orb/circleci/node)
[https://github.com/MoneyMan573/i86-node-orb/tree/node-orb-patch-i86](Patch@MoneyMan573)[Raw Data](https://raw.githubusercontent.com/CircleCI-Public/runner-installation-files/main/download-launch-agent.sh)

`usr/bin/env sh`

# set 
`-eu pipefail`

# echo 
`"Installing CircleCI Runner for ${platform}"`

[base_url]("https://circleci-binary-releases.s3.amazonaws.com/circleci-launch-agent")
`
if 
[ -z ${agent_version+x} ]; 
then
    agent_version=$(curl 
    "${base_url}/release.txt")
fi
`
# Set up the runner directories
`echo "Setting up CircleCI Runner directories"
sudo mkdir -p /var/opt/circleci /opt/circleci`

# Downloading launch agent
`echo "Using CircleCI Launch Agent version ${agent_version}"
echo "Downloading and verifying CircleCI Launch Agent Binary"
curl -sSL "${base_url}/${agent_version}/checksums.txt" -o checksums.txt
file="$(grep -F "${platform}" checksums.txt | cut -d ' ' -f 2 | sed 's/^.//')"
mkdir -p "${platform}"
echo "Downloading CircleCI Launch Agent: ${file}"
curl --compressed -L "${base_url}/${agent_version}/${file}" -o "${file}"`

# Verifying download
`echo "Verifying CircleCI Launch Agent download"
grep "${file}" checksums.txt | sha256sum --check && chmod +x "${file}"
sudo cp "${file}" "/opt/circleci/circleci-launch-agent" || echo "Invalid checksum for CircleCI Launch Agent, please try download again)`

## Contributing

We welcome [issues](https://github.com/CircleCI-Public/node-orb/issues) to and [pull requests](https://github.com/CircleCI-Public/node-orb/pulls) against this repository!

For further questions/comments about this or other orbs, visit [CircleCI's orbs discussion forum](https://discuss.circleci.com/c/orbs).
