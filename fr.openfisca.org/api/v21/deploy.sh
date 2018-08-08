#!/bin/bash

set -ex

REQUIREMENTS="/home/openfisca/openfisca-ops/fr.openfisca.org/api/v21/requirements.txt"

source /home/openfisca/virtualenvs/api-fr21/bin/activate
pip install --requirement "$REQUIREMENTS" --upgrade --upgrade-strategy eager
# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart openfisca-web-api-fr21.service
sudo systemctl restart legislation-explorer.service
