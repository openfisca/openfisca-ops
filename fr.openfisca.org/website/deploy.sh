#!/bin/bash

set -ex

npm install
npm run build

# The current user must have been specifically allowed to run the next command
# Use the visudo command to do so
sudo systemctl restart fr.openfisca.org-beta.service
