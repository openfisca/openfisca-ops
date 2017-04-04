#!/usr/bin/env bash

# Adapt this variable to your server.
VENV_ACTIVATE="/home/openfisca/virtualenvs/openfisca/bin/activate"

source "$VENV_ACTIVATE"
pip install --upgrade OpenFisca-France[api]
if ! (pip check); then
    exit -1
fi
deactivate

sudo systemctl restart openfisca-web-api.service
sudo systemctl restart legislation-explorer.service

~openfisca/new-api/deploy.sh