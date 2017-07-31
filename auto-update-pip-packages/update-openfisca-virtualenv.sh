#!/usr/bin/env bash

# Adapt this variable to your server.
VENV_ACTIVATE="/home/openfisca/virtualenvs/openfisca/bin/activate"
REQUIREMENTS_URL="https://raw.githubusercontent.com/openfisca/openfisca-ops/master/auto-update-pip-packages/requirements.txt"
REQUIREMENTS="/home/openfisca/openfisca-ops/auto-update-pip-packages/requirements.txt"

set -x

wget "$REQUIREMENTS_URL" --output-document="$REQUIREMENTS"

source "$VENV_ACTIVATE"
pip install --requirement "$REQUIREMENTS" --upgrade
if ! (pip check); then
    exit -1
fi
deactivate

sudo systemctl restart openfisca-web-api.service
sudo systemctl restart legislation-explorer.service

~openfisca/new-api/deploy.sh
