#!/bin/bash

set -ex

REQUIREMENTS="/home/openfisca/openfisca-ops/auto-update-pip-packages/requirements.txt"
NEW_REQUIREMENTS="/home/openfisca/new-api/requirements.txt"

sed -e 's/\[api\]//' "$REQUIREMENTS" > "$NEW_REQUIREMENTS"

source /home/openfisca/virtualenvs/new-api/bin/activate
pip install openfisca_core --upgrade
pip install --requirement "$NEW_REQUIREMENTS" --upgrade
# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart openfisca-web-api-new.service
