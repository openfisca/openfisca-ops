# Run a local instance of the OpenFisca Web API in a virtual machine

By following this guide, you will be able to access the latest version of the OpenFisca Web API on your local machine at `http://localhost:8000/`, without worrying about dependency and stack management, thanks to [Vagrant](https://vagrantup.com) and [Ansible](https://www.ansible.com/).

That instance of the API will serve by default the [Country Template](https://github.com/openfisca/country-template), but you will be able to configure it to serve any other available [country package](https://openfisca.org/en/countries/).

> For information, this guide was written with Ansible 2.11.2 running on Python 3.9.4, Vagrant 2.2.16 and VirtualBox 6.1.22.

## 1. Install a virtual machine provider

In order to isolate the OpenFisca Web API environment from your environment, we will set it up in a [virtual machine](https://en.wikipedia.org/wiki/Virtual_machine).

If you don’t already have a [provider](https://www.vagrantup.com/docs/providers) installed (VirtualBox, Docker, VMWare, Hyper-V…), [install VirtualBox](https://www.virtualbox.org/manual/ch02.html).

### On a Mac with an Apple Silicon processor

VirtualBox is not compatible with Apple Silicon (M1…) processors. You will thus need to use the Docker provider.

To that end, install Docker Desktop through a [manual install](https://docs.docker.com/docker-for-mac/install/) or with `brew install --cask docker`.

## 2. Set up Vagrant

Vagrant enables programmatic setup of virtual machines.

[Install Vagrant](https://www.vagrantup.com/downloads).

## 3. Install Ansible

To install Ansible, follow [the documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-specific-operating-systems) for your operating system.

> While Ansible is written in Python, the Python version used to run Ansible on your machine does not have to match the [Python version used by OpenFisca](https://github.com/openfisca/openfisca-core#environment) on the target machine.

To check that Ansible is properly installed, run `ansible --version`. You should get something like:

```
ansible [core 2.16.5]
   …
```

## 4. Install and start the API

1. Clone (or download) the `openfisca-ops` repository: `https://github.com/openfisca/openfisca-ops.git`.
2. Navigate to the freshly downloaded folder: `cd openfisca-ops`.
3. Type the following command: `vagrant up`. If you’re on an Apple Silicon machine or want to use Docker instead of VirtualBox, type `vagrant up --provider=docker`.

Once the command is done, you should have a virtual machine running the OpenFisca Web API with the [Country Template](https://github.com/openfisca/country-template).

The port of the application inside the virtual machine is forwarded to the port 8000 on your development machine by default. You can thus access that API on your local machine on [`http://localhost:8000/`](http://localhost:8000/).

> You can override that port with the `PORT` environment variable: `PORT=8080 vagrant up`.

> You can choose the [country package](https://openfisca.org/en/countries/) served by the API by customizing the variables starting with `country_` in the `Vagrantfile`.

> On such a local virtual machine, the API is by default served over HTTP instead of HTTPS, as SSL certificates cannot be automatically provisioned by Let’s Encrypt.

> The `reverse_proxy_base_path` variable won't have any effect when using this local virtual machine setup. When using Vagrant, by default the app is accessed directly, with no reverse proxy.
