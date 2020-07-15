#!/bin/bash
ROOT_DIR=${PWD}
GIT_DOMAIN=github.com

# set ssh and git config
echo "Host ${GIT_DOMAIN}\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_rsa\n" >> /root/.ssh/config
ssh-keyscan -H ${GIT_DOMAIN} >> /root/.ssh/known_hosts
git config --global url."git@${GIT_DOMAIN}:".insteadOf "https://${GIT_DOMAIN}/"

# go mod download
go mod download

go test "$(go list ./... | grep -v /vendor/)" -coverprofile=coverage/coverage.out
go tool cover -html=coverage/coverage.out -o coverage/coverage.html
