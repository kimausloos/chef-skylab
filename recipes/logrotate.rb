group = value_for_platform(
            "mac_os_x" => { "default" => "admin" },
            "default" => "root"
        )

location = value_for_platform(
            "mac_os_x" => { "default" => "/usr/local/etc/logrotate.d" },
            "default" => "/etc/logrotate.d"
        )

logrotate_app "skylab-apachelog" do
  cookbook "logrotate"
  path ["/home/projects/*/apachelogs/*.log","/var/log/nowebsite.log"]
  options ["compress", "ifempty", "nomail", "copytruncate", "nomissingok"]
  sharedscripts true
  size "50M"
  rotate 2
  frequency "daily"
  postrotate "/usr/bin/killall -HUP apache2"
  template_group group
  location location
end

logrotate_app "skylab-slowlog" do
  cookbook "logrotate"
  path ["/home/projects/*/apachelogs/*.slow", "/var/log/php5-fpm.log"]
  options ["compress", "ifempty", "nomail", "copytruncate", "nomissingok"]
  size "50M"
  rotate 2
  frequency "daily"
  template_group group
  location location
end

logrotate_app "symfony-logs" do
  cookbook "logrotate"
  path "/home/projects/*/data/current/app/logs/*.log"
  options ["compress", "ifempty", "nomail", "copytruncate", "nomissingok"]
  size "50M"
  rotate 5
  frequency "daily"
  template_group group
  location location
end

logrotate_app "tomcat-logs" do
  cookbook "logrotate"
  path "/home/projects/*/tomcat/default/logs/"
  options ["compress", "ifempty", "nomail", "copytruncate", "nomissingok"]
  size "50M"
  rotate 5
  frequency "daily"
  template_group group
  location location
end
