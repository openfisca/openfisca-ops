#!/bin/bash

set -ex

REQUIREMENTS="/home/openfisca/openfisca-ops/fr.openfisca.org/api/v19/requirements.txt"

source /home/openfisca/virtualenvs/api-fr19/bin/activate
pip install --requirement "$REQUIREMENTS" --upgrade
# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart openfisca-web-api-fr19.service