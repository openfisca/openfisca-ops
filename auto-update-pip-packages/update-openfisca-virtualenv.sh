#!/bin/bash

set -e

restart="0"

function check_and_update {
    PACKAGE_NAME="$1"
    PACKAGE_JSON_URL="https://pypi.python.org/pypi/$PACKAGE_NAME/json"
    PACKAGE_PYPI_VERSION=`curl --silent "$PACKAGE_JSON_URL" | jq --raw-output ".info.version"`
    source ~/virtualenvs/openfisca/bin/activate
    PACKAGE_PIP_VERSION=`python -c "import pkg_resources; print(pkg_resources.get_distribution('$PACKAGE_NAME').version)"`
    if [ "$PACKAGE_PYPI_VERSION" != "$PACKAGE_PIP_VERSION" ]; then
        pip install --upgrade $PACKAGE_NAME
        restart="1"
    fi
}

for package in OpenFisca-France OpenFisca-Core OpenFisca-Web-API
do
    check_and_update "$package"
done

if [ "$restart" == "1" ]; then
    sudo systemctl restart openfisca-web-api.service
    sudo systemctl restart legislation-explorer.service
    # Trigger an HTTP request to pre-load OpenFisca-Web-API, so the first user will not have to wait.
    curl --silent --retry 5 https://api.openfisca.fr/
fi