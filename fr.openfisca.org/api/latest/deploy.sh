#!/bin/bash

set -ex

source /home/openfisca/virtualenvs/api-fr-latest/bin/activate

pip install "OpenFisca-Core[web-api]" --upgrade --upgrade-strategy eager
pip install "OpenFisca-France" --upgrade --upgrade-strategy eager
pip install "OpenFisca-Tracker == 0.4.0"

# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart openfisca-web-api-fr-latest.service
/home/openfisca/openfisca-ops/fr.openfisca.org/legislation-explorer/deploy.sh
