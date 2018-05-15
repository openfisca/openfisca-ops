#!/bin/bash

set -ex

REQUIREMENTS="/home/openfisca/openfisca-ops/fr.openfisca.org/api/v18/requirements.txt"

source /home/openfisca/virtualenvs/new-api/bin/activate
pip install --requirement "$REQUIREMENTS" --upgrade
# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart openfisca-web-api-new.service
sudo systemctl restart legislation-explorer.service
