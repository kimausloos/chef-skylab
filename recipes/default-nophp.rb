include_recipe "homebrewalt::default"
include_recipe "git::default"
include_recipe "skylab::postgresql"
include_recipe "applications::mysql"
include_recipe "skylab::apache"
include_recipe "skylab::directories"
include_recipe "skylab::logrotate"
include_recipe "applications::bash-completion"
include_recipe "dotfiles::bash_it"
include_recipe "dotfiles::inputrc"
include_recipe "applications::rsync"
include_recipe "applications::curl"


execute "install skylab" do
    command "curl -sS https://raw.github.com/Kunstmaan/skylab/master/installer | php && mv skylab.phar /usr/local/bin/skylab"
    not_if { ::File.exists?("/usr/local/bin/skylab") }
end
