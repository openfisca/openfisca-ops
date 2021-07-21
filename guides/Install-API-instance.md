# Install an instance of OpenFisca Web API automatically

This repository provides a way to install the OpenFisca Web API automatically on a machine that exposes a SSH connection.

This installation method uses [Ansible](https://www.ansible.com/), a well-known open-source tool enabling infrastructure as code, and is implemented as the [`openfisca-api` _role_](../ansible/roles/openfisca-api/) which is called by the [`openfisca-api` _playbook_](../ansible/openfisca-api.yml).

For now, this _playbook_ installs an instance of OpenFisca Web API parametered to run [OpenFisca-France](https://github.com/openfisca/openfisca-france). More configuration parameters will be added in the near future, to allow installing one or many other country packages.

## Requirements

The Ansible tool must be installed on a machine named [control node](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#control-node) in Ansible parlance that will install OpenFisca Web API on a [managed node](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#managed-nodes). The control node can be, for example, your development machine.

To install Ansible, check [its documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

To check that Ansible is well installed, try to run the following command:

```bash
ansible --version

# It should output something like:

# ansible [core 2.11.2]
#   config file = /etc/ansible/ansible.cfg
#   [...]
```

For information, during the redaction of this guide, we used Ansible version 2.11.2 with Python 3.9.4 (Ansible is written in Python). Note that the Python version used to run Ansible is not related to the [Python version recommended by OpenFisca Core](https://github.com/openfisca/openfisca-core#environment) (which is Python 3.7 at the time we write this guide).

The Ansible _playbook_ is designed to be run on a managed node that runs [Ubuntu 20.04.2.0 LTS (Focal Fossa)](https://releases.ubuntu.com/20.04/), the latest long term support (LTS) version at the time the _playbook_ was written.

## Configuration

The default values of the variables used by the _playbook_ are defined in [`defaults/main.yml`](../ansible/roles/openfisca-api/default/main.yml).

## Install OpenFisca Web API

The following sub-sections describe how to run the `openfisca-api` _playbook_ with 2 scenarios:

- on a remote server for production
- on a local virtual machine (VM) for development

### Remote server scenario

This scenario describes how to install OpenFisca Web API on a remote server.

There are some prerequisites to running the _playbook_:

- a server must be available, running [Ubuntu 20.04.2.0 LTS (Focal Fossa)](https://releases.ubuntu.com/20.04/)
- it must expose an SSH connection
- the _control node_ (the machine that runs the _playbook_) must be able to access the server via SSH as `root`
- a domain name must have been created, and it must target the public IP address of this server

The _playbook_ refers to the server using `openfisca_api`, a symbolic host name that does not necessarily correspond to a real server host name or domain name (cf `hosts` property in [`openfisca-api.yml`](../ansible/openfisca-api.yml)).
To associate a concrete IP address or domain name to that symbolic host name, we use an Ansible inventory that can define host groups with a symbolic name (i.e. `openfisca_api` in this case) targeting one or many concrete host names.

Inventories are stored as sub-directories of the [`inventories`](../ansible/inventories/) directory. Each inventory provides at least a `hosts` file, and can also overload _playbook_ default variables by providing a `group_vars/openfisca_api.yml` file.

An SSL certificate is issued from Let's Encrypt if `enable_ssl` and `letsencrypt_email` variables are both defined.

To run the _playbook_, run the following command.

```bash
ansible-playbook -i ansible/inventories/scaleway/ ansible/openfisca-api.yml
```

### Local VM scenario

This scenario describes how to install OpenFisca Web API on a virtual machine (VM) managed locally on your development machine by [Vagrant](https://www.vagrantup.com/), a well-known open-source tool.

To install Vagrant, check [its documentation](https://www.vagrantup.com/docs/installation).

Vagrant relies on a [provider](https://www.vagrantup.com/docs/providers) to create a VM. The recommended one is [VirtualBox](https://www.virtualbox.org/), so install it by following [VirtualBox documentation](https://www.virtualbox.org/manual/UserManual.html#installation).

For information, during the redaction of this guide, we used Vagrant version 2.2.16 and VirtualBox 6.1.22.

To create the VM and run the _playbook_, just do:

```bash
# Ensure you are in the directory containing the Vagrantfile
cd openfisca-ops

vagrant up
```

About a minute later, the command will finish, and you should have a VM with OpenFisca Web API running. Thanks to Vagrant port forwarding, the internal port 8000 inside the VM is forwarded to the port 80 of your development machine.

To try the API, you must first associate the host name serving the API in your `/etc/hosts` file to the local machine, by adding this line:

```text
127.0.0.1 openfisca-api.local
```

Then you can do:

```bash
curl http://openfisca-api.local:8000/api/latest
```

This should display the following JSON result:

```text
{"welcome":"Welcome to OpenFisca Web API. This instance runs OpenFisca-France country package."}
```

Technical notes:

- No inventory is defined explicitly when using Vagrant because Vagrant itself generates it. The `Vagrantfile` allows defining host vars or group vars. For example, it defines the `host_name: openfisca-api.local` variable.
- No SSL certificate is issued when running the _playbook_ on a local VM, simply because it can't be reached from the Let's Encrypt infrastructure. As a consequence, OpenFisca Web API is served by an HTTP URL, not HTTPS.
- The [`Vagrantfile`](../Vagrantfile) declares how the VM should be created.
