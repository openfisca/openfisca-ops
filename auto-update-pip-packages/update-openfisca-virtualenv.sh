#!/usr/bin/env bash

# Adapt this variable to your server.
VENV_ACTIVATE="/home/openfisca/virtualenvs/openfisca/bin/activate"

set -x
source "$VENV_ACTIVATE"
pip install --requirement requirements.txt
if ! (pip check); then
    exit -1
fi
deactivate

sudo systemctl restart openfisca-web-api.service
sudo systemctl restart legislation-explorer.service

~openfisca/new-api/deploy.sh