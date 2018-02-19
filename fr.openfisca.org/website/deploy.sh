#!/bin/bash

set -ex

yarn install
yarn build

# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart fr.openfisca.org-beta.service
