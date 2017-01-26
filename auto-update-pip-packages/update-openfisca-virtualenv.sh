#!/bin/bash


# Customizable variables
PIP_PACKAGES="OpenFisca-France OpenFisca-Core OpenFisca-Web-API"
VENV_ACTIVATE="$HOME/virtualenvs/openfisca/bin/activate"
# End of customizable variables


CURL="curl --silent --retry 5"
restart_services="0"

function upgrade_package {
    PACKAGE_NAME="$1"
    CURRENT_VERSION=`python -c "import pkg_resources; print(pkg_resources.get_distribution('$PACKAGE_NAME').version)"`
    pip install --quiet --no-cache-dir --upgrade $PACKAGE_NAME
    NEW_VERSION=`python -c "import pkg_resources; print(pkg_resources.get_distribution('$PACKAGE_NAME').version)"`
    if [[ "$NEW_VERSION" != "$CURRENT_VERSION" ]]; then
        echo "- New version of package $PACKAGE_NAME was found on PyPI: current=$CURRENT_VERSION, new=$NEW_VERSION"
        restart_services="1"
    fi
}

source $VENV_ACTIVATE

for package in $PIP_PACKAGES
do
    upgrade_package "$package"
done

if [ "$restart_services" == "1" ]; then
    echo "- New version(s) of PyPI package(s) were found and installed. Restarting openfisca-web-api.service and legislation-explorer.service as a consequence."
    sudo systemctl restart openfisca-web-api.service
    sudo systemctl restart legislation-explorer.service
    TEST_URL="https://api.openfisca.fr/"
    echo "- Triggering an HTTP request on $TEST_URL to pre-load OpenFisca-Web-API simulation results, so the first user will not have to wait. Response body:"
    sleep 10
    $CURL $TEST_URL
fi
