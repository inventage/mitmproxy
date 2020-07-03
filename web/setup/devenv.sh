#!/usr/bin/env bash

set -euo pipefail

echo $0

function runsInVirtualEnv() {
    if [[ -z "${VIRTUAL_ENV:=}" ]]; then
        echo "Starting up the virtual environment"
        . ../../venv/bin/activate
        echo "Virtual environment started ✓"
    else
        echo "Running in virtual environment ✓"
    fi
}

function installDependencies() {
    echo "Installing all required dependencies ..."
    yarn install
    echo "Dependencies installed ✓"
}

function installMitmProxy() {
    echo "Building mitmweb ..."
    yarn run gulp prod
    echo "mitmweb built ✓"
}

function runNginx() {
    echo "Starting Nginx ..."
    docker-compose -f ./nginx/docker-compose.yaml --project-directory ./nginx/ up -d
    echo "Nginx running ✓"
}

function stopNginx() {
    echo "Stopping Nginx ..."
    docker-compose -f ./nginx/docker-compose.yaml down
    echo "Nginx stopped ✓"
}

function runMitmweb() {
    echo "Starting mitmweb ..."
    mitmweb --listen-port "$1"
}

function cleanup() {
    set +e
    echo "Cleaning up"
    stopNginx
}

runsInVirtualEnv
trap cleanup EXIT
installDependencies
installMitmProxy
runNginx
runMitmweb "8084"
