#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
GIT_DOMAIN=github.com

# set ssh and git config
echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config
ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts
git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/"

# go mod download
go mod download

# go test
cd "${SCRIPT_DIR}"/..
if [ ! -d "${PWD}/coverage" ]; then
    mkdir -p coverage
fi
go test "$(go list ./... | grep -v /vendor/)" -coverprofile=coverage/coverage.out
go tool cover -html=coverage/coverage.out -o coverage/coverage.html
