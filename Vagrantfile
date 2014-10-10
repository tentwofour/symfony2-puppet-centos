# -*- mode: ruby -*-
# vi: set ft=ruby :

personalization = "Personalization"
load personalization

Vagrant::Config.run do |config|
  config.vm.box = $base_box

  config.vm.host_name = $vhost + ".dev"

  config.vm.network :hostonly, $ip

  # forward 80 to localhost(host) 8080
  config.vm.forward_port 80, 8080

  config.vm.share_folder $vhost, "/srv/www/vhosts/" + $vhost + ".dev", "./", :nfs => $use_nfs

  config.vm.customize ["modifyvm", :id, "--memory", "512"]

  # Always provision (up/reload)
  config.vm.provision :puppet, run: "always" do |puppet|
      puppet.manifests_path = "puppet"
      puppet.manifest_file  = "site.pp"
      puppet.module_path    = "puppet/modules"
      puppet.options        = "--verbose --debug"
      puppet.facter         = {
                                "vhost" => $vhost,
                                "webserver" => $webserver
                              }
  end
end
