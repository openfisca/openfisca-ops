#!/bin/bash

set -e


# Customizable variables

VENV_ACTIVATE="~/virtualenvs/openfisca/bin/activate"

# End of customizable variables


CURL="curl --silent --retry 5"

restart="0"

function check_and_update {
    PACKAGE_NAME="$1"
    PACKAGE_JSON_URL="https://pypi.python.org/pypi/$PACKAGE_NAME/json"
    PACKAGE_PYPI_VERSION=`$CURL "$PACKAGE_JSON_URL" | jq --raw-output ".info.version"`
    PACKAGE_PIP_VERSION=`python -c "import pkg_resources; print(pkg_resources.get_distribution('$PACKAGE_NAME').version)"`
    if [[ "$PACKAGE_PYPI_VERSION" != "$PACKAGE_PIP_VERSION" ]]; then
        # Check for X.Y.Z version number, exclude alpha, rc, dev versions.
        echo "$PACKAGE_PYPI_VERSION" | grep "^[0-9]\+\.[0-9]\+\.[0-9]\+$" > /dev/null
        if [ $? == 0 ]; then
            pip install --upgrade $PACKAGE_NAME
            restart="1"
        fi
    fi
}

source $VENV_ACTIVATE

for package in OpenFisca-France OpenFisca-Core OpenFisca-Web-API
do
    check_and_update "$package"
done

if [ "$restart" == "1" ]; then
    echo "========="
    echo "New version(s) of PyPI package(s) were found and installed."
    echo "Restarting openfisca-web-api.service and legislation-explorer.service as a consequence."
    echo "========="
    sudo systemctl restart openfisca-web-api.service
    sudo systemctl restart legislation-explorer.service
    # Trigger an HTTP request to pre-load OpenFisca-Web-API, so the first user will not have to wait.
    $CURL https://api.openfisca.fr/
fi
