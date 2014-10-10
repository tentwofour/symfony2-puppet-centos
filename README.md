symfony2-puppet-centos
======================

Vagrant provisioning with Puppet for Centos 6.5, with PHP5.4 (remi), Apache, MySQL, EPEL, composer, and friends.

## Setup

-   Install vagrant on your system
    see [vagrantup.com](http://vagrantup.com/v1/docs/getting-started/index.html)

-   Install vagrant-hostmaster on your system
    see [mosaicxm/vagrant-hostmaster](https://github.com/mosaicxm/vagrant-hostmaster#installation)

-   Get a CentOS 6.x base box with puppet support (like http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box)
    see [vagrantup.com docs](http://vagrantup.com/v1/docs/getting-started/boxes.html)

-   Get a copy of this repository. You can do this either by integrating it as a git submodule or by just checking it out and copying the files. 
    Preferably, the contents of this repository should be placed in a directory `vagrant` inside your project's root dir.

-   Copy `vagrant/Personalization.dist` to `vagrant/Personalization` and modify `vagrant/Personalization` according to your needs.

    Example:
    ```ruby
    $vhost = "project.dev"
    $ip = "192.168.10.42"

    $use_nfs = true

    $base_box = "cent_6_5_x86_64"

    ```
        
    -   Execute "vagrant up" in the vagrant directory.

## Infrastructure

After performing the steps listed above, you will have the following environment set up:

- A running virtual machine with your project on it
- Your project directory will be mounted as a shared folder in this virtual machine
- Your project will be accessible via a browser (go to `http://$ip/[app_dev.php]`)
- The base box will be provisioned with:
  * EPEL
  * REMI
  * PHP 5.4.x
    * 'apc', 'mcrypt', 'intl', 'mysql', 'mbstring', 'gd', 'pecl-imagick', 'xml'
  * Apache 2 (running as vagrant:vagrant)
  * Git, nodejs, npm
  * Composer
  * Symfony Init
   * Composer install
   * doc:database:create
   * doc:schema:update
   * doc:fixtures:load

