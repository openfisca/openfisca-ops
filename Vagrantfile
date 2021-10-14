port = ENV["PORT"] || 8000

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Used to refer to this VM from Ansible playbooks.
  config.vm.define "openfisca_api_fr"

  config.vm.network "forwarded_port", guest: 80, host: port

  config.vm.provider :virtualbox

  # Provider for Docker, necessary for M1 chips
  config.vm.provider :docker do |docker, override|
    override.vm.box = nil
    docker.image = "rofrano/vagrant-provider:ubuntu"
    docker.remains_running = true
    docker.has_ssh = true
    docker.privileged = true
    docker.volumes = ["/sys/fs/cgroup:/sys/fs/cgroup:ro"]
  end

  config.vm.provision :ansible, run: "always" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "ansible/site.yml"

    # Uncomment to define Ansible variables specific to this VM.
    # ansible.host_vars = {
    #   "openfisca_api_fr" => {
    #   }
    # }
  end
end
