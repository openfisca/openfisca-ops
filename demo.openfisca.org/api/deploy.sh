#!/bin/bash

set -ex

source /home/openfisca/virtualenvs/api-demo/bin/activate
pip install OpenFisca-Country-Template --upgrade --upgrade-strategy eager
# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart openfisca-web-api-demo.service
# sudo systemctl restart legislation-explorer-demo.service
