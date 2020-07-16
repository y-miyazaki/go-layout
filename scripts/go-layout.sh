#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")" || exit; pwd)
cd "${SCRIPT_DIR}"/.. || exit
# setting VSCODE
mkdir -p .vscode
curl -sSfL -o .vscode/cspell.json https://raw.githubusercontent.com/y-miyazaki/config/master/.vscode/cspell.json
curl -sSfL -o .vscode/settings.json https://raw.githubusercontent.com/y-miyazaki/config/master/.vscode/settings.json
curl -sSfL -o .vscode/snippets.json https://raw.githubusercontent.com/y-miyazaki/config/master/.vscode/snippets.json
# setting .editorconfig
curl -sSfL -o .editorconfig https://raw.githubusercontent.com/y-miyazaki/config/master/.editorconfig
# devcontainer
mkdir -p .devcontainer
if [ ! -d ".devcontainer" ]; then
    curl -sSfL -o .devcontainer/devcontainer.json https://raw.githubusercontent.com/y-miyazaki/docker-golang/master/env/base/example/.devcontainer/devcontainer.json
    curl -sSfL -o .devcontainer/.env https://raw.githubusercontent.com/y-miyazaki/docker-golang/master/env/base/example/.env
fi
# golangci.yaml
if [ ! -e "golangci.yaml" ]; then
    curl -sSfL -o golangci.yaml https://raw.githubusercontent.com/y-miyazaki/docker-golang/master/golangci.yaml
fi
