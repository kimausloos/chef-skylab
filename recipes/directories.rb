if platform?('mac_os_x')
    include_recipe "osxdefaults::finder_unhide_home"
end

%w{
  /etc/apache2/conf/projects.d
  /etc/apache2/logs
  /etc/tomcat
  /home/projects
  /home/backupped-projects
  /opt/nowebsite
  /opt/jdk
}.each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode 0777
    action :create
    recursive true
  end
end
