include_recipe "applications::apache"

%w{/etc/apache2/conf/projects.d /etc/apache2/logs /opt/nowebsite}.each do |pkg|
    directory pkg do
        owner "root"
        group value_for_platform(
            "mac_os_x" => { "default" => "admin" },
            "default" => "root"
        )
        mode 0777
        action :create
        recursive true
    end
end

%w{/etc/apache2/conf/projects.d/namevirtualhosts /etc/apache2/workers.properties}.each do |pkg|
    file pkg do
        owner "root"
        group value_for_platform(
            "mac_os_x" => { "default" => "admin" },
            "default" => "root"
        )
        mode 0777
        action :touch
    end
end

template "/etc/apache2/conf.d/skylab.conf" do
    source "apache/skylab.conf.erb"
    owner "root"
    group value_for_platform(
        "mac_os_x" => { "default" => "admin" },
        "default" => "root"
    )
    mode "0644"
    variables(
        :user => node['current_user']
    )
end
