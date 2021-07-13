# Install an instance of OpenFisca Web API automatically

This repository provides a way to install the OpenFisca Web API automatically on a machine that exposes a SSH connection.

This installation method uses [Ansible](https://www.ansible.com/), a well-known open-source tool enabling infrastructure as code, and is implemented as an Ansible playbook.

This documentation page describes how to run this Ansible playbook targeting a remote server, or a virtual machine (VM) managed locally on your development machine.

## Requirements

The Ansible tool must be installed on a machine named [control node](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#control-node) in Ansible parlance that will install OpenFisca Web API on a [managed node](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#managed-nodes). The control node can be, for example, your development machine.

To install Ansible, check [its documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

## On a remote server

This scenario describes how to install OpenFisca Web API on a remote server. The only requirement is that this server must expose an SSH connection.

## On a local VM

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

Note: this host name serving the API is defined in [`host_vars/openfisca_api.yml`](../ansible/host_vars/openfisca_api.yml) that is taken into account by Ansible only when the VM host name is `openfisca_api`. The `Vagrantfile` defines that VM host name.

Then you can do:

```bash
curl http://openfisca-api.local:8000/api/latest
```

This should display the following JSON result:

```text
{"welcome":"Welcome to OpenFisca Web API. This instance runs OpenFisca-France country package."}
```
