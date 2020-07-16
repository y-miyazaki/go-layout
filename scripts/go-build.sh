#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "$0")" || exit; pwd)
GIT_DOMAIN=github.com

# set ssh and git config
echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config
ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts
git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/"

# go mod download
go mod download

# build all commands.
cd "${SCRIPT_DIR}"/.. || exit
for file in $(find cmd -name "main.go" -type f); do
    dir=$(dirname "${file}")
    basename=$(basename "${dir}")
    cd "${dir}" || exit
    go build -o cmd/"${basename}"
done
