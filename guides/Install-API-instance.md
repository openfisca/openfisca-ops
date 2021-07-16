# Install an instance of OpenFisca Web API automatically

This repository provides a way to install the OpenFisca Web API automatically on a machine that exposes a SSH connection.

This installation method uses [Ansible](https://www.ansible.com/), a well-known open-source tool enabling infrastructure as code, and is implemented as an Ansible playbook.

This documentation page describes how to run this Ansible playbook targeting a remote server, or a virtual machine (VM) managed locally on your development machine.

## Requirements

The Ansible tool must be installed on a machine named [control node](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#control-node) in Ansible parlance that will install OpenFisca Web API on a [managed node](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#managed-nodes). The control node can be, for example, your development machine.

To install Ansible, check [its documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

The Ansible playbook is designed to be run on a managed node that runs [Ubuntu 20.04.2.0 LTS (Focal Fossa)](https://releases.ubuntu.com/20.04/), the latest long term support (LTS) version at the time the playbook was written.

The default values of the variables used by the Ansible playbook are defined in [`defaults/main.yml`](../ansible/roles/openfisca-api/default/main.yml).

## Install on a remote server

This scenario describes how to install OpenFisca Web API on a remote server. The only requirement is that this server must expose an SSH connection.

The Ansible playbook refers to the server that will host OpenFisca Web API as `openfisca_api`, a symbolic host name (cf `hosts` property in [`openfisca-api.yml`](../ansible/openfisca-api.yml)).
To associate a concrete IP address or DNS name to that symbolic host name, we use Ansible inventories that can define host groups with a symbolic name (e.g. `openfisca_api`) targeting one or many concrete host names.

Inventories are stored as sub-directories of the [`inventories`](../ansible/inventories/) directory. Each inventory provides at least a `hosts` file, and can also overload playbook default variables by providing a `group_vars/openfisca_api.yml` file.

An SSL certificate is issued from Let's Encrypt if `enable_ssl` and `letsencrypt_email` variables are both defined.

To run the Ansible playbook, run the following command. Note: the SSH agent of the current Unix user must be able to connect to the server defined in the inventory as `root`.

```bash
ansible-playbook -i ansible/inventories/scaleway/ ansible/openfisca-api.yml
```

## Install on a local VM

This scenario describes how to install OpenFisca Web API on a virtual machine (VM) managed locally on your development machine by [Vagrant](https://www.vagrantup.com/), a well-known open-source tool.

To install Vagrant, check [its documentation](https://www.vagrantup.com/docs/installation).

The VM is defined by the [`Vagrantfile`](../Vagrantfile) and references the [Ansible playbook](../ansible/openfisca-api.yml) that installs OpenFisca Web API.

To create the VM then run the Ansible playbook, just do:

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
- No SSL certificate is issued when running the Ansible playbook on a local VM, simply because it can't be reached from the Let's Encrypt infrastructure. As a consequence, OpenFisca Web API is served by an HTTP URL, not HTTPS.
