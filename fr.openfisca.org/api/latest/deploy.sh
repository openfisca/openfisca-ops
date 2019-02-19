#!/bin/bash

set -ex

REQUIREMENTS="/home/openfisca/openfisca-ops/fr.openfisca.org/api/latest/requirements.txt"

source /home/openfisca/virtualenvs/api-fr-latest/bin/activate
pip install --requirement "$REQUIREMENTS"
# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart openfisca-web-api-fr-latest.service
/home/openfisca/openfisca-ops/fr.openfisca.org/legislation-explorer/deploy.sh
